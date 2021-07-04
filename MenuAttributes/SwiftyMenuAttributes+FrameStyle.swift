//
//  SwiftyMenuAttributes+FrameStyle.swift
//
//  Copyright (c) 2019-2021 Karim Ebrahem (https://twitter.com/k_ebrahem_)
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
import CoreGraphics
import UIKit

public extension SwiftyMenuAttributes {

    enum ListHeight {

        case `default`
        case value(height: Int)

        var listHeightValue: Int {
            switch self {
            case let .value(height):
                return height
            case .default:
                return 0
            }
        }

    }

    /** Corner radius of the entry - Specifies the corners */
    enum RoundCorners {

        /** *None* of the corners will be round */
        case none

        /** *All* of the corners will be round */
        case all(radius: CGFloat)

        var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }

        var cornerValue: CGFloat? {
            switch self {
            case let .all(radius):
                return radius
            case .none:
                return nil
            }
        }
    }

    /** The border around the entry */
    enum Border {

        /** No border */
        case none

        /** Border wirh color and width */
        case value(color: UIColor, width: CGFloat)

        var hasBorder: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }

        var borderValues: (color: UIColor, width: CGFloat)? {
            switch self {
            case .value(color: let color, width: let width):
                return(color: color, width: width)
            case .none:
                return nil
            }
        }
    }
}
