//
//  SP_GridView_Extension.swift
//  iexbuy
//
//  Created by 刘才德 on 2016/11/22.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

extension SP_GridView {
    //MARK:--- 默认
    func tDefault(_ imageLayer:Bool = false, angle:(hidden:Bool,height:CGFloat) = (false,12), label:(font:CGFloat, color:UIColor) = (14.0,UIColor.maintext_pitchblack), margin:CGFloat = 5.0) {
        
        for (i,item) in _pageView.subviews.enumerated() {
            let image_w = item.bounds.width - margin*2
            var image_h = (item.bounds.height - margin*2)/3*2
            image_h = image_h<image_w ? image_h : image_w
            for subView in item.subviews {
                if let label = item.subviews.first as? UILabel {
                    label.text = _titles.count>i ? _titles[i] : ""
                }
                if let image = subView as? UIImageView {
                    if imageLayer {
                        image.layer.cornerRadius = image_h/2
                        image.clipsToBounds = true
                    }
                    if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                        image.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
                    }else{
                        if !_images[i].isEmpty {
                            image.image = UIImage(named: _images[i])
                        }else{
                            image.image = UIImage(named: placeholderImage)
                        }
                    }
                }
                if let label = item.subviews.last as? UILabel {
                    label.text = _angles.count>i ? _angles[i] : ""
                    return
                }
            }
            
            //文字
            let label_title = UILabel()
            item.addSubview(label_title)
            label_title.text = _titles.count>i ? _titles[i] : ""
            label_title.textAlignment = .center
            label_title.textColor = label.color
            label_title.font = UIFont.systemFont(ofSize: label.font)
            ///图片
            let imageView = UIImageView()
            item.addSubview(imageView)
            if imageLayer {
                imageView.layer.cornerRadius = image_h/2
                imageView.clipsToBounds = true
            }
            
            
            if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                imageView.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
            }else{
                if !_images[i].isEmpty {
                    imageView.image = UIImage(named: _images[i])
                }else{
                    imageView.image = UIImage(named: placeholderImage)
                }
                
            }
            imageView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset(margin)
                make.centerX.equalToSuperview()
                make.height.width.equalTo(image_h)
            })
            
            
            label_title.snp.makeConstraints({ (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(imageView.snp.bottom)
                make.bottom.equalToSuperview()
            })
            //角标
            
            if !angle.hidden {
                let label_angle = UILabel()
                item.addSubview(label_angle)
                label_angle.text = _angles.count>i ? _angles[i] : ""
                label_angle.textAlignment = .center
                label_angle.textColor = UIColor.white
                label_angle.font = UIFont.systemFont(ofSize: angle.height-4)
                label_angle.layer.cornerRadius = angle.height/2
                label_angle.clipsToBounds = true
                label_angle.backgroundColor = UIColor.red
                label_angle.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview().offset(1)
                    make.trailing.equalToSuperview().offset(-1)
                    make.height.equalTo(angle.height)
                })
                var ww = CGSize.sp_LabelSize(label_angle.text!, font: label_angle.font, size: CGSize(width:0,height:angle.height)).width + 4.0
                ww = ww<angle.height ? angle.height : ww
                label_angle.snp.makeConstraints({ (make) in
                    make.width.equalTo(ww)
                })
                
                if label_angle.text!.isEmpty {
                    label_angle.isHidden = true
                }
            }
        }
        
    }
    //MARK:--- 只有图片
    func tOnleImage(_ imageIsSquare:Bool, angle:(hidden:Bool,height:CGFloat) = (true,0)) {
        
        for (i,item) in _pageView.subviews.enumerated() {
            for subView in item.subviews {
                if let image = subView as? UIImageView {
                    if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                        image.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
                    }else{
                        if !_images[i].isEmpty {
                            image.image = UIImage(named: _images[i])
                        }else{
                            image.image = UIImage(named: placeholderImage)
                        }
                    }
                }
                if let label = item.subviews.last as? UILabel {
                    label.text = _angles[i]
                    return
                }
            }
            
            
            ///图片
            let imageView = UIImageView()
            item.addSubview(imageView)
            if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                imageView.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
            }else{
                if !_images[i].isEmpty {
                    imageView.image = UIImage(named: _images[i])
                }else{
                    imageView.image = UIImage(named: placeholderImage)
                }
                
            }
            let image_w = item.bounds.width
            var image_h = item.bounds.height
            image_h = image_h<image_w ? image_h : image_w
            if imageIsSquare {
                imageView.snp.makeConstraints({ (make) in
                    make.center.equalToSuperview()
                    make.height.width.equalTo(image_h)
                })
            }else{
                imageView.snp.makeConstraints({ (make) in
                    make.top.bottom.leading.trailing.equalToSuperview()
                })
            }
            
            
            //角标
            if !angle.hidden {
                let label_angle = UILabel()
                item.addSubview(label_angle)
                label_angle.text = _angles[i]
                label_angle.textAlignment = .center
                label_angle.textColor = UIColor.white
                label_angle.font = UIFont.systemFont(ofSize: 7)
                label_angle.layer.cornerRadius = angle.height/2
                label_angle.clipsToBounds = true
                label_angle.backgroundColor = UIColor.red
                label_angle.snp.makeConstraints({ (make) in
                    make.top.trailing.equalToSuperview()
                    make.height.equalTo(angle.height)
                })
                if _angles[i].characters.count<2 {
                    label_angle.snp.makeConstraints({ (make) in
                        make.width.equalTo(angle.height)
                    })
                }
            }
        }
        
    }
    //MARK:--- 只有文字
    func tOnlyTitle(_ selectIndex:Int = 0, select:(bgcolor:UIColor, textColor:UIColor) = (UIColor.main_1,UIColor.white), normal:(bgcolor:UIColor, textColor:UIColor) = (UIColor.main_bg,UIColor.maintext_darkgray)) {
        
        if selectIndex != 0 && selectIndex < _pageView.subviews.count - _eachNum {
            _scrollView.setContentOffset(CGPoint(x: _pageView.subviews[selectIndex].frame.origin.x, y: 0), animated: false)
        }
        if selectIndex >= _pageView.subviews.count - _eachNum {
            _scrollView.setContentOffset(CGPoint(x: _pageView.subviews[_pageView.subviews.count - _eachNum].frame.origin.x, y: 0), animated: false)
        }
        
        _scrollView.isPagingEnabled = false
        _pageControl.isHidden = true
        for (i,item) in _pageView.subviews.enumerated() {
            item.layer.cornerRadius = item.bounds.size.height/2
            item.clipsToBounds = true
            for subView in item.subviews {
                if let button = subView as? UIButton {
                    button.setTitle(_titles[i], for: .normal)
                    if i == selectIndex {
                        button.backgroundColor = select.bgcolor
                    }else{
                        button.backgroundColor = normal.bgcolor
                    }
                }
            }
            
            ///图片
            let button = UIButton()
            item.addSubview(button)
            button.setTitle(_titles[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(normal.textColor, for: .normal)
            button.setTitleColor(select.textColor, for: .selected)
            button.tintColor = UIColor.clear
            button.tag = i
            if i == selectIndex {
                button.backgroundColor = select.bgcolor
                button.isSelected = true
            }else{
                button.backgroundColor = normal.bgcolor
                button.isSelected = false
            }
            button.addTarget(self, action: #selector(SP_GridView.onlyTitleClick(_:)), for: .touchUpInside)
            button.snp.removeConstraints()
            button.snp.makeConstraints({ (make) in
                make.top.bottom.leading.trailing.equalToSuperview()
            })
            
        }
        
    }
    func onlyTitleClick(_ sender:UIButton) {
        self.tOnlyTitle(sender.tag)
        _block?(sender.tag)
    }

    //MARK:--- 商品
    func tMyGoods_One(_ labelNew:(font:CGFloat, color:UIColor)=(15.0,UIColor.main_1), labelOld:(font:CGFloat, color:UIColor)=(12.0,UIColor.maintext_darkgray)) {
        updateFrames()
        _scrollView.setContentOffset(CGPoint(x: 20, y: 0), animated: true)
        
        for (i,item) in _pageView.subviews.enumerated() {
            //item.backgroundColor = i%2==0 ? UIColor.yellow : UIColor.gray
            for subView in item.subviews {
                if let label = item.subviews.first as? UILabel {
                    label.text = _titles.count>i ? _titles[i] : ""
                }
                if let image = subView as? UIImageView {
                    if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                        image.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
                    }else{
                        if !_images[i].isEmpty {
                            image.image = UIImage(named: _images[i])
                        }else{
                            image.image = UIImage(named: placeholderImage)
                        }
                    }
                }
                if let label = item.subviews.last as? UILabel {
                    label.text = _angles.count>i ? _angles[i] : ""
                    let ww = CGSize.sp_LabelSize(label.text!, font: label.font, size: CGSize(width:0,height:15)).width
                    label.subviews.first?.snp.removeConstraints()
                    label.subviews.first?.snp.makeConstraints({ (make) in
                        make.center.equalToSuperview()
                        make.height.equalTo(1.0)
                        make.width.equalTo(ww)
                    })
                    
                    return
                }
            }
            
            //文字 现价
            let label_new = UILabel()
            item.addSubview(label_new)
            label_new.text = _titles.count>i ? "¥"+_titles[i] : ""
            label_new.textAlignment = .center
            label_new.textColor = labelNew.color
            label_new.font = UIFont.systemFont(ofSize: labelNew.font)
            ///图片
            let imageView = UIImageView()
            item.addSubview(imageView)
            if _images[i].hasPrefix("http://") || _images[i].hasPrefix("https://") {
                imageView.sd_setImage(with: URL(string:_images[i]) , placeholderImage: UIImage(named: placeholderImage))
            }else{
                if !_images[i].isEmpty {
                    imageView.image = UIImage(named: _images[i])
                }else{
                    imageView.image = UIImage(named: placeholderImage)
                }
                
            }
            
            //文字 原价
            let label_old = UILabel()
            item.addSubview(label_old)
            label_old.text = _angles.count>i ? "¥"+_angles[i] : ""
            label_old.textAlignment = .center
            label_old.textColor = labelOld.color
            label_old.font = UIFont.systemFont(ofSize: labelOld.font)
            
            let view_line = UIView()
            label_old.addSubview(view_line)
            view_line.backgroundColor = labelOld.color
            
            
            label_old.snp.makeConstraints({ (make) in
                make.bottom.leading.trailing.equalToSuperview()
                make.height.equalTo(20)
            })
            label_new.snp.makeConstraints({ (make) in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(label_old.snp.top).offset(2)
                make.height.equalTo(20)
            })
            var imageww = item.bounds.size.width
            let imagehh = item.bounds.size.height-40
            imageww = imageww<imagehh ? imageww : imagehh
            imageView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(imageww)
            })

            let ww = CGSize.sp_LabelSize(label_old.text!, font: label_old.font, size: CGSize(width:0,height:15)).width
            view_line.snp.removeConstraints()
            view_line.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.height.equalTo(1.0)
                make.width.equalTo(ww)
            })
        }
        
    }
    
    //MARK:--- 重新布局
    func tDefaultAnimate(_ height:CGFloat = 120.0) {
        updateCellFrames(height)
        self.longPressRemve = true
        tDefault(true)
    }

}
 
