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
    tiPhone4 = 0,
    tiPhone,
    tiPhoneA,
    tiPhoneP,
    tiPad,
}SP_DeviceModel;

typedef NS_ENUM(NSInteger) {
    tUltraLight = 0,
    tThin,
    tLight,
    tRegular,
    tMedium,
    tSemibold,
    tBold,
    tHeavy,
    tBlack
}SP_UIFontWeight;

@interface SP_InfoOC : NSObject
#pragma mark ---------- 单例及打印测试 ----------
@property(nonatomic,strong) NSString *name;
+ (id)shared;
+ (void)sp_print;
#pragma mark ---------- 国际化文字 ----------
+ (NSString *)sp_localizedStringForKey:(NSString *)key from:(NSString *)from;
#pragma mark ---------- 字号适配 ----------
+ (UIFont*) sp_fontFitWithSize:(CGFloat)size;
+ (UIFont*) sp_fontFitWithSize:(CGFloat)size weightType:(SP_UIFontWeight)weightType;
+ (CGFloat) sp_fitWithSize:(CGFloat)size;
+ (SP_DeviceModel)sp_deviceModel;
+ (NSString*) sp_getDateTimeStamp:(double)timeStamp WithFormat:(NSString*)format;


@end
