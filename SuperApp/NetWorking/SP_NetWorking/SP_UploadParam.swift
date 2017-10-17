//
//  SP_UploadParam.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/8.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import Foundation



enum SP_UploadParamType {
    case tData
    case tFileURL
}
struct SP_UploadParam {
    ///Data数据流
    var fileData = Data()
    ///文件的FileURL
    var fileURL:URL?
    ///服务器对应的参数名称
    var serverName = ""
    ///文件的名称(上传到服务器后，服务器保存的文件名)
    var filename = ""
    ///文件的MIME类型(image/png,image/jpg,application/octet-stream/video/mp4等)
    var mimeType = "image/png"
    ///文件类型
    var type:SP_UploadParamType = .tData
    
    
}
