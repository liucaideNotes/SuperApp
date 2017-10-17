//
//  M_MyCommon.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/28.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import SwiftyJSON

struct M_MyCommon {
    
    //媒体上传 - 返回媒体地址
    var media_url = ""
    var media_img = ""
}
extension M_MyCommon:SP_JsonModel {
    init(_ json: JSON) {
        if json.isEmpty{
            return
        }
        
        media_url = json["media_url"].stringValue
        media_img = json["media_img_url"].stringValue
    }
}
