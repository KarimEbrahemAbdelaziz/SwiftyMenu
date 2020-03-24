//
//  ViewController.swift
//  SwiftyMenu
//
//  Created by KEMansour on 04/17/2019.
//  Copyright (c) 2019 KEMansour. All rights reserved.
//

import UIKit
import SwiftyMenu

class ViewController: UIViewController {

    @IBOutlet private weak var dropDown: SwiftyMenu!
    
    private let dropDownOptionsDataSource = ["Option 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup component
        dropDown.delegate = self
        dropDown.items = dropDownOptionsDataSource
        
        // Support CallBacks
        dropDown.didExpand = {
            print("SwiftyMenu Expanded!")
        }
        
        dropDown.didCollapse = {
            print("SwiftyMeny Collapsed")
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
        dropDown.optionColor = .red
        dropDown.placeHolderColor = .blue
        dropDown.menuHeaderBackgroundColor = .lightGray
        dropDown.rowBackgroundColor = .orange
        
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
    
    public var retrivableValue: Any {
        return self
    }
}

