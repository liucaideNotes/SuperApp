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
    static func sp_LabelSize(_ text:String, font:UIFont, size:CGSize) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
//        let textttt = SP_ToolOC.changeLineSpacing(SP_ToolOC.getSeparatedLinesFromtext(text, font: font, maxWidth: size.width))
//        var labelSize = textttt?.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
//        labelSize?.height = ceil(labelSize!.height)
//        labelSize?.width = ceil(labelSize!.width)
//        return labelSize!
        let options:NSStringDrawingOptions =  [.usesLineFragmentOrigin,.usesFontLeading]
        
        var labelSize = text.boundingRect(with: size, options:options, attributes:attributes,context: nil ).size
        labelSize.height = ceil(labelSize.height)
        labelSize.width = ceil(labelSize.width)
        return labelSize
    }
    
    
    
    
    
}
