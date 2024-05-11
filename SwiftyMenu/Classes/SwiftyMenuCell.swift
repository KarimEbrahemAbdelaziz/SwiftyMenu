//
//  SwiftyMenuCell.swift
//
//  Copyright (c) 2019-2024 Karim Ebrahem (https://www.linkedin.com/in/karimebrahem)
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

class SwiftyMenuCell: UITableViewCell {
    var rightMargin: CGFloat = 0.0
    var leftMargin: CGFloat = 0.0
    var isContentRightToLeft: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isContentRightToLeft {
            textLabel?.frame.origin.x = rightMargin
            textLabel?.frame.size.width = contentView.frame.width - rightMargin - leftMargin
            textLabel?.textAlignment = .right
        } else {
            textLabel?.frame.origin.x = leftMargin
            textLabel?.frame.size.width = contentView.frame.width - rightMargin - leftMargin
            textLabel?.textAlignment = .left
        }
    }
}
