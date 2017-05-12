//
//  SP_VipVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/13.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class SP_VipVC: SP_ParentVC {

    class func push(_ parentVC:UIViewController?, tag:Int) {
        let vc = SP_VipVC()
        vc._tag = tag
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    var _tag = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self._title = "会员特权\(_tag)"
        self.view.backgroundColor = UIColor.red
    }

    deinit {
        print("销毁")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
