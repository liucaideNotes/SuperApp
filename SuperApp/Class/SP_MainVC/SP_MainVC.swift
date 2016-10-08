//
//  SP_MainVC.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class SP_MainVC: UIViewController {

    class func initVC() -> SP_MainVC {
        return UIStoryboard(name: "SP_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_MainVC") as! SP_MainVC
    }
    
    
    //MARK:----------- 设置
    let sections_catalogs = ["基本写法","基本APP展示","网络层封装写法","Model","第三方库二次封装","通用独立模块"]
    
    let catalogTitles_0 = ["Navigation&TabBar","TableView","CollectionView","WebView","不借助第三方写约束"]
    let catalogTitles_1 = ["APP"]
    let catalogTitles_2 = ["写法1","写法2","写法3"]
    let catalogTitles_3 = ["写法1","写法2","写法3"]
    let catalogTitles_4 = ["写法1","写法2","写法3"]
    let catalogTitles_5 = ["广告轮播图","九宫格","城市选择器"]
    
    var sections:[[String]] {
        return [catalogTitles_0,catalogTitles_1,catalogTitles_2,catalogTitles_3,catalogTitles_4,catalogTitles_5]
    }
    
    //MARK:----------- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let sections = [catalogTitles_0,catalogTitles_1,catalogTitles_2,catalogTitles_3,catalogTitles_4,catalogTitles_5]

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
//MARK:----------- UITableViewDelegate
extension SP_MainVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections_catalogs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SP_SectionH_Min
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections_catalogs[section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SP_MainVCCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
        
        cell.leftLabel.text = sections[indexPath.section][indexPath.row]
        //cell.rightLabel.text = "\(indexPath.row)-\(indexPath.row)"
        return cell
    }
}
//MARK:----------- SP_MainVCCell
class SP_MainVCCell: UITableViewCell {
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> SP_MainVCCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_MainVCCell", for: indexPath) as! SP_MainVCCell
        return cell
    }
    
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


