//
//  SP_Constant.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/4.
//  Copyright © 2016年 sifenzi_Home. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
//MARK:--- RxSwift -----------------------------



let sp_Notification = NotificationCenter.default
//import SnapKit
//MARK:---- 打印
func print_SP(_ items:Any){
    print(items)
}

//MARK:----------- 基本数据
var sp_UserIsLogin: Bool {
    let isLogin = ((sp_UserDefaultsGet(UserId) as? String ?? "").isEmpty) ? false : true
    return isLogin
}

//MARK:------------- sp_UserDefaults
//全局设置 简化 NSUserDefaults 的写法
func sp_UserDefaultsSet(_ key:String, obj:Any) -> Void {
    return UserDefaults.standard.set(obj, forKey: key)
}
func sp_UserDefaultsGet(_ key:String) -> Any {
    return UserDefaults.standard.value(forKey: key) ?? ""
}
func sp_UserDefaultsRemo(_ key:String) -> Void {
    UserDefaults.standard.removeObject(forKey: key)
}
func sp_UserDefaultsBool(_ key:String) -> Bool {
    
    return UserDefaults.standard.bool(forKey: key)
}
func sp_UserDefaultsSetBool(_ key:String, value:Bool) -> Void {
    
    return UserDefaults.standard.set(value, forKey: key)
}
func sp_UserDefaultsSyn() {
    UserDefaults.standard.synchronize()
}
//MARK:-----------重载运算符 实现两个字典合并为一个字典
func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
//MARK:----------- 屏幕  屏幕宽高 宽高比
let sp_MainWindow = UIApplication.shared.delegate!.window!!
let sp_ScreenMidX: CGFloat = UIScreen.main.bounds.midX
let sp_ScreenMidY: CGFloat = UIScreen.main.bounds.midY
let sp_ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
let sp_ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
let sp_ScreenRatio: CGFloat = sp_ScreenWidth / sp_ScreenHeight
//MARK:----------- 设备
let sp_iphone:String = {
    if sp_ScreenHeight == 667 {
        return "6"
    }
    if sp_ScreenHeight == 736{
        return "6+"
    }
    if sp_ScreenHeight == 480{
        return "4"
    }
    return "5"
}()

//MARK:----------- 导航栏 底部栏 和各减去 高度
let sp_NaviHeight: CGFloat = 64.0
let sp_TabBarHeight: CGFloat = 49.0
let sp_ViewH_Navi:CGFloat = UIScreen.main.bounds.size.height - 64
let sp_ViewH_Tab:CGFloat = UIScreen.main.bounds.size.height - 49
let sp_ViewH_Navi_Tab:CGFloat = UIScreen.main.bounds.size.height - 64 - 49
//MARK:---------- 传过来的 View 的 宽 高
func sp_ViewWidth(view: AnyObject) -> CGFloat {
    return view.bounds.size.width
}
func sp_ViewHeight(view: AnyObject) -> CGFloat {
    return view.bounds.size.height
}
func sp_ViewHeight_Navi(view: AnyObject) -> CGFloat {
    return view.bounds.size.height - 64
}
func sp_ViewHeight_Navi_Tab(view: AnyObject) -> CGFloat {
    return view.bounds.size.height - 64 - 49
}
//--- 组头 组尾 高度
let sp_SectionH_Top: CGFloat = 40.0
let sp_SectionH_Foot: CGFloat = 5.0
let sp_SectionH_Min: CGFloat = 0.0001

/// 是否安装微信
//var haveWeixin:Bool {
//get{
//    return WXApi.isWXAppInstalled()
//}
//}

//MARK:----------- 通过字符串获得类
func sp_classFromString(_ className: String) -> AnyClass? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    //2.通过命名空间和类名转换成类
    let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    //(不建议用这种方式，封装成framework就有问题了)
    //let cls : AnyClass? = NSClassFromString(appName + "." + className)
    return cls
}

func sp_vcFromString(_ controllerName : String) -> UIViewController.Type? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    //2.通过命名空间和类名转换成类
    let classStringName = "_TtC\(appName.characters.count)\(appName)\(controllerName.characters.count)\(controllerName)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    
    //(不建议用这种方式，封装成framework就有问题了)
    //let cls : AnyClass? = NSClassFromString(appName + "." + controllerName)
    
    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
    guard let clsType = cls as? UIViewController.Type else {
        print("无法转换成UIViewController")
        return nil
    }
    return clsType
}

//MARK:--- 判断是否为模拟器平台
let sp_isSimulator: Bool = {
    var isSim = false
    #if arch(i386) || arch(x86_64)
        isSim = true
    #endif
    return isSim
}()


//MARK:-------- 全局 常量 设置
let NewVersion = "NewVersion"  // 是否处于审核期的新版本
let UpdateVersionTime = "UpdateVersionTime"
/// 首次启动app
let NotFirstLaunch = "NotFirstLaunch"
/// UUID
let SPUUID       = "SPUUID"
/// 用户名
let UserName      = "UserName"
/// 用户密码
let UserPwd       = "UserPwd"
/// 用户ID
let UserId        = "UserId"
/// 用户账号
let UserMobile    = "UserMobile"
/// 用户头像
let UserHeadImg   = "UserHeadImg"
/// 用户二维码
let UserCodeNum   = "UserCodeNum"
/// 用户二维码图片
let UserCodeQR   =  "UserCodeQR"
