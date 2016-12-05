//
//  FH_AdsView.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

/**
 * 需要必要的第三方库 SDWebImage 的支持
 * 必要的默认图片修改 FH_AdsView.placeholderImage = ""
 * 参数列表：
 * view 父view 必要
 * imageUrls 图片数组 必要
 * isUrlImage 是否为网络图片，默认为网络图片， 非必要，默认true
 * time 时间间隔  非必要，默认5.0秒
 * adsType 轮播图样式 非必要，默认 .default_H
 * itemSize cell 大小 非必要，默认CGSize(width:frame.size.width/2, height:frame.size.height/2)
 * pageAlignment 分页圆点的位置 非必要，默认 居中
 
 * 使用只需要执行 FH_AdsView.show()
 */

import UIKit

//MARK:---- FH_AdsView 对外接口
extension FH_AdsView {
    
    /*
     * 对外接口
     */
    class func show(_ view:UIView ,frame: CGRect,  imageUrls: [String], isUrlImage:Bool = true , time: TimeInterval = 5.0, adsType: FH_AdsViewType = .default_H, itemSize:CGSize = CGSize(width: 0, height: 0), pageAlignment:UIPageControl.PageControlAlignmentType = .center) -> FH_AdsView {
        for subView in view.subviews {
            if let adsView = subView as? FH_AdsView {
                adsView.frame = frame
                switch adsType {
                case .default_H:
                    adsView._itemSize = CGSize(width:frame.size.width, height:frame.size.height)
                default:
                    adsView._itemSize = itemSize
                    if itemSize == CGSize(width:0, height:0) {
                        adsView._itemSize = CGSize(width:frame.size.width/2, height:frame.size.height/2)
                    }
                    
                }
                adsView.pageControlAlignment = pageAlignment
                adsView._isUrlImage = isUrlImage
                adsView._imageUrls = imageUrls
                return adsView
            }
        }
        let adsView = FH_AdsView(frame: frame, adsType:adsType, time: time)
        view.addSubview(adsView)
        switch adsType {
        case .default_H:
            adsView._itemSize = CGSize(width:frame.size.width, height:frame.size.height)
        default:
            adsView._itemSize = itemSize
            if itemSize == CGSize(width:0, height:0) {
                adsView._itemSize = CGSize(width:frame.size.width/2, height:frame.size.height/2)
            }
        }
        adsView.pageControlAlignment = pageAlignment
        adsView._isUrlImage = isUrlImage
        adsView._imageUrls = imageUrls
        return adsView
    }
}
//MARK:---------- UIColor
extension UIColor {
    open class var adsTintColor1: UIColor { return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1) }
    open class var adsTintColor2: UIColor { return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.6) }
}
//MARK:---------- UIPageControl
extension UIPageControl {
    enum PageControlAlignmentType {
        case left
        case right
        case center
    }
    //设置分页圆点的位置
    fileprivate func alignment(_ type:PageControlAlignmentType, pageCount:Int, sizeW:CGFloat){
        //小圆点个数
        let page_w: CGFloat = self.size(forNumberOfPages: pageCount).width + 20
        switch type {
        case .left:
            self.frame.size.width = page_w
        case .right:
            print(self.frame.size.width)
            let page_x:CGFloat = sizeW - page_w
            self.frame.origin.x = page_x
            self.frame.size.width = page_w
        case .center:break
        }
    }
}

//MARK:---- 主体类
enum FH_AdsViewType {
    case default_H
    case half_H
    case imageBrowse_H
    case imageBrowse_V
    
}
class FH_AdsView: UIView {
    
    /// 默认的图片
    static var placeholderImage = "200x200"
    
    ///闭包传值
    var _FH_AdsViewClosures: ((_ itemIdex: Int, _ isSelect:Bool) -> Void)?
    ///collectionView
    lazy var collectionView: UICollectionView = {
        let view =  UICollectionView(frame:self.frame, collectionViewLayout: self._layout)
        view.backgroundColor = UIColor.clear
        view.dataSource  = self
        view.delegate = self
        view.showsVerticalScrollIndicator   = false  //隐藏滑动条
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true //分页显示
        
        view.register(UINib(nibName: "FH_AdsColleCell", bundle: nil), forCellWithReuseIdentifier: "FH_AdsColleCell")
        return view
    }()
    fileprivate lazy var _layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    ///分页圆点
    fileprivate var pageControlAlignment:UIPageControl.PageControlAlignmentType = .center
    fileprivate lazy var scrollPageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.frame.size.height - 20, width: self.frame.size.width, height: 20))
        //圆点颜色
        pageControl.pageIndicatorTintColor = .adsTintColor2
        pageControl.currentPageIndicatorTintColor = .adsTintColor1
        pageControl.isEnabled = false
        
        return pageControl
    }()
    ///设置一张底图
    fileprivate lazy var _imageView: UIImageView = {
        let image = UIImageView(frame: self.frame)
        image.backgroundColor = .adsTintColor2
        image.image = UIImage(named: FH_AdsView.placeholderImage)
        return image
    }()
    ///图片数据
    var _imageUrls:[String] = [] {
        didSet{
            xzSetType()
            
            if _imageUrls.count == 0 {
                _imageView.isHidden = false //显示底图
            }else{
                _imageView.isHidden = true  //隐藏底图
            }
        }
        
    }
    
    fileprivate var _adsType: FH_AdsViewType = .default_H
    fileprivate var _imaCount:Int = 0
    fileprivate var _time = 5.0
    fileprivate var _frame = CGRect.zero
    fileprivate var _sendTime: Timer!
    
    fileprivate var  itemIdex: Int = 0
    var _isUrlImage = true //是否为网络图片
    var _itemSize:CGSize {
        didSet{
            collectionView.reloadData()
        }
    }
    
    init(frame: CGRect,adsType:FH_AdsViewType, time: TimeInterval) {
        _itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        
        super.init(frame: frame)
        
        _adsType = adsType
        _time = time
        
        
        
        addSubview(_imageView)
        addSubview(collectionView)
        addSubview(scrollPageControl)
        
        if adsType == .default_H || adsType == .half_H {
            updateCollection()
        }
    }
    
    //MARK:---- 更新数据
    fileprivate func xzSetType() {
        _imaCount = _imageUrls.count * 100
        //已滚动后刷新数据不回到原点
        if itemIdex == 0 {
            itemIdex = _imaCount/2
        }
        if itemIdex > _imaCount {
            itemIdex = _imaCount/2
        }
        //时间
        if _imageUrls.count < 2 && _sendTime != nil {
            _sendTime.invalidate()
            _sendTime = nil
        }else if _imageUrls.count >= 2 && _sendTime == nil {
            self.updateCollection()
        }
        if _adsType == .imageBrowse_H || _adsType == .imageBrowse_V {
            _imaCount = _imageUrls.count
            itemIdex = 0
        }
        scrollPageControl.numberOfPages = _imageUrls.count // 页数
        scrollPageControl.alignment(pageControlAlignment, pageCount:_imageUrls.count, sizeW:self.frame.size.width)
        
        // --- 分页圆点
        if _imageUrls.count > 1 {
            scrollPageControl.isHidden = false
        }else{
            scrollPageControl.isHidden = true
        }
        
        if _adsType == .default_H && _imageUrls.count > 1 {
            collectionView.isPagingEnabled = true //分页显示
            collectionView.bounces = false     // 关闭弹簧
            _layout.scrollDirection = .horizontal
        }
        if _adsType == .half_H && _imageUrls.count > 1 {
            _layout.scrollDirection = .horizontal
            scrollPageControl.isHidden = true
        }
        if _adsType == .imageBrowse_H  {
            _layout.scrollDirection = .horizontal
            scrollPageControl.isHidden = true
        }
        if _adsType == .imageBrowse_V {
            _layout.scrollDirection = .vertical
            scrollPageControl.isHidden = true
        }
        
        collectionView.reloadData()
        
        if _imaCount > 0 && itemIdex < _imaCount {
            let indexPath = IndexPath(row: itemIdex, section: 0) // 从中间开始
            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            changePageValue()
        }
        
        
    }
    
    
    
    
    //MARK:---------- 改变分页圆点
    fileprivate func changePageValue() {
        scrollPageControl.currentPage = itemIdex % _imageUrls.count
        self._FH_AdsViewClosures?(itemIdex % self._imageUrls.count, false)
    }
    
    //MARK:---------- 轮循 更新 item
    fileprivate func updateCollection()  {
        if _time > 0 {
            _sendTime = Timer.scheduledTimer(timeInterval: self._time, target: self, selector:#selector(self.timerClosure), userInfo: nil, repeats: true)
            RunLoop.current.add(_sendTime, forMode: .commonModes)
        }
    }
    func timerClosure() {
        //滚动到某一个 item
        if self._adsType == .default_H {
            let indexPath = IndexPath(row: self.itemIdex, section: 0)
            
            if self.itemIdex == self._imaCount/2 {
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
            }else{
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
            }
            self.changePageValue()
            
            self.itemIdex += 1
            if self.itemIdex > self._imaCount - 1{
                self.itemIdex = self._imaCount/2
            }
        }
        if self._adsType == .half_H {
            let indexPath = IndexPath(row: self.itemIdex, section: 0)
            if self.itemIdex == self._imaCount/2 {
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
            }else{
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
            }
            self.changePageValue()
            
            self.itemIdex += 1
            if self.itemIdex > self._imaCount - 1{
                self.itemIdex = self._imaCount/2
            }
        }
    }
    
    
    
    
    func makePerspectiveTransform() -> CATransform3D {
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -2000;
        return transform;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK:---------- UICollectionViewDelegate
extension FH_AdsView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return _imaCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FH_AdsColleCell", for: indexPath) as! FH_AdsColleCell
        
        switch _adsType {
        case .default_H,.half_H:
            cell.model(name: _imageUrls[indexPath.item % _imageUrls.count], isUrlImage:_isUrlImage)
        default:
            cell.model(name: _imageUrls[indexPath.item % _imageUrls.count], isUrlImage:_isUrlImage)
        }
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        _FH_AdsViewClosures?(indexPath.item % _imageUrls.count, true)
    }
    //开始拖曳
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (_adsType == .default_H || _adsType == .half_H) && _sendTime != nil {
            _sendTime.invalidate()
            _sendTime = nil
        }
        
    }
    //结束拖曳
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (_adsType == .default_H || _adsType == .half_H) && _imageUrls.count > 1 && _sendTime == nil {
            self.updateCollection()
        }
        
    }
    //惯性滑动结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if _adsType == .default_H {
            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
            let pInView = self.convert(self.collectionView.center, to: self.collectionView)
            // 获取这一点的indexPath
            let indexPathNow = self.collectionView.indexPathForItem(at: pInView)
            // 赋值给记录当前坐标的变量
            self.itemIdex = (indexPathNow?.item)!
            
            // 更新数据
            self.changePageValue()
            // ...
        }
        if _adsType == .half_H {
            // 获取当前显示的cell的下标
            let lastIndexPath = self.collectionView.indexPathsForVisibleItems.first
            print(lastIndexPath?.item ?? "没有值")
            self.itemIdex = (lastIndexPath?.item)!
            // 更新数据
            self.changePageValue()
            // ...
        }
        
        
    }
    
    // collectionView分页滚动完毕时候调用
    //    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //
    //        if _adsType == .default_H {
    //            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    //            let pInView = self.convert(self.collectionView.center, to: self.collectionView)
    //            // 获取这一点的indexPath
    //            let indexPathNow = self.collectionView.indexPathForItem(at: pInView)
    //            // 赋值给记录当前坐标的变量
    //            self.itemIdex = (indexPathNow?.item)!
    //
    //            // 更新数据
    //            self.changePageValue()
    //            // ...
    //        }
    //        if _adsType == .half_H {
    //            // 获取当前显示的cell的下标
    //            let lastIndexPath = self.collectionView.indexPathsForVisibleItems.first
    //            print(lastIndexPath?.item)
    //            self.itemIdex = (lastIndexPath?.item)!
    //            // 更新数据
    //            self.changePageValue()
    //            // ...
    //        }
    //
    //    }
    
    //MARK:---------- UICollectionViewDelegateFlowLayout
    //布局确定每个Item 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return _itemSize
    }
    //布局确定每个section内的Item距离section四周的间距 UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //返回每个section内上下两个Item之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if _adsType == .half_H {
            return frame.size.width - (_itemSize.width * 2)
        }
        if _adsType == .imageBrowse_V {//上下
            //可视范围内的上下item个数
            let num_item = Int(frame.size.height/_itemSize.height)
            //可视范围内的间距个数
            let num_spacing = Int(frame.size.height/_itemSize.height) > 1 ?  Int(frame.size.height/_itemSize.height) - 1 : Int(frame.size.height/_itemSize.height)
            //可视范围内间距总高度
            let H = frame.size.height - _itemSize.height * CGFloat(num_item)
            //可视范围内间距高度
            let HH = H/CGFloat(num_spacing)
            return HH
            
        }
        if _adsType == .imageBrowse_H {//左右
            //可视范围内的上下item个数
            let num_item = Int(frame.size.width/_itemSize.width)
            //可视范围内的间距个数
            let num_spacing = Int(frame.size.width/_itemSize.width) > 1 ?  Int(frame.size.width/_itemSize.width) - 1 : Int(frame.size.width/_itemSize.width)
            //可视范围内间距总高度
            let W = frame.size.width - _itemSize.width * CGFloat(num_item)
            //可视范围内间距高度
            let WW = W/CGFloat(num_spacing)
            return WW
        }
        return 0;
    }
    //返回每个section内左右两个Item之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if _adsType == .half_H {
            return 0
        }
        if _adsType == .imageBrowse_V{//左右
            //可视范围内的上下item个数
            let num_item = Int(frame.size.width/_itemSize.width)
            //可视范围内的间距个数
            let num_spacing = Int(frame.size.width/_itemSize.width) > 1 ?  Int(frame.size.width/_itemSize.width) - 1 : Int(frame.size.width/_itemSize.width)
            //可视范围内间距总高度
            let W = frame.size.width - _itemSize.width * CGFloat(num_item)
            //可视范围内间距高度
            let WW = W/CGFloat(num_spacing)
            return WW
        }
        if _adsType == .imageBrowse_H {//上下
            //可视范围内的上下item个数
            let num_item = Int(frame.size.height/_itemSize.height)
            //可视范围内的间距个数
            let num_spacing = Int(frame.size.height/_itemSize.height) > 1 ?  Int(frame.size.height/_itemSize.height) - 1 : Int(frame.size.height/_itemSize.height)
            //可视范围内间距总高度
            let H = frame.size.height - _itemSize.height * CGFloat(num_item)
            //可视范围内间距高度
            let HH = H/CGFloat(num_spacing)
            return HH
        }
        
        return 0;
    }
    //MARK:---- 核心动画
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}
