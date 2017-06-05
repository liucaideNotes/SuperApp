//
//  String_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
extension String {
    // 取子串  下标脚本
    /*
     //插入
     var str = "1234"
     str[1..<1] = "345"
     print(str) //1345234
     //替换
     str[1...4] = "000"
     print(str) //100034
     //删除
     str[1...3] = ""
     print(str) //134
     //取子串
     let subStr = str[0...1]
     print(subStr) //13
     */
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: range.upperBound)
            return self[Range(startIndex..<endIndex)]
        }
        
        set {
            let startIndex = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = Range(startIndex..<endIndex)
            self.replaceSubrange(strRange, with: newValue)
        }
    }
    
    //MARK:---------- 汉字转拼音
    func sp_ToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        // 首字母大写
        var str1 = string.replacingOccurrences(of: " ", with: "")
        str1 = str1.capitalized
        return str1
    }
    //MARK:--- 按拼音排序 -----------------------------
    static func sp_SortPinYin(_ arr:[String])->[String]{
        return arr.sorted(by: { (one, two) -> Bool in
            one < two
        })
    }
    
    
    //MARK:---------- 计算时间
    func byNowDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        if let _ = date{
            let nowDate = Date()
            var spceTime = date!.timeIntervalSince(nowDate)
            spceTime += 24 * 3600
            let calendar = Calendar.current
            let unitValue = NSCalendar.Unit.day.rawValue | NSCalendar.Unit.hour.rawValue | NSCalendar.Unit.minute.rawValue
            
            let unit = NSCalendar.Unit(rawValue: unitValue)
            let cmps = (calendar as NSCalendar).components(unit, from: nowDate, to: date!, options: NSCalendar.Options.wrapComponents)
            if cmps.day! > 365 {
                return "一年之内不过期"
            }else{
                return "\(cmps.day)天\(cmps.hour)小时\(cmps.minute)分钟"
            }
        }
        return "已过期"
    }
    //MARK:---------- 手机号判断
    func isMobileNumber() -> Bool {
        
        return self.characters.count == 11
        
        /**
         * 手机号码
         * 小米 大麦 170 171
         * 蚂蚁宝卡 176
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189
 
        let MOBILE = "^1(3[0-9]|5[0-35-9]|7[016]|8[0-9])\\d{8}$"
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         12         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186
         17         */
        let CU = "^1(3[0-2]|5[256]|7[0-9]|8[56])\\d{8}$"
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189,181(增加)
         */
        let CT = "^1((33|53|8[019])[0-9]|349)\\d{7}$"
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@", PHS)
        if regextestmobile.evaluate(with: self)
            || regextestcm.evaluate(with: self)
            || regextestcu.evaluate(with: self)
            || regextestct.evaluate(with: self)
            || regextestPHS.evaluate(with: self){
            return true
        }else{
            return false
        }*/
    }
    //MARK:---------- 获取 IP 地址  前提是你需要在桥接头文件里加上 #include <ifaddrs.h>
    /*
    static func getIPAddress() -> String {
        var address = ""
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            for (var ptr = ifaddr; ptr != nil; ptr = ptr?.pointee.ifa_next) {
                let interface = ptr?.pointee
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    if let name = String(validatingUTF8: (interface?.ifa_name)!), name == "en0" {
                        
                        // Convert interface address to a human readable string:
                        var addr = interface?.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(&addr!, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
     */
    //MARK:---------- 生产一个UUID
    static func xz_UUID() {
        //1.产生随机数
        let randomNum = "\((arc4random() % 100000) + 999999)"
        //2.获取时间，精确到毫秒
        let time = Date.sp_ReturnDateFormat("YYYYMMddhhmmssSS")
        //3.拼接字符串
        let ihguuid = "\(time)\(randomNum)"
        print(ihguuid)
        SP_UserDefaultsSet(SP_UUID, obj: ihguuid)
        SP_UserDefaultsSyn()
        
    }
    
    //MARK:---------- 计算宽高
    func sp_Size(_ font:UIFont, size:CGSize) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var labelSize = self.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes:attributes,context: nil ).size
        labelSize.height = ceil(labelSize.height)
        labelSize.width = ceil(labelSize.width)
        return labelSize
    }
    
    
//    //MARK:---------- sha1 加密
//    func xz_SHA1() -> String {
//        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
//        var digest = [UInt8](repeating: 0,count: Int(CC_SHA1_DIGEST_LENGTH))
//        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
//        
//        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
//        for byte in digest{
//            output.appendFormat("%02x", byte)
//        }
//        return output as String
//    }
    
    //MARK:---------- 筛除富文本
//    func xz_RemoveRichText(_ regexString:String) -> String {
//        return LCDToolClass.xzRemoveString(with: self, withRegex: regexString)
//        
//    }
}
