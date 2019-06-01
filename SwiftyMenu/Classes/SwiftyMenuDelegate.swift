//
//  SwiftyMenuDelegate.swift
//  SwiftyMenu
//
//  Created by Karim Ebrahem on 4/20/19.
//

import Foundation

public protocol SwiftyMenuDelegate: NSObjectProtocol {
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftMenuDisplayable, _ index: Int)
    func swiftyMenuWillAppear(_ swiftyMenu: SwiftyMenu)
    func swiftyMenuDidAppear(_ swiftyMenu: SwiftyMenu)
    func swiftyMenuWillDisappear(_ swiftyMenu: SwiftyMenu)
    func swiftyMenuDidDisappear(_ swiftyMenu: SwiftyMenu)
}

public extension SwiftyMenuDelegate {
    func swiftyMenuWillAppear(_ swiftyMenu: SwiftyMenu) { }
    
    func swiftyMenuDidAppear(_ swiftyMenu: SwiftyMenu) { }
    
    func swiftyMenuWillDisappear(_ swiftyMenu: SwiftyMenu) { }
    
    func swiftyMenuDidDisappear(_ swiftyMenu: SwiftyMenu) { }
}
