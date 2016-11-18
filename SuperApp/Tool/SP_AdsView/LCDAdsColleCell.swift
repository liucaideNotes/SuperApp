//
//  LCDAdsColleCell.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit
import SDWebImage
class LCDAdsColleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func model(name:String, isUrlImage:Bool) {
        if isUrlImage {
            imageView.sd_setImage(with: URL(string: name), placeholderImage: UIImage(named: SP_AdsView.placeholderImage))
        }else{
            imageView.image = UIImage(named: name)
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
