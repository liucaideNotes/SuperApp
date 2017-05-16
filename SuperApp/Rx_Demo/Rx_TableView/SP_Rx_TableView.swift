//
//  SP_Rx_TableView.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/1/15.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class SP_Rx_TableView: SP_ParentVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fd_prefersNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var myTableView: UITableView!

    

}
