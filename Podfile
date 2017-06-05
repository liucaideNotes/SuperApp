# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target ‘SuperApp’ do
    pod 'Alamofire'
    pod 'AFNetworking'
    
    pod 'SwiftyJSON'
    pod 'ObjectMapper'
    
    pod 'SDWebImage'
    
    pod 'SnapKit'
    pod 'Masonry'
    
    pod 'MBProgressHUD'
    pod 'SVProgressHUD'
    
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    pod 'RxAlamofire'
    pod 'Moya/RxSwift'
    #pod 'Moya'
    
    #蓝牙
    pod 'MPBluetoothKit'
    
    #高度自适应
    pod 'UITableView+FDTemplateLayoutCell'
    
    #图表库
    pod 'Charts'
    
    #pod 'Hyphenate_CN'
    #pod 'YYKit'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
