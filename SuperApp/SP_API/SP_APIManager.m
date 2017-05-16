//
//  SP_API.m
//  SuperApp
//
//  Created by 刘才德 on 2017/5/16.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

#import "SP_API.h"
static id shared = nil;
@implementation SP_API
+ (id) shared
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[super alloc] init];
    });
    return shared;
}
@end
