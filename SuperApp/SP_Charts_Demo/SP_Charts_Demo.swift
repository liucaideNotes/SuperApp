//
//  SP_Charts_Demo.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/6/1.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class SP_Charts_Demo: UITableViewController {

    //MARK:--- 初始化及生命周期 -----------------------------
    override class func initSPVC() -> SP_Charts_Demo {
        return UIStoryboard(name: "SP_Charts_Demo", bundle: nil).instantiateViewController(withIdentifier: "SP_Charts_Demo") as! SP_Charts_Demo
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sp_addMJHeaderAndFooter()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:--- 控件 变量 -----------------------------
    @IBOutlet weak var view_head: UIView!
    @IBOutlet weak var view_foot: UIView!

    //MARK:--- Table view data source -----------------------------
    func sp_addMJHeaderAndFooter() {
        tableView?.sp_headerAddMJRefreshGif { [weak self]_ in
            // 模拟延迟加载数据，5秒后调用
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {[weak self]_ in
                self?.tableView?.sp_headerEndRefresh()
                self?.tableView?.sp_footerResetNoMoreData()
            }
            
        }
        
        tableView?.sp_footerAddMJRefresh_Auto { [weak self]() -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                self?.tableView?.sp_footerEndRefreshNoMoreData()
            }
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_Charts_DemoCell_\(indexPath.row)", for: indexPath)

        return cell
    }
    

    

}
