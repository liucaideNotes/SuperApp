//
//  SPNT_TabBarController.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import SVProgressHUD
class SPNT_TabBarController: UITabBarController {

    //Storyboard
    override class func initSPVC() -> SPNT_TabBarController {
        return UIStoryboard(name: "SP_Navigation_TabBar", bundle: nil).instantiateViewController(withIdentifier: "SPNT_TabBarController") as! SPNT_TabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        centerMenuButton22()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//MARK:--- 仿新浪微博tabbar
extension SPNT_TabBarController {
    func centerMenuButton22() {
        sp_hideLine()
        //顶部灰线 -- 需要隐藏自有分割线，因为自有分割线在最上层
        let lineView = UIView()
        lineView.backgroundColor = UIColor.main_line
        self.tabBar.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        let button = UIButton()
        self.tabBar.addSubview(button)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.8
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.tag = 0
        button.setImage(UIImage(named:"logo_0"), for: .normal)
        button.addTarget(self, action: #selector(SPNT_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        /*
        let button1 = UIButton()
        self.tabBar.addSubview(button1)
        button1.backgroundColor = UIColor.white
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderWidth = 0.8
        button1.layer.cornerRadius = 25
        button1.clipsToBounds = true
        button.tag = 1
        button1.setImage(UIImage(named:"logo_0"), for: .normal)
        button1.addTarget(self, action: #selector(SPNT_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button1.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }*/
        
        let button2 = UIButton()
        self.tabBar.addSubview(button2)
        button2.backgroundColor = UIColor.white
        button2.layer.borderColor = UIColor.white.cgColor
        button2.layer.borderWidth = 0.8
        button2.layer.cornerRadius = 25
        button2.clipsToBounds = true
        button2.tag = 2
        button2.setImage(UIImage(named:"logo_0"), for: .normal)
        button2.addTarget(self, action: #selector(SPNT_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button2.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
    }
    func centerMenuButtonClick1(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t两行两列, block: { tag in
                SVProgressHUD.show(withStatus: "点击了Tag = \(tag)")
                SVProgressHUD.dismiss(withDelay: 1.0)
            })
        case 1:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t两行三列, block: { tag in
                SVProgressHUD.show(withStatus: "点击了Tag = \(tag)")
                SVProgressHUD.dismiss(withDelay: 1.0)
            })
        case 2:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t三行三列, block: { tag in
                SVProgressHUD.show(withStatus: "点击了Tag = \(tag)")
                SVProgressHUD.dismiss(withDelay: 1.0)
            })
        default:
            break
        }
        
        
    }
}










