//
//  RBDefaultBridge.swift
//  RBNetworkKit
//
//   Created by 范博  on 16/7/20.
//  Copyright © 2016年 Solomon. All rights reserved.
//

import UIKit
import AFNetworking

let RBTimeoutInterval: TimeInterval = 15

class RBDefaultBridge: RBNetworkBridgeType {
    
    static func instance() -> RBNetworkBridgeType {
        return RBDefaultBridge()
    }
    
    lazy private var session: AFHTTPSessionManager = AFHTTPSessionManager()
    
    lazy private var HTTPHeaderFiled = [String: String]()
    func setValue(value: String?, forHTTPHeaderField header: String) {
        self.HTTPHeaderFiled[header] = value
    }
    
    init() {
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) in
            print("Network Status Change: \(status,status.rawValue)")
            switch status {
            case .reachableViaWWAN:
                self.session = AFHTTPSessionManager()
                break
            case .reachableViaWiFi:
                self.session = AFHTTPSessionManager()
                break
                
            default:
                break
            }
        }
    }
    
    /**
     向指定URL发送POST请求
     
     - parameter path:       URL 地址
       * -see: struct RBRequestFunction
     - parameter params:     POST 参数
     - parameter completion: 完成回调
     */
    func request(path: String, params: [String: AnyObject]?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?) {
        let urlString = path
        guard let url = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(nil, nil, error)
            return
        }
        
        let request = NSMutableURLRequest(url: url as URL)
        request.timeoutInterval = RBTimeoutInterval
        request.httpMethod = "POST"
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let parameters = params {
            let serializerStr = AFQueryStringFromParameters(parameters)
            let HTTPBody = serializerStr.data(using: String.Encoding.utf8)
            request.httpBody = HTTPBody
        }
        let task = self.session.dataTaskWithRequest(request as URLRequest, completionHandler: completion)
        task.resume()
    }
    
    /**
     向指定URL上传文件
     
     - parameter path:                指定URL
       * -see: struct RBRequestFunction
     - parameter data:                上传文件数据
     - parameter uploadProgressBlock: Progress Handler
     - parameter completion:          完成回调
     */
    func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?) {
        let urlString = path
        guard let _ = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(nil, nil, error)
            return
        }
        
        let parameters = params
        // 做一些附加操作
        
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: urlString, parameters: parameters, constructingBodyWith: nil, error: nil)
        request.timeoutInterval = RBTimeoutInterval
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let task = self.session.uploadTaskWithStreamedRequest(request as URLRequest, progress: uploadProgressBlock, completionHandler: completion)
        task.resume()
    }
    
    func download(path: String, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, URLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?) {
        let urlString = path
        guard let url = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(nil, nil, error)
            return
        }
        
        let request = NSMutableURLRequest(URL: url as URL)
        request.timeoutInterval = RBTimeoutInterval
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let downloader = self.session.downloadTaskWithRequest(request, progress: downloadProgressBlock, destination: destination, completionHandler: completion)
        downloader.resume()
    }
    
    func downloadResume(resumeData: NSData, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, NSURLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?) {
        let downloader = self.session.downloadTaskWithResumeData(resumeData, progress: downloadProgressBlock, destination: destination, completionHandler: completion)
        downloader.resume()
    }
    
}
