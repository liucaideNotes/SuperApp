//
//  UIButton_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit

extension UIButton {
    class func xzButtonFrame(_ frame:CGRect, text:String = "", image:String = "", bgImage:String = "", textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true , blod:Bool = false) -> UIButton {
        let button = UIButton()
        button.frame = frame
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        if blod {
            if xzFont {
                button.titleLabel!.font = UIFont.xzFontBold(font)
            }else{
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                button.titleLabel!.font = UIFont.xzFont(font)
            }else{
                button.titleLabel!.font = UIFont.systemFont(ofSize: font)
            }
        }
        if !image.isEmpty {
            button.setImage(UIImage(named: image), for: .normal)
        }
        if !bgImage.isEmpty {
            button.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        
        
        return button
    }
    class func xzButtonBounds(_ center:CGPoint, width:CGFloat, height:CGFloat, text:String = "", image:String = "", bgImage:String = "", textColor:UIColor = UIColor.maintext_pitchblack, font:CGFloat = 15.0, xzFont:Bool = true , blod:Bool = false) -> UIButton {
        let button = UIButton()
        button.center = center
        button.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        if blod {
            if xzFont {
                button.titleLabel!.font = UIFont.xzFontBold(font)
            }else{
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: font)
            }
        }else{
            if xzFont {
                button.titleLabel!.font = UIFont.xzFont(font)
            }else{
                button.titleLabel!.font = UIFont.systemFont(ofSize: font)
            }
        }
        if !image.isEmpty {
            button.setImage(UIImage(named: image), for: .normal)
        }
        if !bgImage.isEmpty {
            button.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        
        
        return button
    }
    
    //MARK:--- 秒表倒计时
    private static var countTime:(countTime:Int,time:Int,timer:Timer, label:UILabel, color:UIColor) = {
        let time = 0
        let countTime = 60
        let timer = Timer()
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        let color = UIColor.clear
        return (countTime,time,timer,label,color)
    }()
    func timeCountDown(_ countTime:Int) {
        UIButton.countTime.color = self.backgroundColor!
        UIButton.countTime.countTime = countTime
        UIButton.countTime.time = 0
        self.isEnabled = false
        self.isSelected = true
        self.tintColor = UIColor.clear
        self.backgroundColor = UIColor.gray
        UIButton.countTime.label.text = "\(countTime) 秒后重发"
        UIButton.countTime.label.font = self.titleLabel?.font
        self.addSubview(UIButton.countTime.label)
        UIButton.countTime.label.frame = self.bounds
        self.setTitle("", for: .normal)
        UIButton.countTime.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(UIButton.timerClosure(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(UIButton.countTime.timer, forMode: .commonModes)
    }
    @objc private func timerClosure(_ timer: Timer) {
        UIButton.countTime.time += 1
        if UIButton.countTime.time >= UIButton.countTime.countTime{
            UIButton.countTime.timer.invalidate()
            self.isEnabled = true
            self.isSelected = false
            self.backgroundColor = UIButton.countTime.color
            self.setTitle("发送验证码", for: .normal)
            UIButton.countTime.label.text = ""
        }
        else{
            UIButton.countTime.label.text = "\(UIButton.countTime.countTime - UIButton.countTime.time) 秒后重发"
            //self.setTitle("\(UIButton.countTime.countTime - UIButton.countTime.time) 秒后重发", for: .normal)
        }
    }
    
    
}
