//
//  SP_Datas.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/1.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

/*mainDatas结构说明：
["sectionName" : String,  //组名
 "titles"      : [String],//功能名
 "represent"   : [String],//描述
 "classes"     : [UIViewController.Type]//类
]
 */

let mainDatas:[[String:Any]] = [
    ["sectionName":"基本写法",
     "titles":[
        "Navigation&TabBar",
        
        "类QQ抽屉式首页",
        "TableView",
        "CollectionView",
        "WebView",
        "不借助第三方写约束",
        "RXSwift+TableView",
        "RXSwift+MVVM"
              ],
     "represent":[
        "基本和多样化Navigation&TabBar嵌套封装，简单接口",
        
        "点击头像或右划即可展示",
        "",
        "",
        "",
        ""
                 ],
     "classes":[
               ]
    ],
    
    ["sectionName":"APP展示",
     "titles":[
        "电商类app"
        ],
     "represent":[
        ""
        ],
    "classes":[
              ]
    ],
    
    ["sectionName":"网络层封装写法",
     "titles":[
        "写法1",
        "写法2",
        "写法3"
              ],
     "represent":[
        "",
        "",
        ""
        ],
     "classes":[
               ]
    ],
    
    ["sectionName":"Model",
     "titles":[
        "写法1",
        "写法2",
        "写法3"
        ],
     "represent":[
        "",
        "",
        ""
        ],
     "classes":[
               ]
    ],
    
    ["sectionName":"第三方库二次封装",
     "titles":[
        "MJRefresh"
              ],
     "represent":[
        "点我或上拉下拉本页面即可观看效果"
        ],
     "classes":[
               ]
    ],
    
    ["sectionName":"通用独立模块",
     "titles":[
        "广告轮播图",
        "九宫格",
        "城市选择器",
        "标签导航"
              ],
     "represent":[
        "基于CollectionView实现"
        ],
     "classes":[
        SP_AdsVC.self,
               ]
    ],
]






