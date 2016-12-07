//
//  Bool_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
extension Bool {
    enum LimitErrorType {
        case length
        case unlawful
    }
    //MARK:---------- 价格类
    static func xzLimitTextFieldForPrice(_ textField: UITextField,  range: NSRange,  string: String, stringLength:Int = 7, errorType:(LimitErrorType) ->Void ) -> Bool {
        print("-->\(string)")
        
        if Int(string) == nil && string != "." && string != ""{
            errorType(.unlawful)
            return false
        }
        // -1- 限制首字
        if textField.text == "" &&  string == "."{
            return false
        }
        // -2- 判断首字为 0 的情况， 再次输入不为 . 替换
        if textField.text == "0" &&  string != "."{
            textField.text = string
            return false
        }
        // -3- 排除 (0123456789.退格) 之外的字符
        let remin = 2
        let pointRange = textField.text?.range(of: ".")
        if ( pointRange != nil )
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9","":
                // -4- 限制只能保留到小数点后2位
                if string != "" {
                    let textRange = Range(pointRange!.lowerBound..<textField.text!.endIndex)
                    let subStr = textField.text!.substring(with: textRange)
                    
                    if subStr.characters.count > remin {
                        return false  // 超出小数后两位
                    }
                    // -5- 限制长度
                    if (range.location >= stringLength + 3) {
                        errorType(.length)
                        return false
                    }
                }
                return true
            default:
                errorType(.unlawful)
                return false // -- 输入非法字符
            }
        }
        else
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9",".","":
                // -5- 限制长度
                if (range.location >= stringLength) {
                    errorType(.length)
                    return false
                }
                
                return true
            default:
                errorType(.unlawful)
                return false  // -- 输入非法字符
            }
        }
    }
    //MARK:---------- 纯数字类
    static func xzLimitTextFieldForNumbers(_ textField: UITextField,  range: NSRange,  string: String, firstcanfor0:Bool = false, stringLength:Int = 7, errorType:(LimitErrorType) ->Void ) -> Bool {
        print("-->\(string)")
        print("-->\(Double(string))")
        // -1- 限制首字
        if Int(string) == nil && string != "" {
            errorType(.unlawful)
            return false
        }
        if textField.text == "" &&  string == "."{
            return false
        }
        // -2- 判断首字为 0 的情况， 再次输入不为 . 替换
        if !firstcanfor0 {
            if textField.text == "0" &&  string != "."{
                textField.text = string
                return false
            }
            if range.location == 0 && string == "0" && !textField.text!.isEmpty{
                return false
            }
        }
        // -2- 排除 (0123456789退格) 之外的字符
        switch string {
        case "0","1","2","3","4","5","6","7","8","9","":
            // -3- 限制长度
            if (range.location >= stringLength) {
                errorType(.length)
                return false
            }
            
            return true
        default:
            errorType(.unlawful)
            return false // -- 输入非法字符
        }
    }
    //MARK:---------- 纯字母类
    static func xzLimitTextFieldForABC(_ textField: UITextField,  range: NSRange,  string: String, stringLength:Int = 16, errorType:(LimitErrorType) ->Void ) -> Bool {
        print("-->\(string)")
        // -1- 排除 (abc--XYZ退格) 之外的字符
        switch string {
        case "","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            // -2- 限制长度
            if (range.location >= stringLength) {
                errorType(.length)
                return false
            }
            
            return true
        default:
            errorType(.unlawful)
            return false // -- 输入非法字符
        }
    }
}
