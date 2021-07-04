//
//  MealSize.swift
//  SwiftyMenu_Example
//
//  Created by Karim Ebrahem on 03/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyMenu

struct MealSize {
    let id: Int
    let name: String
}

extension MealSize: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self.name
    }

    public var retrievableValue: Any {
        return self.id
    }
}
