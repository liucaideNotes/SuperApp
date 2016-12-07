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
    static func xzReturnDateFormat(_ format:String)-> String {
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
    static func xzReturnDateFormat(_ date:String, format:String) -> String {
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
    static func xz_timestampToDate(_ timestamp:Double) -> String {
        
        let dates:Date = Date(timeIntervalSince1970: timestamp)
        
        let time = Date.xz_setDateFormat(dates, formatter: "yyyy-MM-dd HH:mm")
        return time
    }
    //MARK:---- 取特定时间格式
    static func xz_setDateFormat(_ date:Date , formatter:String = "yyyy-MM-dd HH:mm:ss") ->String {
        let dateFormatter:DateFormatter = DateFormatter()
        //设定时间格式,这里可以设置成自己需要的格式
        dateFormatter.dateFormat = formatter
        let time = dateFormatter.string(from: date)
        return time
        
        
    }
    
    
}
