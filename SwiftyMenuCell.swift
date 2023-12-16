//
//  SwiftyMenuCell.swift
//  SwiftyMenu
//
//  Created by Jordan Rojas Alarcon on 8/12/23.
//

import Foundation

class SwiftyMenuCell: UITableViewCell {
    var rightMargin: CGFloat = 0.0
    var leftMargin: CGFloat = 0.0
    var isContentRightToLeft: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust the horizontal padding for the textLabel
        textLabel?.frame.origin.x = isContentRightToLeft ? rightMargin : leftMargin
        textLabel?.frame.size.width = contentView.frame.width - rightMargin - leftMargin
    }
}
