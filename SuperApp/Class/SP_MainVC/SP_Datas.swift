//
//  SP_Datas.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/1.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

/*mainDatas结构说明：
["section" : String,  //组名
 "title"      : [String],//功能名
 "subtitle"   : [String],//描述
 "class"     : [UIViewController.Type]//类
]
 */

let mainDatas:[[String:Any]] = [
    ["section":"基本写法",
     "rows":[
        ["title":"Navigation&TabBar",
         "subtitle":"基本和多样化Navigation&TabBar嵌套封装，简单接口",
         "class":"SPNT_TabBarController"],
        
        ["title":"类QQ抽屉式首页",
         "subtitle":"点击头像或右划即可展示",
         "class":""],
        
        ["title":"WKWebView",
         "subtitle":"",
         "class":""],
        
        ["title":"RXSwift_Demo",
         "subtitle":"",
         "class":"SP_Rx_DemoVC"],
        
        ["title":"Charts_Demo",
         "subtitle":"Swift版 关于Charts库使用Demo",
         "class":"SP_Charts_Demo"]
        ]
     
    ],
    
    ["section":"APP展示",
     "rows":[
        ["title":"电商类",
         "subtitle":"",
         "class":""]
        ]
        
    ],
    
    ["section":"网络层封装写法",
     "rows":[
        ["title":"1",
         "subtitle":"",
         "class":""]
        ]
    ],
    
    ["section":"Model",
     "rows":[
        ["title":"1",
         "subtitle":"",
         "class":""]
        ]
        
    ],
    
    ["section":"第三方库二次封装",
     "rows":[
        ["title":"MJRefresh",
         "subtitle":"点我或上拉下拉本页面即可观看效果",
         "class":"MJRefresh"]
        ]
    ],
    
    ["section":"通用独立模块",
     "rows":[
        ["title":"广告轮播图",
         "subtitle":"基于CollectionView实现",
         "class":"SP_AdsVC"],
        ["title":"九宫格",
         "subtitle":"",
         "class":""],
        ["title":"城市选择器",
         "subtitle":"",
         "class":""],
        ["title":"标签导航",
         "subtitle":"",
         "class":""]
        ]
    ],
]






