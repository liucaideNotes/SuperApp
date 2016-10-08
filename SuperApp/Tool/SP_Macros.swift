//
//  SP_Macros.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/4.
//  Copyright © 2016年 sifenzi_Home. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

//全局设置 简化 NSUserDefaults 的写法
//MARK:----------- 基本数据
var SP_UserIsLogin: Bool {
    let isLogin = ((SP_UserDefaultsGet(key: UserId) as! String).isEmpty) ? false : true
    return isLogin
}
//MARK:-------- 全局 常量 设置
let NewVersion = "NewVersion"  // 是否处于审核期的新版本
let UpdateVersionTime = "UpdateVersionTime"
/// 首次启动app
let NotFirstLaunch = "NotFirstLaunch"
/// UUID
let SP_UUID       = "SPUUID"
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

//MARK:------------- SP_UserDefaults
func SP_UserDefaultsSet(key:String, obj:AnyObject) -> Void {
    return UserDefaults.standard.set(obj, forKey: key)
}
func SP_UserDefaultsGet(key:String) -> AnyObject {
    if (UserDefaults.standard.value(forKey: key) != nil) {
        return UserDefaults.standard.value(forKey: key) as AnyObject
    }
    return "" as AnyObject
}
func SP_UserDefaultsRemo(key:String) -> Void {
    UserDefaults.standard.removeObject(forKey: key)
}
func SP_UserDefaultsBool(key:String) -> Bool {
    // -- 我们确保审核人员手里的APP屏蔽一些东西
    if key == NewVersion && (SP_UserDefaultsGet(key: UserMobile) as! String == "13148491140" || SP_UserDefaultsGet(key: UserName) as! String == "test123456") {
        return true
    }
    return UserDefaults.standard.bool(forKey: key)
}
func SP_UserDefaultsSetBool(key:String, value:Bool) -> Void {
    
    return UserDefaults.standard.set(value, forKey: key)
}
func SP_UserDefaultsSyn() {
    UserDefaults.standard.synchronize()
}
//MARK:-----------重载运算符 实现两个字典合并为一个字典
func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
//MARK:----------- 屏幕  屏幕宽高 宽高比
let SP_MainWindow = UIApplication.shared.delegate!.window!!
let SP_ScreenMidX: CGFloat = UIScreen.main.bounds.midX
let SP_ScreenMidY: CGFloat = UIScreen.main.bounds.midY
let SP_ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
let SP_ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
let SP_ScreenRatio: CGFloat = SP_ScreenWidth / SP_ScreenHeight
//MARK:----------- 设备
func Iphone() -> String {
    if SP_ScreenHeight == 667 {
        return "6"
    }
    if SP_ScreenHeight == 736{
        return "6+"
    }
    if SP_ScreenHeight == 480{
        return "4"
    }
    return "5"
}

//MARK:----------- 导航栏 底部栏 和各减去 高度
let SP_NaviHeight: CGFloat = 64.0
let SP_TabBarHeight: CGFloat = 49.0
let SP_ViewH_Navi:CGFloat = UIScreen.main.bounds.size.height - 64
let SP_ViewH_Tab:CGFloat = UIScreen.main.bounds.size.height - 49
let SP_ViewH_Navi_Tab:CGFloat = UIScreen.main.bounds.size.height - 64 - 49
//MARK:---------- 传过来的 View 的 宽 高
func SP_ViewWidth(view: AnyObject) -> CGFloat {
    return view.bounds.size.width
}
func SP_ViewHeight(view: AnyObject) -> CGFloat {
    return view.bounds.size.height
}
func SP_ViewHeight_Navi(view: AnyObject) -> CGFloat {
    return view.bounds.size.height - 64
}
func SP_ViewHeight_Navi_Tab(view: AnyObject) -> CGFloat {
    return view.bounds.size.height - 64 - 49
}
//--- 组头 组尾 高度
let SP_SectionH_Top: CGFloat = 40.0
let SP_SectionH_Foot: CGFloat = 5.0
let SP_SectionH_Min: CGFloat = 0.0001



func nullCell(tableView:UITableView, indexPath:NSIndexPath, cellId:String = "CellID_null", remove:Bool = true, lineHidden:Bool = false) -> UITableViewCell {
    let cellID_null = cellId
    var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
    if (cell == nil)
    {
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID_null)
    }
    if remove {
        for  view in cell!.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    cell!.selectionStyle = UITableViewCellSelectionStyle.none
//    cell?.backgroundColor = UIColor.xzMainColorBackground()
//    if !lineHidden {
//        UIView.xzSetLineView(cell!, placeType: .Bottom)
//    }
    return cell!
}

let itemID_null = "itemID_null"
func nullItem(collectionView:UICollectionView, indexPath:IndexPath, cellId:String = itemID_null, remove:Bool = true) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    if remove {
        for suItem in cell.subviews {
            suItem.removeFromSuperview()
        }
    }
    
    return cell
}

/// 是否安装微信
//var haveWeixin:Bool {
//get{
//    return WXApi.isWXAppInstalled()
//}
//}
