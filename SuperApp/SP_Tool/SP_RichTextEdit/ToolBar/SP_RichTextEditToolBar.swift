//
//  SP_RichTextEditToolBar.swift
//  Fortuna
//
//  Created by LCD on 2017/8/25.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
class SP_RichTextEditToolBar:UIView {
    
    class func show()->SP_RichTextEditToolBar {
        return Bundle.main.loadNibNamed("SP_RichTextEditToolBar", owner: nil, options: nil)!.first as! SP_RichTextEditToolBar
        
        
//        let view = SP_RichTextEditToolBar()
//        supView.addSubview(view)
//        view.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(40)
//            make.bottom.equalToSuperview().offset(-bottom)
//        }
    }
    
    @IBOutlet weak var tool_B: UIButton!
    @IBOutlet weak var tool_A: UIButton!
    @IBOutlet weak var tool_Img: UIButton!
    @IBOutlet weak var tool_Friend: UIButton!
    @IBOutlet weak var tool_Wine: UIButton!
    @IBOutlet weak var tool_Link: UIButton!
    
    @IBOutlet weak var view_Line: UIView!
}
