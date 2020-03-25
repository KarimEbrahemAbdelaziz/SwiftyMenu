//
//  SwiftyMenuDelegate.swift
//
//  Copyright (c) 2019-2020 Karim Ebrahem (https://twitter.com/k_ebrahem_)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// `SwiftyMenuDelegate` is the delegate interface to delegate different actions of SwiftyMenu.
public protocol SwiftyMenuDelegate: AnyObject {
    /// Called when select an item from `SwiftyMenu`.
    ///
    /// - Parameters:
    ///   - swiftyMenu: The `SwiftyMenu` that was selected from it's items.
    ///   - item: The `Item` that had been selected from `SwiftyMenu`.
    ///   - index: The `Index` of the selected `Item`.
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int)
    
    /// Called when `SwiftyMenu` will going to Expand.
    ///
    /// - Parameter swiftyMenu: The `SwiftyMenu` that is going to Expand.
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu)
    
    /// Called when `SwiftyMenu` Expanded.
    ///
    /// - Parameter swiftyMenu: The `SwiftyMenu` that Expanded.
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu)
    
    /// Called when `SwiftyMenu` will going to Collapse.
    ///
    /// - Parameter swiftyMenu: The `SwiftyMenu` that is going to Collapse.
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu)
    
    /// Called when `SwiftyMenu` Collapsed.
    ///
    /// - Parameter swiftyMenu: The `SwiftyMenu` that Collapsed.
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu)
}

/// `SwiftyMenuDelegate` Default implementation to workaround Optionality.
public extension SwiftyMenuDelegate {
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) { }
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) { }
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) { }
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) { }
}
