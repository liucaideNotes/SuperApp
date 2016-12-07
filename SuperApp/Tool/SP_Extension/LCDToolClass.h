//
//  LCDToolClass.h
//  ihg
//
//  Created by sifenzi on 15/12/17.
//  Copyright © 2015年 Robin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LCDToolClass : NSObject
+ (NSArray *) xzReturnCategoryStringWithType:(NSString *)mallType;


+(NSString *)subStringWithString:(NSString *)string withRegex:(NSString *)regexString;
+ (NSString*) xzRemoveStringWithString:(NSString *)string withRegex:(NSString *)regexString;

+ (NSString *)getIPAddress;
@end
