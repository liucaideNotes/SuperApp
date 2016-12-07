//
//  SP_ParentVC.swift
//  iexbuy
//
//  Created by 刘才德 on 2016/11/14.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//
/***
 ***/
import UIKit
enum SP_ParentVCType {
    case tDefault
    case tHome
    case tOther
}
class SP_ParentVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.main_bg
        self.view.addSubview(_statusBarView)
        self.view.addSubview(_bgNaviView)
        _bgNaviView.addSubview(_naviView)
        _naviView.addSubview(_leftView)
        _naviView.addSubview(_rightView)
        _naviView.addSubview(_centerView)
        
//        _leftView.backgroundColor = UIColor.yellow
//        _rightView.backgroundColor = UIColor.blue
//        _centerView.backgroundColor = UIColor.black
        
        
        xz_navigationView()
        
        addConstraints()
        
        //addConstraints()
        
        
        //bgViewAddConstraints()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.bringSubview(toFront: _bgNaviView)
        self.view.bringSubview(toFront: _statusBarView)
        //updateFrame()
    }
    open var _ParentVCType:SP_ParentVCType = .tDefault {
        didSet{
            xz_navigationView()
            updateConstraints()
        }
    }
    //间距
    private let _space:CGFloat = 5.0
    
    //MARK:--- 背景view
    open lazy var _bgNaviView:UIView = {
        let view = UIView()
         view.backgroundColor = UIColor.white
        return view
    }()
    //MARK:--- 状态栏
    open lazy var _statusBarView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        return view
    }()
    //MARK:--- 导航栏
    private lazy var _naviView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    //MARK:--- 下横线
    open lazy var _naviLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.main_line
        return view
    }()
    //MARK:--- 左边的 view --------------------
    open lazy var _leftView:UIView = {
        let view = UIView()
        return view
    }()
    /*
    open var _leftView_size:CGSize {
        get{
            var ww:CGFloat = 0.0
            var hh:CGFloat = 0.0
            for subView in _leftView.subviews {
                ww += subView.frame.size.width
                hh = subView.frame.size.height
            }
            ww = ww>88 ? 88 : ww
            ww = ww<44 ? 44 : ww
            
            hh = hh>44 ? 44 : hh
            hh = hh<30 ? 30 : hh
            
            return CGSize(width: ww,height: hh)
        }
    }
    */
    //MARK:--- 左按钮
    open lazy var _leftBarButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SP_ParentVC.leftButtonClick), for: .touchUpInside)
        button.setImage(UIImage(named: self._leftBarButtonImage), for: .normal)
        button.setTitle(self._leftBarButtonText, for: .normal)
        button.setTitleColor(UIColor.SP_ParentColor,for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = self._leftBarButton_H/2
        button.clipsToBounds = true
        
        return button
    }()
    ///设置 _leftBarButton 图片
    open var _leftBarButtonImage:String = "navi_back_gray" {
        didSet{
            _leftBarButton.setImage(UIImage(named: _leftBarButtonImage), for: UIControlState())
            updateConstraints()
        }
    }
    ///设置 _leftBarButton显示文字
    open var _leftBarButtonText = "" {
        didSet{
            _leftBarButton.setTitle(_leftBarButtonText, for: .normal)
            updateConstraints()
        }
    }
    ///设置 _leftBarButton高度
    open var _leftBarButton_H:CGFloat = 30.0 {
        didSet{
            _leftBarButton.layer.cornerRadius = _leftBarButton_H/2
            updateConstraints()
        }
    }
    
    ///获取_leftBarButton的 frame
    open var _leftBarButton_size:CGSize {
        get{
            var ww:CGFloat = 0.0
            var hh = self._leftBarButton_H
            if let imageW = _leftBarButton.imageView?.image?.size.width {
                ww += imageW
                hh = _leftBarButton.imageView!.image!.size.height
            }
            if let text = _leftBarButton.titleLabel?.text {
                ww += CGSize.xzLabelSize(text, font: _leftBarButton.titleLabel!.font!, size: CGSize(width:0, height:44)).width
            }
            
            ww = ww>88 ? 88 : ww
            ww = ww<_leftBarButton_H ? _leftBarButton_H : ww
            
            hh = hh>44 ? 44 : hh
            hh = hh<_leftBarButton_H ? _leftBarButton_H : hh
            
            return CGSize(width:ww, height:hh)
        }
    }
    //MARK:--- 左 定位地址 Label
    open lazy var _addLabel:UILabel = {
        let label = UILabel()
        label.text = self._addLabelText
        label.textAlignment = .center
        label.textColor = UIColor.SP_ParentColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        return label
    }()
    ///设置 定位_addLabel显示图标
    open lazy var _addImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:self._addImageName)
        return imageview
    }()
    ///设置 定位_addLabel 城市名
    open var _addLabelText = "广州" {
        didSet{
            _addLabel.text = _addLabelText
            
            updateConstraints()
        }
    }
    ///设置 定位图标名
    open var _addImageName = "navi_add_gray" {
        didSet{
            _addImageView.image = UIImage(named:_addImageName)
        }
    }
    
    /*//获取_rightBarButton的 frame
    open var _addViews_frame:CGRect {
        get{
            var ww_l = CGSize.xzLabelSize(_addLabel.text!, font: _addLabel.font!, size: CGSize(width:0, height:44)).width + 14
            
            ww_l = ww_l>88 ? 88 : ww_l
            ww_l = ww_l<44 ? 44 : ww_l
            
            return CGRect(x: 0,y: 0,width: ww_l,height: 44)
        }
        set{
            _addLabel.frame.size.width = newValue.size.width - 14
            _addImageView.frame = CGRect(x: newValue.size.width-14,y: 15,width: 14,height: 14)
        }
    }*/
    //MARK:--- 右边的 view --------------------
    open lazy var _rightView:UIView = {
        let view = UIView()
        return view
    }()
    /*
    open var _rightView_frame:CGRect {
        get{
            var ww:CGFloat = 0.0
            for subView in _rightView.subviews {
                ww += subView.frame.size.width
            }
            ww = ww>88 ? 88 : ww
            ww = ww<44 ? 44 : ww
            return CGRect(x: SP_ScreenWidth-ww-self._space,y: 20,width: ww,height: 44)
        }
    }*/
    //MARK:--- 右按钮
    open lazy var _rightBarButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SP_ParentVC.rightButtonClick), for: .touchUpInside)
        button.setImage(UIImage(named: self._rightBarButtonImage), for: .normal)
        button.setTitle(self._rightBarButtonText, for: .normal)
        button.setTitleColor(UIColor.SP_ParentColor,for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //button.layer.cornerRadius = self._rightBarButton_H/2
        //button.clipsToBounds = true
        return button
    }()
    ///设置 _leftBarButton 图片
    open var _rightBarButtonImage:String = "" {
        didSet{
            _rightBarButton.setImage(UIImage(named: _rightBarButtonImage), for: UIControlState())
            updateConstraints()
        }
    }
    ///设置 _leftBarButton显示文字
    open var _rightBarButtonText = "" {
        didSet{
            _rightBarButton.setTitle(_rightBarButtonText, for: .normal)
            updateConstraints()
        }
    }
    ///设置 _leftBarButton高度
    open var _rightBarButton_H:CGFloat = 30.0 {
        didSet{
            _rightBarButton.layer.cornerRadius = _rightBarButton_H/2
            updateConstraints()
        }
    }
    //获取_rightBarButton的 frame
    open var _rightBarButton_size:CGSize {
        get{
            var ww:CGFloat = 0.0
            var hh = self._rightBarButton_H
            if let imageW = _rightBarButton.imageView?.image?.size.width {
                ww += imageW
                hh = _rightBarButton.imageView!.image!.size.height
            }
            if let text = _rightBarButton.titleLabel!.text {
                ww += CGSize.xzLabelSize(text, font: _rightBarButton.titleLabel!.font!, size: CGSize(width:0, height:44)).width
            }
            
            ww = ww>88 ? 88 : ww
            ww = ww<_rightBarButton_H ? _rightBarButton_H : ww
            
            hh = hh>44 ? 44 : hh
            hh = hh<_rightBarButton_H ? _rightBarButton_H : hh
            
            return CGSize(width:ww, height:hh)
        }
    }
    //MARK:--- 中间的view --------------------
    open lazy var _centerView:UIView = {
        let view = UIView()
        return view
    }()
    //MARK:--- 中间按钮 _centerButton
    open lazy var _centerButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SP_ParentVC.centerButtonClick), for: .touchUpInside)
        button.setTitle(self._title, for: .normal)
        button.setImage(UIImage(named:self._centerButtonImage), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: self._titleFont)
        button.setTitleColor(self._titleColor, for: .normal)
        //button.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        //button.layer.cornerRadius = self._centerButton_H/2
        //button.clipsToBounds = true
        return button
    }()
    ///设置 searchButton显示文字
    open var _title = "爱换购" {
        didSet{
            _centerButton.setTitle(_title, for: .normal)
            updateConstraints()
        }
    }
    open var _titleFont:CGFloat = 17.0 {
        didSet{
            _centerButton.titleLabel?.font = UIFont.systemFont(ofSize: self._titleFont)
        }
    }
    open var _titleColor:UIColor = UIColor.SP_ParentColor {
        didSet{
            _centerButton.setTitleColor(_titleColor, for: .normal)
            
        }
    }
    ///设置 searchButton图标
    open var _centerButtonImage = "" {
        didSet{
            _centerButton.setImage(UIImage(named:_centerButtonImage), for: .normal)
            updateConstraints()
        }
    }
    ///设置 searchButton高度
    open var _centerButton_H:CGFloat = 30.0 {
        didSet{
            _centerButton.layer.cornerRadius = _centerButton_H/2
            updateConstraints()
        }
    }
    
    private func xz_navigationView() {
        
        switch _ParentVCType {
        case .tDefault:
            _leftView.addSubview(_leftBarButton)
            _rightView.addSubview(_rightBarButton)
            _centerView.addSubview(_centerButton)
            _bgNaviView.addSubview(_naviLine)
        case .tHome:
            
            _leftView.addSubview(_addLabel)
            _leftView.addSubview(_addImageView)
            _leftView.bringSubview(toFront: _leftBarButton)
            
        default:
            break
        }
        
        
    }
    //MARK:--- 添加约束 -----------------
    private func addConstraints() {
        _bgNaviView.snp.removeConstraints()
        _bgNaviView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        _statusBarView.snp.removeConstraints()
        _statusBarView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        _naviView.snp.removeConstraints()
        _naviView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        _naviLine.snp.removeConstraints()
        _naviLine.snp.makeConstraints({ (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        })
        
        
//        _leftView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview().offset(_space)
//            make.width.equalTo(44)
//        }
//        _rightView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-_space)
//            make.width.equalTo(44)
//        }
//        _centerView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalTo(_leftView.snp.trailing).offset(5)
//            make.trailing.equalTo(_rightView.snp.leading).offset(-5)
//        }
        
        
        updateConstraints()
    }
    
    private func updateConstraints() {
        switch _ParentVCType {
        case .tDefault:
            _leftView.snp.removeConstraints()
            _leftView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview().offset(_space)
                make.width.equalTo(_leftBarButton_size.width)
            }
            _rightView.snp.removeConstraints()
            _rightView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview().offset(-_space)
                make.width.equalTo(_rightBarButton_size.height)
            }
            _centerView.snp.removeConstraints()
            _centerView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalTo(_leftView.snp.trailing).offset(5)
                make.trailing.equalTo(_rightView.snp.leading).offset(-5)
            }
            
            _leftBarButton.snp.removeConstraints()
            _leftBarButton.snp.makeConstraints({ (make) in
                make.centerY.leading.equalToSuperview()
                make.height.equalTo(_leftBarButton_H)
                make.width.equalTo(_leftBarButton_H)
            })
            _rightBarButton.snp.removeConstraints()
            _rightBarButton.snp.makeConstraints({ (make) in
                make.centerY.trailing.equalToSuperview()
                make.height.equalTo(_rightBarButton_H)
                make.width.equalTo(_rightBarButton_H)
            })
            _centerButton.snp.removeConstraints()
            _centerButton.snp.makeConstraints({ (make) in
                make.centerY.leading.trailing.equalToSuperview()
                make.height.equalTo(_centerButton_H)
            })
            
        case .tHome:
            var ww_l = CGSize.xzLabelSize(_addLabel.text!, font: _addLabel.font!, size: CGSize(width:0, height:44)).width + 15
            
            ww_l = ww_l>88 ? 88 : ww_l
            ww_l = ww_l<44 ? 44 : ww_l
            
            print(ww_l)
            
            _leftView.snp.removeConstraints()
            _leftView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview().offset(_space)
                make.width.equalTo(ww_l)
            }
            
            _leftBarButton.snp.removeConstraints()
            _leftBarButton.snp.makeConstraints({ (make) in
                make.top.bottom.trailing.leading.equalToSuperview()
            })
            _leftBarButton.setImage(UIImage(), for: .normal)
            _leftBarButton.setTitle("", for: .normal)
            
            _addImageView.snp.removeConstraints()
            _addImageView.snp.makeConstraints({ (make) in
                make.centerY.trailing.equalToSuperview()
                make.width.height.equalTo(14)
            })
            _addLabel.snp.removeConstraints()
            _addLabel.snp.makeConstraints({ (make) in
                make.top.bottom.leading.equalToSuperview()
                make.trailing.equalToSuperview().offset(-15)
            })
        case .tOther:
            break
        }
        
    }

    //MARK:--- 响应事件
    open func leftButtonClick()  {
        if (navigationController?.popViewController(animated: true)) != nil {
            print("点击leftButton返回")
        }else{
            print("点击leftButton")
        }
    }
    
    open func rightButtonClick()  {
        print("点击rightButton")
    }
    open func centerButtonClick()  {
        print("点击centerButton")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
}
//MARK:---------- UIColor
extension UIColor {
    open class var SP_ParentColor: UIColor {
        return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha:1)
    }
}
//MARK:---------- SP_ParentVC

extension SP_ParentVC {
    
    func xz_setClearColor(_ titleClear:Bool = true) {
        self._bgNaviView.backgroundColor = UIColor.clear
        self._naviLine.backgroundColor = UIColor.clear
        if titleClear {
            _titleColor = UIColor.clear
        }
        _leftBarButton.backgroundColor = UIColor.main_1.withAlphaComponent(0.4)
        _leftBarButton.setImage(UIImage(named: "navi_back_white"), for: UIControlState())
    }
    func xz_setBackgroundColor(_ bgColor: UIColor,textColor: UIColor = UIColor.SP_ParentColor, offsetY: CGFloat, maxOffsetY: CGFloat = 150.0, leftButtonImage:String = "navi_back_gray", naviLineHidden:Bool = false) {
        
        if offsetY > 0 {
            let alpha = 1 - ((maxOffsetY - offsetY) / maxOffsetY)
            
            self._bgNaviView.backgroundColor = bgColor.withAlphaComponent(alpha)
            if !naviLineHidden {
                self._naviLine.backgroundColor = UIColor.main_line.withAlphaComponent(alpha)
            }
            
            _titleColor = textColor.withAlphaComponent(alpha)
            
            self._leftBarButton.backgroundColor = UIColor.main_1.withAlphaComponent(0.4-alpha)
            if alpha >= 0.5 {
                _leftBarButton.setImage(UIImage(named: leftButtonImage), for: UIControlState())
            }else{
                _leftBarButton.setImage(UIImage(named: "navi_back_white"), for: UIControlState())
            }
            
        } else {
            self._bgNaviView.backgroundColor = bgColor.withAlphaComponent(0)
            if !naviLineHidden {
                self._naviLine.backgroundColor = UIColor.main_line.withAlphaComponent(0)
            }
            
            _titleColor = textColor.withAlphaComponent(0)
            _leftBarButton.backgroundColor = UIColor.main_1.withAlphaComponent(0.4)
        }
    }
    
}
