//
//  CGSize_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
extension CGSize {
    static func xzLabelSize(_ text:String, font:UIFont, size:CGSize) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: Dictionary = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var labelSize = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes:attributes,context: nil ).size
        labelSize.height = ceil(labelSize.height)
        labelSize.width = ceil(labelSize.width)
        return labelSize
    }
    
}
