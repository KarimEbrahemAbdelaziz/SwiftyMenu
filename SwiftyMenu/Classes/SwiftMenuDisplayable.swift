//
//  SwiftMenuDisplayable.swift
//  Pods-SwiftyMenu_Example
//
//  Created by Amr Elghadban (AmrAngry) on 5/31/19.
//

import Foundation

/**
 Markable interface allow custom types to be used with SwiftyMenu
 
 ## Important Notes ##
 1. Conform this protocol in the type you want to use in the Menu.
 2. displayableValue: This is the value from your type will be displayed in the Menu.
 3. retrivableValue: This is the value will be returned when select Menu Item.
*/
public protocol SwiftyMenuDisplayable {
    /// The value that will be displayed in the menu item
    var displayableValue: String { get }
    
    /// The value that will be returned when select menu item
    var retrivableValue: Any { get }
}
