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
    
    /// `didDselectItem` is a completion closure that will be executed when deselect an item from `SwiftyMenu`.
    /// - Parameters:
    ///   - swiftyMenu: The `SwiftyMenu` that was deselected from it's items.
    ///   - item: The `Item` that had been deselected from `SwiftyMenu`.
    ///   - index: The `Index` of the deselected `Item`.
    public var didDeselectItem: ((_ swiftyMenu: SwiftyMenu,_ item: SwiftyMenuDisplayable,_ index: Int) -> Void) = { _, _, _ in }
    
    // MARK: - Private Properties
    
    private var selectButton: UIButton!
    private var itemsTableView: UITableView!
    private var state: SwiftyMenuState = .hidden
    private var width: CGFloat!
    private var height: CGFloat!
    private var setuped: Bool = false
    private var attributes: SwiftyMenuAttributes!
    private var hasError: Bool = false
    
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
            setuped = true
            changeTintColorArrow(hasError: hasError)
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
    
    /// change style for Error  from Code.
    public func setError(hasError: Bool){
        self.hasError = hasError
        if attributes.multiSelect.isEnabled {
            if selectedIndecis.isEmpty {
                selectButton.setTitleColor(hasError ? attributes.errorInfo.errorInfoValues.placeholderTextColor : attributes.placeHolderStyle.placeHolderValues.textColor, for: .normal)
            } else {
                selectButton.setTitleColor(hasError ? attributes.errorInfo.errorInfoValues.placeholderTextColor : attributes.textStyle.textStyleValues.color, for: .normal)
            }
        } else {
            if selectedIndex == nil {
                selectButton.setTitleColor(hasError ? attributes.errorInfo.errorInfoValues.placeholderTextColor : attributes.placeHolderStyle.placeHolderValues.textColor, for: .normal)
            } else {
                selectButton.setTitleColor(hasError ? attributes.errorInfo.errorInfoValues.placeholderTextColor : attributes.textStyle.textStyleValues.color, for: .normal)
            }
        }
        
        changeTintColorArrow(hasError: hasError)
    }
    
    private func changeTintColorArrow(hasError: Bool){
        if attributes.arrowStyle.arrowStyleValues.isEnabled {
            if let image = attributes.arrowStyle.arrowStyleValues.image{
                if let tintColor = attributes.arrowStyle.arrowStyleValues.tintColor{
                    selectButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                    selectButton.tintColor = (hasError ? (attributes.errorInfo.errorInfoValues.iconTintColor ?? tintColor) : tintColor)
                }else{
                    if hasError, let errorColor = attributes.errorInfo.errorInfoValues.iconTintColor{
                        selectButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                        selectButton.tintColor = (errorColor)
                    }else{
                        selectButton.tintColor = nil
                        selectButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
            selectButton.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource Functions

extension SwiftyMenu: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! SwiftyMenuCell
        cell.textLabel?.text = items[indexPath.row].displayableValue
        cell.textLabel?.textColor = attributes.textStyle.textStyleValues.color
        cell.textLabel?.font = attributes.textStyle.textStyleValues.font
        cell.tintColor = attributes.textStyle.textStyleValues.color
        cell.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        cell.selectionStyle = .none
        cell.leftMargin = attributes.itemMarginHorizontal.leadingValue
        cell.rightMargin = attributes.itemMarginHorizontal.trailingValue
        cell.isContentRightToLeft = self.isContentRightToLeft()
        
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
                let deselectedText = self.items[selectedIndecis[indexPath.row]!]
                delegate?.swiftyMenu(self, didDeselectItem: deselectedText, atIndex: indexPath.row)
                self.didDeselectItem(self, deselectedText, indexPath.row)
                selectedIndecis[indexPath.row] = nil
                setSelectedOptionsAsTitle()
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                //clean arrow color for error
                if hasError && selectedIndecis.isEmpty{
                    hasError = false
                    changeTintColorArrow(hasError: hasError)
                }
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
                switch attributes.multiSelect{
                case .disabled(let allowSingleDeselection):
                    if allowSingleDeselection{
                        let deselectedText = self.items[self.selectedIndex!]
                        delegate?.swiftyMenu(self, didDeselectItem: deselectedText, atIndex: indexPath.row)
                        self.didDeselectItem(self, deselectedText, indexPath.row)
                        selectedIndex = nil
                        setSelectedOptionsAsTitle()
                        tableView.reloadData()
                    }
                default:
                    break
                }
                
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                //clean arrow color for error
                if hasError && selectedIndex == nil{
                    hasError = false
                    changeTintColorArrow(hasError: hasError)
                }
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
    
    private func isContentRightToLeft() -> Bool{
        return UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft
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
        
        let isContentRightToLeft = isContentRightToLeft()
        
        let lineBreakMode: NSLineBreakMode = isContentRightToLeft ? .byTruncatingHead : .byTruncatingTail
        let isArrowEnable: Bool = attributes.arrowStyle.arrowStyleValues.isEnabled
        let arrow = isArrowEnable ? attributes.arrowStyle.arrowStyleValues.image : nil
        let leftPadding = isContentRightToLeft ? attributes.titleMarginHorizontal.trailingValue : attributes.titleMarginHorizontal.leadingValue
        let rightPadding = isContentRightToLeft ? attributes.titleMarginHorizontal.leadingValue : attributes.titleMarginHorizontal.trailingValue
        let font = self.attributes.textStyle.textStyleValues.font
        let placeholderTextColor = attributes.placeHolderStyle.placeHolderValues.textColor
        let spacingBetweenText = isArrowEnable ? attributes.arrowStyle.arrowStyleValues.spacingBetweenText : 0.0
        
        selectButton.backgroundColor = attributes.headerStyle.headerStyleValues.backgroundColor
        
        
        selectButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if #available(iOS 15.0, *){
            
            var btnConfig = UIButton.Configuration.plain()
            btnConfig.titleAlignment = .leading
            btnConfig.imagePlacement = .trailing
            btnConfig.image = arrow
            btnConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leftPadding, bottom: 0, trailing: rightPadding - 2)
            btnConfig.imagePadding = spacingBetweenText //spacing between image and icon
            btnConfig.image =  arrow
            btnConfig.titleLineBreakMode = lineBreakMode
            btnConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = font
                return outgoing
            }
            selectButton.configuration = btnConfig
            selectButton.translatesAutoresizingMaskIntoConstraints = false
            selectButton.contentMode = .scaleAspectFit
            selectButton.contentHorizontalAlignment = (isArrowEnable ? .fill : .leading)
            selectButton.clipsToBounds = true
            selectButton.setTitleColor(color, for: .normal)
        }else{
            if #available(iOS 11.0, *) {
                selectButton.contentHorizontalAlignment = .leading
            } else {
                selectButton.contentHorizontalAlignment = .left
            }
            
            selectButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
            selectButton.titleLabel?.lineBreakMode = lineBreakMode
            selectButton.titleLabel?.font = font
            selectButton.setTitleColor(placeholderTextColor, for: .normal)
            
            self.selectButton?.imageView?.contentMode = .scaleAspectFit
            
            self.selectButton.setImage(arrow, for: .normal)
            
            let imageWidth: CGFloat  = isArrowEnable ? (arrow?.size.width ?? .zero) : 0
            
            
            var adjustImageEdgeInsets: UIEdgeInsets = .zero
            var adjustTitleEdgeInsets: UIEdgeInsets = .zero
            
            let arrowRight = rightPadding + imageWidth
            
            if isContentRightToLeft {
                adjustImageEdgeInsets.left = leftPadding
                adjustImageEdgeInsets.right = width - arrowRight - spacingBetweenText
                
                adjustTitleEdgeInsets.left = arrowRight + spacingBetweenText
                adjustTitleEdgeInsets.right = -imageWidth + rightPadding
            }else{
                adjustImageEdgeInsets.left = width - arrowRight
                adjustImageEdgeInsets.right = rightPadding
                
                adjustTitleEdgeInsets.left = -imageWidth + leftPadding
                adjustTitleEdgeInsets.right = arrowRight + spacingBetweenText
            }
            
            
            self.selectButton.imageEdgeInsets = adjustImageEdgeInsets
            self.selectButton.titleEdgeInsets = adjustTitleEdgeInsets
            
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
        itemsTableView.separatorInset.left = 0
        itemsTableView.separatorInset.right = 0
        itemsTableView.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        itemsTableView.isScrollEnabled = attributes.scroll.isEnabled
        itemsTableView.register(SwiftyMenuCell.self, forCellReuseIdentifier: "OptionCell")
        itemsTableView.showsVerticalScrollIndicator = false
    }
    
    @objc private func handleMenuState() {
        print("swiftyMenuDelegateSpy handleMenuState: \(self.state)")
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
        let sortedSelectedIndecis = selectedIndecis.sorted { $0.key < $1.key }
        let titles = sortedSelectedIndecis.map { (index, _) -> String in
            return items[index].displayableValue
        }
        var selectedTitle = ""
        selectedTitle = titles.joined(separator: separatorCharacters ?? ", ")
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
            print("expandSwiftyMenu linear")
            UIView.animate(withDuration: attributes.expandingTiming.animationTimingValues.duration,
                           delay: attributes.expandingTiming.animationTimingValues.delay,
                           animations: animationBlock,
                           completion: expandingAnimationCompletionBlock)
            
        case .spring(level: let powerLevel):
            print("expandSwiftyMenu spring")
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
        print("didAppeared: \(didAppeared)")
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
