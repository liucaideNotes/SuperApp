//
//  SP_MJRefresh.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/2.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation

/*
 1,需要添加第三方库 MJRefresh 支持
 2,在桥接文件中添加 #import "MJRefresh.h"
 3,如需自定义刷新控件的文字或图片可在SP_MJRefreshDatas类中设置
 4,SP_MJDIYHeader 类用于完全自定义下拉头部View
   SP_MJDIYAutoFooter、SP_MJDIYBackFooter 两个类用于完全自定义上拉底部View
   可在类中自由编写
 4,使用
//没有添加这个扩展类使用 MJRefresh 如下
func addMJHeaderAndFooter() {
    tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
        // 模拟延迟加载数据，2秒后才调用（
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            self.tableView.mj_header.endRefreshing()
        }
    })
    tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
    })
}
func EndRefresh()  {
    tableView.mj_header.endRefreshing()
    tableView.mj_footer.endRefreshing()
    
}
func footerEndRefreshNoMoreData() {
    tableView.mj_footer.endRefreshingWithNoMoreData()
}
//添加这个扩展类之后使用 MJRefresh 方法如下，（只是使MJRefresh使用更加清晰，统一管理）
func addMJHeaderAndFooter() {
    tableView.headerAddMJRefresh { [unowned self]() -> Void in
        // 模拟延迟加载数据，2秒后才调用（
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            self.tableView.headerEndRefresh()
        }
        
    }
    tableView.footerAddMJRefresh { [unowned self]() -> Void in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            self.tableView.footerEndRefreshNoMoreData()
        }
        
    }
}
func endRefresh()  {
    tableView.headerEndRefresh()
    tableView.footerEndRefresh()
}
func footerEndRefreshNoMoreData() {
    tableView.footerEndRefreshNoMoreData()
}
*/

//为什么扩展UIScrollView，你懂的
//MARK:----------- 顶部下拉刷新
extension UIScrollView {
    //MARK:----------- 添加顶部刷新 -- 普通
    func sp_headerAddMJRefresh(_ block:@escaping MJRefreshComponentRefreshingBlock)  {
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        //是否隐藏
        header?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Down
        header?.lastUpdatedTimeLabel.isHidden = MJRefreshDIY_TimeLabelHidden
        
        if !MJRefreshDIY_StateLabelHidden_Down {
            //设置文字
            header?.setTitle(MJRefreshDIY_Title_Idle_Down, for: .idle)
            header?.setTitle(MJRefreshDIY_Title_Pulling_Down, for: .pulling)
            header?.setTitle(MJRefreshDIY_Title_Refreshing_Down, for: .refreshing)
            ///设置字体
            header?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            header?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        if !MJRefreshDIY_TimeLabelHidden {
            header?.lastUpdatedTimeLabel.font = MJRefreshDIY_TimeLabelFont
            header?.lastUpdatedTimeLabel.textColor = MJRefreshDIY_TimeLabelColor
        }
        header?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        
        self.mj_header = header
        
    }
    //MARK:----------- 添加顶部刷新 -- 动态
    func sp_headerAddMJRefreshGif(_ block:@escaping MJRefreshComponentRefreshingBlock)  {
        let header = MJRefreshGifHeader(refreshingBlock: block)
        
        header?.setImages(MJRefreshDIY_Images_Idle_Down, for: .idle)
        header?.setImages(MJRefreshDIY_Images_Pulling_Down, for: .pulling)
        header?.setImages(MJRefreshDIY_Images_Refreshing_Down, for: .refreshing)
        
        //是否隐藏
        header?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Down
        header?.lastUpdatedTimeLabel.isHidden = MJRefreshDIY_TimeLabelHidden
        
        if !MJRefreshDIY_StateLabelHidden_Down {
            //设置文字
            header?.setTitle(MJRefreshDIY_Title_Idle_Down, for: .idle)
            header?.setTitle(MJRefreshDIY_Title_Pulling_Down, for: .pulling)
            header?.setTitle(MJRefreshDIY_Title_Refreshing_Down, for: .refreshing)
            ///设置字体
            header?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            header?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        if !MJRefreshDIY_TimeLabelHidden {
            header?.lastUpdatedTimeLabel.font = MJRefreshDIY_TimeLabelFont
            header?.lastUpdatedTimeLabel.textColor = MJRefreshDIY_TimeLabelColor
        }
        header?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        
        self.mj_header = header
    }
    //MARK:----------- 添加顶部刷新 -- 完全自定义
    func sp_headerAddMJRefreshDIY(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        self.mj_header = SP_MJDIYHeader(refreshingBlock: block)
    }
    //MARK:----------- 调用顶部刷新
    func sp_headerBeginRefresh() {
        self.mj_header.beginRefreshing()
    }
    //MARK:----------- 取消顶部刷新状态
    func sp_headerEndRefresh() {
        self.mj_header.endRefreshing()
    }
    //MARK:----------- 调用底部刷新
    func sp_footerBeginRefresh() {
        self.mj_footer.beginRefreshing()
    }
    
    //MARK:----------- 取消底部刷新状态
    func sp_footerEndRefresh() {
        self.mj_footer.endRefreshing()
    }
    //MARK:----------- 取消底部刷新状态并显示无数据并停用上拉刷新
    func sp_footerEndRefreshNoMoreData() {
        self.mj_footer.endRefreshingWithNoMoreData()
    }
    //MARK: 重置无数据状态(如果执行了footerEndRefreshNoMoreData(),可用此方法开启上拉)
    func sp_footerResetNoMoreData() {
        self.mj_footer.resetNoMoreData()
    }
   
}
//MARK:----------- 底部上拉刷新
extension UIScrollView {
    //MARK:-- 添加底部刷新 -- 普通自动刷新
    func sp_footerAddMJRefresh_Auto(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        let header = MJRefreshAutoNormalFooter(refreshingBlock: block)
        //是否隐藏
        header?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Up
        if !MJRefreshDIY_StateLabelHidden_Up {
            //设置文字
            header?.setTitle(MJRefreshDIY_Title_Idle_Up, for: .idle)
            header?.setTitle(MJRefreshDIY_Title_Pulling_Up, for: .pulling)
            header?.setTitle(MJRefreshDIY_Title_Refreshing_Up, for: .refreshing)
            header?.setTitle(MJRefreshDIY_Title_NoMoreData_Up, for: .noMoreData)
            ///设置字体
            header?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            header?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        header?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        self.mj_footer = header
    }
    //MARK:-- 添加底部刷新 -- 普通手动刷新
    func sp_footerAddMJRefresh_Back(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        let header = MJRefreshBackNormalFooter(refreshingBlock: block)
        //是否隐藏
        header?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Up
        if !MJRefreshDIY_StateLabelHidden_Up {
            //设置文字
            header?.setTitle(MJRefreshDIY_Title_Idle_Up, for: .idle)
            header?.setTitle(MJRefreshDIY_Title_Pulling_Up, for: .pulling)
            header?.setTitle(MJRefreshDIY_Title_Refreshing_Up, for: .refreshing)
            header?.setTitle(MJRefreshDIY_Title_NoMoreData_Up, for: .noMoreData)
            ///设置字体
            header?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            header?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        header?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        self.mj_footer = header
    }
    //MARK:-- 添加底部刷新 -- 动态自动
    func sp_footerAddMJRefreshGif_Auto(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        let footer = MJRefreshAutoGifFooter(refreshingBlock: block)
        footer?.setImages(MJRefreshDIY_Images_Idle_Up, for: .idle)
        footer?.setImages(MJRefreshDIY_Images_Pulling_Up, for: .pulling)
        footer?.setImages(MJRefreshDIY_Images_Refreshing_Up, for: .refreshing)
        footer?.setImages(MJRefreshDIY_Images_NoMoreData_Up, for: .noMoreData)
        
        //是否隐藏
        footer?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Up
        
        if !MJRefreshDIY_StateLabelHidden_Up {
            //设置文字
            footer?.setTitle(MJRefreshDIY_Title_Idle_Up, for: .idle)
            footer?.setTitle(MJRefreshDIY_Title_Pulling_Up, for: .pulling)
            footer?.setTitle(MJRefreshDIY_Title_Refreshing_Up, for: .refreshing)
            footer?.setTitle(MJRefreshDIY_Title_NoMoreData_Up, for: .noMoreData)
            ///设置字体
            footer?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            footer?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        footer?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        self.mj_footer = footer
    }
    //MARK:-- 添加底部刷新 -- 动态手动
    func sp_footerAddMJRefreshGif_Back(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        let footer = MJRefreshBackGifFooter(refreshingBlock: block)
        footer?.setImages(MJRefreshDIY_Images_Idle_Up, for: .idle)
        footer?.setImages(MJRefreshDIY_Images_Pulling_Up, for: .pulling)
        footer?.setImages(MJRefreshDIY_Images_Refreshing_Up, for: .refreshing)
        footer?.setImages(MJRefreshDIY_Images_NoMoreData_Up, for: .noMoreData)
        //是否隐藏
        footer?.stateLabel.isHidden = MJRefreshDIY_StateLabelHidden_Up
        
        if !MJRefreshDIY_StateLabelHidden_Up {
            //设置文字
            footer?.setTitle(MJRefreshDIY_Title_Idle_Up, for: .idle)
            footer?.setTitle(MJRefreshDIY_Title_Pulling_Up, for: .pulling)
            footer?.setTitle(MJRefreshDIY_Title_Refreshing_Up, for: .refreshing)
            footer?.setTitle(MJRefreshDIY_Title_NoMoreData_Up, for: .noMoreData)
            ///设置字体
            footer?.stateLabel.font = MJRefreshDIY_StateLabelFont
            //设置颜色
            footer?.stateLabel.textColor = MJRefreshDIY_StateLabelColor
        }
        footer?.labelLeftInset = MJRefreshDIY_LabelLeftInset
        self.mj_footer = footer
    }
    //MARK:-- 添加底部刷新 -- 完全自定义自动刷新
    func sp_footerAddMJRefreshDIY_Auto(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        self.mj_footer = SP_MJDIYAutoFooter(refreshingBlock: block)
    }
    //MARK:-- 添加底部刷新 -- 完全自定义手动刷新
    func sp_footerAddMJRefreshDIY_Back(_ block:@escaping MJRefreshComponentRefreshingBlock) {
        self.mj_footer = SP_MJDIYBackFooter(refreshingBlock: block)
    }

}
