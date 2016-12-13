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
    }
    //MARK:----------- 配置根控制器
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if isNewVersion() {
            let vc = SP_GuideVC()
            window?.rootViewController = vc
            vc.SP_firstOpenBlock = { [weak self]_ in
                
                //let vc = SP_MainVC.initSPVC()
                let vc = SP_DrawerVC.initSPVC()
                
                self?.window?.rootViewController = vc
                self?.saveVersion()
            }
        }else{
            //let vc = SP_MainVC.initSPVC()
            let vc = SP_DrawerVC.initSPVC()
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }
    
    private static var tabBar:SP_TabBarController = {
        let viewControllers = [SP_MainVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC()]
        let titles = ["1","2","","4","5"]
        let images = ["30x30","30x30","","30x30","30x30"]
        let selectedImages = ["30x30","30x30","","30x30","30x30"]
        let vc = SP_TabBarController.initTabbar(viewControllers, titles: titles, images: images, selectedImages: selectedImages, selectedIndex: 0)
        vc.setProperty(true, colorNormal: UIColor.maintext_darkgray, colorSelected: UIColor.main_1, titleFontNormal: 12.0, titleFontSelected: 12.0, imageInsets: UIEdgeInsetsMake(0, 0, 0, 0))
        vc.centerMenuButton()
        return vc
    }()
    
    //MARK:----------- 判断是否是新版本
    private func isNewVersion() -> Bool {
        // 获取当前的版本号
        let versionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        print(versionString)
        let nowVersion = versionString
        // 获取到之前的版本号
        let oldVersion: String = SP_UserDefaultsGet("oldVersionKey") as! String
        // 对比
        return nowVersion > oldVersion
    }
    //MARK:----------- 保存当前版本号
    private func saveVersion() {
        // 获取当前的版本号
        let nowVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        // 保存当前版本号
        SP_UserDefaultsSet("oldVersionKey", obj:nowVersion as AnyObject)
        SP_UserDefaultsSyn()
    }
    
    
}
