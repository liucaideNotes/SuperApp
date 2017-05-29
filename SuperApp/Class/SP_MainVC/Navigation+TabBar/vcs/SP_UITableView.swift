//
//  SP_UITableView.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/5/21.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
enum SP_UITableViewTouchType {
    case tBegan
    case tMoved
    case tCancelled
    case tEnded
}
class SP_UITableView: UITableView {

    
    var _touchesBlock:((_ type: SP_UITableViewTouchType,_ touches: Set<UITouch>, _ event: UIEvent?)->Void)?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print_SP("touchesBegan --> \(touches)")
        _touchesBlock?(.tBegan,touches,event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        _touchesBlock?(.tMoved,touches,event)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        _touchesBlock?(.tCancelled,touches,event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _touchesBlock?(.tEnded,touches,event)
    }

}
