//
//  SP_MainVC.swift
//  SuperApp
//
//  Created by LCD-sifenzi on 2016/10/8.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class SP_MainVC: SP_ParentVC_Drawer {

    //MARK:----------- 生命周期
    override class func initSPVC() -> SP_MainVC {
        return UIStoryboard(name: "SP_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_MainVC") as! SP_MainVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //网络判断
        Reachability.netRemindForNone(self)
        Reachability.netWorkType { [weak self](type) in
            print(type)
        }
        
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
    

    
    

}
//MARK:----------- UITableViewDelegate
extension SP_MainVC: UITableViewDelegate,UITableViewDataSource {
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
    
    //MARK:--- DataSource
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
        
        switch (mainDatas[indexPath.section]["titles"] as? [String])![indexPath.row] {
        case "MJRefresh":
            tableView.headerBeginRefresh()
        case "Navigation&TabBar":
            let viewControllers = [SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC()]
            let titles = ["1","2","","4","5"]
            let images = ["30x30","30x30","","30x30","30x30"]
            let selectedImages = ["30x30","30x30","","30x30","30x30"]
            let vc = SPNT_TabBarController.initSPVC()
            
//                .initTabbar(viewControllers, titles: titles, images: images, selectedImages: selectedImages, selectedIndex: 0)
//            vc.setProperty(false, colorNormal: UIColor.maintext_darkgray, colorSelected: UIColor.main_1, titleFontNormal: 12.0, titleFontSelected: 12.0, imageInsets: UIEdgeInsetsMake(0, 0, 0, 0))
//            vc.centerMenuButton()
            self.present(vc, animated: true, completion: nil)
        case "仿新浪微博TabBar":
            let viewControllers = [SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC()]
            let titles = ["1","2","","4","5"]
            let images = ["30x30","30x30","","30x30","30x30"]
            let selectedImages = ["30x30","30x30","","30x30","30x30"]
            let vc = SP_TabBarController.initTabbar(viewControllers, titles: titles, images: images, selectedImages: selectedImages, selectedIndex: 0)
            vc.setProperty(true, colorNormal: UIColor.maintext_darkgray, colorSelected: UIColor.main_1, titleFontNormal: 12.0, titleFontSelected: 12.0, imageInsets: UIEdgeInsetsMake(0, 0, 0, 0))
            vc.centerMenuButton22()
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
        
        
        
        guard indexPath.row < (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type] ?? [])!.count else {
            return
        }
        guard let vc = (mainDatas[indexPath.section]["classes"] as? [UIViewController.Type])?[indexPath.row].initSPVC() else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        
        
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

//MARK:--- 仿新浪微博tabbar
extension SP_TabBarController {
    func centerMenuButton22() {
        let button = UIButton()
        self.tabBar.addSubview(button)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.8
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.tag = 0
        button.setImage(UIImage(named:"logo_0"), for: .normal)
        button.addTarget(self, action: #selector(SP_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        let button1 = UIButton()
        self.tabBar.addSubview(button1)
        button1.backgroundColor = UIColor.white
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderWidth = 0.8
        button1.layer.cornerRadius = 25
        button1.clipsToBounds = true
        button.tag = 1
        button1.setImage(UIImage(named:"logo_0"), for: .normal)
        button1.addTarget(self, action: #selector(SP_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button1.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        let button2 = UIButton()
        self.tabBar.addSubview(button2)
        button2.backgroundColor = UIColor.white
        button2.layer.borderColor = UIColor.white.cgColor
        button2.layer.borderWidth = 0.8
        button2.layer.cornerRadius = 25
        button2.clipsToBounds = true
        button2.tag = 2
        button2.setImage(UIImage(named:"logo_0"), for: .normal)
        button2.addTarget(self, action: #selector(SP_TabBarController.centerMenuButtonClick1(_:)), for: .touchUpInside)
        button2.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
    }
    func centerMenuButtonClick1(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t两行两列, block: { tag in
                
            })
        case 1:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t两行三列, block: { tag in
                
            })
        case 2:
            let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
            SP_TabMenuView.show((images,titles) ,type:.t三行三列, block: { tag in
                
            })
        default:
            break
        }
        
        
    }
}

