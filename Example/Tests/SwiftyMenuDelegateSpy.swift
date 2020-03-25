//
//  SwiftyMenuDelegateSpy.swift
//  SwiftyMenu_Example
//
//  Created by Karim Ebrahem on 3/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import SwiftyMenu

class SwiftyMenuDelegateSpy: SwiftyMenuDelegate {
    var willExpandCalled = false
    var didExpandCalled = false
    var willCollapseCalled = false
    var didCollapseCalled = false
    
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        
    }
    
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        willExpandCalled = true
    }
    
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        didExpandCalled = true
    }
    
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        willCollapseCalled = true
    }
    
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        didCollapseCalled = true
    }
}
