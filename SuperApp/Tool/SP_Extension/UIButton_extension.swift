//
//  UIButton_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit

extension UIButton {
    class func xzButtonFrame(_ frame:CGRect, text:String = "", image:String = "", bgImage:String = "", textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true , blod:Bool = false) -> UIButton {
        let button = UIButton()
        button.frame = frame
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        if blod {
            if xzFont {
                button.titleLabel!.font = UIFont.xzFontBold(font)
            }else{
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                button.titleLabel!.font = UIFont.xzFont(font)
            }else{
                button.titleLabel!.font = UIFont.systemFont(ofSize: font)
            }
        }
        if !image.isEmpty {
            button.setImage(UIImage(named: image), for: .normal)
        }
        if !bgImage.isEmpty {
            button.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        
        
        return button
    }
    class func xzButtonBounds(_ center:CGPoint, width:CGFloat, height:CGFloat, text:String = "", image:String = "", bgImage:String = "", textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true , blod:Bool = false) -> UIButton {
        let button = UIButton()
        button.center = center
        button.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        if blod {
            if xzFont {
                button.titleLabel!.font = UIFont.xzFontBold(font)
            }else{
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                button.titleLabel!.font = UIFont.xzFont(font)
            }else{
                button.titleLabel!.font = UIFont.systemFont(ofSize: font)
            }
        }
        if !image.isEmpty {
            button.setImage(UIImage(named: image), for: .normal)
        }
        if !bgImage.isEmpty {
            button.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        
        
        return button
    }
    
}
