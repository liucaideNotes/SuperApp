//
//  SP_LoginView.swift
//  Fortuna
//
//  Created by 刘才德 on 2017/6/6.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
enum SP_TextField_Type {
    case tBegin
    case tChange
    case tEnd
}
enum SP_TextField_Type_Error {
    case tError
    case tChange
    case tEnd
}

class SP_TextField: UIView {

    class func show(_ supView:UIView) -> SP_TextField {
        for item in supView.subviews {
            if let sub = item as? SP_TextField {
                return sub
            }
        }
        let view = (Bundle.main.loadNibNamed("SP_TextField", owner: nil, options: nil)!.first as? SP_TextField)!
        supView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        text_field.delegate = self
    }
    
    @IBOutlet weak var label_L: UILabel!
    @IBOutlet weak var label_R: UILabel!
    @IBOutlet weak var label_error: UILabel!
    
    @IBOutlet weak var button_L: UIButton!
    @IBOutlet weak var button_L_W: NSLayoutConstraint!
    
    @IBOutlet weak var text_field: UITextField!
    
    @IBOutlet weak var view_textBg: UIView!
    @IBOutlet weak var view_Line: UIView!
    
    var _block:((_ type:SP_TextField_Type, _ text:String)->Void)?
    @IBAction func begin(_ sender: UITextField) {
        _block?(.tBegin,sender.text!)
    }
    @IBAction func changed(_ sender: UITextField) {
        _block?(.tChange,sender.text!)
    }
    @IBAction func end(_ sender: UITextField) {
        _block?(.tEnd,sender.text!)
    }
    
}

extension SP_TextField:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
