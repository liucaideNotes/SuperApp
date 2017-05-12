//
//  RBCommonCode.swift
//  Ming_Version_2
//
//   Created by 范博 on 16/8/9.
//  Copyright © 2016年 kevinil. All rights reserved.
//

import UIKit

protocol RBErrorTypeDescription {
    
    var errorDescription: String { get }
    
}

// 请求发送之前核查错误
enum RBNetworkRequestErrorType: Int, RBErrorTypeDescription {
    
    case UnknowError    = -999          // 未知错误
    case NetworkError   = 404           // 网络错误
    case ParamsError    = 9000          // 请求参数错误
    case ResponseError  = 9001          // 返回内容不正确(即后台返回数据与约定不匹配)
    
    var errorDescription: String {
        switch self {
        case .UnknowError:
            return "未知错误".localizedString
        case .NetworkError:
            return "网络错误".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .ResponseError:
            return "返回值不正确".localizedString
        }
    }
    
}

// 返回状态码
enum RBNetworkResponseCodeType: Int, RBErrorTypeDescription {
    
    case Successed      = 200           // 请求成功
    case ParamsError    = 103           // 参数错误
    case Timeout        = 500           // 超时
    case VerifyFailed   = 40001         // 验证失败
    case TokenError     = 40002         // Token验证失败,登录已失效
    case UnLogin        = 40003         // 未登录
    
    var errorDescription: String {
        switch self {
        case .Successed:
            return "请求成功".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Timeout:
            return "请求超时".localizedString
        case .VerifyFailed:
            return "验证失败".localizedString
        case .TokenError:
            return "登录已失效".localizedString
        case .UnLogin:
            return "未登录".localizedString
        }
    }
    
}

// RobotFront.RobotQueue 返回码
enum RBVisitRobotCode: Int, RBErrorTypeDescription {
    
    case BlackList              = 101       // 该用户在黑名单
    case RobotNotExist          = 102       // 机器人不存在
    case ParamsError            = 103       // 参数错误
    case InsertDataFailed       = 104       // 插入数据失败
    case RobotBusy              = 105       // 机器人正在被访问
    case NoVisitPermission      = 107       // 没有访问权限
    case RobotClosed            = 108       // 机器人已关闭/未开启
    case RoomNotExist           = 109       // 机器人房间不存在
    case AllowAccess            = 200       // 允许访问
    case QueueDoneToAccess      = 201       // 排队成功，可以访问
    case QueueDoneWaitAccess    = 202       // 排队成功，等待访问
    
    var errorDescription: String {
        switch self {
        case .BlackList:
            return "访问被拒，你已被加入黑名单".localizedString
        case .RobotNotExist:
            return "机器人不存在".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .InsertDataFailed:
            return "插入数据失败".localizedString
        case .RobotBusy:
            return "机器人正在被访问".localizedString
        case .NoVisitPermission:
            return "没有访问权限".localizedString
        case .RobotClosed:
            return "机器人已关闭/未开启".localizedString
        case .RoomNotExist:
            return "机器人房间不存在".localizedString
        case .AllowAccess:
            return "允许访问".localizedString
        case .QueueDoneToAccess:
            return "排队成功，可以访问".localizedString
        case .QueueDoneWaitAccess:
            return "排队成功，等待访问".localizedString
        }
    }
    
}

// 检查账号状态返回码
enum RBAccountStatus: Int, RBErrorTypeDescription {
    case NotExist               = 100
    case ParamsError            = 103
    case Exist                  = 200
    case ExistButNoPassword     = 201       // 其他人邀请时，如果没有注册，将自动注册，但没有密码
    
    var errorDescription: String {
        switch self {
        case .NotExist:
            return "账号不存在".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Exist:
            return "账号存在".localizedString
        case .ExistButNoPassword:
            return "需要重设密码".localizedString
        }
    }
}

// 发送验证码返回 Code
enum RBSendCaptchaCode: Int, RBErrorTypeDescription {
    
    case SendFailed             = 101       // 发送失败
    case ParamsError            = 103       // 参数错误
    case Success                = 200       // 调用成功
    
    var errorDescription: String {
        switch self {
        case .SendFailed:
            return "发送失败".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Success:
            return "发送成功".localizedString
        }
    }
    
}

// 更新密码返回code
enum RBPublicDoUpdatePasswordCode: Int, RBErrorTypeDescription {
    case UpdateFailed           = 101       // 修改失败
    case NotExist               = 102       // 账号不存在
    case ParamsError            = 103       // 参数错误
    case Success                = 200       // 成功
    
    var errorDescription: String {
        switch self {
        case .UpdateFailed:
            return "更新失败".localizedString
        case .NotExist:
            return "账号不存在".localizedString
        case .ParamsError:
            return RBNetworkRequestErrorType.ParamsError.errorDescription
        case .Success:
            return "更新成功".localizedString
        }
    }
}

// 登录返回 Code
enum RBPublicDoLoginCode: Int, RBErrorTypeDescription {
    case NotExist               = 102       // 账号不存在
    case ParamsError            = 103       // 参数错误
    case UserNameOrPasswordError    = 104   // 用户名或密码错误
    case Success                = 200       // 登录成功
    
    var errorDescription: String {
        switch self {
        case .NotExist:
            return "账号不存在".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .UserNameOrPasswordError:
            return "用户名或密码错误".localizedString
        case .Success:
            return "登录成功".localizedString
        }
    }
}

// 注册返回 Code
enum RBPublicDoRegisterCode: Int, RBErrorTypeDescription {
    case Failed                 = 101       // 注册失败
    case PhoneOccupation        = 102       // 手机已被占用
    case EmailOccupation        = 104       // 邮箱被占用
    case ParamsError            = 103       // 参数错误
    case Success                = 200       // 成功
    
    var errorDescription: String {
        switch self {
        case .Failed:
            return "注册失败".localizedString
        case .PhoneOccupation:
            return "手机号码已存在".localizedString
        case .EmailOccupation:
            return "邮箱号码已存在".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Success:
            return "注册成功".localizedString
        }
    }
}

// 查询机器人访问状态返回码
enum RBRobotFrontRobotQueueCode: Int, RBErrorTypeDescription {
    
    case BlackList          = 101           // 访问者处于黑名单
    case RobotNotExist      = 102           // 机器人不存在
    case ParamsError        = 103           // 参数错误
    case InsertDataFailed   = 104           // 插入数据失败
    case RobotIsVisiting    = 105           // 机器人正在被访问
    case NoVisitPermission  = 107           // 没有访问权限
    case RobotClosed        = 108           // 机器人已关闭
    case RoomNotExist       = 109           // 房间不存在
    case Success            = 200           // 可访问
    case QueueDoneCanVisit  = 201           // 排队成功可访问
    case QueueDoneWait      = 202           // 已排队，等待队列访问
    
    var errorDescription: String {
        switch self {
        case .BlackList:
            return "访问被拒，你已被加入黑名单".localizedString
        case .RobotNotExist:
            return "机器人不存在".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .InsertDataFailed:
            return "插入数据失败".localizedString
        case .RobotIsVisiting:
            return "机器人正在被访问".localizedString
        case .NoVisitPermission:
            return "没有访问权限".localizedString
        case .RobotClosed:
            return "机器人已关闭/未开启".localizedString
        case .RoomNotExist:
            return "机器人房间不存在".localizedString
        case .Success:
            return "允许访问".localizedString
        case .QueueDoneCanVisit:
            return "排队成功，可以访问".localizedString
        case .QueueDoneWait:
            return "排队成功，等待访问".localizedString
        }
    }
    
}

// 关注机器人返回码
enum RBRobotFrontRobotFollowCode: Int, RBErrorTypeDescription {
    
    case HandleError        = 101           // 操作失败
    case StatusError        = 102           // 机器人请求状态与数据库状态一致
    case ParamsError        = 103           // 参数错误
    case Success            = 200           // 请求成功
    var errorDescription: String {
        switch self {
        case .HandleError:
            return "操作失败".localizedString
        case .StatusError:
            return "请求状态与数据库状态一致".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Success:
            return "请求成功".localizedString
        }
    }
    
}

// 删除被邀请机器人
enum RBRobotFrontRobotRejectInviteCode: Int, RBErrorTypeDescription {
    
    case HandleError        = 101
    case ParamsError        = 103
    case Success            = 200
    
    var errorDescription: String {
        switch self {
        case .HandleError:
            return "操作失败".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .Success:
            return "请求成功".localizedString
        }
    }
}

// 发信息请求开启机器人
enum RBRobotFrontRobotApplyOpenRobotCode: Int, RBErrorTypeDescription {
    
    case SendFailed         = 101
    case AccountError       = 102
    case ParamsError        = 103
    case NotFoundOwner      = 104
    case Success            = 200
    
    var errorDescription: String {
        switch self {
        case .SendFailed:
            return "发送失败".localizedString
        case .AccountError:
            return "可接受信息的账号不合法".localizedString
        case .ParamsError:
            return "参数错误".localizedString
        case .NotFoundOwner:
            return "没有找到所有者".localizedString
        case .Success:
            return "请求成功".localizedString
        }
    }
    
}

enum RBCookieKey: String {
    
    case ServerTimestamp        = "time"
    case ServerFormatTime       = "formattime"
    
}

struct RBSigner {
    
    static func sign(params: [String: AnyObject]) -> String {
        let array = params.flatMap( { (key, value) in
            return "\(key)=\(value)"
        } )
        return self.sign(array)
    }
    
    static func sign(params: [String]) -> String {
        var mutableStr = ""
        for str in params.sorted() {
            if mutableStr.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                mutableStr += "&"
            }
            mutableStr += str
        }
        mutableStr += "!@#$roboming"
        return mutableStr.md5()
    }
        
}
