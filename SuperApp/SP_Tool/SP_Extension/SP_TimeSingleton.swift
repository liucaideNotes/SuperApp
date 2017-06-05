//
//  SP_TimeSingleton.swift
//  carpark
//
//  Created by 刘才德 on 2016/12/22.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

class SP_TimeSingleton {
    fileprivate static let sharedInstance = SP_TimeSingleton()
    fileprivate init() {}
    //提供静态访问方法
    open static var shared: SP_TimeSingleton {
        return self.sharedInstance
    }
    
    
    //MARK:--- 秒表倒计时
    fileprivate lazy var _timer:Timer? = {
        let tim = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(SP_TimeSingleton.timerClosure(_:)), userInfo: nil, repeats: true)
        return tim
    }()
    fileprivate lazy var _countTime:Int = {
        let time = 60
        return time
    }()
    fileprivate lazy var _time:Int = {
        let time = 0
        return time
    }()
    fileprivate lazy var _label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    fileprivate lazy var _color:UIColor = {
        let color = UIColor.clear
        return color
    }()
    weak var _button:UIButton?
    
    
    
    
    func starCountDown(_ button:UIButton, countTime:Int, color:(normal:UIColor,select:UIColor)) {
        _button = button
        _color = color.normal
        _label.textColor = color.select
        _countTime = countTime
        _time = 0
        button.isEnabled = false
        button.isSelected = true
        button.tintColor = UIColor.clear
        button.backgroundColor = _color
        _label.text = "\(countTime) 秒后重发"
        _label.font = button.titleLabel?.font
        button.addSubview(_label)
        _label.frame = button.bounds
        button.setTitle("", for: .normal)
        RunLoop.current.add(_timer!, forMode: .commonModes)
    }
    @objc private func timerClosure(_ timer: Timer) {
        _time += 1
        if _time >= _countTime{
            _timer?.invalidate()
            //_timer = nil
            _button?.isEnabled = true
            _button?.isSelected = false
            _button?.backgroundColor = _color
            _button?.setTitle("发送验证码", for: .normal)
            _label.text = ""
        }
        else{
            _label.text = "\(_countTime - _time) 秒后重发"
            //self.setTitle("\(_countTime - _time) 秒后重发", for: .normal)
        }
    }
    
    
}
