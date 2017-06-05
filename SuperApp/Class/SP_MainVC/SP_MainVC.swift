//
//  SP_MainVC.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit
import SwiftyJSON
class SP_MainVC: SP_ParentVC_Drawer {

    //MARK:----------- 生命周期
    override class func initSPVC() -> SP_MainVC {
        return UIStoryboard(name: "SP_MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_MainVC") as! SP_MainVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SP_Info.sp_print()
        
        //网络判断
        Reachability.netRemindForNone(self)
        Reachability.netWorkType { (type) in
            print(type)
        }
        
        //定位
        SP_LocationManager.shared.getLocation(self, coordinateType: .Baidu) { (isChange) in
            if isChange {
                print("位置变更")
            }
        }
        SP_LocationManager.shared.cityChangeBlock = { (province, city, subCity) in
            print("城市（省、市、区）变更")
        }
        
        sp_addMJHeaderAndFooter()
        
        
        
        
//        rightTableVIew.mj_header = MJRefreshGiSPeader(refreshingBlock: {
//            // 模拟延迟加载数据，2秒后才调用（真实开发中，可以移除这段gcd代码）
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
//                self.rightTableVIew.headerEndRefresh()
//            }
//            
//            
//        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:--- 抽屉点击事件通知
    override func drawerReceptionValue(_ notification:NSNotification) {
        super.drawerReceptionValue(notification)
        let notifi = notification.object as? [String:Any]
        
        let tag = notifi?["tag"] as? Int ?? 0
        let index = notifi?["selectIndex"] as? Int ?? 0
        if index == 0 {
            SP_VipVC.push(self,tag:tag)
        }
        
    }
    
    
    
    
    @IBOutlet weak var rightTableVIew: UITableView!
    
    
    
    lazy var _mainDatas:JSON = {
        return JSON(mainDatas)
    }()

}
//MARK:----------- UITableViewDelegate
extension SP_MainVC: UITableViewDelegate,UITableViewDataSource {
    //MARK:----------- 上拉下拉刷新
    func sp_addMJHeaderAndFooter() {
        rightTableVIew.sp_headerAddMJRefreshGif { [weak self]_ in
            // 模拟延迟加载数据，5秒后调用
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {[weak self]_ in
                self?.rightTableVIew.sp_headerEndRefresh()
                self?.rightTableVIew.sp_footerResetNoMoreData()
            }
            
        }
        
        rightTableVIew.sp_footerAddMJRefresh_Auto { [weak self]() -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                self?.rightTableVIew.sp_footerEndRefreshNoMoreData()
            }
        }
        
    }
    func sp_AddMJFooter(_ error:String = MJRefreshDIY_Title_NoMoreData_Up, endRefresh:Bool = false) {
        
            if endRefresh {
                self.sp_footerEndRefreshNoMoreData()
            }
        
    }
    func sp_endRefresh()  {
        rightTableVIew.sp_headerEndRefresh()
        rightTableVIew.sp_footerEndRefresh()
    }
    func sp_footerEndRefreshNoMoreData() {
        rightTableVIew.sp_footerEndRefreshNoMoreData()
    }
    
    //MARK:--- DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainDatas.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mainDatas[section]["rows"] as? [AnyObject] ?? [])!.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainDatas[section]["section"] as? String ?? ""
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_MainVCCell", for: indexPath)
        
        
        
        let title = _mainDatas[indexPath.section]["rows"][indexPath.row]["title"].stringValue
        let subtitle = _mainDatas[indexPath.section]["rows"][indexPath.row]["subtitle"].stringValue
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let className = _mainDatas[indexPath.section]["rows"][indexPath.row]["class"].stringValue
        guard !className.isEmpty else {
            return
        }
        switch className {
        case "MJRefresh":
            tableView.sp_headerBeginRefresh()
        case "SPNT_TabBarController":
            let vc = SPNT_TabBarController.initSPVC()
            self.present(vc, animated: true, completion: nil)
        default:
            
            if let vc = SP_classFromString(className)?.initSPVC() {
                self.navigationController?.show(vc, sender: nil)
            }
        }
        
        
        /*
        guard indexPath.row < (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type] ?? [])!.count else {
            return
        }
        guard let vc = (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type])?[indexPath.row].initSPVC() else {
            return
        }*/
        //ios 8 之后可使用这个
        //self.navigationController?.show(vc, sender: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        
        
//        if let vc = SP_classFromString(className: "SP_AdsVC")?.initVC() {
//            self.present(vc, animated: true, completion: nil)
//        }
        
        
    }
    
}


