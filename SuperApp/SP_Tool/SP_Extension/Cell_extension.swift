//
//  UITableViewCell_extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
import UIKit
import Foundation
//MARK:---- UITableViewCell
extension UITableViewCell {
    class func nullCell(_ tableView:UITableView, indexPath:IndexPath, cellId:String = "CellID_null", removeSubViews:Bool = true, bottomLineHidden:Bool = false) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        if removeSubViews {
            for  view in cell!.contentView.subviews {
                view.removeFromSuperview()
            }
        }
        cell!.selectionStyle = .none
        cell?.backgroundColor = UIColor.main_bg
        if !bottomLineHidden {
            //UIView.xzSetLineView(cell!.contentView, placeType: .bottom)
        }
        return cell!
    }
    
    class func adsCell(_ tableView:UITableView, parentVC:UIViewController, frame:CGRect, datas:[String], time:TimeInterval = 5.0) -> (UITableViewCell,SP_AdsView) {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SP_AdsCell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SP_AdsCell")
            
        }
        cell?.backgroundColor = .main_bg
        cell?.selectionStyle = .none
        
        let adsView = SP_AdsView.show(cell!.contentView, frame: frame, imageUrls: datas, time: time, adsType: .default_H)
        /*
        var imageUrls = [String]()
        for item in datas {
            imageUrls.append(item.picCarousel)
        }
        adsView.SP_AdsViewClosures = { [weak parentVC](itemIdex, isSelect) in
            if isSelect {
                guard datas.count != 0 else{return}
                guard parentVC != nil else {return}
                M_HomeContentCarouselList.adsClickPush(parentVC!, model: datas[itemIdex])
            }
        }*/
        return (cell!,adsView)
        
    }
}
//MARK:---- UICollectionViewCell
extension UICollectionViewCell {
    class func nullCell(_ collectionView:UICollectionView, indexPath:IndexPath,  removeSubViews:Bool = true) -> UICollectionViewCell {
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "itemID_null")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemID_null", for: indexPath)
        if removeSubViews {
            for suItem in cell.subviews {
                suItem.removeFromSuperview()
            }
        }
        
        return cell
    }
    /*
    class func adsCell(_ collectionView:UICollectionView, indexPath:IndexPath, frame:CGRect,  parentVC:UIViewController,  datas:[M_HomeContentCarouselList]) -> UICollectionViewCell {
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "itemID_null")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemID_null", for: indexPath)
        cell.backgroundColor = .main_bg
        var imageUrls = [String]()
        for item in datas {
            imageUrls.append(item.picCarousel)
        }
        let adsView = SP_AdsView.show(cell, frame: frame, imageUrls: imageUrls, adsType: .default_H)
        adsView.SP_AdsViewClosures = { [weak parentVC](itemIdex, isSelect) in
            if isSelect {
                guard datas.count != 0 else{return}
                guard parentVC != nil else {return}
                M_HomeContentCarouselList.adsClickPush(parentVC!, model: datas[itemIdex])
            }
        }
        
        return cell
    }*/

}
