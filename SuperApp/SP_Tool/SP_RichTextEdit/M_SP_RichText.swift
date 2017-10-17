//
//  M_SP_RichText.swift
//  Fortuna
//
//  Created by LCD on 2017/8/28.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import SwiftyJSON


struct M_SP_RichText {
    
    var type:String = ""  //[Text]:普通文字，[Image]：图片，[@]：@标签，[#]：#标签 [://]:网址
    var text = ""
    var isBold = false
    var fontPt:CGFloat = 18
    var fontPx:CGFloat = 36
    
    var imgUrl = ""
    
    var imgWidth:CGFloat = 0
    var imgHeight:CGFloat = 0
    
    var code = ""
    
    var link = ""

}

extension M_SP_RichText: SP_JsonModel {
    init(_ json: JSON) {
        if json.isEmpty {return}
        type = json["type"].stringValue //M_SP_RichTextType.t其他.rawValue  //[Text]:普通文字，[Image]：图片，[@]：@标签，[#]：#标签 [://]:网址
        text = json["text"].stringValue
        isBold = json["isBold"].boolValue
        fontPt = CGFloat(json["fontPt"].doubleValue)
        fontPx = CGFloat(json["fontPx"].doubleValue)
        
        imgUrl = json["imgUrl"].stringValue
        
        imgWidth = CGFloat(json["imgWidth"].doubleValue)
        imgHeight = CGFloat(json["imgHeight"].doubleValue)
        
        code = json["code"].stringValue
        
        link = json["link"].stringValue
    }
}

