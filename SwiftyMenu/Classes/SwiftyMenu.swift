//
//  SwiftyMenu.swift
//  DropDownMenu
//
//  Created by Karim Ebrahem on 4/17/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import UIKit
// Markable interface for pathing datasource objects in late binding
public protocol SwiftMenuDisplayable {
    var displayValue: String { get }
    var valueToRetrive: Any { get }
}

@IBDesignable
public class SwiftyMenu: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    private var selectButton: UIButton!
    private var optionsTableView: UITableView!
    private var state: MenuState = .hidden
    private enum MenuState {
        case shown
        case hidden
    }
    private var width: CGFloat!
    private var height: CGFloat!
    
    public var selectedIndex: Int?
    public var options = [SwiftMenuDisplayable]()
    
    // MARK: - Closures
    
    private var updateHeightConstraint: () -> () = { }
    private var didSelectCompletion: (SwiftMenuDisplayable, Int) -> () = { selectedText, index in }
    private var TableWillAppearCompletion: () -> () = { }
    private var TableDidAppearCompletion: () -> () = { }
    private var TableWillDisappearCompletion: () -> () = { }
    private var TableDidDisappearCompletion: () -> () = { }
    
    // MARK: - IBInspectable
    
    @IBInspectable public var rowHeight: Double = 35
    @IBInspectable public var rowBackgroundColor: UIColor = .white
    @IBInspectable public var selectedRowColor: UIColor = .white
    @IBInspectable public var hideOptionsWhenSelect = true
    @IBInspectable public var optionColor: UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    @IBInspectable public var placeHolderColor: UIColor = UIColor(red: 149.0/255.0, green: 149.0/255.0, blue: 149.0/255.0, alpha: 1.0) {
        didSet {
            selectButton.setTitleColor(placeHolderColor, for: .normal)
        }
    }
    @IBInspectable public var placeHolderText: String? {
        didSet {
            selectButton.setTitle(placeHolderText, for: .normal)
        }
    }
    @IBInspectable public var arrow: UIImage? {
        didSet {
            selectButton.titleEdgeInsets.left = 5
            selectButton.setImage(arrow, for: .normal)
        }
    }
    @IBInspectable public var titleLeftInset: Int = 0 {
        didSet {
            selectButton.titleEdgeInsets.left = CGFloat(titleLeftInset)
        }
    }
    @IBInspectable public var borderColor: UIColor =  UIColor.lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var listHeight: CGFloat = 150 {
        didSet {
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupUI()
    }
    
    private func setupUI () {
        setupView()
        getViewWidth()
        getViewHeight()
        setupSelectButton()
        setupDataTableView()
    }
    
    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    private func getViewWidth() {
        width = self.frame.width
    }
    
    private func getViewHeight() {
        height = self.frame.height
    }
    
    private func setupSelectButton() {
        selectButton = UIButton(frame: self.frame)
        self.addSubview(selectButton)
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: selectButton!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height).isActive = true
        NSLayoutConstraint(item: selectButton!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: selectButton!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: selectButton!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
        
        let color = placeHolderColor
        selectButton.setTitleColor(color, for: .normal)
        selectButton.setTitle(placeHolderText, for: .normal)
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        selectButton.imageEdgeInsets.left = width - 16
        
        let frameworkBundle = Bundle(for: SwiftyMenu.self)
        let image = UIImage(named: "downArrow", in: frameworkBundle, compatibleWith: nil)
        arrow = image
        
        if arrow == nil {
            selectButton.titleEdgeInsets.left = 16
        }
        
        if #available(iOS 11.0, *) {
            selectButton.contentHorizontalAlignment = .leading
        } else {
            selectButton.contentHorizontalAlignment = .left
        }
        
        selectButton.addTarget(self, action: #selector(handleMenuState), for: .touchUpInside)
    }
    
    private func setupDataTableView() {
        optionsTableView = UITableView()
        self.addSubview(optionsTableView)
        
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: optionsTableView!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: optionsTableView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: selectButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: optionsTableView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: optionsTableView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.rowHeight = CGFloat(rowHeight)
        optionsTableView.separatorInset.left = 8
        optionsTableView.separatorInset.right = 8
    }
    
    @objc private func handleMenuState() {
        switch self.state {
        case .shown:
            collapseMenu()
        case .hidden:
            expandMenu()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SwiftyMenu: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row].displayValue
        cell.textLabel?.textColor = optionColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.tintColor = optionColor
        cell.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SwiftyMenu: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedText = self.options[self.selectedIndex!]
        selectButton.setTitle(selectedText.displayValue, for: .normal)
        didSelectCompletion(selectedText, indexPath.row)
        tableView.reloadData()
        collapseMenu()
    }
}

// MARK: - Private Functions

extension SwiftyMenu {
    private func expandMenu() {
        self.state = .shown
        heightConstraint.constant = CGFloat(rowHeight * Double(options.count + 1))
        updateHeightConstraint()
    }
    
    private func collapseMenu() {
        self.state = .hidden
        heightConstraint.constant = CGFloat(rowHeight)
        updateHeightConstraint()
    }
}

// MARK: - Delegates

extension SwiftyMenu {
    public func updateConstraints(completion: @escaping () -> ()) {
        updateHeightConstraint = completion
    }
    
    public func didSelectOption(completion: @escaping (_ selected: SwiftMenuDisplayable, _ index: Int) -> ()) {
        didSelectCompletion = completion
    }
    
    public func listWillAppear(completion: @escaping () -> ()) {
        TableWillAppearCompletion = completion
    }
    
    public func listDidAppear(completion: @escaping () -> ()) {
        TableDidAppearCompletion = completion
    }
    
    public func listWillDisappear(completion: @escaping () -> ()) {
        TableWillDisappearCompletion = completion
    }
    
    public func listDidDisappear(completion: @escaping () -> ()) {
        TableDidDisappearCompletion = completion
    }
}
