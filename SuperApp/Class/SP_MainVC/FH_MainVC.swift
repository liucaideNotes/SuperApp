//
//  FH_MainVC.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class FH_MainVC: UIViewController {

    override class func initVC() -> FH_MainVC {
        return UIStoryboard(name: "FH_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FH_MainVC") as! FH_MainVC
    }
    
    //MARK:----------- 设置
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    @IBOutlet weak var rightTableVIew: UITableView!
    //MARK:----------- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //网络判断
        Reachability.netRemindForNone(self)
        Reachability.netWorkType { [weak self](type) in
            print(type)
        }
        
        //定位
        FH_LocationManager.shared.getLocation(self, coordinateType: .Baidu) { [weak self](isChange) in
            if isChange {
                print("位置变更")
            }
        }
        FH_LocationManager.shared.cityChangeBlock = { (province, city, subCity) in
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
extension FH_MainVC: UITableViewDelegate,UITableViewDataSource {
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
        return FH_SectionH_Min
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainDatas[section]["sectionName"] as? String ?? ""
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FH_MainVCCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
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
        
        
//        if let vc = FH_classFromString(className: "FH_AdsVC")?.initVC() {
//            self.present(vc, animated: true, completion: nil)
//        }
        
        
    }
    
}
//MARK:----------- FH_MainVCCell
class FH_MainVCCell: UITableViewCell {
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> FH_MainVCCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FH_MainVCCell", for: indexPath) as! FH_MainVCCell
        return cell
    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
