//
//  SP_InfoOC.m
//  SuperApp
//
//  Created by 刘才德 on 2017/5/30.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

#import "SP_InfoOC.h"

static SP_InfoOC* shared = nil;
@implementation SP_InfoOC
#pragma mark ---------- 单例 ----------
+ (SP_InfoOC*) shared
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (shared == nil) {
            shared = [[self alloc] init];
        }
        
    });
    return shared;
}
/**
 覆盖该方法主要确保当用户通过[[Singleton alloc] init]创建对象时对象的唯一性，alloc方法会调用该方法，只不过zone参数默认为nil，因该类覆盖了allocWithZone方法，所以只能通过其父类分配内存，即[super allocWithZone:zone]
 */
+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(shared == nil){
            shared = [super allocWithZone:zone];
        }
    });
    return shared;
}
//自定义初始化方法，本例中只有name这一属性
- (instancetype)init
{
    self = [super init];
    if(self){
        self.name = @"Singleton";
    }
    return self;
}
//覆盖该方法主要确保当用户通过copy方法产生对象时对象的唯一性
- (id)copy
{
    return self;
}
//覆盖该方法主要确保当用户通过mutableCopy方法产生对象时对象的唯一性
- (id)mutableCopy
{
    return self;
}
//自定义描述信息，用于log详细打印
- (NSString *)description
{
    return [NSString stringWithFormat:@"memeory address:%p,property name:%@",self,self.name];
}
//测试
+ (void)sp_print {
    SP_InfoOC *defaultManagerSingleton =[SP_InfoOC shared];
    NSLog(@"defaultManagerSingleton:\n%@",defaultManagerSingleton);
    SP_InfoOC *allocSingleton = [[SP_InfoOC alloc] init];
    NSLog(@"allocSingleton:\n%@",allocSingleton);
    SP_InfoOC *copySingleton = [allocSingleton copy];
    NSLog(@"copySingleton:\n%@",copySingleton);
    SP_InfoOC *mutebleCopySingleton = [allocSingleton mutableCopy];
    NSLog(@"mutebleCopySingleton:\n%@",mutebleCopySingleton);
}
#pragma mark ---------- 国际化文字 ----------
+ (NSString *)sp_localizedStringForKey:(NSString *)key from:(NSString *)from {
    return NSLocalizedStringFromTable(key, from, @"");
}
#pragma mark ---------- 当前设备 ----------
+ (SP_DeviceModel)sp_deviceModel {
    /*
     int mib[2];
     size_t len;
     char *machine;
     
     mib[0] = CTL_HW;
     mib[1] = HW_MACHINE;
     sysctl(mib, 2, NULL, &len, NULL, 0);
     machine = malloc(len);
     sysctl(mib, 2, machine, &len, NULL, 0);
     
     NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
     free(machine);
     NSLog(@"%@",platform);
     if ([platform isEqualToString:@"iPhone1,1"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone1,2"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone2,1"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone3,1"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone3,2"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone3,3"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone4,1"]) return tiPhone4;
     if ([platform isEqualToString:@"iPhone5,1"]) return tiPhone;
     if ([platform isEqualToString:@"iPhone5,2"]) return tiPhone;
     if ([platform isEqualToString:@"iPhone5,3"]) return tiPhone;
     if ([platform isEqualToString:@"iPhone5,4"]) return tiPhone;
     if ([platform isEqualToString:@"iPhone6,1"]) return tiPhoneA;
     if ([platform isEqualToString:@"iPhone6,2"]) return tiPhoneP;
     if ([platform isEqualToString:@"iPhone7,1"]) return tiPhoneA;
     if ([platform isEqualToString:@"iPhone7,2"]) return tiPhoneP;
     
     if ([platform isEqualToString:@"iPod1,1"])   return tiPod;
     if ([platform isEqualToString:@"iPod2,1"])   return tiPod;
     if ([platform isEqualToString:@"iPod3,1"])   return tiPod;
     if ([platform isEqualToString:@"iPod4,1"])   return tiPod;
     if ([platform isEqualToString:@"iPod5,1"])   return tiPod;
     
     if ([platform isEqualToString:@"iPad1,1"])   return tiPad;
     
     if ([platform isEqualToString:@"iPad2,1"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,2"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,3"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,4"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,5"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,6"])   return tiPad;
     if ([platform isEqualToString:@"iPad2,7"])   return tiPad;
     
     if ([platform isEqualToString:@"iPad3,1"])   return tiPad;
     if ([platform isEqualToString:@"iPad3,2"])   return tiPad;
     if ([platform isEqualToString:@"iPad3,3"])   return tiPad;
     if ([platform isEqualToString:@"iPad3,4"])   return tiPad;
     if ([platform isEqualToString:@"iPad3,5"])   return tiPad;
     if ([platform isEqualToString:@"iPad3,6"])   return tiPad;
     
     if ([platform isEqualToString:@"iPad4,1"])   return tiPad;
     if ([platform isEqualToString:@"iPad4,2"])   return tiPad;
     if ([platform isEqualToString:@"iPad4,3"])   return tiPad;
     if ([platform isEqualToString:@"iPad4,4"])   return tiPad;
     if ([platform isEqualToString:@"iPad4,5"])   return tiPad;
     if ([platform isEqualToString:@"iPad4,6"])   return tiPad;
     
     if ([platform isEqualToString:@"i386"])      return tiPhone;
     if ([platform isEqualToString:@"x86_64"])    return tiPhone;
     return tiPhone;*/
    
    //.main.bounds
    CGFloat ww =  [UIScreen mainScreen].bounds.size.width;
    CGFloat hh =  [UIScreen mainScreen].bounds.size.height;
    CGFloat ww_hh = ww/hh;
    
    if (ww_hh == 320.0/480.0 || ww_hh == 480.0/320.0)
    return tiPhone4;
    if (ww_hh == 320.0/568.0 || ww_hh == 568.0/320.0)
    return tiPhone;
    if (ww_hh == 375.0/667.0 || ww_hh == 667.0/375.0)
    return tiPhoneA;
    if (ww_hh == 414.0/736.0 || ww_hh == 736.0/414.0)
    return tiPhoneP;
    return tiPad;
    
}

#pragma mark ---------- 字号适配 ----------
+ (UIFont*) sp_fontFitWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size]];
}

+ (UIFont*) sp_fontFitWithSize:(CGFloat)size weightType:(SP_UIFontWeight)weightType {
    switch (weightType) {
            case tUltraLight:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightUltraLight];
            break;
            case tThin:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightThin];
            break;
            case tLight:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightLight];
            break;
            case tRegular:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightRegular];
            break;
            case tMedium:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightMedium];
            break;
            case tSemibold:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightSemibold];
            break;
            case tBold:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightBold];
            break;
            case tHeavy:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightHeavy];
            break;
            case tBlack:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightBlack];
            break;
        default:
            return [UIFont systemFontOfSize:[SP_InfoOC sp_fitWithSize:size] weight:UIFontWeightRegular];
    }
}

+ (UIFont*) sp_fontBoldFitWithSize:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:[SP_InfoOC sp_fitWithSize:size]];
}

+ (CGFloat) sp_fitWithSize:(CGFloat)size {
    //CGFloat multiple = 1;
    switch ([SP_InfoOC sp_deviceModel]) {
            case tiPhone:
            return size-2;
            break;
            case tiPhoneA:
            return size;
            break;
            case tiPhoneP:
            return size+2;
            break;
            case tiPad:
            return size+2;
            break;
        default:
            return size;
            break;
    }
}

+ (NSString*) sp_getDateTimeStamp:(double)timeStamp WithFormat:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}




@end
