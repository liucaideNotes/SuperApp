//
//  RxSwiftTableViewModel.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/13.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

let rx_detail = "SuperApp -- 这是一个超级App、支持swift3.0，一个让ios开发人员疯狂的一个超级demo，我们竭尽所能，持续更新！"
//MARK:--- Model
struct RxSwiftTableView_Model {
    var rx_name    = ""
    var rx_url     = ""
    var rx_details = ""
    var rx_price:Double = 0.0
    
}

//MARK:--- ViewModel
class RxSwiftTableView_ViewModel: NSObject {
    /*
    func getDatas() -> SectionModel<Any, Any>  {
        let datas = [
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 100.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 200.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 300.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 400.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 500.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 600.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 700.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 800.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 900.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 1000.10)
        ]
        let datas2 = [
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 100.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 200.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 300.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 400.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 500.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 600.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 700.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 800.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 900.10),
            RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 1000.10)
        ]
        let section = [SectionModel(model: "第一组", items: datas),
                       SectionModel(model: "第二组", items: datas2)]
        return section
    }*/
 
    
    
    func getDatas() -> Observable<[SectionModel<String, RxSwiftTableView_Model>]> {
        return Observable.create({ (observer) -> Disposable in
            
            
            let datas = [
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 100.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 200.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 300.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 400.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 500.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 600.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 700.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 800.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 900.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 1000.10)
            ]
            let datas2 = [
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 100.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 200.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 300.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 400.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 500.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 600.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 700.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 800.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "logo_0", rx_details:rx_detail, rx_price: 900.10),
                RxSwiftTableView_Model(rx_name: "超级App", rx_url: "200x200", rx_details:rx_detail, rx_price: 1000.10)
            ]
            let section = [SectionModel(model: "第一组", items: datas),
                           SectionModel(model: "第二组", items: datas2)]
            observer.onNext(section)
            observer.onCompleted()
            
            return  AnonymousDisposable(disposeAction: observer) //AnonymousDisposable{}
        })
    }
    
}
