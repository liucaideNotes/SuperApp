//
//  SP_MJRefreshDatas.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/2.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation


//MARK:----------- 下拉刷新文字组
///上下拉闲置状态
let MJRefreshDIY_Title_Idle_Down         = "下拉可以刷新"
let MJRefreshDIY_Title_Idle_Up           = "点击或上拉加载更多"
///上下拉提示松开状态
let MJRefreshDIY_Title_Pulling_Down      = "放手是一种态度"
let MJRefreshDIY_Title_Pulling_Up        = "放手是一种态度"
///上下拉松开正在刷新状态
let MJRefreshDIY_Title_Refreshing_Down   = "洗刷刷洗刷刷"
let MJRefreshDIY_Title_Refreshing_Up     = "洗刷刷洗刷刷"
///上下拉数据加载完毕状态
let MJRefreshDIY_Title_NoMoreData_Down   = "刷新完毕"
let MJRefreshDIY_Title_NoMoreData_Up     = "加载完毕"
///显示刷新状态的Label字体
let MJRefreshDIY_StateLabelFont = UIFont.systemFont(ofSize: 15.0)
///显示刷新状态的Label颜色
let MJRefreshDIY_StateLabelColor = UIColor.gray
///刷新状态的Label是否隐藏
let MJRefreshDIY_StateLabelHidden_Down = true
let MJRefreshDIY_StateLabelHidden_Up   = false
///显示时间Label字体
let MJRefreshDIY_TimeLabelFont = UIFont.systemFont(ofSize: 14.0)
///显示时间Label颜色
let MJRefreshDIY_TimeLabelColor = UIColor.gray.withAlphaComponent(0.8)
///时间Label是否隐藏
let MJRefreshDIY_TimeLabelHidden = true
///文字和图片间的距离
let MJRefreshDIY_LabelLeftInset:CGFloat = 20
//MARK:----------- 下拉刷新动画图片组
///上下拉闲置状态动画图片 如果不自定义图片则置空
var MJRefreshDIY_Images_Idle_Down:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
var MJRefreshDIY_Images_Idle_Up:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
///上下拉提示松开状态动画图片
let MJRefreshDIY_Images_Pulling_Down:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        //避免图片不存在引起的崩溃
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
let MJRefreshDIY_Images_Pulling_Up:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        //避免图片不存在引起的崩溃
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
///上下拉松开正在刷新状态动画图片
let MJRefreshDIY_Images_Refreshing_Down:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
let MJRefreshDIY_Images_Refreshing_Up:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
///上下拉数据加载完毕状态动画图片
let MJRefreshDIY_Images_NoMoreData_Down:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()
let MJRefreshDIY_Images_NoMoreData_Up:[UIImage] = {
    var imageNames:[String] {
        var names:[String] = []
        for i in 0...7 {
            names.append("paopaogif_\(i)")
        }
        return names
    }
    var images:[UIImage] = []
    for item in imageNames {
        let image = UIImage(named: item)
        guard let ima:UIImage = image else {break}
        images.append(ima)
    }
    return images
}()

