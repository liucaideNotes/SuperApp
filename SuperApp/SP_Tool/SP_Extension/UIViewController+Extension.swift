//
//  UIViewController+Extension.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/10/14.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

extension UIViewController {
    class func initSPVC() -> UIViewController {
        return self.init()
    }
    func sp_Push(_ vc:UIViewController?, animated:Bool = true, completion:(()->Void)? = nil) {
        guard vc != nil else {return}
        self.navigationController?.pushViewController(vc!, animated: animated)
        completion?()
        
    }
    func sp_pop(_ toVC:UIViewController?, animated:Bool = true, completion:(()->Void)? = nil) {
        if toVC == nil {
            _ = self.navigationController?.popViewController(animated: animated)
        }else{
            _ = self.navigationController?.popToViewController(toVC!, animated: animated)
        }
        _ = self.navigationController?.popToRootViewController(animated: animated)
        completion?()
        
    }
    func sp_Present(_ vc:UIViewController?, animated:Bool = true, completion:(()->Void)? = nil) {
        guard vc != nil else {return}
        self.present(vc!, animated: true) {
            completion?()
        }
    }
    func sp_dismis(_ vc:UIViewController?, animated:Bool = true, completion:(()->Void)? = nil) {
        guard vc != nil else {return}
        self.dismiss(animated: animated) {
            completion?()
        }
    }
    
    //MARK:--- VM
    /*
    func vmHeightRow(_ indexPath:IndexPath) -> CGFloat {
        return 0
    }
    func vmCell(_ indexPath:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func vmCell(_ mcell:UITableViewCell, indexPath:IndexPath){}
    func vmCellSelect(_ indexPath:IndexPath) {}
    */
    
    
    /*/ 一劳永逸去除返回按钮的文字以及去除导航栏底部线条
    open override class func initialize() {
        guard self === UIViewController.self else {
            return
        }
        
        // if using swift2.0+
        /*
         struct Static {
         static var onceToken: dispatch_once_t = 0
         }
         dispatch_once(&Static.onceToken) {
         replaceViewWillAppear()
         }
         */
        
        // if using swift3.0+
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
    }*/
}
