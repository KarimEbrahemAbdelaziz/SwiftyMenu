//
//  SwiftyMenuAttributes.swift
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

public struct SwiftyMenuAttributes {

    /**
     A settable **optional** name that matches the menu-attributes.
     */
    public var name: String?

    /**
     Describes the scrolling behaviour of the menu.
     */
    public var scroll = Scroll.enabled

    /**
     Describes the accessory behaviour of the menu.
     */
    public var accessory = Accessory.enabled

    /**
     Describes the selection behaviour of the menu.
     */
    public var multiSelect = MultiSelection.enabled

    /**
     Describes the after selection behaviour of the menu.
     */
    public var hideOptionsWhenSelect = HideMenuWhenSelection.enabled

    /**
     Describes the style for row of the menu.
     */
    public var rowStyle = RowStyle.default

    /**
     Describes the style for header of the menu.
     */
    public var headerStyle = HeaderStyle.value(backgroundColor: .clear, height: 40)

    /**
     Describes the style for arrow of the menu.
     */
    public var arrowStyle = ArrowStyle.default

    /**
     Describes the style for separator of the menu.
     */
    public var separatorStyle = SeparatorStyle.default

    /**
     Describes the style for text of the menu.
     */
    public var textStyle = TextStyle.default

    /**
     Describes the style for row of the menu.
     */
    public var placeHolderStyle = PlaceHolderStyle.value(text: "", textColor: .black)

    /** The corner attributes */
    public var roundCorners = RoundCorners.none

    /** The border around the menue */
    public var border = Border.none

    /** The height of the menue */
    public var height = ListHeight.default

    /** Describes how the menu animates while expanding */
    public var expandingAnimation = Animation.linear

    /** Describes how the menu animates while collapsing */
    public var collapsingAnimation = Animation.linear

    /** Describes how long the menu animates while expanding */
    public var expandingTiming = AnimationTiming.default

    /** Describes how long the menu animates while collapsing */
    public var collapsingTiming = AnimationTiming.default

    /** Init with default attributes */
    public init() {}
}
