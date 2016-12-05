//
//  FH_LocationManager.swift
//  IEXBUY
//
//  Created by sifenzi on 16/6/8.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//
/*
 1,在 info.plist里加入定位描述（Value值为空也可以）：
    <key>NSLocationAlwaysUsageDescription</key>
	<string>允许SupApp在后台获取您的定位信息</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>允许SupApp在前台获取您的定位信息</string>
 2,在桥接文件中添加
   #import "CLLocation+YCLocation.h"
 3,添加CoreLocation.framework
 4,使用：
FH_LocationManager.shared.getLocation(self, coordinateType: .Baidu) { [weak self](isChange) in
    if isChange {
        print("位置变更")
    }
}
FH_LocationManager.shared.cityChangeBlock = { [weak self](province, city, subCity) in
    print("城市（省、市、区）变更")
}
 */


enum CoordinateType {
    case Baidu
    case Mars
    case GPS
}
class FH_LocationManager: NSObject,CLLocationManagerDelegate {
    
    private static let sharedInstance = FH_LocationManager()
    private override init() {}
    //提供静态访问方法
    internal static var shared: FH_LocationManager {
        return self.sharedInstance
    }
    
    
    
    /// 用户位置
    var _currentCoord: CLLocationCoordinate2D {
        set{
            
            UserDefaults.standard.set(newValue.latitude, forKey: "FH_LocationManagerLatitude")
            UserDefaults.standard.set(newValue.longitude, forKey: "FH_LocationManagerLongitude")
            UserDefaults.standard.synchronize()
        }
        get{
            let latitude = UserDefaults.standard.value(forKey: "FH_LocationManagerLatitude") as? Double ?? 0.0
            let longitude = UserDefaults.standard.value(forKey: "FH_LocationManagerLongitude") as? Double ?? 0.0
            var currentCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            if(longitude == 0.0 || longitude == 0.0) {
                UserDefaults.standard.set(23.119298, forKey: "FH_LocationManagerLatitude")
                UserDefaults.standard.set(113.321201, forKey: "FH_LocationManagerLongitude")
                UserDefaults.standard.synchronize()
                currentCoordinate = CLLocationCoordinate2DMake(23.119298, 113.321201)//珠江新城
            }
            return currentCoordinate
        }
    }
    
    //MARK:----------- 定位服务
    ///位置变更回调
    var locationChangeBlock:((_ changeLocation:Bool)->Void)?
    ///城市变更回调
    var cityChangeBlock:((_ province:String, _ city:String, _ subCity:String)->Void)?
    
    private weak var _parentVC:UIViewController?
    private var _coordinateType:CoordinateType = .GPS
    private var _locationManager:CLLocationManager!
    
    
    func getLocation(_ parentVC:UIViewController, coordinateType type:CoordinateType, changeBlock block:@escaping (Bool)->Void){
        self._parentVC = parentVC
        self._coordinateType = type
        //如果设备没有开启定位服务
        if !CLLocationManager.locationServicesEnabled()
        {
            DispatchQueue.main.async{
                let aler = UIAlertController(title: "无法定位，因为您的设备没有启用定位服务，请到设置中启用", message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction.init(title: "知道了", style: .default, handler: { (UIAlertAction) in
                })
                aler.addAction(cancel)
                if #available(iOS 10.0, *) {
                    let paizhao = UIAlertAction.init(title: "开启", style: UIAlertActionStyle.default, handler: { (alertAction) in
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                    })
                    aler.addAction(paizhao)
                    
                }else{
                    // Fallback on earlier versions
                    //UIApplication.shared.open(URL(string: "prefs:root=LOCATION_SERVICES")!, options: [:], completionHandler: nil)
                }
                self._parentVC?.present(aler, animated: true, completion: nil)
            }
            return
        }
        _locationManager = CLLocationManager()
        /*
         定位服务管理类CLLocationManager的desiredAccuracy属性表示精准度，有如下6种选择：
         kCLLocationAccuracyBestForNavigation ：精度最高，一般用于导航
         kCLLocationAccuracyBest ： 精确度最佳
         kCLLocationAccuracyNearestTenMeters ：精确度10m以内
         kCLLocationAccuracyHundredMeters ：精确度100m以内
         kCLLocationAccuracyKilometer ：精确度1000m以内
         kCLLocationAccuracyThreeKilometers ：精确度3000m以内
         */
        //设置定位获取成功或者失败后的代理，Class后面要加上CLLocationManagerDelegate协议
        _locationManager.delegate = self
        //设置精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        _locationManager.distanceFilter = 50
        
        
        //在IOS8以上系统中，需要使用requestWhenInUseAuthorization方法才能弹窗让用户确认是否允许使用定位服务的窗口
        if #available(iOS 8.0, *) {
            //用户还没有做出选择，弹窗发送授权申请 让用户选择
            if CLLocationManager.authorizationStatus() == .notDetermined {
                _locationManager.requestWhenInUseAuthorization()//只在前台定位
                //_locationManager.requestAlwaysAuthorization()//前后台定位
            }
                //用户没有授权，提醒用户授权
            else if(CLLocationManager.authorizationStatus() == .denied){
                //需要把弹窗放在主线程才能强制显示
                DispatchQueue.main.async{
                    let aler = UIAlertController(title: "无法定位，因为您没有授权爱换购使用定位，请至设置中开启！", message: nil, preferredStyle: .alert)
                    let cancel = UIAlertAction.init(title: "知道了", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(cancel)
                    if #available(iOS 10.0, *) {
                        let paizhao = UIAlertAction.init(title: "开启", style: UIAlertActionStyle.default, handler: { (alertAction) in
                            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                        })
                        aler.addAction(paizhao)
                        
                    }else{
                        // Fallback on earlier versions
                        //UIApplication.shared.open(URL(string: "prefs:root=LOCATION_SERVICES")!, options: [:], completionHandler: nil)
                    }
                    self._parentVC?.present(aler, animated: true, completion: nil)
                    return
                }
            }
        }
        
        //开始获取定位信息，异步方式
        _locationManager.startUpdatingLocation()
        
        locationChangeBlock = block
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        if locations.count > 0 {
            //  使用last 获取 最后一个最新的位置， 前面是上一次的位置信息
            let currLocation:CLLocation = locations.last!
            // ---  将GPS坐标转换为指定坐标
            let amapcoord:CLLocationCoordinate2D?
            switch _coordinateType {
            case .Baidu:
                amapcoord = currLocation.locationBaiduFromEarth().coordinate
            case .Mars:
                amapcoord = currLocation.locationMarsFromEarth().coordinate
            default:
                amapcoord = currLocation.coordinate
            }
            
            // 如果坐标变动超过10m就通知
            let locationS = CLLocation(latitude: _currentCoord.latitude, longitude: _currentCoord.longitude)
            let locationE = CLLocation(latitude: amapcoord!.latitude, longitude: amapcoord!.longitude)
            let distance:CLLocationDistance = locationS.distance(from: locationE)
            //代理有时候会连续跑很多次，这里再增加限制
            if distance > 10.0 || distance < -10.0 {
                // --- 进行变更
                locationChangeBlock?(true)
                // --- 将新坐标存起来
                _currentCoord = amapcoord!
                
            }
            //获取定位的城市名字
            let geocoder = CLGeocoder()
            let loc = CLLocation(latitude: currLocation.coordinate.latitude, longitude:currLocation.coordinate.longitude)
            geocoder.reverseGeocodeLocation(loc, completionHandler: { [unowned self](placemarks, error) in
                if placemarks != nil {
                    for placemark in placemarks! {
                        var myProvince:String = placemark.administrativeArea!
                        
                        if myProvince.isEmpty {
                            myProvince = placemark.locality!
                            _ = placemark.subLocality  //获取城市名
                        }else{
                            _ = placemark.thoroughfare      //获取街道地址
                            let cityName:String = placemark.locality! //获取城市名
                            let subCityName:String = placemark.subLocality!   //获取区名
                            myProvince = placemark.administrativeArea!   //获取省名
                            
                            //print_FH(placemark.name)//地址
                            //print_FH(placemark.thoroughfare)//街道
                            //print_FH(placemark.subThoroughfare)//门牌号
                            //print_FH(placemark.locality)//城市 、、如果是拼音首字母大写，没有市，Guangzhou
                            //print_FH(placemark.subLocality)//城区
                            //print_FH(placemark.administrativeArea)//省
                            //print_FH(placemark.subAdministrativeArea)
                            //print_FH(placemark.postalCode)
                            //print_FH(placemark.ISOcountryCode)//国家编码
                            //print_FH(placemark.country)//国家
                            //print_FH(placemark.inlandWater)
                            //print_FH(placemark.ocean)
                            
                            //城市变更
                            self.cityChangeBlock?(myProvince, cityName, subCityName)
                            
                        }
                        
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //        SCMessageBox.showquick(self, contentMsg: "定位发生异常：\(error)")
    }

    
    

}
