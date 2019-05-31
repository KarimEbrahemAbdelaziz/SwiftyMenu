//
//  UIViewExtensions.swift
//  Pods-SwiftyMenu_Example
//
//  Created by Karim Ebrahem on 4/20/19.
//

import Foundation
import UIKit

extension UIView {
    //Get Parent View Controller from any view
    var parentViewController: UIViewController {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if responder == nil {
                break
            }
        }
        return (responder as? UIViewController)!
    }
}
