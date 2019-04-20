//
//  SwiftyMenuDelegate.swift
//  SwiftyMenu
//
//  Created by Karim Ebrahem on 4/20/19.
//

import Foundation

public protocol SwiftyMenuDelegate: NSObjectProtocol {
    func didSelectOption(_ selectedOption: String, _ index: Int)
    func swiftyMenuWillAppear()
    func swiftyMenuDidAppear()
    func swiftyMenuWillDisappear()
    func swiftyMenuDidDisappear()
}

public extension SwiftyMenuDelegate {
    func swiftyMenuWillAppear() { }
    
    func swiftyMenuDidAppear() { }
    
    func swiftyMenuWillDisappear() { }
    
    func swiftyMenuDidDisappear() { }
}
