//
//  UITextField_LCD.swift
//  IEXBUY
//
//  Created by sifenzi on 16/8/17.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit

class UITextField_LCD: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 键盘完成按钮
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenSize().width, height: 30))
        toolBar.barStyle = UIBarStyle.default
        
        let btnFished = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        btnFished.setTitleColor(RGB(4, g: 170, b: 174), for: UIControlState())
        btnFished.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btnFished.setTitle("完成", for: UIControlState())
        btnFished.addTarget(self, action: #selector(UITextField_LCD.finishTapped(_:)), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btnFished)
        
        let space = UIView(frame: CGRect(x: 0, y: 0, width: screenSize().width - btnFished.frame.width - 30, height: 25))
        let item = UIBarButtonItem(customView: space)
        
        toolBar.setItems([item,item2], animated: true)
        
        self.inputAccessoryView = toolBar
    }
    
    func finishTapped(_ sender:UIButton){
        self.resignFirstResponder()
    }
    

}

func screenSize() -> CGSize{
    return UIScreen.main.bounds.size
}

func RGB (_ r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

