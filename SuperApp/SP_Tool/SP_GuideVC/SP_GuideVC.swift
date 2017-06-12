//
//  SP_GuideVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/11/1.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit
// -- 图片名称
private let launch_Images = ["firstOpen_0","firstOpen_1","firstOpen_2"]

class SP_GuideVC: UIViewController {

    var SP_firstOpenBlock: ((_ isOk:Bool) -> Void)?
    //MARK:----------- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        // --- collectionView
        self.view.addSubview(collectionView)
        collectionViewRegister()
        // --- 分页圆点
        self.view.addSubview(scrollPageControl)
    }

    //MARK:---------- 设置collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collecView =  UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collecView.backgroundColor = .clear
        collecView.dataSource  = self
        collecView.delegate = self
        collecView.showsVerticalScrollIndicator   = false
        collecView.showsHorizontalScrollIndicator = false
        collecView.isPagingEnabled = true //分页显示
        collecView.bounces = false
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: sp_ScreenWidth, height: sp_ScreenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return collecView
    }()
    //MARK:----------- collectionViewCell注册
    private func collectionViewRegister() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "LaunchCell")
    }
    //MARK:---------- 设置分页圆点
    private lazy var  scrollPageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x:10, y:sp_ScreenHeight - 20, width:sp_ScreenWidth - 20, height:20))
        pageControl.numberOfPages = launch_Images.count // 页数
        //圆点颜色
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.isEnabled = false
        return pageControl
    }()
    
    //MARK:---------- 改变分页圆点
    fileprivate func changePageValue(index:Int) {
        scrollPageControl.currentPage = index % launch_Images.count
    }
    //MARK:---------- 立即体验按钮
    fileprivate lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.setTitle("立即体验", for: .normal)
        button.addTarget(self, action: #selector(SP_GuideVC.experienceClick), for: .touchUpInside)
        return button
    }()
    //MARK:---------- 立即体验按钮动画
    fileprivate func startButtonAnimation() {
        startButton.isHidden = false
        // 把按钮的 transform 缩放设置为0
        startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform = .identity
        }) { (_) -> Void in
            
        }
    }
    //MARK:---------- 立即体验按钮点击
    func experienceClick() {
        SP_firstOpenBlock?(true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SP_GuideVC:UICollectionViewDelegate,UICollectionViewDataSource {
    //MARK:---------- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launch_Images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCell", for: indexPath)
        for item in cell.subviews {
            item.removeFromSuperview()
        }
        
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = UIImage(named: launch_Images[indexPath.row])
        cell.addSubview(imageView)
        
        
        if indexPath.row == launch_Images.count - 1 {
            //startButton.isHidden = true
            cell.addSubview(startButton)
            // 关闭autoresizing 不关闭否则程序崩溃
            startButton.translatesAutoresizingMaskIntoConstraints = false
            //宽度约束
            let width:NSLayoutConstraint = NSLayoutConstraint(item: startButton, attribute: .width, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:0.0, constant:100)
            startButton.addConstraint(width)//自己添加约束
            //底部约束
            let bottom:NSLayoutConstraint = NSLayoutConstraint(item: startButton, attribute: .bottom, relatedBy:.equal, toItem:cell, attribute:.bottom, multiplier:1.0, constant: -40)
            startButton.superview!.addConstraint(bottom)//父控件添加约束
            //中线约束
            let centerX:NSLayoutConstraint = NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy:.equal, toItem:cell, attribute:.centerX, multiplier:1.0, constant: 0)
            startButton.superview!.addConstraint(centerX)//父控件添加约束
            //            使用 SnapKit 第三方添加约束
            //            startButton.snp.makeConstraints({ (make) in
            //                make.centerX.equalTo(cell)
            //                make.width.equalTo(100)
            //                make.bottom.equalTo(-40)
            //            })
            
        }
        return cell
        
    }
    
    // collectionView分页滚动完毕时候调用
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 正在显示的cell的indexPath
        let showIndexPath = collectionView.indexPathsForVisibleItems.first!
        // 更新分页圆点
        self.changePageValue(index: showIndexPath.item)
        // 最后一页动画
        startButton.isHidden = true
        if showIndexPath.item == launch_Images.count - 1 {
            // 开始按钮动画
            startButtonAnimation()
        }
        
    }
    // MARK: - 惯性滑动结束 - 效果是一样的
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 将collectionView在控制器view的中心点转化成collectionView上的坐标
        let pInView = self.view.convert(self.collectionView.center, to: self.collectionView)
        // 获取这一点的indexPath
        let indexPathNow = self.collectionView.indexPathForItem(at: pInView)
        // 赋值给记录当前坐标的变量
        
        // 更新分页圆点
        self.changePageValue(index: (indexPathNow?.item)!)
        // 最后一页动画
        startButton.isHidden = true
        if indexPathNow?.item == launch_Images.count - 1 {
            // 开始按钮动画
            startButtonAnimation()
        }
    }

}
