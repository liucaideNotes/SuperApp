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
let sp_ntfNameKeyboardWillShow = NSNotification.Name.UIKeyboardWillShow
let sp_ntfNameKeyboardWillHide = NSNotification.Name.UIKeyboardWillHide

//import SnapKit
//MARK:---- 打印
func print_SP(_ items:Any){
    print(items)
}
func print_Json(_ items:Any){
    print(items)
}
//MARK:------------- sp_UserDefaults
//全局设置 简化 NSUserDefaults 的写法
func sp_UserDefaultsSet(_ key:String, value:Any) -> Void {
    return UserDefaults.standard.set(value, forKey: key)
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
var sp_MainWindow: UIWindow!// = UIApplication.shared.delegate!.window!!
let sp_ScreenMidX: CGFloat = UIScreen.main.bounds.midX
let sp_ScreenMidY: CGFloat = UIScreen.main.bounds.midY
let sp_ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
let sp_ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
let sp_ScreenRatio: CGFloat = sp_ScreenWidth / sp_ScreenHeight

//MARK:----------- 设备
enum SP_DeviceType {
    case tiPhone4
    case tiPhone
    case tiPhoneA
    case tiPhoneP
    case tiPad
}
var sp_iphone:SP_DeviceType {
    let ww_hh = sp_ScreenWidth/sp_ScreenHeight
    if (ww_hh == 320.0/480.0 || ww_hh == 480.0/320.0) {return .tiPhone4}
    if (ww_hh == 320.0/568.0 || ww_hh == 568.0/320.0) {return .tiPhone}
    if (ww_hh == 375.0/667.0 || ww_hh == 667.0/375.0) {return .tiPhoneA}
    if (ww_hh == 414.0/736.0 || ww_hh == 736.0/414.0) {return .tiPhoneP}
    return .tiPad
}
//MARK:----------- 屏幕适配尺寸
func sp_fitSize(_ size:(CGFloat,CGFloat,CGFloat)) -> CGFloat {
    switch sp_iphone {
    case .tiPhone4,.tiPhone:
        return size.0
    case .tiPhoneA:
        return size.1
    case .tiPhoneP:
        return size.2
    default:
        return size.2
    }
}
let sp_fitFont11 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 11))
let sp_fitFont12 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 12))
let sp_fitFont13 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 13))
let sp_fitFont14 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 14))
let sp_fitFont15 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 15))
let sp_fitFont16 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 16))
let sp_fitFont18 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 18))
let sp_fitFont20 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 20))
let sp_fitFont22 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 22))
let sp_fitFont30 = UIFont.systemFont(ofSize: SP_InfoOC.sp_fit(withSize: 30))

let sp_fitFontB12 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 12))
let sp_fitFontB14 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 14))
let sp_fitFontB15 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 15))
let sp_fitFontB16 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 16))
let sp_fitFontB18 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 18))
let sp_fitFontB20 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 20))
let sp_fitFontB22 = UIFont.boldSystemFont(ofSize: SP_InfoOC.sp_fit(withSize: 22))
//MARK:--- 语言适配 -----------------------------
func sp_localized(_ key:String, from:String = "Localization") -> String {
    return SP_InfoOC.sp_localizedString(forKey: key, from:from)
}

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
let sp_SectionH_Top: CGFloat = 50.0
let sp_SectionH_Foot: CGFloat = 5.0
let sp_SectionH_Min: CGFloat = 0.0001
//--- 间距
let sp_Space_L: CGFloat = 15.0
let sp_Space_R: CGFloat = 15.0
let sp_Space_T: CGFloat = 15.0
let sp_Space_B: CGFloat = 15.0

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
