//
//  SP_Alamofire.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/21.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import Alamofire


struct SP_ALf_IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}

open class SP_Alamofire {
    fileprivate static let sharedInstance = SP_Alamofire()
    fileprivate init() {}
    //提供静态访问方法
    open static var shared: SP_Alamofire {
        return self.sharedInstance
    }
    
    lazy var _manager = SessionManager.default
    
    //MARK:--- SSL认证 -----------------------------
    func alf_SSL(_ hosts:[String], p12:(name:String, pwd:String)) {
        let selfSignedHosts = hosts//["192.168.1.112", "www.hangge.com"]
        _manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            //认证服务器（这里不使用服务器证书认证，只需地址是我们定义的几个地址即可信任）
            if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodServerTrust
                && selfSignedHosts.contains(challenge.protectionSpace.host)
            {
                print("服务器认证！")
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                return (.useCredential, credential)
            }
            //认证客户端证书
            else if challenge.protectionSpace.authenticationMethod
                    == NSURLAuthenticationMethodClientCertificate
            {
                print("客户端证书认证！")
                //获取客户端证书相关信息
                let identityAndTrust:SP_ALf_IdentityAndTrust = self.extractIdentity(p12);
                let urlCredential:URLCredential = URLCredential(
                    identity: identityAndTrust.identityRef,
                    certificates: identityAndTrust.certArray as? [AnyObject],
                    persistence: URLCredential.Persistence.forSession);
                
                return (.useCredential, urlCredential);
            }
            // 其它情况（不接受认证）
            else
            {
                print("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    //MARK:--- 双向认证 -----------------------------
    func alf_SSL2(_ cerName:String ,p12:(name:String, pwd:String)) {
        
        _manager.delegate.sessionDidReceiveChallenge = { (session, challenge) in
            //认证服务器
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            {
                print("服务端证书认证！")
                let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
                let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
                let remoteCertificateData
                    = CFBridgingRetain(SecCertificateCopyData(certificate))!
                //证书目录
                let cerPath = Bundle.main.path(forResource: cerName, ofType: "cer")!
                let cerUrl = URL(fileURLWithPath:cerPath)
                let localCertificateData = try! Data(contentsOf: cerUrl)
                if (remoteCertificateData.isEqual(localCertificateData) == true) {
                    let credential = URLCredential(trust: serverTrust)
                    challenge.sender?.use(credential, for: challenge)
                    return (URLSession.AuthChallengeDisposition.useCredential,
                            URLCredential(trust: challenge.protectionSpace.serverTrust!))
                }else {
                    return (.cancelAuthenticationChallenge, nil)
                }
            }
            //认证客户端证书
            else if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodClientCertificate
            {
                print("客户端证书认证！")
                //获取客户端证书相关信息
                let identityAndTrust:SP_ALf_IdentityAndTrust = self.extractIdentity(p12);
                
                let urlCredential:URLCredential = URLCredential(
                    identity: identityAndTrust.identityRef,
                    certificates: identityAndTrust.certArray as? [AnyObject],
                    persistence: URLCredential.Persistence.forSession);
                
                return (.useCredential, urlCredential);
            }
            // 其它情况（不接受认证）
            else
            {
                print("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    //MARK:--- 获取客户端证书相关信息 -----------------------------
    fileprivate func extractIdentity(_ p12:(name:String, pwd:String)) -> SP_ALf_IdentityAndTrust {
        
        var identityAndTrust:SP_ALf_IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess
        //客户端证书 p12 文件目录
        let path: String = Bundle.main.path(forResource: p12.name, ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile:path)!
        let key : NSString = kSecImportExportPassphrase as NSString
        let options : NSDictionary = [key : p12.pwd] //客户端证书密码
        //create variable for holding security information
        //var privateKeyRef: SecKeyRef? = nil
        var items : CFArray?
        securityError = SecPKCS12Import(PKCS12Data, options, &items)
        if securityError == errSecSuccess {
            let certItems:CFArray = items as CFArray!;
            let certItemsArray:Array = certItems as Array
            let dict:AnyObject? = certItemsArray.first;
            if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
                // grab the identity
                let identityPointer:AnyObject? = certEntry["identity"];
                let secIdentityRef:SecIdentity = identityPointer as! SecIdentity!
                print("\(identityPointer)  :::: \(secIdentityRef)")
                // grab the trust
                let trustPointer:AnyObject? = certEntry["trust"]
                let trustRef:SecTrust = trustPointer as! SecTrust
                print("\(trustPointer)  :::: \(trustRef)")
                // grab the cert
                let chainPointer:AnyObject? = certEntry["chain"]
                identityAndTrust = SP_ALf_IdentityAndTrust(identityRef: secIdentityRef,
                                                    trust: trustRef, certArray:  chainPointer!)
            }
        }
        return identityAndTrust;
    }
    
    var uploadCancel = false
    
    var _headers:[String:String] = [:]
}

extension SP_Alamofire {
    //MARK:--- 网络请求 -----------------------------
    class func get(_ url:String, param:[String:Any], block: sp_netComBlock? = nil) {
         DispatchQueue.global().async {
            SP_Alamofire.shared._manager.request(url, method: .get, parameters: param, headers: SP_Alamofire.shared._headers).responseJSON { (response) in
                DispatchQueue.main.async {
                    SP_Alamofire.disposeResponse(response, block:block)
                }
                
            }
        }
        
        
    }
    class func post(_ url:String, param:[String:Any], block: sp_netComBlock? = nil) {
        SP_Alamofire.shared._manager
            .request(url, method: .post,
                     parameters: param,
                     headers: SP_Alamofire.shared._headers)
            .responseJSON { response in
                SP_Alamofire.disposeResponse(response, block:block)
                
        }
        
    }
    class func upload(_ url:String, param:[String:String], uploadParams:[SP_UploadParam], progressBlock: sp_netProgressBlock? = nil, block: sp_netComBlock? = nil) {
        
        SP_Alamofire.shared.uploadCancel = false
        SP_Alamofire.shared._manager.upload(multipartFormData: { (formData) in
            for item in uploadParams {
                switch (item.type) {
                case .tData:
                    formData.append(item.fileData, withName: item.serverName, fileName: item.filename, mimeType: item.mimeType)
                case .tFileURL:
                    if let fileUrl = item.fileURL {
                        formData.append(fileUrl, withName: item.serverName, fileName: item.filename, mimeType: item.mimeType)
                    }
                }
            }
            for item in param {
                let dat:Data = item.value.data(using: String.Encoding.utf8) ?? Data()
                formData.append(dat, withName: item.key)
            }
        }, to: url, headers:SP_Alamofire.shared._headers, encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
            case .success(let uploads, _, _):
                if SP_Alamofire.shared.uploadCancel {
                    uploads.cancel()
                }
                uploads.uploadProgress(closure: { (progress) in
                    progressBlock?(progress)
                }).responseJSON { response in
                    SP_Alamofire.disposeResponse(response, block:block)
                }
            case .failure(let error):
                block?(false,"",sp_returnNSError(error))
            }
        })
    }
    class func downLoad(_ url:String, param:[String:Any], progressBlock: sp_netProgressBlock? = nil, block: sp_netComBlock? = nil) {
        /*
        Alamofire.download("https://httpbin.org/image/png").responseData { response in
            if let data = response.result.value {
                let image = UIImage(data: data)
            }
        }
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendPathComponent("pig.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(urlString, to: destination).response { response in
            print(response)
            
            if response.error == nil, let imagePath = response.destinationURL?.path {
                let image = UIImage(contentsOfFile: imagePath)
            }
        }
        Alamofire.download("https://httpbin.org/image/png")
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    let image = UIImage(data: data)
                }
        }*/
        
    }
    
    class func disposeResponse(_ response:DataResponse<Any>, block:sp_netComBlock? = nil) {
        var error = ""
        var isOk = false
        switch response.result {
        case .success(let json):
            if (response.result.value != nil) {
                isOk = true
                error = ""
            } else{
                isOk = false
                error = SP_ErrorType.noData.stringValue
            }
            block?(isOk,json,error)
        case .failure(let error):
            isOk = false
            //let err:NSError = error as NSError
            //error = getError(ErrorCodeType(rawValue: err.code)!)
            block?(isOk,"",sp_returnNSError(error))
        }
    }
}











