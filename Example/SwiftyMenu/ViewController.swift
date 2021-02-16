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
    
    private let dropDownOptionsDataSource = ["Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dropDown2 = SwiftyMenu(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        
        view.addSubview(dropDown2)
        
        dropDown2.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: dropDown2, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: dropDown2, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: otherView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 64)
        let widthConstraint = NSLayoutConstraint(item: dropDown2, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 255)
        dropDown2.heightConstraint = NSLayoutConstraint(item: dropDown2, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([horizontalConstraint, topConstraint, widthConstraint, dropDown2.heightConstraint])
        
        // Setup component
        dropDown.delegate = self
        dropDown.items = dropDownOptionsDataSource
        dropDown2.items = dropDownOptionsDataSource
        
        dropDown.placeHolderText = "Please Select Item"
        dropDown2.placeHolderText = "Please Select Item"
        // With this set true, drop down menu will change collapse
        // state when item is selected
        dropDown2.hideOptionsWhenSelect = true
		
		dropDown.separatorCharacters = " & "
		print(dropDown2.selectedIndecis)
        
        // Support CallBacks
        dropDown.didExpand = {
            print("SwiftyMenu Expanded!")
        }
        
        dropDown.didCollapse = {
            print("SwiftyMenu Collapsed!")
        }
        
        dropDown.didSelectItem = { _, item, index in
            print("\(item) at index: \(index)")
        }
        
        // Custom Behavior
        dropDown.scrollingEnabled = true
        dropDown.isMultiSelect = true
        dropDown.hideOptionsWhenSelect = false
        
        // Custom UI
        dropDown.rowHeight = 35
        dropDown.listHeight = 300
        dropDown.borderWidth = 1.0
        
        // Custom Colors
        dropDown.borderColor = .black
        dropDown.itemTextColor = .red
        dropDown.placeHolderColor = .lightGray
        dropDown.menuHeaderBackgroundColor = .white
		dropDown.rowBackgroundColor = .orange
		dropDown.separatorColor = .white
        
        // Custom Animation
        dropDown.expandingAnimationStyle = .spring(level: .low)
        dropDown.expandingDuration = 0.5
        dropDown.collapsingAnimationStyle = .linear
        dropDown.collapsingDuration = 0.5
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

// String extension to conform SwiftyMenuDisplayable for defult behavior
extension String: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self
    }
    
    public var retrievableValue: Any {
        return self
    }
}

