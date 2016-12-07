//
//  SP_TabBarController.swift
//  IEXBUY
//
//  Created by 刘才德 on 2016/11/4.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

/**
 * 默认样式集中写法
 *
 */

import UIKit
import SnapKit
/**
 * NavigationController
 *
 */
class SP_NavigationController: UINavigationController,UINavigationControllerDelegate {
    
    var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    //UINavigationControllerDelegate方法 -- 解决自定义返回键 右划返回手势失效
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
/**
 * TabBarController
 *
 */
class SP_TabBarController: UITabBarController {
    
    class func initTabbar(_ viewControllers:[UIViewController], titles:[String], images:[String], selectedImages:[String], selectedIndex:Int = 0) -> SP_TabBarController {
       
        let tabbar = SP_TabBarController()
        
        tabbar._titles = titles
        tabbar._images = images
        tabbar._selectedImages = selectedImages
        tabbar._selectedIndex = selectedIndex
        
        tabbar._viewControllers = viewControllers
        
        return tabbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLine()
    }
    ///tabbar标签对应的控制器
    fileprivate var _viewControllers:[UIViewController] = [] {
        didSet{
            makeTabBar()
        }
    }
    ///tabbar标签
    private var _titles:[String] = []
    ///tabbar标签图片
    private var _images:[String] = []
    ///tabbar标签选中图片
    private var _selectedImages:[String] = []
    ///tabbar初始选中标签
    private var _selectedIndex = 0
    private var navigations    = [SP_NavigationController]()
    ///是否隐藏navigationbar
    open var _naviBarHidden = false {
        didSet{
            for item in navigations {
                item.isNavigationBarHidden = _naviBarHidden
            }
        }
    }
    
    ///标签颜色
    open var _colorNormal   = UIColor.gray {
        didSet{
            for item in self.tabBar.items! {
                item.setTitleTextAttributes(
                    [NSFontAttributeName:UIFont.systemFont(ofSize: _titleFontNormal),NSForegroundColorAttributeName:_colorNormal], for:.normal)
            }
        }
    }
    ///选中标签颜色
    open var _colorSelected = UIColor.gray {
        didSet{
            for item in self.tabBar.items! {
                item.setTitleTextAttributes(
                    [NSFontAttributeName:UIFont.systemFont(ofSize: _titleFontSelected),NSForegroundColorAttributeName:_colorSelected], for:.selected)
            }
        }
    }
    
    ///标签字体大小
    open var _titleFontNormal:CGFloat = 10.0 {
        didSet{
            for item in self.tabBar.items! {
                item.setTitleTextAttributes(
                    [NSFontAttributeName:UIFont.systemFont(ofSize: _titleFontNormal),NSForegroundColorAttributeName:_colorNormal], for:.normal)
            }
            
        }
    }
    ///选中标签字体大小
    open var _titleFontSelected:CGFloat = 10.0 {
        didSet{
            for item in self.tabBar.items! {
                item.setTitleTextAttributes(
                    [NSFontAttributeName:UIFont.systemFont(ofSize: _titleFontSelected),NSForegroundColorAttributeName:_colorSelected], for:.selected)
            }
        }
    }
    // 矫正TabBar图片位置，使之垂直居中显示
    open var _imageInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) {
        didSet{
            for item in self.tabBar.items! {
                item.imageInsets = _imageInsets
            }
        }
    }
    //MARK:---- 准备 TabBar
    fileprivate func makeTabBar() {
        navigations.removeAll()
        for (i,item) in _viewControllers.enumerated() {
            let navigation = SP_NavigationController(rootViewController:item)
            navigation.isNavigationBarHidden = _naviBarHidden
            navigations.append(navigation)
            if _titles.count>i && _images.count>i && _selectedImages.count>i {
                item.tabBarItem = UITabBarItem(title: _titles[i], image: UIImage(named: _images[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: _selectedImages[i])?.withRenderingMode(.alwaysOriginal))
            }
        }
        
        self.viewControllers = navigations
        self.tabBar.isTranslucent = false
        self.selectedIndex = _selectedIndex
    }
    //MARK:--- 设置基本属性
    open func setProperty(_ naviBarHidden:Bool, colorNormal:UIColor = UIColor.gray, colorSelected:UIColor = UIColor.black, titleFontNormal:CGFloat = 12.0, titleFontSelected:CGFloat = 12.0, imageInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0))  {
        
        _naviBarHidden = naviBarHidden
        _colorNormal   = colorNormal
        _colorSelected =  colorSelected
        _titleFontNormal = titleFontNormal
        _titleFontSelected = titleFontSelected
        _imageInsets = imageInsets
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

/**
 * 自定义按钮
 *
 */
extension SP_TabBarController {
    //MARK:--- 中间 + 按钮
    func centerMenuButton() {
        let button = UIButton()
        self.tabBar.addSubview(button)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.8
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setImage(UIImage(named:"logo_0"), for: .normal)
        button.addTarget(self, action: #selector(SP_TabBarController.centerMenuButtonClick(_:)), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
    }
    func centerMenuButtonClick(_ sender:UIButton) {
        let images = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
        let titles = ["200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200","200x200"]
        SP_TabMenuView.show((images,titles) ,type:.t两行三列, block: { tag in
            
        })
        
    }
    //MARK:--- 去掉tabBar顶部线条
    func hideLine() {
        //去掉tabBar顶部线条
        let rect = CGRect(x: 0, y: 0, width: SP_ScreenWidth, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.clear.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.backgroundImage = image
        self.tabBar.shadowImage = image
    }
}

/**
 * 默认代码加载
 *
 */
extension SP_TabBarController {
    
}




