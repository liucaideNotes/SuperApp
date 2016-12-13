//
//  SP_RxSwiftTableView.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/12.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class SP_RxSwiftTableView: SP_ParentVC_Drawer {

    override class func initSPVC() -> SP_RxSwiftTableView {
        return UIStoryboard(name: "SP_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_RxSwiftTableView") as! SP_RxSwiftTableView
    }
    
    class func push(_ parentVC:UIViewController?) {
        let vc = SP_RxSwiftTableView.initSPVC()
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    //MARK:--- 抽屉点击事件通知
    override func drawerReceptionValue(_ notification:NSNotification) {
        super.drawerReceptionValue(notification)
        let notifi = notification.object as? [String:Any]
        
        let tag = notifi?["tag"] as? Int ?? 0
        let index = notifi?["selectIndex"] as? Int ?? 0
        if index == 1 {
            SP_VipVC.push(self,tag:tag)
        }
        
    }

}
