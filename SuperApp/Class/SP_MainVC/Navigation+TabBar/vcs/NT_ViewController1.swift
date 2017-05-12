//
//  NT_ViewController1.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class NT_ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //_navigationView.backgroundColor = UIColor.main_1
        //self.navigationController?.isNavigationBarHidden = true
        //self.navigationController?.sp_SetNavigationBarLine(UIColor.white)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
//    override func clickn_btn_L1() {
//        //_naviBlock?(true)
//        self.dismiss(animated: true) { 
//            
//        }
//    }

    

}
