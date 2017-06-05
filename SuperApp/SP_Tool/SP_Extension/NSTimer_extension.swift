//
//  NSTimer_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
typealias TimerExcuteClosure = @convention(block)()->Void
extension Timer{
    public class func LCD_scheduledTimerWithTimeInterval(_ ti:TimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer{
        return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, to: AnyObject.self), repeats: yesOrNo)
        
    }
    
    class func excuteTimerClosure(_ timer: Timer)
    {
        let closure = unsafeBitCast(timer.userInfo, to: TimerExcuteClosure.self)
        closure()
    }
}
