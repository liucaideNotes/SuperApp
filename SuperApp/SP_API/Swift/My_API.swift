//
//  JH_API.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/8.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import SwiftyJSON

//#if DEBUG
//let main_url = "http://39.108.142.204/"
//#else
//let main_url = ""
//#endif

//测试环境
let main_url = "https://jh.qiuxiaokun.com/"
//生产环境
//let main_url = ""

let my_pageSize = 20

enum My_API {
    static let url_SocketIO广播 = "http://39.108.142.204:8001/"
    
    static let url_用户信息修改 = "api/account/info/"
    case t_用户信息修改(nickname:String,email:String,img_url:String)
    
    static let url_获取自选列表 = "api/wine/getopt/"
    case t_获取自选列表(page:Int)
    
    static let url_添加自选数据 = "api/wine/setopt/"
    case t_添加自选数据(code:String)
    
    static let url_删除自选数据 = "api/wine/delopt/"
    case t_删除自选数据(code:String)
    
    static let url_自选搜索 = "api/wine/search/"
    case t_自选搜索(key:String, page:Int)
    
    static let url_自选数据排序 = "api/wine/sortopt/"
    case t_自选数据排序(code:String, sort_no:String)
    
    static let url_买入 = "api/wine/buy/"
    case t_买入(code:String, price:String, num:String)
    
    static let url_卖出 = "api/wine/sell/"
    case t_卖出(code:String, price:String, num:String)
    
    static let url_分时数据 = "api/wine/forchart/"
    case t_分时数据(code:String, period:String)
    
    static let url_K线图数据 = "api/wine/kline/"
    case t_K线图数据(code:String, period:String)
    
    static let url_详情页基础数据 = "api/wine/detail/"
    case t_详情页基础数据(code:String)
    
    
    static let url_获取行情数据 = "api/wine/quotes/"
    case t_获取行情数据
    
    static let url_获取最近聊天记录 = "api/chat/comment/"
    case t_获取最近聊天记录(code:String, page:Int)
    
    
    static let url_媒体文件上传 = "api/chat/upload/"
    case t_媒体文件上传(uploadParams:[SP_UploadParam])
    case t_媒体文件上传2(file:URL)
    
    static let url_当日成交 = "api/wine/todaydeal/"
    case t_当日成交(page:Int)
    
    static let url_当日委托 = "api/wine/todaycommission/"
    case t_当日委托(page:Int)
    
    static let url_历史成交 = "api/wine/historydeal/"
    case t_历史成交(page:Int)
    
    static let url_历史委托 = "api/wine/historycommission/"
    case t_历史委托(page:Int)
    
    static let url_单品委托列表 = "api/wine/detailcancelcomm/"
    case t_单品委托列表(code:String)
    
    static let url_我的持仓 = "api/account/myposition/"
    case t_我的持仓(page:Int)
    
    static let url_撤销委托单 = "api/wine/cancelcommission/"
    case t_撤销委托单(commission_id:String)
    
    //MARK:--- 帖子新闻 ----------
    static let url_获取资讯列表 = "api/news/getnews/"
    case t_获取资讯列表(page:Int)
    
    static let url_获取朋友列表 = "api/account/getattentionobj/"
    case t_获取朋友列表
    static let url_删除朋友关注 = "api/account/cancelattention/"
    case t_删除朋友关注(user_id:String)
    static let url_添加朋友关注 = "api/account/addattention/"
    case t_添加朋友关注(user_id:String)
    
    /*content:正文,title:标题,bastract:摘要,first_img:首图,area:位置,friends:朋友,wines:自选酒*/
    static let url_发表短评接口 = "api/commentary/saveblog/"
    case t_发表短评接口(content:String,title:String,bastract:String,first_img:String,friends:String,wines:String,parent_blog_id:String)
    
    static let url_获取短评列表 = "api/commentary/getbloglist/"
    case t_获取短评列表(page:Int)
    
    static let url_获取葡萄酒相关短评列表 = "api/commentary/getwineblogs/"
    case t_获取葡萄酒相关短评列表(code:String,page:Int)
    
    static let url_发表短评评论接口 = "api/commentary/savecomment/"
    case t_发表短评评论接口(content:String,blog_id:String)
    
    static let url_删除短评 = "api/commentary/deleteblog/"
    case t_删除短评(blog_id:String)
    
    static let url_获取短评详细内容 = "api/commentary/getblogdetail/"
    case t_获取短评详细内容(blog_id:String)
    
    static let url_短评点赞 = "api/commentary/savelike/"
    case t_短评点赞(blog_id:String)
    
    static let url_获取短评评论 = "api/commentary/getcomments/"
    case t_获取短评评论(blog_id:String, page:Int)
    
    static let url_删除短评评论 = "api/commentary/deletecomment/"
    case t_删除短评评论(blog_id:String)
    
    static let url_短评评论点赞 = "api/commentary/savecommentlike/"
    case t_短评评论点赞(comment_id:String)
    
    static let url_获取消息列表 = "api/commentary/getnotices/"
    case t_获取消息列表(page:Int)
    
    
    
    
    //MARK:--- Liv-ex ----------
    static let url_Liv获取指数表现 = "https://datafeed.liv-ex.com/df/indexperformance/getjson/token/e3b1877a-9568-4e69-b7df-404e54d560c5/symbol/LVX50,LVX100,LVXBDX500,LVXINV,BdxL50,Bgdy150,Cham50,Rho100,Ital100,ROW50"
    case t_Liv获取指数表现
    
    static let url_Liv获取指数所有历史数据 = "https://datafeed.liv-ex.com/df/indexfullhistory/getjson/token/e3b1877a-9568-4e69-b7df-404e54d560c5/symbol/"
    case t_Liv获取指数所有历史数据(symbol:String)
    
    static let url_Liv最近一个时间段的数据数据 = "https://datafeed.liv-ex.com/df/indexcompacthistory/getjson/token/e3b1877a-9568-4e69-b7df-404e54d560c5/symbol/"
    case t_Liv最近一个时间段的数据数据(symbol:String)
}
extension My_API {
    func post<T: SP_JsonModel>(_ type: T.Type, block:((Bool,Any,String) -> Void)? = nil) {
        //"token":SP_User.shared.userToken
        SP_Alamofire.shared._headers = ["Authorization":"Bearer "+SP_User.shared.userToken,"deviceuuid":SP_User.shared.deviceUUID]
        var parame:[String:Any] = [:]
        switch self {
        case .t_获取自选列表(let page):
            parame += ["page":page,"page_num":my_pageSize]
            print_Json("url_获取自选列表 parame=>\(parame))")
            print_Json("url_获取自选列表 _headers=>\(SP_Alamofire.shared._headers))")
            SP_Alamofire.get(main_url+My_API.url_获取自选列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取自选列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            
        case .t_自选搜索(let key, let page):
            parame += ["key":key, "page":page,"page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_自选搜索, param: parame, block: { (isOk, res, error) in
                print_Json("url_自选搜索=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_添加自选数据(let code):
            parame += ["code":code]
            SP_Alamofire.post(main_url+My_API.url_添加自选数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_添加自选数据=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_删除自选数据(let code):
            parame += ["code":code]
            SP_Alamofire.post(main_url+My_API.url_删除自选数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_删除自选数据=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_自选数据排序(let code, let sort_no):
            parame += ["code":code, "sort_no":sort_no]
            SP_Alamofire.post(main_url+My_API.url_自选数据排序, param: parame, block: { (isOk, res, error) in
                print_Json("url_自选数据排序=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            
        case .t_用户信息修改(let nickname,let email,let img_url):
            parame += ["nickname":nickname,"email":email,"img_url":img_url]
            SP_Alamofire.post(main_url+My_API.url_用户信息修改, param: parame, block: { (isOk, res, error) in
                print_Json("url_用户信息修改=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_买入(let code,let price,let num):
            parame += ["code":code,"price":price,"num":num]
            SP_Alamofire.post(main_url+My_API.url_买入, param: parame, block: { (isOk, res, error) in
                print_Json("url_买入=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_卖出(let code,let price,let num):
            parame += ["code":code,"price":price,"num":num]
            SP_Alamofire.post(main_url+My_API.url_卖出, param: parame, block: { (isOk, res, error) in
                print_Json("url_卖出=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_分时数据(let code,let period):
            let dateTime = Date().timeIntervalSince1970
            let now = String(format: "%.0f", dateTime)
            parame += ["code":code,"period":period,"now":now]
            SP_Alamofire.post(main_url+My_API.url_分时数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_分时数据=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_K线图数据(let code,let period):
            let dateTime = Date().timeIntervalSince1970
            let now = String(format: "%.0f", dateTime)
            parame += ["code":code,"period":period,"now":now,"count":100]
            SP_Alamofire.post(main_url+My_API.url_K线图数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_K线图数据=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_详情页基础数据(let code):
            parame += ["code":code]
            SP_Alamofire.post(main_url+My_API.url_详情页基础数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_详情页基础数据=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取行情数据:
            SP_Alamofire.shared._headers = ["deviceuuid":SP_User.shared.deviceUUID]
            parame += [:]
            SP_Alamofire.get(main_url+My_API.url_获取行情数据, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取行情数据=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取最近聊天记录(let code, let page):
            parame += ["code":code, "page":page, "page_num":"50"]
            SP_Alamofire.get(main_url+My_API.url_获取最近聊天记录, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取最近聊天记录=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_当日成交(let page):
            parame += ["page":page, "page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_当日成交, param: parame, block: { (isOk, res, error) in
                print_Json("url_当日成交=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        
        case .t_当日委托(let page):
            parame += ["page":page, "page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_当日委托, param: parame, block: { (isOk, res, error) in
                print_Json("url_当日委托=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_历史成交(let page):
            parame += ["page":page, "page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_历史成交, param: parame, block: { (isOk, res, error) in
                print_Json("url_历史成交=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_历史委托(let page):
            parame += ["page":page, "page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_历史委托, param: parame, block: { (isOk, res, error) in
                print_Json("url_历史委托=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_单品委托列表(let code):
            parame += ["code":code]
            SP_Alamofire.post(main_url+My_API.url_单品委托列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_单品委托列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_我的持仓(let page):
            parame += ["page":page, "page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_我的持仓, param: parame, block: { (isOk, res, error) in
                print_Json("url_我的持仓=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_撤销委托单(let commission_id):
            parame += ["commission_id":commission_id]
            SP_Alamofire.post(main_url+My_API.url_撤销委托单, param: parame, block: { (isOk, res, error) in
                print_Json("url_撤销委托单=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        //MARK:--- 帖子新闻 ----------
        case .t_获取资讯列表(let page):
            parame += ["page":page,"page_num":my_pageSize]
            SP_Alamofire.post(main_url+My_API.url_获取资讯列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取资讯列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取朋友列表:
            SP_Alamofire.get(main_url+My_API.url_获取朋友列表, param: [:], block: { (isOk, res, error) in
                print_Json("url_获取朋友列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_添加朋友关注(let user_id):
            SP_Alamofire.post(main_url+My_API.url_添加朋友关注, param: ["user_id":user_id], block: { (isOk, res, error) in
                print_Json("url_添加朋友关注=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_删除朋友关注(let user_id):
            SP_Alamofire.post(main_url+My_API.url_删除朋友关注, param: ["user_id":user_id], block: { (isOk, res, error) in
                print_Json("url_删除朋友关注=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_发表短评接口(let content, let title, let bastract, let first_img, let friends, let wines,let parent_blog_id):
            parame   =   ["content":content,
                          "title":title,
                          "abstract":bastract,
                          "first_img":first_img,
                          "friends":friends,
                          "wines":wines,
                          
            ]
            if !parent_blog_id.isEmpty {
                parame += ["parent_blog_id":parent_blog_id]
            }
            SP_Alamofire.post(main_url+My_API.url_发表短评接口, param: parame, block: { (isOk, res, error) in
                print_Json("url_发表短评接口=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_发表短评评论接口(let content,let blog_id):
            parame = ["content":content,
                      "blog_id":blog_id]
            
            SP_Alamofire.post(main_url+My_API.url_发表短评评论接口, param: parame, block: { (isOk, res, error) in
                print_Json("url_发表短评评论接口=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取短评列表(let page):
            parame += ["page":page,"page_num":my_pageSize]
            SP_Alamofire.get(main_url+My_API.url_获取短评列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取短评列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取葡萄酒相关短评列表(let code,let page):
            parame += ["code":code,"page":page,"page_num":my_pageSize]
            SP_Alamofire.get(main_url+My_API.url_获取葡萄酒相关短评列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取葡萄酒相关短评列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_获取消息列表(let page):
            parame += ["page":page,"page_num":my_pageSize]
            SP_Alamofire.get(main_url+My_API.url_获取消息列表, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取消息列表=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            
        case .t_获取短评详细内容(let blog_id):
            SP_Alamofire.get(main_url+My_API.url_获取短评详细内容, param: ["blog_id":blog_id], block: { (isOk, res, error) in
                print_Json("url_获取短评详细内容=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            
        case .t_短评点赞(let blog_id):
            SP_Alamofire.post(main_url+My_API.url_短评点赞, param: ["blog_id":blog_id], block: { (isOk, res, error) in
                print_Json("url_短评点赞=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_短评评论点赞(let comment_id):
            SP_Alamofire.post(main_url+My_API.url_短评评论点赞, param: ["comment_id":comment_id], block: { (isOk, res, error) in
                print_Json("url_短评评论点赞=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            
        case .t_获取短评评论(let blog_id, let page):
            parame += ["page":page,"page_num":my_pageSize,"blog_id":blog_id]
            SP_Alamofire.get(main_url+My_API.url_获取短评评论, param: parame, block: { (isOk, res, error) in
                print_Json("url_获取短评评论=>\(JSON(res!))")
                My_API.map_Array(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
            //MARK:--- t_Liv获取指数表现 ----------
        case .t_Liv获取指数表现:
            SP_Alamofire.get(My_API.url_Liv获取指数表现, param: [:], block: { (isOk, res, error) in
                print_Json("url_Liv获取指数表现=>\(JSON(res!))")
                if isOk {
                    let json = JSON(res!)
                    guard let array:[JSON] = json["index"].array else{
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                        return
                    }
                    var objects = [T]()
                    
                    if array.count > 0 {
                        for object in array {
                            if let obj = My_API.map_FromJSON(object, classType:type)  {
                                objects.append(obj)
                            }
                        }
                        block?(true,objects,"")
                    } else {
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                    }
                }else{
                    block?(false,[],error!)
                }
            })
        case .t_Liv获取指数所有历史数据(let symbol):
            SP_Alamofire.get(My_API.url_Liv获取指数所有历史数据 + symbol, param: [:], block: { (isOk, res, error) in
                print_Json("url_Liv获取指数所有历史数据=>\(JSON(res!))")
                if isOk {
                    let json = JSON(res!)
                    guard let array0:[JSON] = json["index"].array, array0.count > 0 else{
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                        return
                    }
                    guard let array:[JSON] = array0[0]["data"].array else{
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                        return
                    }
                    var objects = [T]()
                    
                    if array.count > 0 {
                        for object in array {
                            if let obj = My_API.map_FromJSON(object, classType:type)  {
                                objects.append(obj)
                            }
                        }
                        block?(true,objects,"")
                    } else {
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                    }
                }else{
                    block?(false,[],error!)
                }
            })
        case .t_Liv最近一个时间段的数据数据(let symbol):
            SP_Alamofire.get(My_API.url_Liv最近一个时间段的数据数据 + symbol, param: [:], block: { (isOk, res, error) in
                print_Json("url_Liv最近一个时间段的数据数据=>\(JSON(res!))")
                if isOk {
                    let json = JSON(res!)
                    guard let array0:[JSON] = json["index"].array, array0.count > 0 else{
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                        return
                    }
                    guard let array:[JSON] = array0[0]["data"].array else{
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                        return
                    }
                    var objects = [T]()
                    
                    if array.count > 0 {
                        for object in array {
                            if let obj = My_API.map_FromJSON(object, classType:type)  {
                                objects.append(obj)
                            }
                        }
                        block?(true,objects,"")
                    } else {
                        block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                    }
                }else{
                    block?(false,[],error!)
                }
            })
        default:break
        }
    }
    
    func upload<T: SP_JsonModel>(_ type: T.Type, block:((Bool,Any,String) -> Void)? = nil, progressBlock:sp_netProgressBlock? = nil) {
        SP_Alamofire.shared._headers = ["Authorization":"Bearer "+SP_User.shared.userToken,"deviceuuid":SP_User.shared.deviceUUID]
        switch self {
        case .t_媒体文件上传(let uploadParams):
            SP_Alamofire.upload(main_url+My_API.url_媒体文件上传, param: [:], uploadParams: uploadParams, progressBlock: progressBlock, block: { (isOk, res, error) in
                print_Json("url_媒体文件上传=>\(JSON(res!))")
                My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                    block?(isOk, datas, error)
                })
            })
        case .t_媒体文件上传2(let file):
            SP_Alamofire.shared._manager.upload(file, to: main_url+My_API.url_媒体文件上传, headers:SP_Alamofire.shared._headers).uploadProgress(closure: { (progress) in
                progressBlock?(progress)
            }).responseJSON(completionHandler: { (response) in
                SP_Alamofire.disposeResponse(response, block: { (isOk, res, error) in
                    print_Json("url_t_媒体文件上传2=>\(JSON(res!))")
                    My_API.map_Object(type, response: res, error: error, isOk: isOk, block: { (isOk, datas, error) in
                        block?(isOk, datas, error)
                    })
                })
            })
        default:
            break
        }
        
    }
    
}


//MARK:--- 数据初步处理 -----------------------------
public protocol SP_JsonModel {
    //所有的转模型通过遵循 SP_JsonModel 协议
    init()
    init(_ json:JSON)
    
}
extension My_API {
    
    static func map_FromJSON<T: SP_JsonModel>(_ jsonData:JSON, classType: T.Type) -> T? {
        return T(jsonData)
    }
    
    static func map_Array<T: SP_JsonModel>(_ type: T.Type, response:Any?, error:String?, isOk:Bool, block:((Bool,[T],String)->Void)? = nil){
        if isOk {
            let json = JSON(response!)
            guard json[My_Net_Code].stringValue == My_NetCodeError.t成功.rawValue else{
                let message = (My_NetCodeError(rawValue: json[My_Net_Code].stringValue) ?? .tError).stringValue
                block?(false,[],message)
                
                if json[My_Net_Code].stringValue == My_NetCodeError.t需要登录.rawValue {
                    My_API.needLogin()
                }
                
                return
            }
            guard let array:[JSON] = json[My_Net_Data].array else{
                block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
                return
            }
            var objects = [T]()
            
            if array.count > 0 {
                for object in array {
                    if let obj = My_API.map_FromJSON(object, classType:type)  {
                        objects.append(obj)
                    }
                }
                block?(true,objects,"")
            } else {
                block?(true,[],sp_localized(My_NetCodeError.t没有数据.rawValue))
            }
        }else{
            block?(false,[],error!)
        }
    }
    
    static func map_Object<T: SP_JsonModel>(_ type: T.Type, response:Any?, error:String?, isOk:Bool, block:((Bool,T,String)->Void)? = nil){
        if isOk {
            let json = JSON(response!)
            guard json[My_Net_Code].stringValue == My_NetCodeError.t成功.rawValue else{
                let message = (My_NetCodeError(rawValue: json[My_Net_Code].stringValue) ?? .tError).stringValue
                block?(false,T(),message)
                
                if json[My_Net_Code].stringValue == My_NetCodeError.t需要登录.rawValue {
                    My_API.needLogin()
                }
                
                return
            }
            guard !json[My_Net_Data].isEmpty else{
                block?(true,T(),sp_localized(My_NetCodeError.t没有数据.rawValue))
                return
            }
            let obj = My_API.map_FromJSON(json[My_Net_Data], classType:type)!
            block?(true,obj,"")
        }else{
            block?(false,T(),error!)
        }
    }
    
    //登录失效处理
    static func needLogin() {
        SP_User.shared.needLogin()
    }
    
}

let My_Net_Code = "code"
let My_Net_Msg = "msg"
let My_Net_Data = "data"

enum My_NetCodeError: String {
    case t成功         = "000000"
    case t请求方法错误  = "000001"
    case t参数错误     = "000002"
    case t用户已注册   = "000003"
    case t用户未注册    = "000004"
    case t发送验证码失败 = "000005"
    case t密码错误     = "000006"
    case t需要登录     = "000007"
    case t无效用户     = "000008"
    case t验证码错误   = "000009"
    case t获取access_token错误   = "000010"
    case tClient数据错误   = "000011"
   
    case t已添加     = "100001"
    case t持仓量不足     = "100002"
    
    case t未知错误   = "999999"
    
    case t没有数据    = "9011110"
    case tError      = "9011111"
    
    var stringValue:String {
        switch self {
        case .t成功:
            return sp_localized(My_NetCodeError.t成功.rawValue)
        case .t请求方法错误:
            return sp_localized(My_NetCodeError.t请求方法错误.rawValue)
        case .t参数错误:
            return sp_localized(My_NetCodeError.t参数错误.rawValue)
        case .t用户已注册:
            return sp_localized(My_NetCodeError.t用户已注册.rawValue)
        case .t用户未注册:
            return sp_localized(My_NetCodeError.t用户未注册.rawValue)
        case .t发送验证码失败:
            return sp_localized(My_NetCodeError.t发送验证码失败.rawValue)
        case .t密码错误:
            return sp_localized(My_NetCodeError.t密码错误.rawValue)
        case .t需要登录:
            return sp_localized(My_NetCodeError.t需要登录.rawValue)
        case .t没有数据:
            return sp_localized(My_NetCodeError.t没有数据.rawValue)
        case .t无效用户:
            return sp_localized(My_NetCodeError.t无效用户.rawValue)
        case .t验证码错误:
            return sp_localized(My_NetCodeError.t验证码错误.rawValue)
        case .t获取access_token错误:
            return sp_localized(My_NetCodeError.t获取access_token错误.rawValue)
        case .tClient数据错误:
            return sp_localized(My_NetCodeError.tClient数据错误.rawValue)
        case .t已添加:
            return sp_localized(My_NetCodeError.t已添加.rawValue)
        case .t持仓量不足:
            return sp_localized(My_NetCodeError.t持仓量不足.rawValue)
        case .t未知错误:
            return sp_localized(My_NetCodeError.t未知错误.rawValue)
        default:
            return sp_localized(My_NetCodeError.tError.rawValue)
        }
    }
}

