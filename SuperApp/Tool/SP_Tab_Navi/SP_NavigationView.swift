//
//  SPswift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
let sp_navigationViewLeftButtonImg = "navi_back_gray"
let sp_navigationViewLeftButtonImg2 = "navi_back_gray"

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
    
    

    
    @IBOutlet weak var n_view_Status: UIView!
    @IBOutlet weak var n_view_NaviBar: UIView!
    @IBOutlet weak var n_view_NaviLine: UIView!
    @IBOutlet weak var n_view_Act: UIActivityIndicatorView!
    
    @IBOutlet weak var n_img_Bg: UIImageView!
    @IBOutlet weak var n_img_NaviBar: UIImageView!
    
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
    
    @IBOutlet weak var n_viewStatus_T: NSLayoutConstraint!
    
    
    var _clickBlock:((Int)->Void)?
    //MARK:--- 点击事件
    @IBAction func click_NaviButton(_ sender: UIButton) {
        _clickBlock?(sender.tag)
        
    }
    
    
    //MARK:--- 基本配置 -----------------------------
    open var n_btn_L1_Image:String = sp_navigationViewLeftButtonImg {
        didSet{
            if n_btn_L1_Image.isEmpty {
                n_btn_L1_W.constant = 0
            }else {
                n_btn_L1.setImage(UIImage(named: n_btn_L1_Image), for: .normal)
                
            }
            
            
        }
    }
    open var n_btn_L1_Text = "" {
        didSet{
            if n_btn_L1_Text.isEmpty {
                n_btn_L1_W.constant = 0
            }else {
                n_btn_L1.setTitle(n_btn_L1_Text, for: .normal)
            }
            
            
        }
    }
    open var n_btn_L2_Image:String = "" {
        didSet{
            if n_btn_L2_Image.isEmpty {
                n_btn_L2_W.constant = 0
            }else {
                n_btn_L2.setImage(UIImage(named: n_btn_L2_Image), for: .normal)
            }
            
            
        }
    }
    open var n_btn_L2_Text = "" {
        didSet{
            if n_btn_L2_Text.isEmpty {
                n_btn_L2_W.constant = 0
            }else {
                n_btn_L2.setTitle(n_btn_L2_Text, for: .normal)
            }
            
            
        }
    }
    
    open var n_btn_R1_Image:String = "" {
        didSet{
            if n_btn_R1_Image.isEmpty {
                n_btn_R1_W.constant = 0
            }else {
                n_btn_R1.setImage(UIImage(named: n_btn_R1_Image), for: .normal)
            }
        }
    }
    open var n_btn_R1_Text = "" {
        didSet{
            if n_btn_R1_Text.isEmpty {
                n_btn_R1_W.constant = 0
            }else {
                n_btn_R1.setTitle(n_btn_R1_Text, for: .normal)
            }
        }
    }
    
    open var n_btn_R2_Image:String = "" {
        didSet{
            if n_btn_R2_Image.isEmpty {
                n_btn_R2_W.constant = 0
            }else {
                n_btn_R2.setImage(UIImage(named: n_btn_R2_Image), for: .normal)
            }
        }
    }
    open var n_btn_R2_Text = "" {
        didSet{
            if n_btn_R2_Text.isEmpty {
                n_btn_R2_W.constant = 0
            }else {
                n_btn_R2.setTitle(n_btn_R2_Text, for: .normal)
            }
        }
    }
    
    open var n_btn_R3_Image:String = "" {
        didSet{
            if n_btn_R3_Image.isEmpty {
                n_btn_R3_W.constant = 0
            }else {
                n_btn_R3.setImage(UIImage(named: n_btn_R3_Image), for: .normal)
            }
        }
    }
    open var n_btn_R3_Text = "" {
        didSet{
            if n_btn_R3_Text.isEmpty {
                n_btn_R3_W.constant = 0
            }else {
                n_btn_R3.setTitle(n_btn_R3_Text, for: .normal)
            }
        }
    }
    
    open var _logoImage:String = "" {
        didSet{
            if !_logoImage.isEmpty {
                n_btn_C1.setImage(UIImage(named: _logoImage), for: .normal)
            }
        }
    }
    open var _title = "" {
        didSet{
            if !_title.isEmpty {
                n_btn_C1.setTitle(_title, for: .normal)
            }
        }
    }
    open var _titleColor:UIColor = UIColor.sp_ParentTintColor {
        didSet{
            n_btn_C1.setTitleColor(_titleColor, for: .normal)
            
        }
    }
    open var n_view_ActShow:Bool = false {
        didSet{
            if !n_view_ActShow {
                n_view_Act.startAnimating()
                n_view_Act.isHidden = !n_view_ActShow
            }else{
                n_view_Act.stopAnimating()
                n_view_Act.isHidden = !n_view_ActShow
            }
        }
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

extension SP_NavigationView {
    
    
    
    func sp_setClearColor(_ titleClear:Bool = true, leftBackImg:String = sp_navigationViewLeftButtonImg2) {
        backgroundColor = UIColor.clear
        n_view_NaviLine.backgroundColor = UIColor.clear
        n_view_Status.backgroundColor = UIColor.clear
        n_view_NaviBar.backgroundColor = UIColor.clear
        
        if titleClear {
            _titleColor = UIColor.clear
        }
        //n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        //n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        n_btn_L1.setImage(UIImage(named: leftBackImg), for: .normal)
    }
    
    func sp_setBgAlpha(_ bgColor: UIColor,textColor: UIColor = UIColor.sp_ParentTintColor, offsetY: CGFloat, maxOffsetY: CGFloat = 150.0, leftBackImg:String = sp_navigationViewLeftButtonImg, leftBackImg2:String = sp_navigationViewLeftButtonImg2, naviLineHidden:Bool = false) {
        
        if offsetY > 0 {
            let alpha = 1 - ((maxOffsetY - offsetY) / maxOffsetY)
            
            backgroundColor = bgColor.withAlphaComponent(alpha)
            if !naviLineHidden {
                n_view_NaviLine.backgroundColor = UIColor.main_line.withAlphaComponent(alpha)
            }
            
            _titleColor = textColor.withAlphaComponent(alpha)
            
            //self.n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4-alpha)
            //self.n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4-alpha)
            if alpha >= 0.5 {
                n_btn_L1.setImage(UIImage(named: leftBackImg), for: UIControlState())
            }else{
                n_btn_L1.setImage(UIImage(named: leftBackImg2), for: UIControlState())
            }
            
        } else {
            backgroundColor = bgColor.withAlphaComponent(0)
            if !naviLineHidden {
                n_view_NaviLine.backgroundColor = UIColor.main_line.withAlphaComponent(0)
            }
            
            _titleColor = textColor.withAlphaComponent(0)
            //n_btn_L1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
            //n_btn_R1.backgroundColor = UIColor.sp_ParentMainColor.withAlphaComponent(0.4)
        }
    }
    
}



