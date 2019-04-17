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
        
        dropDown.updateConstraints {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        dropDown.didSelectOption { (selectedText, index) in
            print("Selected String: \(selectedText) at index: \(index)")
        }
        
        dropDown.options = dropDownOptionsDataSource
    }

}

