//
//  SP_AdsColleCell.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit

class SP_AdsColleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName:String = "" {
        didSet{
            imageView.sp_ImageName(imageName)
            
        }
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
