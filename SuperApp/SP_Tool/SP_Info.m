//
//  SP_Info.m
//  SuperApp
//
//  Created by 刘才德 on 2017/5/30.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

#import "SP_Info.h"

static SP_Info* shared = nil;
@implementation SP_Info
#pragma mark ---------- 单例 ----------
+ (SP_Info*) shared
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
    SP_Info *defaultManagerSingleton =[SP_Info shared];
    NSLog(@"defaultManagerSingleton:\n%@",defaultManagerSingleton);
    SP_Info *allocSingleton = [[SP_Info alloc] init];
    NSLog(@"allocSingleton:\n%@",allocSingleton);
    SP_Info *copySingleton = [allocSingleton copy];
    NSLog(@"copySingleton:\n%@",copySingleton);
    SP_Info *mutebleCopySingleton = [allocSingleton mutableCopy];
    NSLog(@"mutebleCopySingleton:\n%@",mutebleCopySingleton);
}
#pragma mark ---------- 国际化文字 ----------
+ (NSString *)sp_localizedStringForKey:(NSString *)key {
    return NSLocalizedStringFromTable(key, @"Localization", @"");
}
#pragma mark ---------- 当前设备 ----------
+ (SP_DeviceModel)sp_deviceModel {
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
    
    if ([platform isEqualToString:@"iPhone1,1"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone1,2"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone2,1"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone3,1"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone3,2"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone3,3"]) return tiPhone;
    if ([platform isEqualToString:@"iPhone4,1"]) return tiPhone;
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
    return tiPhone;
}

#pragma mark ---------- 字号适配 ----------
+ (UIFont*) sp_fontFitWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:[SP_Info sp_fitWithSize:size]];
}
+ (CGFloat) sp_fitWithSize:(CGFloat)size {
    switch ([SP_Info sp_deviceModel]) {
        case tiPhone:
            return size;
            break;
        case tiPhoneA:
            return size+1;
            break;
        case tiPhoneP:
            return size+2;
            break;
        case tiPod:
            return size;
            break;
        case tiPad:
            return size+2;
            break;
        default:
            return size;
            break;
    }
}

@end
