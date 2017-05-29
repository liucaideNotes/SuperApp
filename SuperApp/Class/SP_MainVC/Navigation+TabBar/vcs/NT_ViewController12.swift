//
//  NT_ViewController3.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/12.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit

class NT_ViewController12: SP_ParentVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fd_prefersNavigationBarHidden = true
        
//        if self.responds(to: #selector(getter: UIViewController.automaticallyAdjustsScrollViewInsets)) {
//            
//            self.automaticallyAdjustsScrollViewInsets = false
//            
//        }
        myTableView.delegate = self
        var insets = self.myTableView.contentInset
        insets.top = 24
        self.myTableView.contentInset = insets
        self.myTableView.scrollIndicatorInsets = insets
        
        /*
        myTableView._touchesBlock = { (type,touches,event) in
            switch type {
            case .tBegan:
                self.n_view.sp_setBgHidden(true, offsetY: 0)
            case .tMoved:
                break
            default:
                break
            }
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var myTableView: UITableView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print_SP("touchesBegan --> \(touches)")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print_SP("touchesMoved --> \(touches)")
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print_SP("touchesCancelled --> \(touches)")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print_SP("touchesEnded --> \(touches)")
    }
    
}
extension NT_ViewController12:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NT_ViewControllerCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    //MARK:---------- ScrollViewDelegate
    /*
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print_SP("velocity --> \(velocity)")
        print_SP("targetContentOffset --> \(targetContentOffset)")
        
        if(velocity.y>0)
        {
            n_view.n_view_NaviBar.isHidden = true
        }
        else
        {
            n_view.n_view_NaviBar.isHidden = false
        }
    }*/
    //MARK:--- 开始拖动 -----------------------------
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print_SP("开始拖动 --> \(scrollView.contentOffset.y)")
        //n_view.sp_setBgHidden(true, offsetY: scrollView.contentOffset.y)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print_SP("正在滚动 --> \(scrollView.contentOffset.y)")
        //n_view.sp_setBgHidden(false, offsetY: scrollView.contentOffset.y)
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print_SP("开始滚动 --> \(scrollView.contentOffset.y)")
    }
    
    
}
