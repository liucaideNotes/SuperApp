//
//  NT_ViewController14.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/20.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class NT_ViewController14: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return UITableViewCell()
    }
    

    //MARK:---------- ScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动时修改NavigationBar的透明度
        // NavigationBar的颜色
        // 当前的Y轴偏移量offsetY
        // 最大偏移量，当滚动到这个位置时，NavigationBar完全显示
        // 向下滚动为负
        
        //self.navigationController?.sp_changeColor(offsetY: scrollView.contentOffset.y, maxOffsetY: 100, bgColor:UIColor.main_1)
        
        
    }

}
