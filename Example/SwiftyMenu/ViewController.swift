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
        dropDown.options = dropDownOptionsDataSource
        
        // Support CallBacks
        dropDown.didExpand = {
            print("SwiftyMenu Expanded!")
        }
        
        dropDown.didCollapse = {
            print("SwiftyMeny Collapsed")
        }
        
        dropDown.didSelectOption = { (selection: Selection) in
            print("\(selection.value) at index: \(selection.index)")
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
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        print("Selected option: \(selectedOption), at index: \(index)")
    }
    
    func swiftyMenuWillAppear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu will appear.")
    }
    
    func swiftyMenuDidAppear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu did appear.")
    }
    
    func swiftyMenuWillDisappear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu will disappear.")
    }
    
    func swiftyMenuDidDisappear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu did disappear.")
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

