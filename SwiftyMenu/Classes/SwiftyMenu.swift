//
//  SwiftyMenu.swift
//
//  Copyright (c) 2019-2020 Karim Ebrahem (https://twitter.com/k_ebrahem_)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit
import SnapKit

/// `SwiftyMenu` is the menu class that provides common state, delegate, and callbacks handling.
final public class SwiftyMenu: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet public var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    /// `selectedIndex` is a property to get and set selected item in `SwiftyMenu` when it is a Single Selection.
    public var selectedIndex: Int? {
        didSet {
            if selectedIndex == nil {
                setPlaceholder()
            } else {
                setSingleSelectedOption()
            }
        }
    }
    
    /// `selectedIndecis` is a property to get and set selected item in `SwiftyMenu` when it is a Multi Selection.
    public var selectedIndecis: [Int: Int] = [:] {
        didSet {
            setMultiSelectedOptions()
        }
    }
    
    /// `items` is the `SwiftyMenu` DataSource.
    ///
    /// The items that will appear in the `SwiftyMenu`.
    public var items = [SwiftyMenuDisplayable]() {
        didSet {
            self.itemsTableView.reloadData()
        }
    }
    
    /// `delegate` is the `SwiftyMenu` delegate property.
    public weak var delegate: SwiftyMenuDelegate?

    /// `separatorCharacters` is a property to get and set separator characters  in `SwiftyMenu` when it is a Multi Selection.
    public var separatorCharacters: String?
    
    // MARK: - Public Callbacks
    
    /// `willExpand` is a completion closure that will be executed when `SwiftyMenu` is going to expand.
    public var willExpand: (() -> Void) = { }
    
    /// `didExpand` is a completion closure that will be executed once `SwiftyMenu` expanded.
    public var didExpand: (() -> Void) = { }
    
    /// `willCollapse` is a completion closure that will be executed when `SwiftyMenu` is going to collapse.
    public var willCollapse: (() -> Void) = { }
    
    /// `didCollapse` is a completion closure that will be executed once `SwiftyMenu` collapsed.
    public var didCollapse: (() -> Void) = { }
    
    /// `didSelectItem` is a completion closure that will be executed when select an item from `SwiftyMenu`.
    /// - Parameters:
    ///   - swiftyMenu: The `SwiftyMenu` that was selected from it's items.
    ///   - item: The `Item` that had been selected from `SwiftyMenu`.
    ///   - index: The `Index` of the selected `Item`.
    public var didSelectItem: ((_ swiftyMenu: SwiftyMenu,_ item: SwiftyMenuDisplayable,_ index: Int) -> Void) = { _, _, _ in }

    // MARK: - Private Properties
    
    private var selectButton: UIButton!
    private var itemsTableView: UITableView!
    private var state: SwiftyMenuState = .hidden
    private var width: CGFloat!
    private var height: CGFloat!
    private var setuped: Bool = false
    private var attributes: SwiftyMenuAttributes!
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectButton = UIButton(frame: self.frame)
        itemsTableView = UITableView()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        selectButton = UIButton(frame: self.frame)
        itemsTableView = UITableView()
    }
    
    // MARK: - LifeCycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setuped {
            setupUI()
            setupArrowImage()
            setuped = true
        }
    }
    
    // MARK: - Public Funcitons

    /// Configure `SwiftyMenu` with attributes.
    public func configure(with attributes: SwiftyMenuAttributes) {
        self.attributes = attributes
    }
    
    /// Expand or Collapse `SwiftyMenu` from Code.
    public func toggle() {
        handleMenuState()
    }
    
}

// MARK: - UITableViewDataSource Functions

extension SwiftyMenu: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].displayableValue
        cell.textLabel?.textColor = attributes.textStyle.textStyleValues.color
        cell.textLabel?.font = attributes.textStyle.textStyleValues.font
        cell.tintColor = attributes.textStyle.textStyleValues.color
        cell.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        cell.selectionStyle = .none

        if attributes.multiSelect.isEnabled {
            if selectedIndecis[indexPath.row] != nil {
                cell.accessoryType = attributes.accessory.isEnabled ? .checkmark : .none
                cell.backgroundColor = attributes.rowStyle.rowStyleValues.selectedColor
            } else {
                cell.accessoryType = .none
            }
        } else {
            if indexPath.row == selectedIndex {
                cell.accessoryType = attributes.accessory.isEnabled ? .checkmark : .none
                cell.backgroundColor = attributes.rowStyle.rowStyleValues.selectedColor
            } else {
                cell.accessoryType = .none
            }
        }

        return cell
    }
}

// MARK: - UITableViewDelegate Functions

extension SwiftyMenu: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(attributes.rowStyle.rowStyleValues.height)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if attributes.multiSelect.isEnabled {
            if selectedIndecis[indexPath.row] != nil {
                selectedIndecis[indexPath.row] = nil
                setSelectedOptionsAsTitle()
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                selectedIndecis[indexPath.row] = indexPath.row
                setSelectedOptionsAsTitle()
                let selectedText = self.items[selectedIndecis[indexPath.row]!]
                delegate?.swiftyMenu(self, didSelectItem: selectedText, atIndex: indexPath.row)
                self.didSelectItem(self, selectedText, indexPath.row)
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            }
        } else {
            if selectedIndex == indexPath.row {
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                selectedIndex = indexPath.row
                setSelectedOptionsAsTitle()
                let selectedText = self.items[self.selectedIndex!]
                delegate?.swiftyMenu(self, didSelectItem: selectedText, atIndex: indexPath.row)
                self.didSelectItem(self, selectedText, indexPath.row)
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            }
        }
    }
}

// MARK: - Setup SwiftyMenu Views Functions

extension SwiftyMenu {
    private func setupUI () {
        setupView()
        getViewWidth()
        getViewHeight()
        setupSelectButton()
        setupDataTableView()
        setupSeparatorStyle()
    }

    public func setupSeparatorStyle() {
        itemsTableView.separatorStyle = attributes.separatorStyle.separatorStyleValues.style
        if attributes.separatorStyle.separatorStyleValues.isBlured {
            itemsTableView.separatorEffect = UIBlurEffect()
        }
        itemsTableView.separatorColor = attributes.separatorStyle.separatorStyleValues.color
    }
    
    private func setupArrowImage() {
        let spacing = self.selectButton.frame.width - 20 // the amount of spacing to appear between image and title
        var imageEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: 0)
        if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(spacing))
        }
        selectButton.imageEdgeInsets = imageEdgeInsets
    }
    
    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = attributes.roundCorners.cornerValue ?? 0
        layer.borderWidth = attributes.border.borderValues?.width ?? 0
        layer.borderColor = attributes.border.borderValues?.color.cgColor
    }
    
    private func setupSelectButton() {
        self.addSubview(selectButton)
        
        selectButton.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalTo(self)
            maker.height.equalTo(height)
        }

        let color = attributes.placeHolderStyle.placeHolderValues.textColor
        selectButton.setTitleColor(color, for: .normal)
        UIView.performWithoutAnimation {
            selectButton.setTitle(attributes.placeHolderStyle.placeHolderValues.text, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.titleLabel?.font = attributes.textStyle.textStyleValues.font

        selectButton.imageEdgeInsets.right = width - 16
        selectButton.imageEdgeInsets.left = width - 16
        
        if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
            selectButton.titleEdgeInsets.right = 16
            selectButton.titleEdgeInsets.left = attributes.arrowStyle.arrowStyleValues.isEnabled ? 32 : 16
            selectButton.titleLabel?.lineBreakMode = .byTruncatingHead
        } else {
            selectButton.titleEdgeInsets.right = attributes.arrowStyle.arrowStyleValues.isEnabled ? 32 : 16
            selectButton.titleEdgeInsets.left = 16
            selectButton.titleLabel?.lineBreakMode = .byTruncatingTail
        }

        selectButton.backgroundColor = attributes.headerStyle.headerStyleValues.backgroundColor

        let arrow = attributes.arrowStyle.arrowStyleValues.image

        if attributes.arrowStyle.arrowStyleValues.isEnabled {
            if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
                selectButton.titleEdgeInsets.right = 4
            } else {
                selectButton.titleEdgeInsets.left = 4
            }
            selectButton.setImage(arrow, for: .normal)
        }
        
        if #available(iOS 11.0, *) {
            selectButton.contentHorizontalAlignment = .leading
        } else {
            selectButton.contentHorizontalAlignment = .left
        }
        
        selectButton.addTarget(self, action: #selector(handleMenuState), for: .touchUpInside)
    }
    
    private func setupDataTableView() {
        self.addSubview(itemsTableView)
        
        itemsTableView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalTo(self)
            maker.top.equalTo(selectButton.snp.bottom)
        }
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.rowHeight = CGFloat(attributes.rowStyle.rowStyleValues.height)
        itemsTableView.separatorInset.left = 8
        itemsTableView.separatorInset.right = 8
        itemsTableView.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        itemsTableView.isScrollEnabled = attributes.scroll.isEnabled
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        itemsTableView.showsVerticalScrollIndicator = false
    }
    
    @objc private func handleMenuState() {
        switch self.state {
        case .shown:
            collapseSwiftyMenu()
        case .hidden:
            expandSwiftyMenu()
        }
        state.toggle()
    }
}

// MARK: - Private Functions

extension SwiftyMenu {
    private func getViewWidth() {
        width = self.frame.width
    }
    
    private func getViewHeight() {
        height = self.frame.height
    }
    
    private func setMultiSelectedOptions() {
        let titles = selectedIndecis.mapValues { (index) -> String in
            return items[index].displayableValue
        }
        var selectedTitle = ""
        selectedTitle = titles.values.joined(separator: separatorCharacters ?? ", ")
        UIView.performWithoutAnimation {
            selectButton.setTitle(selectedTitle, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.textStyle.textStyleValues.color, for: .normal)
    }
    
    private func setSingleSelectedOption() {
        UIView.performWithoutAnimation {
            selectButton.setTitle(items[selectedIndex!].displayableValue, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.textStyle.textStyleValues.color, for: .normal)
    }
    
    private func setPlaceholder() {
        UIView.performWithoutAnimation {
            selectButton.setTitle(attributes.placeHolderStyle.placeHolderValues.text, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.placeHolderStyle.placeHolderValues.textColor, for: .normal)
    }
    
    private func setSelectedOptionsAsTitle() {
        if attributes.multiSelect.isEnabled {
            if selectedIndecis.isEmpty {
                setPlaceholder()
            } else {
                setMultiSelectedOptions()
            }
        } else {
            if selectedIndex == nil {
                setPlaceholder()
            } else {
                setSingleSelectedOption()
            }
        }
    }
}

// MARK: - SwiftyMenu Expand and Collapse Functions

extension SwiftyMenu {
    /// Called to Expand `SwiftyMenu`.
    private func expandSwiftyMenu() {
        delegate?.swiftyMenu(willExpand: self)
        self.willExpand()
        heightConstraint.constant = attributes.height.listHeightValue == 0 || !attributes.scroll.isEnabled || (CGFloat(Double(attributes.rowStyle.rowStyleValues.height) * Double(items.count + 1)) < CGFloat(attributes.height.listHeightValue)) ? CGFloat(Double(attributes.rowStyle.rowStyleValues.height) * Double(items.count + 1)) : CGFloat(attributes.height.listHeightValue)

        switch attributes.expandingAnimation {
        case .linear:
            UIView.animate(withDuration: attributes.expandingTiming.animationTimingValues.duration,
                           delay: attributes.expandingTiming.animationTimingValues.delay,
                           animations: animationBlock,
                           completion: expandingAnimationCompletionBlock)
            
        case .spring(level: let powerLevel):
            let damping = CGFloat(0.5 / powerLevel.rawValue)
            let initialVelocity = CGFloat(0.5 * powerLevel.rawValue)
            
            UIView.animate(withDuration: attributes.expandingTiming.animationTimingValues.duration,
                           delay: attributes.expandingTiming.animationTimingValues.delay,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialVelocity,
                           options: [],
                           animations: animationBlock,
                           completion: expandingAnimationCompletionBlock)
        }
    }
    
    /// Called to Collapse `SwiftyMenu`.
    private func collapseSwiftyMenu() {
        delegate?.swiftyMenu(willCollapse: self)
        self.willCollapse()
        heightConstraint.constant = CGFloat(attributes.headerStyle.headerStyleValues.height)
        
        switch attributes.collapsingAnimation {
        case .linear:
            UIView.animate(withDuration: attributes.collapsingTiming.animationTimingValues.duration,
                           delay: attributes.collapsingTiming.animationTimingValues.delay,
                           animations: animationBlock,
                           completion: collapsingAnimationCompletionBlock)
            
        case .spring(level: let powerLevel):
            let damping = CGFloat(1.0 * powerLevel.rawValue)
            let initialVelocity = CGFloat(10.0 * powerLevel.rawValue)
            
            UIView.animate(withDuration: attributes.collapsingTiming.animationTimingValues.duration,
                           delay: attributes.collapsingTiming.animationTimingValues.delay,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialVelocity,
                           options: .curveEaseIn,
                           animations: animationBlock,
                           completion: collapsingAnimationCompletionBlock)
        }
    }
}

// MARK: - SwiftyMenu Animation Functions

extension SwiftyMenu {
    private func animationBlock() {
        if attributes.arrowStyle.arrowStyleValues.isEnabled {
            self.selectButton.imageView?.transform = self.selectButton.imageView!.transform.rotated(by: CGFloat.pi)
        }
        self.parentViewController?.view.layoutIfNeeded()
    }
    
    private func expandingAnimationCompletionBlock(didAppeared: Bool) {
        if didAppeared {
            self.delegate?.swiftyMenu(didExpand: self)
            self.didExpand()
        }
    }
    
    private func collapsingAnimationCompletionBlock(didAppeared: Bool) {
        if didAppeared {
            self.delegate?.swiftyMenu(didCollapse: self)
            self.didCollapse()
        }
    }
}
