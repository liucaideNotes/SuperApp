//
//  AppDelegate+Extension.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    //MARK:----------- 状态栏全局样式
    func setupGlobalStyle() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        //JFProgressHUD.setupHUD() // 配置HUD
    }
    //MARK:----------- 配置根控制器
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if isNewVersion() {
            let vc = ViewController()
            window?.rootViewController = vc
            vc.sp_firstOpenBlock = { _ in
                
                let vc = SP_MainVC.initVC()
                self.window?.rootViewController = vc
                self.saveVersion()
            }
        }else{
            let vc = SP_MainVC.initVC()
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }
    
    //MARK:----------- 判断是否是新版本
    private func isNewVersion() -> Bool {
        // 获取当前的版本号
        let versionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        print(versionString)
        let nowVersion = versionString
        // 获取到之前的版本号
        let oldVersion: String = SP_UserDefaultsGet(key:"oldVersionKey") as! String
        // 对比
        return nowVersion > oldVersion
    }
    //MARK:----------- 保存当前版本号
    private func saveVersion() {
        // 获取当前的版本号
        let nowVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        // 保存当前版本号
        SP_UserDefaultsSet(key:"oldVersionKey", obj:nowVersion as AnyObject)
        SP_UserDefaultsSyn()
    }
    
    
}
