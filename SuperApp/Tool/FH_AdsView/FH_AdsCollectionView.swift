//
//  FH_AdsCollectionView.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/1.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit

class FH_AdsCollectionView: UICollectionView {

    var vm = FH_AdsCollectionViewModel()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        vm.target = self
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
