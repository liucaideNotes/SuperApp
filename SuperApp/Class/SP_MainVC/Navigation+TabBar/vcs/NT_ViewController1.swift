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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBOutlet weak var myTableView: UITableView!
    
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
}

extension NT_ViewController1:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(format: "NT_ViewController1Cell%d", indexPath.row), for: indexPath)
        return cell
    }
    
    //MARK:---------- ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动时修改NavigationBar的透明度
        // NavigationBar的颜色
        // 当前的Y轴偏移量offsetY
        // 最大偏移量，当滚动到这个位置时，NavigationBar完全显示
        // 向下滚动为负
        
        //self.navigationController?.sp_changeColor(offsetY: scrollView.contentOffset.y, maxOffsetY: 100, bgColor:UIColor.main_1)
        
        
    }

}
