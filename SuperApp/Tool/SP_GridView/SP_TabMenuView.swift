//
//  SP_TabMenuView.swift
//  carpark
//
//  Created by 刘才德 on 2016/12/5.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import UIKit
import AVFoundation

enum SP_TabMenuViewType {
    case t两行两列
    case t两行三列
    case t三行三列
}

class SP_TabMenuView: UIView {
    //MARK:--- ❤️外部接口
    class func show(_ datas:(images:[String],titles:[String]), type:SP_TabMenuViewType = .t两行三列, block:@escaping ((Int)->Void)) {
        let view = (Bundle.main.loadNibNamed("SP_TabMenuView", owner: nil, options: nil)!.first as? SP_TabMenuView)!
        view.block = block
        view.frame = SP_MainWindow.bounds
        view._type = type
        view._images = datas.images
        view._titles = datas.titles
        _self = view
        SP_MainWindow.addSubview(view)
    }
    weak static var _self:SP_TabMenuView?
    class func dismis() {
        _self?.removeFromSuperview()
    }
    
    //MARK:--- 主体方法
    override func awakeFromNib() {
        super.awakeFromNib()
        //创建毛玻璃效果
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(blurView)
        self.sendSubview(toBack: blurView)
        blurView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        showSubViews()
    }
    //MARK:--- 主体数据和控件
    var _type:SP_TabMenuViewType = .t两行三列 {
        didSet{
            switch _type {
            case .t两行两列:
                _eachNum = 2
                _row = 2
            case .t两行三列:
                _eachNum = 3
                _row = 2
            case .t三行三列:
                _eachNum = 3
                _row = 3
                view_item_W.constant = 470
                
            }
        }
    }
    lazy var _images = [String]()
    lazy var _titles = [String]()
    lazy var _eachNum = 3
    lazy var _row = 2
    private lazy  var _pageItemNum:Int = {
        return self._eachNum * self._row
    }()
    private lazy var _animateTime:TimeInterval = 0
    @IBOutlet weak var view_item: UIView!
    @IBOutlet weak var view_item_W: NSLayoutConstraint!
    @IBOutlet weak var button_back: UIButton!
    var block:((_ tag:Int)->Void)?
    @IBAction func backClick(_ sender: UIButton) {
        hideSubViews()
    }
    //MARK:--- 九宫格，需要本项目当中 SP_GridView类 的支持
    lazy var _itemView:SP_GridView = {
        let view = SP_GridView.show(CGRect(x:0,y:0,width:SP_ScreenWidth,height:self.view_item.bounds.size.height),superView: self.view_item, datas: (eachNum: self._eachNum, row: self._row, space: 0, margin: (30,10), images: (name: self._images, placeholderImage: "200x200"), titles: self._titles, angles: []), block: { (indx) in
        })
        view.tDefaultAnimate()
        return view
    }()
    //MARK:--- 音频播放器
    lazy var _player:AVAudioPlayer? = {
        let path = Bundle.main.path(forResource: "tanhuang", ofType: "mp3") ?? ""
        
        guard let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        //let player1 = try! AVAudioPlayer(data: Data()) //通过data创建
        //1、音量
        player.volume = 0.005//0.0-1.0之间
        //2、循环次数
        //player.numberOfLoops = 1 //默认只播放一次
        //3、播放位置
        //player.currentTime = 0.0 //可以指定从任意位置开始播放
        //4、声道数
        //let channels = player.numberOfChannels //只读属性
        //5、持续时间
        //let duration = player.duration //获取持续时间
        //6、仪表计数
        //player.isMeteringEnabled = true //开启仪表计数功能
        //player.updateMeters()//更新仪表计数
        return player
        
    }()
    //MARK:--- 显示
    private func showSubViews() {
        _player?.prepareToPlay()//分配播放所需的资源，并将其加入内部播放队列
        _player?.play()//播放
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            self._player?.stop()
        }
        _itemView._pageControl.isHidden = true
        for (i,item) in _itemView._pageView.subviews.enumerated() {
            showAnimate(item, delay:0.0+TimeInterval(i)/16, height: view_item_W.constant, block: {
                if i == self._pageItemNum-1 {
                    self._itemView._pageControl.isHidden = false
                }
                
            })
            
        }
    }
    
    
    //MARK:--- 隐藏
    private func hideSubViews() {
        _player?.prepareToPlay()//分配播放所需的资源，并将其加入内部播放队列
        _player?.play()//播放
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            self._player?.stop()
        }
        //当前显示的页码
        _itemView._pageControl.isHidden = true
        let pagenum = _itemView._pageControl.currentPage
        for (i,item) in _itemView._pageView.subviews.enumerated() {
            if item.tag >= pagenum*_pageItemNum && item.tag < (pagenum+1)*_pageItemNum {
                hideAnimate(item, delay:_animateTime-TimeInterval(i%self._pageItemNum)/16, height: view_item_W.constant+100, block: {
                    if i == pagenum*self._pageItemNum {
                        self.removeFromSuperview()
                    }
                })
            }
            
        }
    }
    
    //MARK:--- 核心动画 - 显示
    private func showAnimate(_ view:UIView, delay:TimeInterval, height:CGFloat, block:@escaping (()->Void)) {
        view.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            let spring = CASpringAnimation(keyPath: "position.y")
            //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
            spring.damping = 50
            //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
            spring.stiffness = 900
            //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
            spring.mass = 1.2
            //初始速率，动画视图的初始速度大小
            //速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
            spring.initialVelocity = -150
            spring.fromValue = view.layer.position.y + height
            spring.toValue = view.layer.position.y
            //结算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算,建议使用预估时间
            self._animateTime = spring.settlingDuration
            spring.duration = spring.settlingDuration
            view.layer.add(spring, forKey: spring.keyPath)
            view.isHidden = false
            print(spring.duration)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay+_animateTime) {
            block()
        }
        
    }
    //MARK:--- 核心动画 - 隐藏
    private func hideAnimate(_ view:UIView, delay:TimeInterval, height:CGFloat, block:@escaping (()->Void)) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            let spring = CASpringAnimation(keyPath: "position.y")
            //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
            spring.damping = 10
            //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
            spring.stiffness = 200
            //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
            spring.mass = 1
            //初始速率，动画视图的初始速度大小
            //速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
            spring.initialVelocity = 0
            spring.fromValue = view.layer.position.y
            spring.toValue = view.layer.position.y + height
            //结算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算,建议使用预估时间
            spring.duration = spring.settlingDuration
            view.layer.add(spring, forKey: spring.keyPath)
            print(spring.duration)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay+_animateTime) {
            block()
        }
        
    }
 

}
