//
//  NT_ViewController2.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class NT_ViewController11: SP_ParentVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fd_prefersNavigationBarHidden = true
        myTableView.delegate = self
        
        
        n_view.n_btn_L1_W.constant = 36
        n_view.n_btn_L1_H.constant = 36
        n_view.n_btn_L1_L.constant = 8
        n_view.n_btn_L1.layer.cornerRadius = 18
        n_view.n_btn_L1.clipsToBounds = true
        
        n_view.sp_setBgAlpha(UIColor.main_1,textColor: UIColor.white, offsetY: 0, maxOffsetY: 200, leftBackImg: sp_navigationViewLeftButtonImg2, leftBackImg2: sp_navigationViewLeftButtonImg2)
        
        
    }

    @IBOutlet weak var myTableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension NT_ViewController11:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NT_ViewControllerCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    //MARK:---------- ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        n_view.sp_setBgAlpha(UIColor.main_1,textColor:UIColor.white, offsetY: scrollView.contentOffset.y, maxOffsetY: 200, leftBackImg: sp_navigationViewLeftButtonImg2, leftBackImg2: sp_navigationViewLeftButtonImg2)
        
    }
    
}
