//
//  SP_ParentVC_Drawer.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/12.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//
/**
   抽屉 父类 继承于 基础父类 SP_ParentVC
   让需要展示抽屉的 子类继承此类，子类中重写 drawerReceptionValue 以接收抽屉中的点击事件
 */

import UIKit
import RxSwift

class SP_ParentVC_Drawer: SP_ParentVC {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.fd_prefersNavigationBarHidden = true
        /*
        NotificationCenter
            .default
            .rx
            .notification(NSNotification.Name(rawValue: "SP_DrawerVCPostValue"), object: nil)
            .takeUntil(self.rx.deallocated)
            .asObservable().subscribe(onNext: { [weak self](notification) in
                //MARK:--- 抽屉点击事件通知
                self?.closeDrawer()
            }).addDisposableTo(disposeBag)
        */
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SP_ParentVC_Drawer.drawerReceptionValue(_:)), name:NSNotification.Name(rawValue: "SP_DrawerVCPostValue"), object: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SP_DrawerVCPostValue"), object: nil)
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:--- 抽屉点击事件通知
    func drawerReceptionValue(_ notification:NSNotification) {
        closeDrawer()
    }
    //左侧展开宽度
    private let _left_W:CGFloat = 260
    //顶部展开高度
    private let _top_H:CGFloat = 50

    //MARK:--- 设置导航栏
    override func sp_makeNaviDefault() {
        super.sp_makeNaviDefault()
        n_view.n_btn_L2_Image = "200x200"
        n_view.n_btn_L1.setImage(UIImage(named: ""), for: .normal)
        n_view.n_btn_L2_W.constant = 36
        n_view.n_btn_L2_H.constant = 36
        n_view.n_btn_L1_W.constant = 10
        n_view.n_btn_L2.layer.cornerRadius = 18
        n_view.n_btn_L2.clipsToBounds = true
        
//        _leftBarButton_H = 36
//        _leftBarButton.snp.removeConstraints()
//        _leftBarButton.snp.makeConstraints({ (make) in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(10)
//            make.height.equalTo(_leftBarButton_H)
//            make.width.equalTo(_leftBarButton_H)
//        })
        
        //设置抽屉
        sp_MainWindow.addSubview(sunshadeView)
        sunshadeView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(sp_MainWindow)
            make.leading.equalTo(sp_MainWindow)
            make.width.equalTo(0)
        }
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(SP_ParentVC_Drawer.viewPanClick(_:)))
        self.view.addGestureRecognizer(viewPan)
    }
    override func clickN_btn_L2() {
        //_naviBlock?(true)
        openDrawer()
    }
    
    
    //MARK:--- 遮罩View
    private lazy var sunshadeView:UIView = {
        let view = UIView()
        //view.isHidden = true
        //view.backgroundColor = UIColor.yellow
        //点击手势
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(SP_ParentVC_Drawer.viewTapClick(_:)))
        view.addGestureRecognizer(viewTap)
        //拖曳手势
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(SP_ParentVC_Drawer.viewPanClick(_:)))
        view.addGestureRecognizer(viewPan)
        
        return view
    }()
    // -- 点击
    @objc private func viewTapClick(_ tap:UITapGestureRecognizer)  {
        //_naviBlock?(false)
        closeDrawer()
        
    }
    // -- 拖曳
    private var panPointBegan:CGFloat = 0.0
    private var panPointChanged:CGFloat = 0.0
    @objc private func viewPanClick(_ pan:UIPanGestureRecognizer)  {
        switch pan.state {
        case .began:  // 开始拖动
            panPointBegan = pan.location(in: sp_MainWindow).x
        case .changed:  // 正在拖动
            panPointChanged = pan.location(in: sp_MainWindow).x - panPointBegan
            if !_isOpen {
                if panPointChanged >= 0  {
                    self.tabBarController?.view.snp.updateConstraints { (make) in
                        make.trailing.equalToSuperview().offset(panPointChanged)
                        make.leading.equalToSuperview().offset(panPointChanged)
                        make.top.equalToSuperview().offset((_top_H/_left_W)*panPointChanged)
                        make.bottom.equalToSuperview().offset(-(_top_H/_left_W)*panPointChanged)
                    }
                }
            }else{
                if panPointChanged < 0 {
                    self.tabBarController?.view.snp.updateConstraints { (make) in
                        make.trailing.equalToSuperview().offset(_left_W+panPointChanged)
                        make.leading.equalToSuperview().offset(_left_W+panPointChanged)
                        make.top.equalToSuperview().offset(_top_H - (_top_H/_left_W) * -panPointChanged)
                        make.bottom.equalToSuperview().offset(-(_top_H - (_top_H/_left_W) * -panPointChanged))
                    }
                }
                
            }
        case .ended:   // 停止拖动
            if !_isOpen {
                if panPointChanged >= _left_W/2 {
                    openDrawer()
                }else{
                    closeDrawer()
                }
            }else{
                if panPointChanged > -_left_W/2 {
                    openDrawer()
                }else{
                    closeDrawer()
                }
            }
        default:
            break
        }
        
    }

    //MARK:--- 展开 关闭 抽屉
    private var _isOpen = false
    private func openDrawer() {
        _isOpen = true
        self.tabBarController?.view.snp.updateConstraints { (make) in
            make.trailing.equalToSuperview().offset(_left_W)
            make.leading.equalToSuperview().offset(_left_W)
            make.top.equalToSuperview().offset(_top_H)
            make.bottom.equalToSuperview().offset(-_top_H)
        }
        sunshadeView.snp.updateConstraints { (make) in
            make.leading.equalTo(sp_MainWindow).offset(_left_W)
            make.width.equalTo(400)
        }
        self.tabBarController?.view.superview?.setNeedsLayout()
        UIView.animate(withDuration: 0.2, animations: {
            self.tabBarController?.view.superview?.layoutIfNeeded()
        })
    }
    private func closeDrawer() {
        _isOpen = false
        self.tabBarController?.view.snp.updateConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        sunshadeView.snp.updateConstraints { (make) in
            make.leading.equalTo(sp_MainWindow).offset(0)
            make.width.equalTo(0)
        }
        self.tabBarController?.view.superview?.setNeedsLayout()
        UIView.animate(withDuration: 0.2, animations: {
            self.tabBarController?.view.superview?.layoutIfNeeded()
        })
    }


    
    
    
    
}


