//
//  SP_DrawerVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/12.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//
/**
 * 抽屉 底部的 ViewController， 以此VC作为底层
 * 让需要展示抽屉的 子类继承 SP_ParentVC_Drawer
 *
 *
 *
 */
import UIKit

class SP_DrawerVC: UIViewController {

    //MARK:----------- 生命周期
    override class func initSPVC() -> SP_DrawerVC {
        return UIStoryboard(name: "SP_MainVCStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_DrawerVC") as! SP_DrawerVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(tabBar.view)
        self.addChildViewController(tabBar)
        tabBar.view.snp.makeConstraints { (make) in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        mytableView.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBOutlet weak var mytableView: UITableView!
    
    @IBOutlet weak var viewL_constLeading: NSLayoutConstraint!
    @IBOutlet weak var viewL_constTrailing: NSLayoutConstraint!
    
    
    //MARK:--- TabBar+Navigation 嵌套架构
    private lazy var tabBar:SP_TabBarController = {
        let viewControllers = [SP_MainVC.initSPVC(),SP_RxSwiftTableView.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC(),SP_AdsVC.initSPVC()]
        let titles = ["1","2","","4","5"]
        let images = ["30x30","30x30","","30x30","30x30"]
        let selectedImages = ["30x30","30x30","","30x30","30x30"]
        let vc = SP_TabBarController.initTabbar(viewControllers, titles: titles, images: images, selectedImages: selectedImages, selectedIndex: 0)
        vc.setProperty(true, colorNormal: UIColor.maintext_darkgray, colorSelected: UIColor.main_1, titleFontNormal: 12.0, titleFontSelected: 12.0, imageInsets: UIEdgeInsetsMake(0, 0, 0, 0))
        vc.sp_centerMenuButton()
        return vc
    }()
    
    //MARK:--- 向子控制器传值 - 通知
    func postNotification(_ tag:Int) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SP_DrawerVCPostValue"), object: ["tag":tag,"selectIndex":self.tabBar.selectedIndex])
    }
    

}

extension SP_DrawerVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SP_DrawerCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postNotification(indexPath.row)
    }
}
//MARK:----------- SP_MainVCCell
class SP_DrawerCell: UITableViewCell {
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> SP_DrawerCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_DrawerCell", for: indexPath) as! SP_DrawerCell
        return cell
    }
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
}


