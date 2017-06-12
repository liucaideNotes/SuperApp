//
//  UIFont_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
extension UIFont {
    
    class  func xzFont(_ size:CGFloat) -> UIFont {
        if sp_iphone == "6+" {
            return .systemFont(ofSize: size + 2.0)
        }
        if sp_iphone == "6" {
            return .systemFont(ofSize: size + 1.0)
        }
        return .systemFont(ofSize: size)
    }
    class  func xzFontBold(_ size:CGFloat) -> UIFont {
        
        if sp_iphone == "6+" {
            return .boldSystemFont(ofSize: size + 2.0)
        }
        if sp_iphone == "6" {
            return .boldSystemFont(ofSize: size + 1.0)
        }
        return .boldSystemFont(ofSize: size)
    }
}
