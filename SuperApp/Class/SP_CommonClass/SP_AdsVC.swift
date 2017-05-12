//
//  SP_AdsVC.swift
//  SP_AdsView
//
//  Created by 刘才德 on 16/8/21.
//  Copyright © 2016年 sifenzi. All rights reserved.
//

import UIKit

class SP_AdsVC: SP_ParentVC,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images1 = ["http://p1.ifengimg.com/a/2016_35/bf489286fc9050d_size52_w900_h502.jpg",
                   "",
                   "http://p0.ifengimg.com/a/2016_35/becb7b6d997a1d0_size53_w750_h500.jpg",
                   "http://p1.ifengimg.com/a/2016_35/dc2acc684d61c74_size57_w978_h550.jpg",
                   "http://p2.ifengimg.com/a/2016_35/f966a4d9e469952_size57_w978_h550.jpg",
                   "http://p0.ifengimg.com/a/2016_35/071b8b8c35a9a9e_size39_w750_h500.jpg",
                   "http://p1.ifengimg.com/a/2016_35/0eac1e14cbb655e_size49_w750_h480.jpg",
                   "http://photocdn.sohu.com/20160824/Img465700296.jpg",
                   "http://photocdn.sohu.com/20160825/Img465897773.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875448.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875443.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875446.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875449.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875450.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875451.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875452.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875453.jpg"
    ]
    
    override class func initSPVC() -> SP_AdsVC {
        return UIStoryboard(name: "SP_CommonClassStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_AdsVC") as! SP_AdsVC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.perform(#selector(SP_AdsVC.upArrayClick), with: nil, afterDelay: 4.3)
    }
    
    func upArrayClick() {
        images1.removeLast()
        tableView.reloadData()
        if images1.count > 0 {
            self.perform(#selector(SP_AdsVC.upArrayClick), with: nil, afterDelay: 4.3)
        }
        
    }
    
    @IBAction func backClick(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    let cell_H:CGFloat = 150.0
    var _itemIdex = 0
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "第\(section)组"
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_H
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, adsType: .default_H, pageAlignment:.right)
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 1:
            let cell = TableViewCell_Title.dequeueReusable(tableView: tableView, indexPath:indexPath as IndexPath)
            let adsView = SP_AdsView.show(cell.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, time: Double(indexPath.section), adsType: .default_H)
            cell.titleLab.text = "title_\(_itemIdex)"
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }else{
                    //可以在这里对自定义分页圆点或其他空间赋值
                    self?._itemIdex = itemIdex
//                    let dic:[String:Any] = ["2":123,"3":"456"]
//                    cell.titleLab.text = dic["1"]! as? String
                    cell.titleLab.text = "title_\(itemIdex)"
                }
            }
            cell.contentView.sendSubview(toBack: adsView)//将轮播放在底层
            
            return cell
        case 2:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, time: Double(indexPath.section),adsType: .half_H, itemSize:CGSize(width:UIScreen.main.bounds.size.width/2 - 2, height:cell_H))
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 3:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, adsType: .imageBrowse_H,itemSize:CGSize(width:(cell_H-5)/2, height:(cell_H-5)/2))
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 4:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H)
                , imageUrls: images1, adsType: .imageBrowse_V)
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 5:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: [], adsType: .imageBrowse_V,itemSize:CGSize(width:(cell_H-5)/2, height:(cell_H-5)/2))
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        default:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = SP_AdsView.show(cell!.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, adsType: .default_H)
            adsView._SP_AdsViewClosures = { [weak self](itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self?.present(aler, animated: true, completion: nil)
                }
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        let array =  tableView.indexPathsForVisibleRows
        //        let firstIndexPath = array![0]
        //        //设置anchorPoint
        //        cell.layer.anchorPoint = CGPointMake(0, 0.5)
        //        //为了防止cell视图移动，重新把cell放回原来的位置
        //        cell.layer.position = CGPointMake(0, cell.layer.position.y)
        //
        //
        //        //设置cell 按照z轴旋转90度，注意是弧度
        //        if (firstIndexPath.row < indexPath.row) {
        //            cell.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1.0)
        //        }else{
        //            cell.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1.0)
        //        }
        //
        //
        //        cell.alpha = 0.0;
        //        UIView.animateWithDuration(1.0, animations: {
        //            cell.layer.transform = CATransform3DIdentity
        //            cell.alpha = 1.0
        //            }) { (Bool) in
        //
        //        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
}

class TableViewCell_Title: UITableViewCell {
    
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> TableViewCell_Title {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_Title", for: indexPath) as! TableViewCell_Title
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

