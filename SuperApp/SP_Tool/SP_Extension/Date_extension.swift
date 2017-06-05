//
//  NSDate_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
extension Date {
    //MARK:---------- 取得设备时间
    static func sp_ReturnDateFormat(_ format:String)-> String {
        let date = Date()
        var format2 = format;
        if format.isEmpty {
            format2 = "YYYY-MM-dd"
        }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format2
        let datestr = dateformatter.string(from: date)
        return datestr
    }
    //MARK:---------- 根据格式截取时间
    static func sp_ReturnDateFormat(_ date:String, format:String) -> String {
        let dateTime = Date(timeIntervalSince1970: Double(date)!)
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let formatterLocal = Locale.init(identifier: "en_us")
        formatter.locale = formatterLocal as Locale!
        formatter.dateFormat = format
        return formatter.string(from: dateTime)
    }
    //MARK:---- 时间戳转换成时间
    static func sp_timestampToDate(_ timestamp:Double) -> String {
        
        let dates:Date = Date(timeIntervalSince1970: timestamp)
        
        let time = Date.sp_setDateFormat(dates, formatter: "yyyy-MM-dd HH:mm")
        return time
    }
    //MARK:---- 取特定时间格式
    static func sp_setDateFormat(_ date:Date , formatter:String = "yyyy-MM-dd HH:mm:ss") ->String {
        let dateFormatter:DateFormatter = DateFormatter()
        //设定时间格式,这里可以设置成自己需要的格式
        dateFormatter.dateFormat = formatter
        let time = dateFormatter.string(from: date)
        return time
        
        
    }
    
    //MARK:--- 计算时间差
    static func sp_TimeInterval(frome:Double, to:Double) -> DateComponents {
        let date1 = "2017-03-04 18:00:00"
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateresult = dateformatter.date(from: date1)
        
        let gregorian = Calendar(identifier: .gregorian)
        let result = gregorian.dateComponents([Calendar.Component.minute], from: dateresult!, to: Date())
        return result
        //print_SP(result.minute ?? 0)
    }
    
    //MARK:---------- 计算时间
    func byNowDateString(_ time:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: time)
        if let _ = date{
            let nowDate = Date()
            var spceTime = date!.timeIntervalSince(nowDate)
            spceTime += 24 * 3600
            //let calendar = Calendar.current
            let gregorian = Calendar(identifier: .gregorian)
            let cmps = gregorian.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: nowDate, to: date!)
            
            
            //let cmps = (calendar as NSCalendar).components(unit, from: nowDate, to: date!, options: NSCalendar.Options.wrapComponents)
            if cmps.day! > 365 {
                return "一年之内不过期"
            }else{
                return "\(cmps.day)天\(cmps.hour)小时\(cmps.minute)分钟"
            }
        }
        return "已过期"
    }
    
}
