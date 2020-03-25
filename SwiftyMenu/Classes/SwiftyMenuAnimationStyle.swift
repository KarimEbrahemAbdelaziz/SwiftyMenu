//
//  SwiftyMenuAnimationStyle.swift
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

/// Type describing the Animation Styles used to create the animation of Expanding and Collapsing `SwiftyMenu`.
public enum AnimationStyle {
    /// `SwiftyMenu` animation should be linear (Smooth Animation)
    case linear
    
    /// `SwiftyMenu` animation should be spring (Bouncy Animation)
    case spring(level: SpringPowerLevel)
    
    /// Defines how bouncy the animation should be
    ///
    /// - low: Bit of smooth and a bit of bounciness at the end
    /// - normal: Not too bouncy and not too smooth
    /// - high: Too bouncy
    public enum SpringPowerLevel: Double {
        case low = 0.75
        case normal = 1.0
        case high = 1.5
    }
}
