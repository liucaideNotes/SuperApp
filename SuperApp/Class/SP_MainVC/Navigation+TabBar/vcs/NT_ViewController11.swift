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
        
        n_view.sp_setBgAlpha(UIColor.blue,textColor: UIColor.black, offsetY: 0)
    }

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
        
        n_view.sp_setBgAlpha(UIColor.blue,textColor:UIColor.black, offsetY: scrollView.contentOffset.y)
        
    }
    
}
