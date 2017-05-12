//
//  RBNetworkType.swift
//  RBNetworkKit
//
//   Created by 范博 on 16/7/19.
//  Copyright © 2016年 Solomon. All rights reserved.
//

import UIKit



// 开发环境
struct RBEnvironment {
    
    let requestUrl: String
    let imageUrl: String
    let uploadImageUrl: String
    
    static var Current: RBEnvironment {
        return .Product
    }
    
    // 测试环境
    static let Product: RBEnvironment = {
        return RBEnvironment(requestUrl: "https://api.roboming.com/roboming2.1/api.php?s=",
                             imageUrl: "http://115.29.9.76/roboming2/images/headImage/",
                             uploadImageUrl: "http://115.29.9.76/roboming2")
    } ()
    
    // 生产环境
    static let Beta: RBEnvironment = {
        return RBEnvironment(requestUrl: "https://beta2.roboming.com/api.php?s=",
                             imageUrl: "http://115.29.9.76/roboming2/images/headImage/",
                             uploadImageUrl: "http://115.29.9.76/roboming2")
    } ()
    
}

// 方法域
struct RBRequestFunction {
    
    // Log 方法域
    static let Log = RBRequestDomainLogType.self
    
    // Public 方法域
    static let Public = RBRequestDomainPublicType.self
    
    // Robot 方法域 （头部端）
    static let Robot = RBRequestDomainRobotType.self
    
    // RobotFront 方法域 （操作端）
    static let RobotFront = RBRequestDomainRobotFrontType.self
    
    // SendEmail 方法域
    static let SendEmail = RBRequestDomainSendEmailType.self
    
    // SendSms 方法域
    static let SendSms = RBRequestDomainSendSmsType.self
    
    // User 方法域
    static let User = RBRequestDomainUserType.self
    
    // Upload 方法域
    static let Upload = RBRequestUploadType.self
    
}

protocol RBRequestFunctionType {
    
    var base: String { get }
    
    var domain: String { get }
    var function: String { get }
    
    var urlString: String { get }
    
}

extension RBRequestFunctionType {
    
    var base: String {
        return RBEnvironment.Current.requestUrl
    }
    
    var urlString: String {
        return "\(self.base)/\(self.domain)/\(self.function)"
    }
    
}

struct RBRequestUploadType: RBRequestFunctionType {
    
    private(set) var base: String = RBEnvironment.Current.uploadImageUrl
    private(set) var domain = "api4"
    private(set) var function: String
    
    static let UploadUserImage: RBRequestUploadType = {
        return RBRequestUploadType(function: "ios_uploadUserImage.php")
    } ()
    
    static let UploadRobotImage: RBRequestUploadType = {
        return RBRequestUploadType(function: "ios_uploadRobotImage.php")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainLogType: RBRequestFunctionType {
    
    private(set) var domain = "Logs"
    private(set) var function: String
    
    static let LogsList: RBRequestDomainLogType = {
        return RBRequestDomainLogType(function: "LogsList")
    } ()
    
    static let AdminLogFile: RBRequestDomainLogType = {
        return RBRequestDomainLogType(function: "AdminLogFile")
    } ()
    
    static let AdminLogDetail: RBRequestDomainLogType = {
        return RBRequestDomainLogType(function: "AdminLogDetail")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainPublicType: RBRequestFunctionType {
    
    private(set) var domain = "Public"
    private(set) var function: String
    
    // 登陆
    static let DoLogin: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "DoLogin")
    } ()
    
    // 注册
    static let DoRegister: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "DoRegister")
    } ()
    
    static let DoLogout: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "DoLogout")
    } ()
    
    // 检查用户类型接口
    static let LoginType: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "LoginType")
    } ()
    
    // 修改密码
    static let DoUpdatePwd: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "DoUpdatePwd")
    } ()
    
    // 获取服务器时间
    static let GetServiceTime: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "GetServiceTime")
    } ()
    
    // 获取当前版本
    static let GetCurrentVersion: RBRequestDomainPublicType = {
        return RBRequestDomainPublicType(function: "GetCurrentVersion")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainRobotType: RBRequestFunctionType {
    
    private(set) var domain = "Robot"
    private(set) var function: String
    
    // 获取机器人列表
    static let RobotList: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "RobotList")
    } ()
    
    // 获取机器人详情
    static let RobotDetail: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "RobotDetail")
    } ()
    
    // 更新机器人信息
    static let DoUpdate: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "DoUpdate")
    } ()
    
    // 机器人受邀者列表
    static let InviteeList: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "InviteeList")
    } ()
    
    // 机器人访问记录
    static let VisitlogList: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "VisitlogList")
    } ()
    
    // 后台机器人排队预约记录
    static let ReserveList: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "ReserveList")
    } ()
    
    // 后台机器人删除排队预约记录
    static let ReserveDel: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "ReserveDel")
    } ()
    
    // 删除机器人
    static let UserrobotDel: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "UserrobotDel")
    } ()
    
    // 操作机器人黑名单
    static let OpreratorBlackList: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "OpreratorBlackList")
    } ()
    
    // 操作机器人个性域名
    static let OpreratorPersonalDomain: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "OpreratorPersonalDomain")
    } ()
    // 机器人是否需要下载视频
    static let RobotVideo: RBRequestDomainRobotType = {
        return RBRequestDomainRobotType(function: "RobotVideo")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainRobotFrontType: RBRequestFunctionType {
    
    private(set) var domain = "RobotFront"
    private(set) var function: String
    
    // 机器人列表
    static let RobotList: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotList")
    } ()
    
    // 发现机器人
    static let RobotDiscover: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotDiscover")
    } ()
    
    // 获取机器人可访问状态
    @available(*, unavailable, message: "已废弃，请使用三合一接口 RBRequestDomainRobotFrontType.RobotQueue")
    static let RobotStatus: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotStatus")
    } ()
    
    // 访问公开机器人
    @available(*, unavailable, message: "已废弃，请使用三合一接口 RBRequestDomainRobotFrontType.RobotQueue")
    static let RobotLine: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotLine")
    } ()
    
    // 访问私有机器人
    @available(*, unavailable, message: "已废弃，请使用三合一接口 RBRequestDomainRobotFrontType.RobotQueue")
    static let RobotPrivateLine: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotPrivateLine")
    } ()
    
    // 获取机器人可访问状态
    static let RobotQueue: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "robotQueue")
    } ()
    
    // 获取机器人可访问时间
    static let GetRobotVisitTime: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "GetRobotVisitTime")
    } ()
    
    // 确定邀请
    static let EnsureInvitation: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "EnsureInvitation")
    } ()
    
    // 关注机器人
    static let FollowRobot: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "FollowRobot")
    } ()
    
    // 删除被邀请机器人信息
    static let DelRobotInvite: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "DelRobotInvite")
    } ()
    
    // 添加机器人
    static let RobotAdd: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotAdd")
    } ()
    
    // 删除机器人
    static let RobotDel: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "RobotDel")
    } ()
    
    // 机器人更新图片（App端）
    static let AppUploadImage: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "AppUploadImage")
    } ()
    
    // 机器人更新图片（web端）
    static let UploadImage: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "UploadImage")
    } ()
    
    //  邀请访问机器人列表
    static let InviteVisit: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "InviteVisit")
    } ()
    
    // 取消邀请访问机器人
    static let CancleInviteVisit: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "CancleInviteVisit")
    } ()
    
    // 更新设备访问令牌
    static let UpdateIosDeviceToken: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "UpdateIosDeviceToken")
    } ()
    
    // 新增访客记录信息，同时更新队列
    static let AddVisitLog: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "AddVisitLog")
    } ()
    
    // 获取当个机器人所有访问记录
    static let SingleRobotVisitlogList: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "SingleRobotVisitlogList")
    } ()
    
    // 晴空机器人访问队列
    static let ClearReserveList: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "ClearReserveList")
    } ()
    
    // 申请访问机器人
    static let ApplyOpenRobot: RBRequestDomainRobotFrontType = {
        return RBRequestDomainRobotFrontType(function: "ApplyOpenRobot")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainSendEmailType: RBRequestFunctionType {
    
    private(set) var domain = "SendEmail"
    private(set) var function: String
    
    // 发送邮件
    static let SendEmail: RBRequestDomainSendEmailType = {
        return RBRequestDomainSendEmailType(function: "SendEmail")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainSendSmsType: RBRequestFunctionType {
    
    private(set) var domain = "SendSms"
    private(set) var function: String
    
    // 发送短信验证码
    static let SendCode: RBRequestDomainSendSmsType = {
        return RBRequestDomainSendSmsType(function: "SendCode")
    } ()
    
    // 发送短信请求打开机器人
    static let SendApplyOpenRobot: RBRequestDomainSendSmsType = {
        return RBRequestDomainSendSmsType(function: "SendApplyOpenRobot")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

struct RBRequestDomainUserType: RBRequestFunctionType {
    
    private(set) var domain = "User"
    private(set) var function: String
    
    // 更新用户信息
    static let DoUpdate: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "DoUpdate")
    } ()
    
    // 更新头像（App端）
    static let UploadImage: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "UploadImage")
    } ()
    
    // 更新头像（web端）
    static let AppUploadImage: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "AppUploadImage")
    } ()
    
    // 用户列表（web端）
    static let UserList: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "UserList")
    } ()
    
    // 用户详情
    static let UserDetail: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "UserDetail")
    } ()
    
    // 用户留言信息
    static let UserMessage: RBRequestDomainUserType = {
        return RBRequestDomainUserType(function: "UserMessage")
    } ()
    
    init(function: String) {
        self.function = function
    }
    
}

let RBNetworkKitGetCurrentSystemVersion: OperatingSystemVersion {
    let pro = ProcessInfo()
    return pro.operatingSystemVersion
}; ()

func RBNetworkKitCheckSystemVersionLeast(version: OperatingSystemVersion-> Bool, {
    let check = ProcessInfo().isOperatingSystemAtLeastVersion(version)
    return check
}

func RBNetworkKitCheckSystemVersionLeast(major majorVersion: Int, minor minorVersion: Int = 0, patch patchVersion: Int = 0) -> Bool {
    let version = OperatingSystemVersion(majorVersion: majorVersion, minorVersion: minorVersion, patchVersion: patchVersion)
    return RBNetworkKitCheckSystemVersionLeast(version)
}
