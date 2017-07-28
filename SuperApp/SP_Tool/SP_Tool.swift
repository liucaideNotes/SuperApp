
//
//  LCD_Tool.swift
//  IEXBUY
//
//  Created by sifenzi on 16/7/13.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
import UIKit
//MARK:---- 获取本地文件
struct SP_Tool{
    static func sp_ReturnBundleArray(_ path:String, name:String) -> [AnyObject] {
        let path:String = Bundle.main.path(forResource: path, ofType: nil)!
        let dic = NSDictionary(contentsOfFile: path)
        let arr = dic!["\(name)"]
        
        return arr as? [AnyObject] ?? []
    }
}
