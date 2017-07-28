//
//  SP_Rx_NotificationCenter.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/6/7.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SP_Rx_NotificationCenter: UIViewController {
    override class func initSPVC() -> SP_Rx_NotificationCenter {
        return UIStoryboard(name: "SP_RxDemo", bundle: nil).instantiateViewController(withIdentifier: "SP_Rx_NotificationCenter") as! SP_Rx_NotificationCenter
    }
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sp_Notification.rx
            .notification(ntf_Name_SP_Rx, object: nil)
            .takeUntil(self.rx.deallocated)
            .asObservable()
            .subscribe(onNext: { [weak self](notification) in
                self?.label_text.text = notification.object as? String ?? "无"
                self?.num += 1
            }).addDisposableTo(disposeBag)
        //.addDisposableTo(DisposeBag()) 如果这样写将收不到通知
    }
    
    var num = 0
    
    @IBAction func postClick(_ sender: UIButton) {
        sp_Notification.post(name: ntf_Name_SP_Rx, object: "发送了通知_\(num+1)")
    }
    @IBOutlet weak var label_text: UILabel!
}
