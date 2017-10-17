//
//  SP_InfoOC.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import MBProgressHUD

open class SP_Tool {
    fileprivate static let sharedInstance = SP_Tool()
    fileprivate init() {}
    //提供静态访问方法
    open static var shared: SP_Tool {
        return self.sharedInstance
    }
    
    
}

extension SP_Tool {
    
    //MARK:--- 获取本地文件 -----------------------------
    class func sp_ReturnBundleArray(_ path:String, name:String) -> [AnyObject] {
        let path:String = Bundle.main.path(forResource: path, ofType: nil)!
        let dic = NSDictionary(contentsOfFile: path)
        let arr = dic!["\(name)"]
        
        return arr as? [AnyObject] ?? []
    }
    
    
    
    
}
