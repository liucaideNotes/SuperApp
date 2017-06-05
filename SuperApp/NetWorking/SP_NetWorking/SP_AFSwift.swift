//
//  SP_AFSwift.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/7.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import Foundation
import AFNetworking

enum SP_AFSwiftType {
    case get
    case post
}
/// 网络请求回调闭包 success:是否成功 result:数据 progress:请求进度 error:错误信息
typealias NetworkFinished = (_ success: Bool, _ result: Any?, _ error: Error?) -> Void
typealias NetworkProgress = (_ progress:Progress?) -> Void

open class SP_AFSwift {
    fileprivate static let sharedInstance = SP_AFSwift()
    fileprivate init() {}
    //提供静态访问方法
    open static var shared: SP_AFSwift {
        return self.sharedInstance
    }
    
    fileprivate lazy var _manager:AFHTTPSessionManager = {
        let mana = AFHTTPSessionManager()
        //设置请求头文件头文件，不需要注释掉即可
        let str:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        mana.requestSerializer.setValue("i-3-"+str+"-AppStore", forHTTPHeaderField: "app-ver")
        //text/html
        //mana.responseSerializer.acceptableContentTypes?.insert("application/json")
        //设置超时时间
        mana.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        mana.requestSerializer.timeoutInterval = 15.0
        mana.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        return mana
    }()
    //MARK:--- SSL验证
    private lazy var mySecurityPolicy: AFSecurityPolicy =  {
        let securityPolicy = AFSecurityPolicy.init(pinningMode: AFSSLPinningMode.certificate)
        securityPolicy.allowInvalidCertificates = false
        securityPolicy.validatesDomainName = true
        return securityPolicy
    }()
    
    private func makeSSL(_ cerName:String) {
        guard !cerName.isEmpty else {return}
        let cerPath:String = Bundle.main.path(forResource: cerName, ofType: "cer")!
        let url = URL(fileURLWithPath: cerPath)
        if let cerData = try? Data.init(contentsOf: url) {
            _manager.securityPolicy = self.mySecurityPolicy
            mySecurityPolicy.pinnedCertificates = [cerData]
        }
    }
    //MARK:--- 请求头 -----------------------------
    func httpHeaderField(_ value:String, field:String) {
        _manager.requestSerializer.setValue(value, forHTTPHeaderField: field)
    }
    //MARK:--- 设置超时时 -----------------------------
    func timeoutInterval(_ time:TimeInterval) {
        _manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        _manager.requestSerializer.timeoutInterval = time
        _manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
    }
    
    
    //MARK:---- 监测网络
    var netTypeBlock:((AFNetworkReachabilityStatus)->Void)?//网络变更回调
    fileprivate var _hasReachability = false
    fileprivate var _netState = true
    func netWorkReachability() -> Bool {
        if (!_hasReachability) {
            let reachability = AFNetworkReachabilityManager.shared()
            reachability.startMonitoring()
            reachability.setReachabilityStatusChange({ [weak self](status) in
                switch status {
                case .unknown:
                    self?._netState = true
                    self?.netTypeBlock?(.unknown)
                case .reachableViaWiFi:
                    self?._netState = true
                    self?.netTypeBlock?(.reachableViaWiFi)
                case .reachableViaWWAN:
                    self?._netState = true
                    self?.netTypeBlock?(.reachableViaWWAN)
                case .notReachable:
                    self?._netState = false
                    self?.netTypeBlock?(.notReachable)
                }
            })
            _hasReachability = true
        }
        return _netState
    }
    
    //MARK:---- get 请求
    func get(_ url:String, cerName:String = "", block:@escaping NetworkFinished) {
        guard netWorkReachability() else {return}
        makeSSL(cerName)
        
        _manager.get(url, parameters: nil, progress: { (Progress) in
            
        }, success: { (DataTask, obj) in
            block(true,obj, nil)
        }, failure: { (DataTask, error) in
            block(false,"", error)
        })
    }
    //MARK:---- post 请求
    func post(_ url:String, param:[String:Any], cerName:String = "", block:@escaping NetworkFinished) {
        guard netWorkReachability() else {return}
        makeSSL(cerName)
        
        _manager.post(url, parameters: param, progress: { (Progress) in
            
        }, success: { (DataTask, obj) in
            block(true,obj, nil)
        }) { (DataTask, error) in
            print(error)
            block(false,"", error)
        }
        
    }
    //MARK:---- 上传
    func upload(_ url:String, param:[String:Any], uploadParams:[SP_UploadParam], cerName:String = "",progress:@escaping NetworkProgress, block:@escaping NetworkFinished) {
        guard netWorkReachability() else {return}
        makeSSL(cerName)
        
        _manager.post(url, parameters: param, constructingBodyWith: { (formData) in
            //上传文件参数
            for param in uploadParams {
                switch (param.type) {
                case .tData:
                    //formData.appendPart(withForm: param.imageData, name: param.imageName)
                    formData.appendPart(withFileData: param.imageData, name: param.imageName, fileName: param.filename, mimeType: param.mimeType)
                case .tFileURL:
                    
                    //formData.appendPartWithFileURL(NSURL(fileURLWithPath: param.fileURL), name: param.imageName, fileName: param.filename, mimeType: param.mimeType)
                    break
                }
            }
            
            }, progress: { (uploadProgress) in
                //打印下上传进度
                //print(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount)
               progress(uploadProgress)
                
            }, success: { (dataTask, obj) in
                block(true,obj, nil);
            }) { (dataTask, error) in
                block(false,"", error);
        }
        
    }
    
    //MARK:---- 下载
    func downLoad(_ url:String, param:[String:Any], cerName:String = "", progress:@escaping NetworkProgress, block:@escaping NetworkFinished) {
        
        guard netWorkReachability() else {return}
        makeSSL(cerName)
        
        _manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: url)!)
        let downLoadTask = _manager.downloadTask(with: request, progress: { (downloadProgress) in
            //打印下下载进度
            print(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount)
            progress(downloadProgress)
            }, destination: { (targetPath, response) -> URL in
                //下载地址
                print("默认下载地址:\(targetPath)")
                return targetPath
                //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
                //NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
                //return [NSURL URLWithString:filePath];
            }) { (response, filePath, error) in
                //下载完成调用的方法
                print("下载完成")
                print("\(response)-->\(filePath)")
                let result:[String:AnyObject] = ["response":response,"filePath":filePath as AnyObject? ?? "" as AnyObject]
                block(true,result as AnyObject?, error as NSError?);
                
        }
        downLoadTask.resume()
    }
}


