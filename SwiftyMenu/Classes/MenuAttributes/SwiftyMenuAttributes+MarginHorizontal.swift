//
//  SwiftyMenuAttributes+MarginHorizontal.swift
//  SwiftyMenu
//
//  Created by Jordan Rojas Alarcon on 8/12/23.
//

import Foundation
import UIKit

public extension SwiftyMenuAttributes {
    enum MarginHorizontal {
        
        case `default`
        case value(leading: CGFloat, trailing: CGFloat)
        
        var leadingValue: CGFloat {
            switch self {
            case let .value(leading, _):
                return leading
            case .default:
                return 16.0 // Default leading margin
            }
        }
        
        var trailingValue: CGFloat {
            switch self {
            case let .value(_, trailing):
                return trailing
            case .default:
                return 16.0 // Default trailing margin
            }
        }
    }
}
