//
//  SP_RxSwiftTableView.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/12.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class SP_RxSwiftTableView: SP_ParentVC_Drawer,UITableViewDelegate {

    override class func initSPVC() -> SP_RxSwiftTableView {
        return UIStoryboard(name: "SP_MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_RxSwiftTableView") as! SP_RxSwiftTableView
    }
    
    class func push(_ parentVC:UIViewController?) {
        let vc = SP_RxSwiftTableView.initSPVC()
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func sp_makeNaviDefault() {
        super.sp_makeNaviDefault()
        n_view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        n_view.n_view_NaviLine.isHidden = true
    }
    //MARK:--- 抽屉点击事件通知
    override func drawerReceptionValue(_ notification:Notification) {
        super.drawerReceptionValue(notification)
        let notifi = notification.object as? [String:Any]
        
        let tag = notifi?["tag"] as? Int ?? 0
        let index = notifi?["selectIndex"] as? Int ?? 0
        if index == 1 {
            SP_VipVC.push(self,tag:tag)
        }
        
    }
    
    //MARK:--- 数据源
    @IBOutlet weak var myTableView: UITableView!
    
    /*
    let myDataSource = SP_RxSwiftTableView.configureDataSource()
    let viewModel    = RxSwiftTableView_ViewModel()
    let myDisposeBag = DisposeBag()
    

    static func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, User>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RxSwiftTableView_Model>>()
        
        dataSource.configureCell = { (section, tableView, indexPath, model) in
            let cell = SP_RxSwiftTableViewCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
            let model = section.sectionModels[indexPath.section]
            cell.model = model.items[indexPath.row]
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
        
        dataSource.canEditRowAtIndexPath = { (ds, ip) in
            return true
        }
        
        dataSource.canMoveRowAtIndexPath = { _ in
            return true
        }
        
        return dataSource
    }

    
    func makeUIFromeData() {
        
        myDataSource.configureCell = {
            section, tableView, indexPath, model in
            
            let cell = SP_RxSwiftTableViewCell.dequeueReusable(tableView: tableView, indexPath: indexPath)
            cell.tag = indexPath.row
            
            let model = section.sectionModels[indexPath.section]
            cell.model = model.items[indexPath.row]
            return cell
        }
        
//        viewModel.getDatas()
//            .bindTo(myTableView.rx.items(dataSource: myDataSource))
//            .addDisposableTo(self.myDisposeBag)
        
        
        myTableView.rx.setDelegate(self).addDisposableTo(myDisposeBag)
        
        
        
    }*/

}

class SP_RxSwiftTableViewCell: UITableViewCell {
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> SP_RxSwiftTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_RxSwiftTableViewCell", for: indexPath) as! SP_RxSwiftTableViewCell
        return cell
    }
    @IBOutlet weak var image_logo: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_detail: UILabel!
    @IBOutlet weak var label_price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /*
    var model:RxSwiftTableView_Model = RxSwiftTableView_Model() {
        willSet{
            if newValue.rx_url.hasPrefix("https://") || newValue.rx_url.hasPrefix("http://")  {
                image_logo.sd_setImage(with: URL(string:"newValue.rx_url"), placeholderImage: UIImage(named:"200x200"))
            }else{
                image_logo.image = newValue.rx_url.isEmpty ? UIImage(named:"200x200") : UIImage(named:newValue.rx_url)
            }
            
            label_name.text = newValue.rx_name
            label_detail.text = newValue.rx_details
            label_price.text = String(format:"%.2f",newValue.rx_price)
        }
    }*/
    
}
