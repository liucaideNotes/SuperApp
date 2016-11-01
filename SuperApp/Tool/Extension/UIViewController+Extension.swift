//
//  UIViewController+Extension.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/10/14.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

extension UIViewController {
    class func initVC() -> UIViewController {
        return self.init()//为什么self能用？？？？？？？
    }
    class func initVC2() -> UIViewController {
        return UIViewController()
    }
}
