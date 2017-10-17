//
//  SP_RichTextEdit_EnumType.swift
//  Fortuna
//
//  Created by LCD on 2017/8/25.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation

enum SP_RichTextEditType:String {
    case t短评 = "短评"
    case t长文 = "长文"
    case t转发 = "转发"
    case t评论 = "评论"
}
enum M_SP_RichTextType:String {
    case t文字 = "[Text]"
    case t图片 = "[Image]"
    case t关注 = "[@]"
    case t自选酒 = "[#]"
    case t超链接 = "[://]"
    case t其他 = ""
    
    var prefixValue:String {
        switch self {
        case .t文字:
            return ""
        case .t图片:
            return "\n"
        case .t关注:
            return " @"
        case .t自选酒:
            return " #"
        case .t超链接:
            return " ["
        default:
            return ""
        }
    }
    var suffixValue:String {
        switch self {
        case .t文字:
            return ""
        case .t图片:
            return "\n"
        case .t关注:
            return " "
        case .t自选酒:
            return " "
        case .t超链接:
            return "] "
        default:
            return ""
        }
    }
}

