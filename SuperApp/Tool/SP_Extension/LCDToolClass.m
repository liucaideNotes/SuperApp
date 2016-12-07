//
//  LCDToolClass.m
//  ihg
//
//  Created by sifenzi on 15/12/17.
//  Copyright © 2015年 Robin Zhang. All rights reserved.
//

#import "LCDToolClass.h"
#import <ifaddrs.h>
#import<CommonCrypto/CommonDigest.h>
#import <arpa/inet.h>

@implementation LCDToolClass
+ (NSArray *) xzReturnCategoryStringWithType:(NSString *)mallType{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"TuPian.plist" ofType:nil];
    NSDictionary * Dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray * CategoryArr = [Dic valueForKey:mallType];
    return CategoryArr;
}

#pragma mark ------------------------------ 筛除富文本
+(NSString *)subStringWithString:(NSString *)string withRegex:(NSString *)regexString{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    if (error != nil) {
        NSLog(@"%@", error);
        return NULL;
    }
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从String当中截取数据
            NSString *result=[string substringWithRange:resultRange];
            //返回结果
            return  result;
        }
    }
    return @"";
}
+ (NSString*) xzRemoveStringWithString:(NSString *)string withRegex:(NSString *)regexString{
    //----------内容
    NSString * xzStr = string;
    
    while (![[self subStringWithString:xzStr withRegex:regexString] isEqualToString: @""]) {
        NSString * str = [self subStringWithString:xzStr withRegex:regexString];
        NSArray *arr = [xzStr componentsSeparatedByString:str];
        xzStr = [arr componentsJoinedByString:@""];
    }
    return xzStr;
}

+ (NSString *)getIPAddress{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


@end
