//
//  RBRequest.swift
//  RBNetworkKit
//
//   Created by 范博 on 16/7/19.
//  Copyright © 2016年 Solomon. All rights reserved.
//

import UIKit

class RBNetworkRequest: NSObject {
    
    static func reset() {
        // 重置设置，在没有网络的情况下
    }
    
    static func request(path: String, params: [String: AnyObject]?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?) {
        RBRequestFetcher().request(path: path, params: params, completion: completion)
    }
    
    static func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?) {
        RBRequestFetcher().upload(path: path, params: params, progress: uploadProgressBlock, completion: completion)
    }
    
    static func download(path: String, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, URLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?) {
        RBRequestFetcher().download(path, progress: downloadProgressBlock, destination: destination, completion: completion)
    }
    
    static func downloadResume(resumeData: NSData, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, URLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?) {
        RBRequestFetcher().downloadResume(resumeData, progress: downloadProgressBlock, destination: destination, completion: completion)
    }
    
    static func cookieValueForKey(key: String, urlDomain domain: String? = nil) -> String? {
        guard let cookies = HTTPCookieStorage.shared.cookies else {
            return nil
        }
        for cookie in cookies {
            if cookie.name == key {
                if let dm = domain {
                    if dm == cookie.domain {
                        return cookie.value
                    }
                } else {
                    return cookie.value
                }
            }
        }
        
        return nil
    }
    
}
