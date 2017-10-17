//
//  SP_ErrorType.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/21.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation


/// 网络请求回调闭包 success:是否成功 result:数据 progress:请求进度 error:错误信息
typealias sp_netComBlock = (_ success: Bool, _ result: Any?, _ error: String?) -> Void
typealias sp_netProgressBlock = (_ progress:Progress?) -> Void

//MARK:--- 罗列错误类型(自定义) -----------------------------
enum SP_ErrorType:Int {
    case noData      = 10000000
    case nsurlErrorUnknown = -1
    case nsurlErrorCancelled = -999
    case nsurlErrorBadURL = -1000
    case nsurlErrorTimedOut = -1001
    case nsurlErrorUnsupportedURL = -1002
    case nsurlErrorCannotFindHost = -1003
    case nsurlErrorCannotConnectToHost = -1004
    case nsurlErrorDataLengthExceedsMaximum = -1103
    case nsurlErrorNetworkConnectionLost = -1005
    case nsurlErrorDNSLookupFailed = -1006
    case nsurlErrorHTTPTooManyRedirects = -1007
    case nsurlErrorResourceUnavailable = -1008
    case nsurlErrorNotConnectedToInternet = -1009
    case nsurlErrorRedirectToNonExistentLocation = -1010
    case nsurlErrorBadServerResponse = -1011
    case nsurlErrorUserCancelledAuthentication = -1012
    case nsurlErrorUserAuthenticationRequired = -1013
    case nsurlErrorZeroByteResource = -1014
    case nsurlErrorCannotDecodeRawData = -1015
    case nsurlErrorCannotDecodeContentData = -1016
    case nsurlErrorCannotParseResponse = -1017
    case nsurlErrorFileDoesNotExist = -1100
    case nsurlErrorFileIsDirectory = -1101
    case nsurlErrorNoPermissionsToReadFile = -1102
    case nsurlErrorSecureConnectionFailed = -1200
    case nsurlErrorServerCertificateHasBadDate = -1201
    case nsurlErrorServerCertificateUntrusted = -1202
    case nsurlErrorServerCertificateHasUnknownRoot = -1203
    case nsurlErrorServerCertificateNotYetValid = -1204
    case nsurlErrorClientCertificateRejected = -1205
    case nsurlErrorClientCertificateRequired = -1206
    case nsurlErrorCannotLoadFromNetwork = -2000
    case nsurlErrorCannotCreateFile = -3000
    case nsurlErrorCannotOpenFile = -3001
    case nsurlErrorCannotCloseFile = -3002
    case nsurlErrorCannotWriteToFile = -3003
    case nsurlErrorCannotRemoveFile = -3004
    case nsurlErrorCannotMoveFile = -3005
    case nsurlErrorDownloadDecodingFailedMidStream = -3006
    case nsurlErrorDownloadDecodingFailedToComplete = -3007
    
    
    var stringValue:String {
        switch self {
        case .nsurlErrorUnknown:                                 return sp_localized("未知错误",from:"SP_ErrorType")
        case .nsurlErrorCancelled:                               return sp_localized("取消了网址",from:"SP_ErrorType")
        case .nsurlErrorBadURL:                                  return sp_localized("错误URL",from:"SP_ErrorType")
        case .nsurlErrorTimedOut:                                return sp_localized("请求超时",from:"SP_ErrorType")
        case .nsurlErrorUnsupportedURL:                          return sp_localized("不支持URL",from:"SP_ErrorType")
        case .nsurlErrorCannotFindHost:                          return sp_localized("无法找到服务器",from:"SP_ErrorType")
        case .nsurlErrorCannotConnectToHost:                     return sp_localized("无法连接到服务器",from:"SP_ErrorType")
        case .nsurlErrorDataLengthExceedsMaximum:                return sp_localized("数据长度超过最大值",from:"SP_ErrorType")
        case .nsurlErrorNetworkConnectionLost:                   return sp_localized("网络连接丢失",from:"SP_ErrorType")
        case .nsurlErrorDNSLookupFailed:                         return sp_localized("DNS查找失败",from:"SP_ErrorType")
        case .nsurlErrorHTTPTooManyRedirects:                    return sp_localized("HTTP重定向",from:"SP_ErrorType")
        case .nsurlErrorResourceUnavailable:                     return sp_localized("资源不可用",from:"SP_ErrorType")
        case .nsurlErrorNotConnectedToInternet:                  return sp_localized("您可能没有连接互联网",from:"SP_ErrorType")
        case .nsurlErrorRedirectToNonExistentLocation:           return sp_localized("重定向到不存在的位置",from:"SP_ErrorType")
        case .nsurlErrorBadServerResponse:                       return sp_localized("服务器响应错误",from:"SP_ErrorType")
        case .nsurlErrorUserCancelledAuthentication:             return sp_localized("用户取消认证",from:"SP_ErrorType")
        case .nsurlErrorUserAuthenticationRequired:              return sp_localized("用户认证要求",from:"SP_ErrorType")
        case .nsurlErrorZeroByteResource:                        return sp_localized("零字节资源",from:"SP_ErrorType")
        case .nsurlErrorCannotDecodeRawData:                     return sp_localized("不能解码原始数据",from:"SP_ErrorType")
        case .nsurlErrorCannotDecodeContentData:                 return sp_localized("无法解码内容数据",from:"SP_ErrorType")
        case .nsurlErrorCannotParseResponse:                     return sp_localized("无法解析响应",from:"SP_ErrorType")
        case .nsurlErrorFileDoesNotExist:                        return sp_localized("文件不存在",from:"SP_ErrorType")
        case .nsurlErrorFileIsDirectory:                         return sp_localized("文件目录错误",from:"SP_ErrorType")
        case .nsurlErrorNoPermissionsToReadFile:                 return sp_localized("没有权限读取文件",from:"SP_ErrorType")
        case .nsurlErrorSecureConnectionFailed:                  return sp_localized("安全连接失败",from:"SP_ErrorType")
        case .nsurlErrorServerCertificateHasBadDate:             return sp_localized("服务器证书已过期",from:"SP_ErrorType")
        case .nsurlErrorServerCertificateUntrusted:              return sp_localized("服务器证书不可信",from:"SP_ErrorType")
        case .nsurlErrorServerCertificateHasUnknownRoot:         return sp_localized("服务器证书具有未知的Root",from:"SP_ErrorType")
        case .nsurlErrorServerCertificateNotYetValid:            return sp_localized("服务器证书无效",from:"SP_ErrorType")
        case .nsurlErrorClientCertificateRejected:               return sp_localized("客户端证书被拒绝",from:"SP_ErrorType")
        case .nsurlErrorClientCertificateRequired:               return sp_localized("客户端证书要求",from:"SP_ErrorType")
        case .nsurlErrorCannotLoadFromNetwork:                   return sp_localized("无法加载网络",from:"SP_ErrorType")
        case .nsurlErrorCannotCreateFile:                        return sp_localized("无法创建文件",from:"SP_ErrorType")
        case .nsurlErrorCannotOpenFile:                          return sp_localized("无法打开文件",from:"SP_ErrorType")
        case .nsurlErrorCannotCloseFile:                         return sp_localized("无法关闭文件",from:"SP_ErrorType")
        case .nsurlErrorCannotWriteToFile:                       return sp_localized("无法写入文件",from:"SP_ErrorType")
        case .nsurlErrorCannotRemoveFile:                        return sp_localized("无法删除文件",from:"SP_ErrorType")
        case .nsurlErrorCannotMoveFile:                          return sp_localized("无法移动文件",from:"SP_ErrorType")
        case .nsurlErrorDownloadDecodingFailedMidStream:         return sp_localized("下载解码失败",from:"SP_ErrorType")
        case .nsurlErrorDownloadDecodingFailedToComplete:        return sp_localized("下载解码未能完成",from:"SP_ErrorType")
        case .noData: return sp_localized("没有获取到数据",from:"SP_ErrorType")
            
        }
    }
    
    
}

//MARK:--- 罗列错误类型（系统） -----------------------------
func sp_returnNSError(_ error:Error) -> String {
    switch (error as NSError).code {
    case NSURLErrorUnknown:                                 return sp_localized("未知错误",from:"SP_ErrorType")
    case NSURLErrorCancelled:                               return sp_localized("取消了网址",from:"SP_ErrorType")
    case NSURLErrorBadURL:                                  return sp_localized("错误URL",from:"SP_ErrorType")
    case NSURLErrorTimedOut:                                return sp_localized("请求超时",from:"SP_ErrorType")
    case NSURLErrorUnsupportedURL:                          return sp_localized("不支持URL",from:"SP_ErrorType")
    case NSURLErrorCannotFindHost:                          return sp_localized("无法找到服务器",from:"SP_ErrorType")
    case NSURLErrorCannotConnectToHost:                     return sp_localized("无法连接到服务器",from:"SP_ErrorType")
    case NSURLErrorDataLengthExceedsMaximum:                return sp_localized("数据长度超过最大值",from:"SP_ErrorType")
    case NSURLErrorNetworkConnectionLost:                   return sp_localized("网络连接丢失",from:"SP_ErrorType")
    case NSURLErrorDNSLookupFailed:                         return sp_localized("DNS查找失败",from:"SP_ErrorType")
    case NSURLErrorHTTPTooManyRedirects:                    return sp_localized("HTTP重定向",from:"SP_ErrorType")
    case NSURLErrorResourceUnavailable:                     return sp_localized("资源不可用",from:"SP_ErrorType")
    case NSURLErrorNotConnectedToInternet:                  return sp_localized("您可能没有连接互联网",from:"SP_ErrorType")
    case NSURLErrorRedirectToNonExistentLocation:           return sp_localized("重定向到不存在的位置",from:"SP_ErrorType")
    case NSURLErrorBadServerResponse:                       return sp_localized("服务器响应错误",from:"SP_ErrorType")
    case NSURLErrorUserCancelledAuthentication:             return sp_localized("用户取消认证",from:"SP_ErrorType")
    case NSURLErrorUserAuthenticationRequired:              return sp_localized("用户认证要求",from:"SP_ErrorType")
    case NSURLErrorZeroByteResource:                        return sp_localized("零字节资源",from:"SP_ErrorType")
    case NSURLErrorCannotDecodeRawData:                     return sp_localized("不能解码原始数据",from:"SP_ErrorType")
    case NSURLErrorCannotDecodeContentData:                 return sp_localized("无法解码内容数据",from:"SP_ErrorType")
    case NSURLErrorCannotParseResponse:                     return sp_localized("无法解析响应",from:"SP_ErrorType")
    case NSURLErrorFileDoesNotExist:                        return sp_localized("文件不存在",from:"SP_ErrorType")
    case NSURLErrorFileIsDirectory:                         return sp_localized("文件目录错误",from:"SP_ErrorType")
    case NSURLErrorNoPermissionsToReadFile:                 return sp_localized("没有权限读取文件",from:"SP_ErrorType")
    case NSURLErrorSecureConnectionFailed:                  return sp_localized("安全连接失败",from:"SP_ErrorType")
    case NSURLErrorServerCertificateHasBadDate:             return sp_localized("服务器证书已过期",from:"SP_ErrorType")
    case NSURLErrorServerCertificateUntrusted:              return sp_localized("服务器证书不可信",from:"SP_ErrorType")
    case NSURLErrorServerCertificateHasUnknownRoot:         return sp_localized("服务器证书具有未知的Root",from:"SP_ErrorType")
    case NSURLErrorServerCertificateNotYetValid:            return sp_localized("服务器证书无效",from:"SP_ErrorType")
    case NSURLErrorClientCertificateRejected:               return sp_localized("客户端证书被拒绝",from:"SP_ErrorType")
    case NSURLErrorClientCertificateRequired:               return sp_localized("客户端证书要求",from:"SP_ErrorType")
    case NSURLErrorCannotLoadFromNetwork:                   return sp_localized("无法加载网络",from:"SP_ErrorType")
    case NSURLErrorCannotCreateFile:                        return sp_localized("无法创建文件",from:"SP_ErrorType")
    case NSURLErrorCannotOpenFile:                          return sp_localized("无法打开文件",from:"SP_ErrorType")
    case NSURLErrorCannotCloseFile:                         return sp_localized("无法关闭文件",from:"SP_ErrorType")
    case NSURLErrorCannotWriteToFile:                       return sp_localized("无法写入文件",from:"SP_ErrorType")
    case NSURLErrorCannotRemoveFile:                        return sp_localized("无法删除文件",from:"SP_ErrorType")
    case NSURLErrorCannotMoveFile:                          return sp_localized("无法移动文件",from:"SP_ErrorType")
    case NSURLErrorDownloadDecodingFailedMidStream:         return sp_localized("下载解码失败",from:"SP_ErrorType")
    case NSURLErrorDownloadDecodingFailedToComplete:        return sp_localized("下载解码未能完成",from:"SP_ErrorType")
    
    default: return sp_localized("连接错误",from:"SP_ErrorType")
    }
}



