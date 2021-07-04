//
//  ViewController.swift
//  SwiftyMenu
//
//  Created by KEMansour on 04/17/2019.
//  Copyright (c) 2019 KEMansour. All rights reserved.
//

import UIKit
import SwiftyMenu
import SnapKit

class ViewController: UIViewController {

    @IBOutlet private weak var dropDown: SwiftyMenu!
    @IBOutlet private weak var otherView: UIView!

    /// Define menu data source
    /// The data source type should conform to `SwiftyMenuDisplayable`
    private let dropDownOptionsDataSource = [
        "Option 1", "Option 2", "Option 3",
        "Option 4", "Option 5", "Option 6",
        "Option 7", "Option 8", "Option 9"
    ]

    private let dropDownCodeOptionsDataSource = [
        MealSize(id: 1, name: "Small"),
        MealSize(id: 2, name: "Medium"),
        MealSize(id: 3, name: "Large"),
        MealSize(id: 4, name: "Combo Large"),
    ]

    /// Define menu attributes
    private var storyboardMenuAttributes: SwiftyMenuAttributes {
        var attributes = SwiftyMenuAttributes()

        // Custom Behavior
        attributes.multiSelect = .enabled
        attributes.scroll = .enabled
        attributes.hideOptionsWhenSelect = .disabled

        // Custom UI
        attributes.roundCorners = .all(radius: 8)
        attributes.rowStyle = .value(height: 35, backgroundColor: .white, selectedColor: UIColor.gray.withAlphaComponent(0.1))
        attributes.headerStyle = .value(backgroundColor: .white, height: 35)
        attributes.placeHolderStyle = .value(text: "Please Select Item", textColor: .lightGray)
        attributes.textStyle = .value(color: .gray, separator: " & ", font: .systemFont(ofSize: 12))
        attributes.separatorStyle = .value(color: .black, isBlured: false, style: .singleLine)
        attributes.arrowStyle = .value(isEnabled: true)
        attributes.height = .value(height: 300)

        // Custom Animations
        attributes.expandingAnimation = .spring(level: .low)
        attributes.expandingTiming = .value(duration: 0.5, delay: 0)

        attributes.collapsingAnimation = .linear
        attributes.collapsingTiming = .value(duration: 0.5, delay: 0)

        return attributes
    }

    private var codeMenuAttributes: SwiftyMenuAttributes {
        var attributes = SwiftyMenuAttributes()

        // Custom Behavior
        attributes.multiSelect = .disabled
        attributes.scroll = .disabled
        attributes.hideOptionsWhenSelect = .enabled

        // Custom UI
        attributes.roundCorners = .all(radius: 8)
        attributes.rowStyle = .value(height: 39, backgroundColor: .white, selectedColor: .white)
        attributes.headerStyle = .value(backgroundColor: .white, height: 40)
        attributes.placeHolderStyle = .value(text: "Please Select Size", textColor: .lightGray)
        attributes.textStyle = .value(color: .gray, separator: " & ", font: .systemFont(ofSize: 12))
        attributes.separatorStyle = .value(color: .black, isBlured: false, style: .singleLine)
        attributes.arrowStyle = .value(isEnabled: false)
        attributes.accessory = .disabled

        // Custom Animations
        attributes.expandingAnimation = .linear
        attributes.expandingTiming = .value(duration: 0.5, delay: 0)

        attributes.collapsingAnimation = .linear
        attributes.collapsingTiming = .value(duration: 0.5, delay: 0)

        return attributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStoryboardMenu()
        setupCodeMenu()
    }

    /// Example of building SwiftyMenu from Storyboard
    private func setupStoryboardMenu() {
        /// Setup component
        dropDown.delegate = self
        dropDown.items = dropDownOptionsDataSource

        /// Configure SwiftyMenu with the attributes
        dropDown.configure(with: storyboardMenuAttributes)
    }

    /// Example of building SwiftyMenu from Code
    private func setupCodeMenu() {

        /// Init SwiftyMenu from Code
        let dropDownCode = SwiftyMenu(frame: CGRect(x: 0, y: 0, width: 0, height: 40))

        /// Add it as subview
        view.addSubview(dropDownCode)

        /// Add constraints to SwiftyMenu
        /// You must take care of `hegiht` constraint, please.
        dropDownCode.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: otherView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 64)
        let widthConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 255)
        dropDownCode.heightConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate(
            [
                horizontalConstraint,
                topConstraint,
                widthConstraint,
                dropDownCode.heightConstraint
            ]
        )

        /// Setup SwiftyMenu data source
        dropDownCode.items = dropDownCodeOptionsDataSource

        /// SwiftyMenu also supports `CallBacks`
        dropDownCode.willExpand = {
            print("SwiftyMenu Code Will Expand!")
        }

        dropDownCode.didExpand = {
            print("SwiftyMenu Code Expanded!")
        }

        dropDownCode.willCollapse = {
            print("SwiftyMenu Code Will Collapse!")
        }

        dropDownCode.didCollapse = {
            print("SwiftyMenu Code Collapsed!")
        }

        dropDownCode.didSelectItem = { _, item, index in
            print("Selected from Code \(item) at index: \(index)")
        }

        /// Configure SwiftyMenu with the attributes
        dropDownCode.configure(with: codeMenuAttributes)
    }

}

// MARK: - SwiftMenuDelegate

extension ViewController: SwiftyMenuDelegate {
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
    
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willExpand.")
    }
    
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didExpand.")
    }
    
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willCollapse.")
    }
    
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didCollapse.")
    }

}
