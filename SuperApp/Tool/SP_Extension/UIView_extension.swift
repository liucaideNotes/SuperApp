//
//  UIView+Extension.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/3.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//



import UIKit

extension UIView {
    public enum PlaceType {
        case top
        case bottom
        case left
        case right
        case centerX
        case centerY
        case otherH
        case otherV
        case remove
    }
    //MARK:---------- 线条 应写在 awakeFromNib() 中，否则会发生重影
    class func xzSetLineView(_ superview:UIView, placeType:PlaceType, width:Float = 0.5, height:Float = 0.5,otherX:Float = 0, otherY:Float = 0, offL:Double = 0.0, offR:Double = 0.0, offT:Double = 0.0, offB:Double = 0.0){
        
        let shuLine = UIView()
        shuLine.backgroundColor = UIColor.main_line
        superview.addSubview(shuLine)
        
        switch placeType {
        case .top:
            shuLine.snp.makeConstraints { (make) in
                make.height.equalTo(height)
                make.top.equalTo(superview)
                make.left.equalTo(superview).offset(offL)
                make.right.equalTo(superview).offset(offR)
            }
        case .bottom:
            shuLine.snp.makeConstraints { (make) in
                make.height.equalTo(height)
                make.bottom.equalTo(superview)
                make.left.equalTo(superview).offset(offL)
                make.right.equalTo(superview).offset(offR)
            }
        case .left:
            shuLine.snp.makeConstraints { (make) in
                make.width.equalTo(width)
                make.top.equalTo(superview).offset(offT)
                make.bottom.equalTo(superview).offset(offB)
                make.left.equalTo(superview)
            }
        case .right:
            shuLine.snp.makeConstraints { (make) in
                make.width.equalTo(width)
                make.top.equalTo(superview).offset(offT)
                make.bottom.equalTo(superview).offset(offB)
                make.right.equalTo(superview)
            }
        case .centerX:
            shuLine.snp.makeConstraints { (make) in
                make.width.equalTo(width)
                make.centerX.equalTo(superview)
                make.top.equalTo(superview).offset(offT)
                make.bottom.equalTo(superview).offset(offB)
            }
        case .centerY:
            shuLine.snp.makeConstraints { (make) in
                make.height.equalTo(height)
                make.centerY.equalTo(superview)
                make.left.equalTo(superview).offset(offL)
                make.right.equalTo(superview).offset(offR)
            }
        case .otherH:
            shuLine.snp.makeConstraints { (make) in
                make.height.equalTo(height)
                make.top.equalTo(superview).offset(otherY)
                make.left.equalTo(superview).offset(offL)
                make.right.equalTo(superview).offset(offR)
            }
        case .otherV:
            shuLine.snp.makeConstraints { (make) in
                make.width.equalTo(width)
                make.left.equalTo(superview).offset(otherX)
                make.top.equalTo(superview).offset(offT)
                make.bottom.equalTo(superview).offset(offB)
            }
        case .remove:
            shuLine.removeFromSuperview()
        }
        
    }
    
    
    //    //MARK:---- Loading
    //    enum XZ_ActivityViewType {
    //        case Loading
    //        case Botton
    //    }
    //    func xz_activityView(frame:CGRect = CGRectMake(0,100,SP_ScreenWidth,50)) {
    //        self.addSubview(activityView)
    //        activityView.frame = frame
    //        activityView.backgroundColor = UIColor.clearColor()
    //        for item in activityView.subviews {
    //            item.removeFromSuperview()
    //        }
    //
    //        let activity = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    //        activityView.addSubview(activity)
    //        activity.center = CGPoint(x: activityView.center.x - 20, y: activityView.center.y)
    //        activity.startAnimating()
    //
    //
    //        let titleLab = UILabel.xzTextBounds(CGPoint(x: activityView.center.x + 50, y: activityView.center.y), width: 100, height: 20, text: "努力加载中...", alignment: .Left, textColor: UIColor.maintext_darkgray, font: 15.0, xzFont: true)
    //        activityView.addSubview(titleLab)
    //    }
    //    func xz_activityButton(frame:CGRect = CGRectMake(0,100,SP_ScreenWidth,50)) -> UIView {
    //        activityView.frame = CGRectMake(0,100,SP_ScreenWidth,50)
    //        activityView.backgroundColor = UIColor.clearColor()
    //        for item in activityView.subviews {
    //            item.removeFromSuperview()
    //        }
    //
    //        let label = UILabel.xzTextBounds(activityView.center, width: 100, height: 35, text: "😂网络不给力，请点我重试！", textColor: UIColor.maintext_darkgray, font: 15.0, xzFont: true)
    //        label.layer.cornerRadius = 4.0
    //        label.clipsToBounds = true
    //        label.layer.borderColor = UIColor.maintext_lightgray().CGColor
    //        label.layer.borderWidth = 0.5
    //        activityView.addSubview(label)
    //        return activityView
    //    }
    
    
}

