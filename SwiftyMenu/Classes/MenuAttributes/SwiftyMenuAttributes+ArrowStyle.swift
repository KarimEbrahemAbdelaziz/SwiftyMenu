//
//  SwiftyMenuAttributes+ArrowStyle.swift
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
import UIKit

public extension SwiftyMenuAttributes {

    /** Describes the style for row of the menu */
    enum ArrowStyle {

        case `default`

        case value(isEnabled: Bool, image: UIImage? = nil)

        var arrowStyleValues: (isEnabled: Bool, image: UIImage?) {
            let frameworkBundle = Bundle(for: SwiftyMenu.self)
            let defaultImage = UIImage(named: "downArrow", in: frameworkBundle, compatibleWith: nil)!

            switch self {
            case let .value(isEnabled, image):
                if isEnabled && image != nil {
                    return (isEnabled: isEnabled, image: image)
                } else if isEnabled {
                    return (isEnabled: isEnabled, image: defaultImage)
                } else {
                    return (isEnabled: isEnabled, image: nil)
                }
            case .default:
                return (isEnabled: true, image: defaultImage)
            }
        }
    }
}
