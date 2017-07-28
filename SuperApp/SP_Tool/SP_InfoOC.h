//
//  SP_InfoOC.h
//  SuperApp
//
//  Created by 刘才德 on 2017/5/30.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#pragma mark ---------- 设备型号 ----------
typedef NS_ENUM(NSInteger) {
    tiPhone = 0,
    tiPhoneA,
    tiPhoneP,
    tiPod,
    tiPad,
}SP_DeviceModel;

@interface SP_InfoOC : NSObject
#pragma mark ---------- 单例及打印测试 ----------
@property(nonatomic,strong) NSString *name;
+ (id)shared;
+ (void)sp_print;
#pragma mark ---------- 国际化文字 ----------
+ (NSString *)sp_localizedStringForKey:(NSString *)key;
#pragma mark ---------- 字号适配 ----------
+ (UIFont*) sp_fontFitWithSize:(CGFloat)size;
+ (CGFloat) sp_fitWithSize:(CGFloat)size;
+ (SP_DeviceModel)sp_deviceModel;
@end
