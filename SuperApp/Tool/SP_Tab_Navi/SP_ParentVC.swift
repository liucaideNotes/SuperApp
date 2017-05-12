//
//  SP_ParentVC.swift
//  carpark
//
//  Created by 刘才德 on 2017/4/17.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

fileprivate let leftButtonImg = "navi_back_gray"
fileprivate let leftButtonImg2 = "navi_back_gray"

class SP_ParentVC: UIViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sp_makeNaviDefault()
        _navigationView._clickBlock = { [unowned self]tag in
            switch tag {
            case 0:
                self.clickn_btn_L1()
            case 1:
                self.clickn_btn_L2()
            case 2:
                self.clickn_btn_C1()
            case 3:
                self.clickn_btn_R3()
            case 4:
                self.clickn_btn_R2()
            case 5:
                self.clickn_btn_R2()
            default:
                break
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.bringSubview(toFront: _navigationView)
        
        
    }
    
    
    
    lazy var _navigationView:SP_NavigationView = {
        let navigationView = SP_NavigationView.show(self.view)
        return navigationView
    }()
    
    open var n_btn_L1_Image:String = leftButtonImg {
        didSet{
            if n_btn_L1_Image.isEmpty {
                _navigationView.n_btn_L1_W.constant = 0
            }else {
                _navigationView.n_btn_L1.setImage(UIImage(named: n_btn_L1_Image), for: .normal)
                _navigationView.n_btn_L1_W.constant = 44
            }
            
            
        }
    }
    open var n_btn_L1_Text = "" {
        didSet{
            if n_btn_L1_Text.isEmpty {
                _navigationView.n_btn_L1_W.constant = 0
            }else {
                _navigationView.n_btn_L1.setTitle(n_btn_L1_Text, for: .normal)
            }
            
            
        }
    }
    open var n_btn_L2_Image:String = "" {
        didSet{
            if n_btn_L2_Image.isEmpty {
                _navigationView.n_btn_L2_W.constant = 0
            }else {
                _navigationView.n_btn_L2.setImage(UIImage(named: n_btn_L2_Image), for: .normal)
            }
            
            
        }
    }
    open var n_btn_L2_Text = "" {
        didSet{
            if n_btn_L2_Text.isEmpty {
                _navigationView.n_btn_L2_W.constant = 0
            }else {
                _navigationView.n_btn_L2.setTitle(n_btn_L2_Text, for: .normal)
            }
            
            
        }
    }
    
    open var n_btn_R1_Image:String = "" {
        didSet{
            if n_btn_R1_Image.isEmpty {
                _navigationView.n_btn_R1_W.constant = 0
            }else {
                _navigationView.n_btn_R1.setImage(UIImage(named: n_btn_R1_Image), for: .normal)
            }
        }
    }
    open var n_btn_R1_Text = "" {
        didSet{
            if n_btn_R1_Text.isEmpty {
                _navigationView.n_btn_R1_W.constant = 0
            }else {
                _navigationView.n_btn_R1.setTitle(n_btn_R1_Text, for: .normal)
            }
        }
    }
    
    open var n_btn_R2_Image:String = "" {
        didSet{
            if n_btn_R2_Image.isEmpty {
                _navigationView.n_btn_R2_W.constant = 0
            }else {
                _navigationView.n_btn_R2.setImage(UIImage(named: n_btn_R2_Image), for: .normal)
            }
        }
    }
    open var n_btn_R2_Text = "" {
        didSet{
            if n_btn_R2_Text.isEmpty {
                _navigationView.n_btn_R2_W.constant = 0
            }else {
                _navigationView.n_btn_R2.setTitle(n_btn_R2_Text, for: .normal)
            }
        }
    }
    
    open var n_btn_R3_Image:String = "" {
        didSet{
            if n_btn_R3_Image.isEmpty {
                _navigationView.n_btn_R3_W.constant = 0
            }else {
                _navigationView.n_btn_R3.setImage(UIImage(named: n_btn_R3_Image), for: .normal)
            }
        }
    }
    open var n_btn_R3_Text = "" {
        didSet{
            if n_btn_R3_Text.isEmpty {
                _navigationView.n_btn_R3_W.constant = 0
            }else {
                _navigationView.n_btn_R3.setTitle(n_btn_R3_Text, for: .normal)
            }
        }
    }
    
    open var _logoImage:String = "" {
        didSet{
            if !_logoImage.isEmpty {
                _navigationView.n_btn_C1.setImage(UIImage(named: _logoImage), for: .normal)
            }
        }
    }
    open var _title = "" {
        didSet{
            if !_title.isEmpty {
                _navigationView.n_btn_C1.setTitle(_title, for: .normal)
            }
        }
    }
    open var _titleColor:UIColor = UIColor.sp_ParentTintColor {
        didSet{
            _navigationView.n_btn_C1.setTitleColor(_titleColor, for: .normal)
            
        }
    }
    open var n_view_ActShow:Bool = false {
        didSet{
            if !n_view_ActShow {
                _navigationView.n_view_Act.startAnimating()
                _navigationView.n_view_Act.isHidden = !n_view_ActShow
            }else{
                _navigationView.n_view_Act.stopAnimating()
                _navigationView.n_view_Act.isHidden = !n_view_ActShow
            }
        }
    }
    
    
    //MARK:--- 设置各按钮默认值 -----------------------------
    open func sp_makeNaviDefault() {
        _title = self.title ?? ""
        _logoImage = ""
        n_btn_L1_Text = ""
        n_btn_L2_Text = ""
        n_btn_R1_Text = ""
        n_btn_R2_Text = ""
        n_btn_R3_Text = ""
        
        n_btn_L1_Image = leftButtonImg
        n_btn_L2_Image = ""
        n_btn_R1_Image = ""
        n_btn_R2_Image = ""
        n_btn_R3_Image = ""
        n_view_ActShow = false
    }
    
}

extension SP_ParentVC {
    //MARK:--- 响应事件
    open func clickn_btn_L1()  {
        if (navigationController?.popViewController(animated: true)) != nil {
            print("点击Button_L1返回")
        }else{
            print("点击Button_L1")
        }
    }
    
    open func clickn_btn_L2()  {
        print("点击Button_L2")
    }
    open func clickn_btn_R1()  {
        print("点击Button_R1")
    }
    open func clickn_btn_R2()  {
        print("点击Button_R2")
    }
    open func clickn_btn_R3()  {
        print("点击Button_R3")
    }
    open func clickn_btn_C1()  {
        print("点击Button_C1")
    }

}


//MARK:---------- UIColor
extension UIColor {
    open class var sp_ParentTintColor: UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1)
    }
    open class var sp_ParentMainColor: UIColor {
        return UIColor.main_1
    }
}
//MARK:---------- SP_ParentVC

extension SP_ParentVC {
    
    func xz_setClearColor(_ titleClear:Bool = true, leftBackImg:String = leftButtonImg2) {
        _navigationView.backgroundColor = UIColor.clear
        _navigationView.n_view_NaviLine.backgroundColor = UIColor.clear
        _navigationView.n_view_Status.backgroundColor = UIColor.clear
        _navigationView.n_view_NaviBar.backgroundColor = UIColor.clear
        
        if titleClear {
            _titleColor = UIColor.clear
        }
        //n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        //n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        _navigationView.n_btn_L1.setImage(UIImage(named: leftBackImg), for: .normal)
    }
    func xz_setBackgroundColor(_ bgColor: UIColor,textColor: UIColor = UIColor.sp_ParentTintColor, offsetY: CGFloat, maxOffsetY: CGFloat = 150.0, leftBackImg:String = leftButtonImg, leftBackImg2:String = leftButtonImg2, naviLineHidden:Bool = false) {
        
        if offsetY > 0 {
            let alpha = 1 - ((maxOffsetY - offsetY) / maxOffsetY)
            
            _navigationView.backgroundColor = bgColor.withAlphaComponent(alpha)
            if !naviLineHidden {
                _navigationView.n_view_NaviLine.backgroundColor = UIColor.main_line.withAlphaComponent(alpha)
            }
            
            _titleColor = textColor.withAlphaComponent(alpha)
            
            //self.n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4-alpha)
            //self.n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4-alpha)
            if alpha >= 0.5 {
                _navigationView.n_btn_L1.setImage(UIImage(named: leftBackImg), for: UIControlState())
            }else{
                _navigationView.n_btn_L1.setImage(UIImage(named: leftBackImg2), for: UIControlState())
            }
            
        } else {
            _navigationView.backgroundColor = bgColor.withAlphaComponent(0)
            if !naviLineHidden {
                _navigationView.n_view_NaviLine.backgroundColor = UIColor.main_line.withAlphaComponent(0)
            }
            
            _titleColor = textColor.withAlphaComponent(0)
            //n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
            //n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        }
    }
    
}



