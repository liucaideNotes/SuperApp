//
//  SP_Rx_DemoVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/1/15.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


typealias TableSP_Rx_DemoModel = AnimatableSectionModel<String, M_SP_Rx_Demo>

class SP_Rx_DemoVC: UITableViewController {

    override class func initSPVC() -> SP_Rx_DemoVC {
        return UIStoryboard(name: "SP_RxDemo", bundle: nil).instantiateViewController(withIdentifier: "SP_Rx_DemoVC") as! SP_Rx_DemoVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = nil
        tableView.dataSource = nil
        
        makeTableView()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    let disposeBag = DisposeBag()

    /// 保存所有的 Section
    let sections = Variable([TableSP_Rx_DemoModel]())
    
    static let sectionsValue1: [M_SP_Rx_Demo] = [
        M_SP_Rx_Demo(name: "Rx_TableView", type: 11),
        M_SP_Rx_Demo(name: "Rx_CollectionView", type: 12)
    ]
    static let sectionsValue2: [M_SP_Rx_Demo] = [
        M_SP_Rx_Demo(name: "NotificationCenter", type: 21)
    ]
    static let sectionsValue3: [M_SP_Rx_Demo] = [
        M_SP_Rx_Demo(name: "Rx_UIButton", type: 31),
        M_SP_Rx_Demo(name: "Rx_UILabel", type: 32),
        M_SP_Rx_Demo(name: "Rx_UITextField", type: 33),
        M_SP_Rx_Demo(name: "Rx_UITextView", type: 34),
        ]
    
    func makeTableView() {
        let tabData = RxTableViewSectionedReloadDataSource<TableSP_Rx_DemoModel>()
        tabData.configureCell = { (dat, tab, index, model) in
            let cell = tab.dequeueReusableCell(withIdentifier: "Rx_DemoCell")
            cell?.textLabel?.text = model.name
            return cell!
        }
        
        
        //数据绑定
        sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: tabData))
            .addDisposableTo(disposeBag)
        
        sections.value = [TableSP_Rx_DemoModel(model: "", items: SP_Rx_DemoVC.sectionsValue1), TableSP_Rx_DemoModel(model: "", items: SP_Rx_DemoVC.sectionsValue2), TableSP_Rx_DemoModel(model: "", items: SP_Rx_DemoVC.sectionsValue3)]
        
        
        tableView.rx.modelSelected(M_SP_Rx_Demo.self)
            .subscribe(onNext: { [unowned self]model in
                print(model.name)
                switch model.type {
                case 33:
                    let vc = SP_Rx_SigninVC.initSPVC()
                    self.navigationController?.show(vc, sender: nil)
                case 21:
                    let vc = SP_Rx_NotificationCenter.initSPVC()
                    self.navigationController?.show(vc, sender: nil)
                default:
                    break
                }
            })
            .addDisposableTo(disposeBag)
        
        
    }
    

    
    
}



struct M_SP_Rx_Demo {
    let name: String
    let type: Int
}

extension M_SP_Rx_Demo: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

extension M_SP_Rx_Demo: IdentifiableType {
    var identity: Int {
        return hashValue
    }
}

func ==(lhs: M_SP_Rx_Demo, rhs: M_SP_Rx_Demo) -> Bool {
    return lhs.name == rhs.name
}

extension M_SP_Rx_Demo: CustomStringConvertible {
    var description: String {
        return "\(name)'s age is \(type)"
    }
}

