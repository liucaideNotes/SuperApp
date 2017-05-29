//
//  Rx_RegisterVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/22.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SP_Rx_SigninVC: UITableViewController {

    override class func initSPVC() -> SP_Rx_SigninVC {
        return UIStoryboard(name: "SP_RxDemo", bundle: nil).instantiateViewController(withIdentifier: "SP_Rx_SigninVC") as! SP_Rx_SigninVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        make_Rx()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    let disposeBag = DisposeBag()
    var text_phone = UITextField()
    var text_verific = UITextField()
    var text_password = UITextField()
    
    var label_phone = UILabel()
    var label_verific = UILabel()
    var label_password = UILabel()
    
    var btn_verific = UIButton()
    var btn_ok = UIButton()
    
    var title_phone = ""
    var title_verific = ""
    var title_password = ""
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_Rx_SigninVCCell_"+String(format:"%d",indexPath.row), for: indexPath)
        
        switch indexPath.row {
        case 0:
            let item = cell as! SP_Rx_SigninVCCell_0
            text_phone = item.text_field
            label_phone = item.label_warn
            
            //let phoneValid =  item.text_field.rx.text.map { $0!.characters.count == 11 }.shareReplay(1)
            let phoneValid =  item.text_field.rx.text.shareReplay(1)
            phoneValid.subscribe(onNext: { [weak self](text) in
                print_SP(text!)
                self?.title_phone = text!
            }).addDisposableTo(disposeBag)
            item.text_field.rx.textInput
            
            phoneValid.map { $0!.characters.count == 11 }
                .bind(to: label_phone.rx.isHidden)
                .disposed(by: disposeBag)
            
        case 1:
            let item = cell as! SP_Rx_SigninVCCell_1
            text_verific = item.text_field
            label_verific = item.label_warn
            btn_verific = item.btn_verific
        case 2:
            let item = cell as! SP_Rx_SigninVCCell_2
            text_password = item.text_field
            label_password = item.label_warn
            
        case 3:
            let item = cell as! SP_Rx_SigninVCCell_3
            btn_ok = item.btn_ok
            
        default:
            break
        }
        
        return cell
    }

    func make_Rx(){
        
        /*
        let phoneValid =  text_phone.rx.text.map { $0!.characters.count == 11 }.shareReplay(1)
        
        let verificVaild = text_verific.rx.text.map { $0!.characters.count == 6 }.shareReplay(1)
        
        let passwordValid =  text_password.rx.text.map { $0!.characters.count <= 16 && $0!.characters.count >= 6 }.shareReplay(1)
        
        let everythingValid = Observable.combineLatest(phoneValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        /*
        phoneValid.bind(to: UIBindingObserver(UIElement: text_phone, binding: { (text, valid) in
            
            label_phone.rx.isHidden = valid ? true : false
            
        } )).disposed(by: disposeBag)
        */
        
        
        
        
        phoneValid
            .bind(to: label_phone.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        everythingValid
            .bind(to: btn_ok.rx.isEnabled)
            .disposed(by: disposeBag)*/
    }
}

