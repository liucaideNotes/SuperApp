//
//  SP_MainVC.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class SP_MainVC: UIViewController {

    override class func initVC() -> SP_MainVC {
        return UIStoryboard(name: "SP_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_MainVC") as! SP_MainVC
    }
    
    //MARK:----------- 设置
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableVIew: UITableView!
    //MARK:----------- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //定位
        SP_LocationManager.shared.getLocation(self, coordinateType: .Baidu) { (isChange) in
            if isChange {
                print("位置变更")
            }
        }
        
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
        return mainDatas.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mainDatas[section]["titles"] as? [AnyObject] ?? [])!.count
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SP_SectionH_Min
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainDatas[section]["sectionName"] as? String ?? ""
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SP_MainVCCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
        cell.leftLabel.text = (mainDatas[indexPath.section]["titles"] as? [AnyObject])?[indexPath.row] as? String ?? "缺少值"
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type] ?? [])!.count else {
            return
        }
        guard let vc = (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type])?[indexPath.row].initVC() else {
            return
        }
        self.present(vc, animated: true, completion: nil)
        
        
//        if let vc = SP_classFromString(className: "SP_AdsVC")?.initVC() {
//            self.present(vc, animated: true, completion: nil)
//        }
        
        
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
