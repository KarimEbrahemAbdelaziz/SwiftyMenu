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
    
    private let dropDownOptionsDataSource = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5",
                                             "Option 6", "Option 7", "Option 8", "Option 9", "Option 10",
                                             "Option 11", "Option 12", "Option 13", "Option 14", "Option 15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDown.delegate = self
        dropDown.options = dropDownOptionsDataSource
    }

}

// MARK: - SwiftMenuDelegate

extension ViewController: SwiftyMenuDelegate {
    func didSelectOption(_ selectedOption: String, _ index: Int) {
        print("Selected option: \(selectedOption), at index: \(index)")
    }
    
    func swiftyMenuWillAppear() {
        print("SwiftyMenu will appear.")
    }
    
    func swiftyMenuDidAppear() {
        print("SwiftyMenu did appear.")
    }
    
    func swiftyMenuWillDisappear() {
        print("SwiftyMenu will disappear.")
    }
    
    func swiftyMenuDidDisappear() {
        print("SwiftyMenu did disappear.")
    }
}

