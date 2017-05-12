//
//  SP_NavigationView.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
let SP_NavigationViewLeftButtonImg = "navi_back_gray"
let SP_NavigationViewLeftButtonImg2 = "navi_back_gray"
class SP_NavigationView: UIView {
    
    class func show(_ pView:UIView) -> SP_NavigationView{
        for item in pView.subviews {
            if let subView = item as? SP_NavigationView {
                return subView
            }
        }
        let view = (Bundle.main.loadNibNamed("SP_NavigationView", owner: nil, options: nil)!.first as? SP_NavigationView)!
        pView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(64)
        }
        return view
    }
    
    

    @IBOutlet weak var n_view_Bg: UIView!
    @IBOutlet weak var n_view_Status: UIView!
    @IBOutlet weak var n_view_NaviBar: UIView!
    @IBOutlet weak var n_view_NaviLine: UIView!
    @IBOutlet weak var n_view_Act: UIActivityIndicatorView!
    
    
    @IBOutlet weak var n_btn_C1: UIButton!
    
    @IBOutlet weak var n_btn_L1: UIButton!
    @IBOutlet weak var n_btn_L2: UIButton!
    
    @IBOutlet weak var n_btn_R1: UIButton!
    @IBOutlet weak var n_btn_R2: UIButton!
    @IBOutlet weak var n_btn_R3: UIButton!
    
    @IBOutlet weak var n_btn_C1_H: NSLayoutConstraint!
    
    @IBOutlet weak var n_btn_L1_H: NSLayoutConstraint!
    @IBOutlet weak var n_btn_L1_W: NSLayoutConstraint!
    
    @IBOutlet weak var n_btn_L2_H: NSLayoutConstraint!
    @IBOutlet weak var n_btn_L2_W: NSLayoutConstraint!
    
    @IBOutlet weak var n_btn_R1_H: NSLayoutConstraint!
    @IBOutlet weak var n_btn_R1_W: NSLayoutConstraint!
    
    @IBOutlet weak var n_btn_R2_H: NSLayoutConstraint!
    @IBOutlet weak var n_btn_R2_W: NSLayoutConstraint!
    
    @IBOutlet weak var n_btn_R3_W: NSLayoutConstraint!
    @IBOutlet weak var n_btn_R3_H: NSLayoutConstraint!
    
    var _clickBlock:((Int)->Void)?
    //MARK:--- 点击事件
    @IBAction func click_NaviButton(_ sender: UIButton) {
        _clickBlock?(sender.tag)
    }
}
