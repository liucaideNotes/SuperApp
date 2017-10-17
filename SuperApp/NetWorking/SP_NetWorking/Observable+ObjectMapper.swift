//
//  Observable+ObjectMapper.swift
//  PalmCivet
//
//  Created by DianQK on 16/2/4.
//  Copyright © 2016年 DianQK. All rights reserved.
//
import RxSwift
import Moya
import ObjectMapper
import SwiftyJSON

extension Observable {
    
    func mapObject<T: Mappable>(_ type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw SP_MoyaError.tParseJSONError
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(_ type: T.Type) -> Observable<[T]> {
        return self.map { representor in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = representor as? [Any] else {
                throw SP_MoyaError.tParseJSONError
            }
            guard let dicts = array as? [[String: Any]] else {
                throw SP_MoyaError.tParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)!
        }
    }
}

public protocol Mapable {
    init?(jsonData:JSON)
}
extension Observable {
    private func resultFromJSON<T: Mapable>(_ jsonData:JSON, classType: T.Type) -> T? {
        return T(jsonData: jsonData)
    }
    func mapSwiftyJsonObj<T: Mapable>(_ type: T.Type) -> Observable<T?> {
        return map { response in
            /*/ get Moya.Response
            guard let res = response as? Response else {
                throw SP_MoyaError.tNoRepresentor
            }
            // check http status
            guard ((200...209) ~= res.statusCode) else {
                throw SP_MoyaError.tNotSuccessfulHTTP
            }*/
            
            // unwrap biz json shell
            let json = JSON(response)
            
            // check biz status
            if let code = json[SP_Moya_Code].string{
                if code == SP_MoyaCodeError.t成功.rawValue {
                    // bizSuccess -> return biz obj
                    return self.resultFromJSON(json[SP_Moya_Data], classType:type)
                } else {
                    // bizError -> throw biz error
                    throw SP_MoyaError.tError(resultCode: SP_MoyaCodeError(rawValue: json[SP_Moya_Code].stringValue), resultMsg: json[SP_Moya_Msg].stringValue)
                }
            } else {
                throw SP_MoyaError.tOtherError
            }
        }
    }
    
    func mapSwiftyJsonArray<T: Mapable>(_ type: T.Type) -> Observable<[T]> {
        return map { response in
            
            /*/ get Moya.Response
            guard let response = response as? Response else {
                throw RxSwiftMoyaError.tNoRepresentor
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw RxSwiftMoyaError.tNotSuccessfulHTTP
            }*/
            
            // unwrap biz json shell
            let json = JSON(response)
            
            // check biz status
            if let code = json[SP_Moya_Code].string {
                if code == SP_MoyaCodeError.t成功.rawValue {
                    // bizSuccess -> wrap and return biz obj array
                    var objects = [T]()
                    let objectsArrays = json[SP_Moya_Data].array
                    if let array = objectsArrays {
                        for object in array {
                            if let obj = self.resultFromJSON(object, classType:type) {
                                objects.append(obj)
                            }
                        }
                        return objects
                    } else {
                        throw SP_MoyaError.tNoData
                    }
                    
                } else {
                    throw SP_MoyaError.tError(resultCode: SP_MoyaCodeError(rawValue: json[SP_Moya_Code].stringValue) , resultMsg: json[SP_Moya_Msg].stringValue)
                }
            }
            else {
                throw SP_MoyaError.tOtherError
            }
            
        }
    }
    
    
}

enum SP_MoyaError: Swift.Error {
    case tParseJSONError
    case tNoRepresentor
    case tNotSuccessfulHTTP
    case tNoData
    case tError(resultCode: SP_MoyaCodeError?, resultMsg: String?)
    case tOtherError
    
    var stringValue:String {
        switch self {
        case .tParseJSONError:
            return "Json格式错误"
        case .tNoRepresentor:
            return "数据错误"
        case .tNotSuccessfulHTTP:
            return "连接错误"
        case .tNoData:
            return "没有数据"
        case .tError(let code, let msg):
            guard msg!.isEmpty else {
                return msg!
            }
            guard code!.stringValue.isEmpty else {
                return code!.stringValue
            }
            return "服务器错误"
        case .tOtherError: return "服务器错误"
        }
    }
}

enum SP_MoyaCodeError: String {
    case t成功         = "000000"
    case t请求方法错误  = "000001"
    case t参数错误     = "000002"
    case t用户已注册   = "000003"
    case t用户未注册    = "000004"
    case t发送验证码失败 = "000005"
    case t密码错误     = "000006"
    case t需要登录     = "000007"
    case tError      = "011111"
    
    var stringValue:String {
        switch self {
        case .t成功:       return sp_localized(SP_MoyaCodeError.t成功.rawValue)
        case .t请求方法错误: return sp_localized(SP_MoyaCodeError.t请求方法错误.rawValue)
        case .t参数错误:    return sp_localized(SP_MoyaCodeError.t参数错误.rawValue)
        case .t用户已注册:   return sp_localized(SP_MoyaCodeError.t用户已注册.rawValue)
        case .t用户未注册:   return sp_localized(SP_MoyaCodeError.t用户未注册.rawValue)
        case .t发送验证码失败: return sp_localized(SP_MoyaCodeError.t发送验证码失败.rawValue)
        case .t密码错误: return sp_localized(SP_MoyaCodeError.t密码错误.rawValue)
        case .t需要登录: return sp_localized(SP_MoyaCodeError.t需要登录.rawValue)
        default: return sp_localized(SP_MoyaCodeError.tError.rawValue)
        }
    }
}

func SP_MoyaReturnError(_ error:Swift.Error) -> String {
    if let err = error as? SP_MoyaError {
        return err.stringValue
    }
    else if let err = error as? MoyaError {
        
        if err.errorDescription == "Status code didn't fall within the given range." {
            return "API错误"
        }else{
            return err.errorDescription ?? "服务器错误"
        }
        
    }
    else{
        return sp_returnNSError(error)
    }
}

let SP_Moya_Code = "code"
let SP_Moya_Msg = "msg"
let SP_Moya_Data = "data"



