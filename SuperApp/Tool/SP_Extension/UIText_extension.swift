//
//  UITextField_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
//MARK:---- UITextField
extension UITextField {
    func showOkButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0,y: 0, width: SP_ScreenWidth,height: 40))
        toolBar.backgroundColor = UIColor.main_bg
        let button = UIButton(frame: CGRect(x: SP_ScreenWidth - 60,y: 0,width: 50,height: 40))
        button.setTitle("完成", for: UIControlState())
        button.setTitleColor(UIColor.main_1, for: UIControlState())
        button.addTarget(self, action: #selector(UITextField.resignFirstResponder), for: .touchUpInside)
        toolBar.addSubview(button)
        self.inputAccessoryView = toolBar
    }
    
    
}
//MARK:---- UITextView
extension UITextView {
    func showOkButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0,y: 0, width: SP_ScreenWidth,height: 40))
        toolBar.backgroundColor = UIColor.main_bg
        let button = UIButton(frame: CGRect(x: SP_ScreenWidth - 60,y: 0,width: 50,height: 40))
        button.setTitle("完成", for: UIControlState())
        button.setTitleColor(UIColor.main_1, for: UIControlState())
        button.addTarget(self, action: #selector(UITextView.resignFirstResponder), for: .touchUpInside)
        toolBar.addSubview(button)
        self.inputAccessoryView = toolBar
    }
    
    
}
