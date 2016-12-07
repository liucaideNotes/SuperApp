//
//  UILabel+Extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//


import UIKit

extension UILabel {
    class func xzTextFrame(_ frame:CGRect, text:String, alignment:NSTextAlignment = .left, textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true, blod:Bool = false) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.frame = frame
        titleLabel.textAlignment = alignment
        titleLabel.textColor = textColor
        if blod {
            if xzFont {
                titleLabel.font = UIFont.xzFontBold(font)
            }else{
                titleLabel.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                titleLabel.font = UIFont.xzFont(font)
            }else{
                titleLabel.font = UIFont.systemFont(ofSize: font)
            }
        }
        
        return titleLabel
    }
    
    class func xzTextBounds(_ center:CGPoint, width:CGFloat, height:CGFloat, text:String, alignment:NSTextAlignment = .left, textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true , blod:Bool = false) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.center = center
        titleLabel.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        titleLabel.textAlignment = alignment
        titleLabel.textColor = textColor
        if blod {
            if xzFont {
                titleLabel.font = UIFont.xzFontBold(font)
            }else{
                titleLabel.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                titleLabel.font = UIFont.xzFont(font)
            }else{
                titleLabel.font = UIFont.systemFont(ofSize: font)
            }
        }
        
        return titleLabel
    }
    
}
