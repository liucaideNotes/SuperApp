//
//  RBNetworkBridgeType.swift
//  RBNetworkKit
//
//   Created by 范博 on 16/7/20.
//  Copyright © 2016年 Solomon. All rights reserved.
//

import UIKit

protocol RBNetworkBridgeType {
    
    static func instance() -> RBNetworkBridgeType
    
    // Request Setting
    func setValue(value: String?, forHTTPHeaderField header: String)
    
    // POST 的形式进行请求
    func request(path: String, params: [String: AnyObject]?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?)
    
    func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, completion: ((URLResponse?, AnyObject?, NSError?) -> Void)?)
    
    func download(path: String, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, URLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?)
    
    func downloadResume(resumeData: NSData, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((NSURL, URLResponse) -> NSURL)?, completion: ((URLResponse?, NSURL?, NSError?) -> Void)?)
    
}

private let RBRequester = RBDefaultBridge.instance()
func RBRequestFetcher() -> RBNetworkBridgeType {
    return RBRequester
}



