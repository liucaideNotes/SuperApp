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
            //UIView.xzSetLineView(cell!, placeType: .bottom)
        }
        return cell!
    }
    /*
    class func adsCell(_ tableView:UITableView, parentVC:UIViewController, frame:CGRect, datas:[AdsBannersModel]) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SP_AdsCell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SP_AdsCell")
            
        }
        cell?.backgroundColor = .main_bg
        cell?.selectionStyle = .none
        var imageUrls = [String]()
        for item in datas {
            imageUrls.append(item.ihg_url)
        }
        let adsView = SP_AdsView.show(cell!, frame: frame, imageUrls: imageUrls, adsType: .default_H)
        adsView._SP_AdsViewClosures = { [weak parentVC](itemIdex, isSelect) in
            if isSelect {
                guard datas.count != 0 else{return}
                xzAdsClickPush(parentVC!, adsModel: datas[itemIdex])
            }
        }
        return cell!
        
    }*/
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
    class func adsCell(_ collectionView:UICollectionView, indexPath:IndexPath,  parentVC:UIViewController,  datas:[AdsBannersModel]) -> UICollectionViewCell {
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "itemID_null")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemID_null", for: indexPath)
        cell.backgroundColor = .main_bg
        var imageUrls = [String]()
        for item in datas {
            imageUrls.append(item.ihg_url)
        }
        let adsView = SP_AdsView.show(cell, frame: cell.bounds, imageUrls: imageUrls, adsType: .default_H)
        adsView._SP_AdsViewClosures = { [weak parentVC](itemIdex, isSelect) in
            if isSelect {
                guard datas.count != 0 else{return}
                xzAdsClickPush(parentVC!, adsModel: datas[itemIdex])
            }
        }
        
        return cell
    }*/

}
