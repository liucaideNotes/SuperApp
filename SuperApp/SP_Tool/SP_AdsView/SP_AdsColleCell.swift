//
//  SP_AdsColleCell.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit
import SDWebImage
class SP_AdsColleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName:String = "" {
        didSet{
            if imageName.hasPrefix("https://") || imageName.hasPrefix("http://") {
                imageView.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: SP_AdsView.placeholderImage))
            }else{
                print(imageName)
                imageView.image = imageName.isEmpty ? UIImage(named: SP_AdsView.placeholderImage) : UIImage(named: imageName)
            }
        }
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
