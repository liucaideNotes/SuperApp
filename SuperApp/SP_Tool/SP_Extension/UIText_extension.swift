//
//  UITextField_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation

enum UITextDelegateType {
    case tBegin
    case tChange
    case tEnd
    
}


//MARK:---- UITextField
extension UITextField {
    func showOkButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0,y: 0, width: SP_ScreenWidth,height: 25))
        toolBar.backgroundColor = UIColor.main_bg
        let button = UIButton(frame: CGRect(x: SP_ScreenWidth - 40,y: 0,width: 40,height: 25))
        button.setTitle("完成", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.main_1, for: .normal)
        button.addTarget(self, action: #selector(UITextField.resignFirstResponder), for: .touchUpInside)
        toolBar.addSubview(button)
        self.inputAccessoryView = toolBar
    }
    
    
}
//MARK:---- UITextView
extension UITextView {
    func showOkButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0,y: 0, width: SP_ScreenWidth,height: 25))
        toolBar.backgroundColor = UIColor.main_bg
        let button = UIButton(frame: CGRect(x: SP_ScreenWidth - 40,y: 0,width: 40,height: 25))
        button.setTitle("完成", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.main_1, for: .normal)
        button.addTarget(self, action: #selector(UITextView.resignFirstResponder), for: .touchUpInside)
        toolBar.addSubview(button)
        self.inputAccessoryView = toolBar
    }
}


extension UITextView:UITextViewDelegate {
    
    static var sendBlock:((_ type:UITextDelegateType)->Void)?
    public func textViewDidBeginEditing(_ textView: UITextView) {
        UITextView.sendBlock?(.tBegin)
    }
    public func textViewDidChange(_ textView: UITextView) {
        UITextView.sendBlock?(.tChange)
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        UITextView.sendBlock?(.tEnd)
    }
}
