//
//  String+Extensions.swift
//  SwiftyMenu_Example
//
//  Created by Karim Ebrahem on 03/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyMenu

extension String: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self
    }

    public var retrievableValue: Any {
        return self
    }
}
