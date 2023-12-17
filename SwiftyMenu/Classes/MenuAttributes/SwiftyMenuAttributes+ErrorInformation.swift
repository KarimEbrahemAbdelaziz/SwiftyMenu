//
//  SwiftyMenuAttributes+ErrorInformation.swift
//  SwiftyMenu
//
//  Created by Jordan Rojas Alarcon
//

import Foundation
import UIKit

public extension SwiftyMenuAttributes{
    enum ErrorInformation {
        case `default`
        case custom(placeholderTextColor: UIColor = .red, iconTintColor: UIColor? = .red)
        
        public var errorInfoValues: (placeholderTextColor: UIColor, iconTintColor: UIColor?) {
            switch self {
            case .default:
                return (placeholderTextColor: .red, iconTintColor: .red)
            case let .custom(placeholderTextColor, iconTintColor):
                return (placeholderTextColor: placeholderTextColor, iconTintColor: iconTintColor)
            }
        }
    }
}
