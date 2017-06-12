//
//  UINavi_TabBar+Extension.swift
//  carpark
//
//  Created by 刘才德 on 2017/1/13.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import UIKit

private var key: Void?
private var naviLine: UIView?
extension UINavigationController {
    //隐藏分割线
    func sp_setNavigationBarLine(_ bgColor:UIColor = UIColor.clear, imageName:String="") {
        //去掉顶部线条
        
        if imageName.isEmpty {
            let rect = CGRect(x: 0, y: 0, width: sp_ScreenWidth, height: 64)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(bgColor.cgColor)
            context!.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.navigationBar.setBackgroundImage(image, for: .default)
        }else{
            self.navigationBar.setBackgroundImage(UIImage(named:imageName), for: .default)
        }
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        
    }
    
    
    
    
    //MARK:--- 滚动时动态修改NavigationBar颜色
    /**
     滚动时动态修改NavigationBar颜色
     - parameter color: 颜色
     */
    var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    private func sp_changeColor(bgColor: UIColor = UIColor.white, tintColor:UIColor = UIColor.gray, titleColor:UIColor = UIColor.black, lineColor:(hidden:Bool,color:UIColor) = (true,UIColor.clear)) {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = UIColor.clear
        
        if overlay == nil {
            overlay = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: self.navigationBar.bounds.height + 20))
        }
        overlay?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationBar.insertSubview(self.overlay!, at: 0)
        overlay?.backgroundColor = bgColor
        
        self.navigationBar.tintColor = tintColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:titleColor]
        
        if overlay != nil && naviLine == nil{
            naviLine = UIView(frame: CGRect(x: 0, y: self.navigationBar.bounds.height + 20 - 0.5, width: UIScreen.main.bounds.width, height: 0.5))
            overlay?.addSubview(naviLine!)
        }
        
        naviLine?.backgroundColor = lineColor.color
        naviLine?.isHidden = lineColor.hidden
    }
    /**
     滚动时动态修改NavigationBar颜色
     - parameter color:      颜色
     - parameter offsetY:    当前offsetY
     - parameter maxOffsetY: 偏移量最大值
     */
    func sp_changeColor(offsetY: CGFloat, maxOffsetY: CGFloat, bgColor: UIColor = UIColor.white, tintColor:UIColor = UIColor.gray, titleColor:UIColor = UIColor.black, lineColor:(hidden:Bool,color:UIColor) = (true,UIColor.clear)) {
        
        if offsetY > 0 {
            let alpha = 1 - ((maxOffsetY - offsetY) / maxOffsetY)
            sp_changeColor(bgColor: bgColor.withAlphaComponent(alpha), tintColor:tintColor.withAlphaComponent(alpha), titleColor:titleColor.withAlphaComponent(alpha), lineColor:(lineColor.hidden,lineColor.color.withAlphaComponent(alpha)))
            
            
        } else {
            sp_changeColor(bgColor: bgColor.withAlphaComponent(0), tintColor:tintColor.withAlphaComponent(0), titleColor:titleColor.withAlphaComponent(0), lineColor:(lineColor.hidden,lineColor.color.withAlphaComponent(0)))
        }
    }
    /**
     恢复
     */
    func sp_recover(barTintColor:UIColor = UIColor.white,tintColor:UIColor = UIColor.gray, titleColor:UIColor = UIColor.black) {
        self.navigationBar.setBackgroundImage(nil, for: .default)
        overlay?.removeFromSuperview()
        overlay = nil
        self.navigationBar.barTintColor = barTintColor
        self.navigationBar.backgroundColor = barTintColor
        self.navigationBar.tintColor = tintColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:titleColor]
    }

}


extension UINavigationController {
    
    func sp_setLeft(){
        
        //self.navigationItem.leftBarButtonItems
    }
    
    
    
    
}

extension UIViewController {
    // 一劳永逸去除返回按钮的文字以及去除导航栏底部线条
    open override class func initialize() {
        guard self === UIViewController.self else {
            return
        }
        let dispatchOnce: Void = {
            replaceViewWillAppear()
        }()
        _ = dispatchOnce
    }
    
    // 替换系统的 ViewWillAppear
    private class func replaceViewWillAppear() {
        let originSel = #selector(UIViewController.viewWillAppear(_:))
        let swizzlSel = #selector(UIViewController.sp_viewWillAppear(_:))
        
        let originMethod = class_getInstanceMethod(self, originSel)
        let swizzlMethod = class_getInstanceMethod(self, swizzlSel)
        
        let addMethod = class_addMethod(self, originSel,
                                        method_getImplementation(swizzlMethod),
                                        method_getTypeEncoding(swizzlMethod))
        
        if addMethod {
            class_replaceMethod(self, swizzlSel,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod))
        } else {
            method_exchangeImplementations(originMethod, swizzlMethod)
        }
    }
    
    func sp_viewWillAppear(_ animated: Bool) {
        self.sp_viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
        
        //self.navigationController?.setNavigationBarLine()
    }

}



