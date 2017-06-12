//
//  SP_TabBarControllerExtension.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/12.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation
/**
 * 自定义按钮
 *
 */
extension UITabBarController {
    //MARK:--- 中间 + 按钮
    func sp_centerMenuButton() {
        sp_hideLine()
        //顶部灰线 -- 需要隐藏自有分割线，因为自有分割线在最上层
        let lineView = UIView()
        lineView.backgroundColor = UIColor.main_line
        self.tabBar.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
        }
        //中间button
        let button = UIButton()
        self.tabBar.addSubview(button)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.8
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setImage(UIImage(named:"logo_0"), for: .normal)
        button.addTarget(self, action: #selector(UITabBarController.sp_centerMenuButtonClick(_:)), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
    }
    func sp_centerMenuButtonClick(_ sender:UIButton) {
        let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
        let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
        SP_TabMenuView.show((images,titles) ,type:.t两行三列, block: { tag in
            
        })
        
    }
    
    //MARK:--- 去掉tabBar顶部线条
    func sp_hideLine() {
        //去掉tabBar顶部线条
        let rect = CGRect(x: 0, y: 0, width: sp_ScreenWidth, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.clear.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.backgroundImage = image
        self.tabBar.shadowImage = image
    }
}






