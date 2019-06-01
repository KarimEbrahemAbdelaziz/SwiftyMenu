//
//  SwiftMenuDisplayable.swift
//  Pods-SwiftyMenu_Example
//
//  Created by Amr Elghadban (AmrAngry) on 5/31/19.
//

import Foundation

// Markable interface for pathing datasource objects in late binding
public protocol SwiftMenuDisplayable {
    var displayValue: String { get }
    var valueToRetrive: Any { get }
}
