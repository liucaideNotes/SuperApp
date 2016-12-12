# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target ‘SuperApp’ do
    pod 'Alamofire'
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'SwiftyJSON'
    pod 'SnapKit'
    pod 'MBProgressHUD'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
