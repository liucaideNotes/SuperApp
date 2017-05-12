//
//  SPNT_TabBarController.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class SPNT_TabBarController: UITabBarController {

    //Storyboard
    override class func initSPVC() -> SPNT_TabBarController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SPNT_TabBarController") as! SPNT_TabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
    

}
