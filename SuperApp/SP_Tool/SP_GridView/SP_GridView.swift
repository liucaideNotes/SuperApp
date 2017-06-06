//
//  SP_GridView.swift
//  IEXBUY
//
//  Created by sifenzi on 16/7/14.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
// 九宫格
/**
 *在tableView中添加collectionView，如果单页显示的collectionViewCell过多，在滚动时会有卡顿感，体验不好，因此自制一个类似collectionView的九宫格，淡然这个九宫格只是用于如：类别按钮，的显示
 
 *我们只提供一个接口 SP_GridView.show(.....)
 
 *datas  是个元组，里面包含：
  ----- eachNum 单页单行个数
  ----- row     单页行数
  ----- space   间距
  ----- margin  四周的边距
  ----- images 图片名
  ----- titles 名
  ----- angles 角标名
 *block 点击回调

 **/

import UIKit
import SnapKit

class SP_GridView: UIView, UIScrollViewDelegate {
    var _block: ((_ index:Int) -> Void)?
    fileprivate lazy var _row:Int = 1 // 行数
    lazy var _eachNum = 5 // 单行个数
    fileprivate lazy var _itemNum = 0  // 个数
    fileprivate lazy var _isPaging = false  // 是否分页
    fileprivate lazy var _pageNum = 1  // 页数
    fileprivate lazy var _WW:CGFloat = 0.0 // 单个item宽
    fileprivate lazy var _HH:CGFloat = 0.0 // 单个item高
    //间距
    fileprivate var _space:CGFloat = 5.5
    //边距
    fileprivate var _margin:(top:CGFloat,left:CGFloat) = (0.0,0.0)
    
    open lazy var placeholderImage = "placeholderImage"
    open var _images:[String] = []
    open var _titles: [String] = []
    open var _angles: [String] = []
    open lazy var _pageView:UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.yellow
        return view
    }()
    
    open lazy var _scrollView:UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        //view.backgroundColor = UIColor.red
        view.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        view.delegate = self
        return view
    }()
    open lazy var _pageControl:UIPageControl = {
        let page = UIPageControl()
        page.frame = CGRect(x: 0, y: self.frame.size.height - 15, width: self.frame.size.width, height: 10)
        page.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
        page.currentPageIndicatorTintColor = UIColor.white
        
        page.currentPage = 0
        return page
    }()
    //MARK:--- 背景图片
    fileprivate lazy var _bgImageView:UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    fileprivate func setBgImage(_ name:String, color:UIColor) {
        _bgImageView.sp_ImageName(name)
        
        _bgImageView.backgroundColor = color
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(_bgImageView)
        _bgImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.addSubview(_scrollView)
        _scrollView.addSubview(_pageView)
        _scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.addSubview(_pageControl)
        
        makeFrame()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK:--- 设置坐标
    fileprivate func makeFrame(){
        
        var ww:CGFloat = self.bounds.size.width
        if !_isPaging {
            _scrollView.bounces = false
            _pageControl.isHidden = true
        }else{
            ww = CGFloat(_pageNum) * self.bounds.size.width
            _scrollView.bounces = true
            _pageControl.isHidden = false
        }
        print(_pageNum)
        print(_isPaging)
        print(ww)
        _pageControl.numberOfPages = self._pageNum
        _pageView.frame = CGRect(x:0,y:0,width:ww,height:self.bounds.size.height)
        
        _scrollView.contentSize = CGSize(width: ww, height: self.bounds.size.height)
    }
    //MARK:--- 设置 单元格
    func makeSubUI() {
        guard _itemNum != _pageView.subviews.count else {
            return
        }
        for item in _pageView.subviews {
            item.removeFromSuperview()
        }
        _WW = (frame.size.width-_margin.left*2-_space*CGFloat(_eachNum-1 < 0 ? 0 : _eachNum-1))/CGFloat(_eachNum)
        _HH = (frame.size.height-_margin.top*2-_space*(_row == 1 ? 0 : CGFloat(_row-1)))/CGFloat(_row)
        
        for  i in 0..<_itemNum {
            // 如果用 UIButton 做底，不规则的图片不好控制
            let bgView = UIView()
            _pageView.addSubview(bgView)
            bgView.tag = i
            //bgView.backgroundColor = i%2==0 ? UIColor.gray : UIColor.yellow
            //点击手势
            let viewTap = UITapGestureRecognizer(target: self, action: #selector(SP_GridView.viewTapClick(_:)))
            bgView.addGestureRecognizer(viewTap)
            //长按手势
            let viewLongPress = UILongPressGestureRecognizer(target: self, action: #selector(SP_GridView.longPressClick(_:)))
            viewLongPress.minimumPressDuration = 0.2
            bgView.addGestureRecognizer(viewLongPress)
            
            
            let page = Int(i/(_row*_eachNum))
            
            
            let xx = CGFloat(i%_eachNum) * (_WW + _space) + _margin.left + (CGFloat(page)*frame.size.width)
            
            var yy = CGFloat(i/_eachNum) * (_HH + _space) + _margin.top
            if i%(_row*_eachNum)<_eachNum {
                yy = _margin.top
            }else{
                yy = CGFloat((i%(_row*_eachNum))/_eachNum) * (_HH + _space) + _margin.top
            }
            
            bgView.frame = CGRect(x: xx,y: yy,width: _WW,height: _HH)
            
            
        }
    }
    // -- 点击
    func viewTapClick(_ tap:UITapGestureRecognizer)  {
        
        _block?((tap.view?.tag)!)
    }
    // -- 长按
    fileprivate var longPressEnabled = true
    open var longPressRemve = false
    func longPressClick(_ longPress:UILongPressGestureRecognizer)  {
        guard !longPressRemve else {
            return
        }
        switch longPress.state {
        case .began:
            longPress.view?.backgroundColor = UIColor.main_bg
            longPressEnabled = true
            self.perform(#selector(SP_GridView.endTime), with: self, afterDelay: 0.5)
        case .changed:break
            
        case .ended:
            longPress.view?.backgroundColor = UIColor.white
            if longPressEnabled {
                _block?((longPress.view?.tag)!)
            }
        default:
            break
        }
    }
    func endTime() {
        longPressEnabled = false
    }
    //MARK:--- scrollViewDidEndDecelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _pageControl.currentPage = Int(scrollView.contentOffset.x/self.frame.size.width)
    }
    
    
    
    //MARK:--- 更新坐标 不分页
    open func updateFrames() {
        var ww:CGFloat = self.bounds.size.width
        
        ww = CGFloat(_pageNum) * self.bounds.size.width
        if _pageNum > 1 && _itemNum%(_eachNum*_row) < _eachNum && _itemNum%(_eachNum*_row) != 0 {
            //单个subview宽
            let ww_1:CGFloat = ((frame.size.width-_margin.left-_space*CGFloat(_eachNum < 0 ? 0 : _eachNum))/CGFloat(_eachNum))
            let ww_2:CGFloat = _margin.left + _space*CGFloat(_itemNum%(_eachNum*_row))
            let www:CGFloat =  CGFloat(_itemNum%(_eachNum*_row)) * ww_1 + ww_2
            ww = CGFloat(_pageNum-1) * self.bounds.size.width + www
        }
        
        _scrollView.showsHorizontalScrollIndicator = true
        _scrollView.isPagingEnabled = false
        _pageControl.isHidden = true
        _scrollView.bounces = true
        _pageControl.numberOfPages = self._pageNum
        _pageView.frame = CGRect(x:0,y:0,width:ww,height:self.bounds.size.height)
        
        _scrollView.contentSize = CGSize(width: ww, height: self.bounds.size.height)
        
        _WW = (frame.size.width-_margin.left*2-_space*CGFloat(_eachNum < 0 ? 0 : _eachNum))/CGFloat(_eachNum)
        _HH = (frame.size.height-_margin.top*2-_space*(_row == 1 ? 0 : CGFloat(_row-1)))/CGFloat(_row)
        for (i,item) in _pageView.subviews.enumerated() {
            let page = Int(i/(_row*_eachNum))
            var xx = CGFloat(i%_eachNum) * (_WW + _space) + _space + (CGFloat(page)*frame.size.width)
            if page == 0 {
                xx = CGFloat(i%_eachNum) * (_WW + _space) + _margin.left + (CGFloat(page)*frame.size.width)
            }
            var yy = CGFloat(i/_eachNum) * (_HH + _space) + _margin.top
            if i%(_row*_eachNum)<_eachNum {
                yy = _margin.top
            }else{
                yy = CGFloat((i%(_row*_eachNum))/_eachNum) * (_HH + _space) + _margin.top
            }
            item.frame = CGRect(x: xx,y: yy,width: _WW,height: _HH)
        }
    }

    //MARK:--- 更新 单元格 坐标，
    open func updateCellFrames(_ height:CGFloat) {
        _HH = height
        let yyyy = (CGFloat(_row-1) * _space+_margin.top + CGFloat(_row)*height)
        _pageControl.frame = CGRect(x: 0, y: yyyy, width: self.frame.size.width, height: 10)
        for (i,item) in _pageView.subviews.enumerated() {
            let page = Int(i/(_row*_eachNum))
            var xx = CGFloat(i%_eachNum) * (_WW + _space) + _space + (CGFloat(page)*frame.size.width)
            if page == 0 {
                xx = CGFloat(i%_eachNum) * (_WW + _space) + _margin.left + (CGFloat(page)*frame.size.width)
            }
            var yy = CGFloat(i/_eachNum) * (_HH + _space) + _margin.top
            if i%(_row*_eachNum)<_eachNum {
                yy = _margin.top
            }else{
                yy = CGFloat((i%(_row*_eachNum))/_eachNum) * (_HH + _space) + _margin.top
            }
            item.frame = CGRect(x: xx,y: yy,width: _WW,height: _HH)
        }
    }
    
    
}

extension SP_GridView {
    class func show(_ frame:CGRect, superView:UIView, datas:(eachNum:Int,row:Int,space:CGFloat,margin:(top:CGFloat,left:CGFloat),images:(name:[String], placeholderImage:String), titles:[String], angles:[String]) = (5,1,0.0,(0,0),([],""),[],[]), bgImage:(name:String,color:UIColor) = ("",.clear), block:@escaping ((_ index:Int)->Void)) -> SP_GridView {
        for subview in superView.subviews {
            if let item = subview as? SP_GridView {
                //首先进行处理
                item.frame = frame
                item._eachNum = datas.eachNum
                item._itemNum = datas.images.name.count > datas.titles.count ? datas.images.name.count : datas.titles.count
                item._space = datas.space
                item._margin = datas.margin
                item._images  = datas.images.name
                item._titles  = datas.titles
                item._angles  = datas.angles
                item.placeholderImage = datas.images.placeholderImage
                item.setBgImage(bgImage.name, color:bgImage.color)
                if datas.images.name.count > datas.titles.count && datas.titles.count > 0 {
                    for _ in 0 ..< datas.images.name.count-datas.titles.count {
                        item._titles.append("")
                    }
                }else if datas.images.name.count < datas.titles.count && datas.images.name.count > 0{
                    for _ in 0 ..< datas.titles.count-datas.images.name.count {
                        item._images.append(datas.images.placeholderImage)
                    }
                }
                guard item._itemNum > 0 else {return item}
                guard item._eachNum > 0 else {return item}
                
                if datas.row*item._eachNum < item._itemNum {
                    item._isPaging = true
                    item._row = datas.row
                    item._pageNum = item._itemNum/(datas.row*item._eachNum) + (item._itemNum%(datas.row*item._eachNum)>0 ? 1 : 0)
                }else{
                    item._row = Int(item._itemNum/item._eachNum) + (item._itemNum%item._eachNum>0 ? 1 : 0)
                }
                item._block   = block
                item.makeFrame()
                item.makeSubUI()
                return item
            }
        }
        
        let item = SP_GridView(frame:frame)
        superView.addSubview(item)
        item.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        //首先进行处理
        item._eachNum = datas.eachNum
        item._itemNum = datas.images.name.count > datas.titles.count ? datas.images.name.count : datas.titles.count
        item._space = datas.space
        item._margin = datas.margin
        item._images  = datas.images.name
        item._titles  = datas.titles
        item._angles  = datas.angles
        item.placeholderImage = datas.images.placeholderImage
        item.setBgImage(bgImage.name, color:bgImage.color)
        if datas.images.name.count > datas.titles.count {
            for _ in 0 ..< datas.images.name.count-datas.titles.count {
                item._titles.append("")
            }
        }else if datas.images.name.count < datas.titles.count{
            for _ in 0 ..< datas.titles.count-datas.images.name.count {
                item._images.append(datas.images.placeholderImage)
            }
        }
        guard item._itemNum > 0 else {return item}
        guard item._eachNum > 0 else {return item}
        
        if datas.row*item._eachNum < item._itemNum {
            item._isPaging = true
            item._row = datas.row
            item._pageNum = item._itemNum/(datas.row*item._eachNum) + (item._itemNum%(datas.row*item._eachNum)>0 ? 1 : 0)
        }else{
            item._row = Int(item._itemNum/item._eachNum) + (item._itemNum%item._eachNum>0 ? 1 : 0)
        }
        item._block   = block
        item.makeFrame()
        item.makeSubUI()
        return item
    }
}


