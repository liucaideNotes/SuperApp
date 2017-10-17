//
//  SP_RichTextEditAddLinkView.swift
//  Fortuna
//
//  Created by LCD on 2017/9/4.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import IQKeyboardManager

class SP_RichTextEditAddLinkView: UIView {

    class func show(_ block:((_ link:String,_ title:String)->Void)? = nil) {
        let view = Bundle.main.loadNibNamed("SP_RichTextEditAddLinkView", owner: nil, options: nil)!.first as! SP_RichTextEditAddLinkView
        sp_MainWindow.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view._block = block
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        text_title.delegate = self
    }

    @IBOutlet weak var lab_error: UILabel!
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var text_link: UITextField!
    var _block:((_ link:String,_ title:String)->Void)?
    @IBAction func clickButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
            IQKeyboardManager.shared().isEnabled = true
            IQKeyboardManager.shared().isEnableAutoToolbar = true
            self.removeFromSuperview()
        }else{
            if text_link.text!.hasPrefix("http://") || text_link.text!.hasPrefix("https://") {
                
                IQKeyboardManager.shared().isEnabled = true
                IQKeyboardManager.shared().isEnableAutoToolbar = true
                _block?(text_link.text!, text_title.text!.isEmpty ? "网页链接" : text_title.text!)
                self.removeFromSuperview()
            }else{
                lab_error.text = sp_localized("*请输入正确的网址")
            }
        }
    }
    
    @IBAction func textBegin(_ sender: UITextField) {
        lab_error.text = ""
    }
    
}

extension SP_RichTextEditAddLinkView:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == text_title {
            if (range.location >= 30 || range.location + string.characters.count > 30) {
                return false
            }else{
                return true
            }
        }
        return true
    }
}
