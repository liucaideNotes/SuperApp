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
    
    
    @IBOutlet weak var rightTableVIew: UITableView!
    //MARK:----------- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //定位
        SP_LocationManager.shared.getLocation(self, coordinateType: .Baidu) { [weak self](isChange) in
            if isChange {
                print("位置变更")
            }
        }
        SP_LocationManager.shared.cityChangeBlock = { (province, city, subCity) in
            print("城市（省、市、区）变更")
        }
        
        addMJHeaderAndFooter()
        
        
//        rightTableVIew.mj_header = MJRefreshGifHeader(refreshingBlock: {
//            // 模拟延迟加载数据，2秒后才调用（真实开发中，可以移除这段gcd代码）
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
//                self.rightTableVIew.headerEndRefresh()
//            }
//            
//            
//        })
    }
    
    //MARK:----------- 上拉下拉刷新
    func addMJHeaderAndFooter() {
        rightTableVIew.headerAddMJRefreshGif { [unowned self]() -> Void in
            // 模拟延迟加载数据，5秒后调用
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                self.rightTableVIew.headerEndRefresh()
                self.rightTableVIew.footerResetNoMoreData()
            }
            
        }
        rightTableVIew.footerAddMJRefresh_Auto { [unowned self]() -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                self.rightTableVIew.footerEndRefreshNoMoreData()
            }
            
        }
    }
    func endRefresh()  {
        rightTableVIew.headerEndRefresh()
        rightTableVIew.footerEndRefresh()
    }
    func footerEndRefreshNoMoreData() {
        rightTableVIew.footerEndRefreshNoMoreData()
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
        if (mainDatas[indexPath.section]["titles"] as? [String] ?? [])!.count > indexPath.row {
            cell.leftLabel.text = (mainDatas[indexPath.section]["titles"] as? [String])![indexPath.row]
        }
        if (mainDatas[indexPath.section]["represent"] as? [String] ?? [])!.count > indexPath.row {
            cell.rightLabel.text = (mainDatas[indexPath.section]["represent"] as? [String])![indexPath.row]
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (mainDatas[indexPath.section]["titles"] as? [String])![indexPath.row] == "MJRefresh" {
            tableView.headerBeginRefresh()
        }
        
        
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
