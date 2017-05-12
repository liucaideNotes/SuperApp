//
//  RBRequestHelper.swift
//  RoboMing-Controller
//
//   Created by 范博 on 16/8/16.
//  Copyright © 2016年 Solomon. All rights reserved.
//

import Foundation


private let RBRequestDomain = "com.roboming.Robot_Controller"

var RBParamsErrorObject: NSError {
    let error = NSError(domain: RBRequestDomain, code: RBNetworkRequestErrorType.UnknowError.rawValue,
                        userInfo: [NSLocalizedDescriptionKey: RBNetworkRequestErrorType.UnknowError.errorDescription])
    return error
}

struct RBRequestHelper {
    
    static func request(path: String, params: [String: AnyObject]?, file: String = #file, line: Int = #line, function: String = #function, completion: ((_ response: AnyObject?, _ code: Int, _ error: NSError?) -> Void)?) {
        
        var parameters = params
        if params?["userId"] != nil {
            guard let token = RBUser.user?.token else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserTokenInvalidNotificationName), object: nil)
                return
            }
            parameters?["token"] = token
        }
        
        if let dict = params, dict["secret"] == nil {
            let secret = RBSigner.sign(dict)
            parameters?["secret"] = secret
        }
        
        RBNetworkRequest.request(path: path, params: parameters) { (urlResponse, objc, error) in
            guard error == nil else {
                HUD.show(error!.localizedDescription)
                debugPrint(String(format: "--------------------\nFile: \(file)\nLine: \(line)\nFunction: \(function)"))
                completion?(nil, error!.code, error)
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    HUD.show(RBNetworkRequestErrorType.UnknowError.errorDescription)
                    let error: NSError
                    if let httpResponse = urlResponse as? HTTPURLResponse {
                        error = NSError(domain: RBRequestDomain, code: httpResponse.statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode)])
                    } else {
                        error = NSError(domain: RBRequestDomain, code: RBNetworkRequestErrorType.UnknowError.rawValue,
                                        userInfo: [NSLocalizedDescriptionKey: RBNetworkRequestErrorType.UnknowError.errorDescription])
                    }
                    debugPrint(String(format: "--------------------\nFile: \(file)\nLine: \(line)\nFunction: \(function)"))
                    completion?(nil, error.code, error)
                    return
            }
            
            guard let code = objc?["code"] as? Int else {
                HUD.show(RBNetworkRequestErrorType.ResponseError.errorDescription)
                let error = RBParamsErrorObject
                debugPrint(String(format: "--------------------\nFile: \(file)\nLine: \(line)\nFunction: \(function)"))
                completion?(nil, error.code, error)
                return
            }
            
            if let status = RBNetworkResponseCodeType(rawValue: code), status != .Successed {
                HUD.show(status.errorDescription)
                NotificationCenter.defaultCenter().postNotificationName(kUserTokenInvalidNotificationName, object: RBUser.user)
                let error = NSError(domain: RBRequestDomain, code: status.rawValue, userInfo: [NSLocalizedDescriptionKey: RBNetworkResponseCodeType.TokenError.errorDescription])
                completion?(nil, code, error)
                return
            }
            
            completion?(objc?["body"] as AnyObject?, code, nil)
        }
    }
    
    static func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, file: String = #file, line: Int = #line, function: String = #function, completion: ((_ response: AnyObject?, _ code: Int, _ error: NSError?) -> Void)?) {
        var parameters = params
        if params?["userId"] != nil {
            guard let token = RBUser.user?.token else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserTokenInvalidNotificationName), object: nil)
                return
            }
            parameters?["token"] = token
        }
        RBNetworkRequest.upload(path: path, params: parameters, progress: uploadProgressBlock) { (urlResponse, objc, error) in
            guard error == nil else {
                HUD.show(error!.localizedDescription)
                debugPrint(String(format: "--------------------\nFile: \(file)\nLine: \(line)\nFunction: \(function)"))
                completion?(nil, error!.code, error)
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    HUD.show(RBNetworkRequestErrorType.UnknowError.errorDescription)
                    let error: NSError
                    if let httpResponse = urlResponse as? HTTPURLResponse {
                        error = NSError(domain: RBRequestDomain, code: httpResponse.statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode)])
                    } else {
                        error = NSError(domain: RBRequestDomain, code: RBNetworkRequestErrorType.UnknowError.rawValue,
                                        userInfo: [NSLocalizedDescriptionKey: RBNetworkRequestErrorType.UnknowError.errorDescription])
                    }
                    debugPrint(String(format: "--------------------\nFile: \(file)\nLine: \(line)\nFunction: \(function)"))
                    completion?(nil, error.code, error)
                    return
            }
            
            completion?(objc, -1, nil)
        }
    }
    
    static func randomCode(length: Int = 6) -> String {
        var code = ""
        for _ in 0 ..< length {
            code = code + "\(arc4random() % 10)"
        }
        return code
    }

    // 获取上一次请求以后服务器时间，大部分时候这个时间是可信赖的
    // 比如访问机器人，再跳转页面之前，肯定会请求，这个时候在访问页获取服务器时间是可信赖的
    // 但是对于某些操作前没有进行网络请求的，此时间不能作为判断标准
    static func serverTime() -> NSDate? {
        if var beginTime = RBNetworkRequest.cookieValueForKey(key: RBCookieKey.ServerFormatTime.rawValue)?.urlDecoding {
            while let range = beginTime.rangeOfString("+") {
                beginTime.replaceRange(range, with: " ")
            }
            
            return NSDate.dateFromString(beginTime)
        }
        
        return nil
    }
    
}

let kUserTokenInvalidNotificationName   = "com.roboming.kUserTokenInvalidNotificationName"
