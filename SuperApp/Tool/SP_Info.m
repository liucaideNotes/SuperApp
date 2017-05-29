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

#pragma mark ---------- 当前系统版本 ----------
#pragma mark ---------- 字号 ----------









@end
