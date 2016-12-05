//
//  FH_AdsColleCell.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit
import SDWebImage
class FH_AdsColleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func model(name:String, isUrlImage:Bool) {
        if isUrlImage {
            imageView.sd_setImage(with: URL(string: name), placeholderImage: UIImage(named: FH_AdsView.placeholderImage))
        }else{
            imageView.image = UIImage(named: name)
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
