//
//  LCDToolClass.h
//  ihg
//
//  Created by sifenzi on 15/12/17.
//  Copyright © 2015年 Robin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import<CommonCrypto/CommonDigest.h>
#import <arpa/inet.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

//#import <TVCClientSDK/TVCClient.h>
//#import <TVCClientSDK/TVCCommon.h>
//#import <TVCClientSDK/TVCConfig.h>

//#import "HXPhotoModel.h"


@interface LCDToolClass : NSObject
+ (NSArray *) xzReturnCategoryStringWithType:(NSString *)mallType;


+(NSString *)subStringWithString:(NSString *)string withRegex:(NSString *)regexString;
+ (NSString*) xzRemoveStringWithString:(NSString *)string withRegex:(NSString *)regexString;

+ (NSString *)getIPAddress;

+ (UIViewController *)getCurrentVC;
+ (UIViewController *)getPresentedViewController;
// 根据图片url获取图片尺寸
//+(CGSize)getImageSizeWithURL:(id)imageURL;

+ (NSString *)sha1String:(NSData*)data;
+ (NSString*)sign:(NSString*)hash withFileName:(NSString*)fileName;
+ (NSString*)imagePathForVideo:(NSURL *)videoURL;
+ (NSString*)videoUrl;

+ (void)clickUpload:(NSString*)sign customFolderPath:(NSString*)customFolderPath tempImage:(NSString*)tempImage;

//+ (AVAssetExportSession*) zipVideoWithModel:(HXPhotoModel *) model;

+ (void) zipVideoWithInputURL:(NSURL*)inputURL
                completeBlock:(void (^)(NSURL *))completeBlock;

+ (NSDictionary*) prameWithTitle:(NSString*)Title
                         Content:(NSString*)Content
                             Ids:(NSString*)Ids
                     TypeNameIds:(NSString*)TypeNameIds
                       cheyouhui:(NSString*)cheyouhui
                        CityClub:(NSString*)CityClub
                         CarClub:(NSString*)CarClub
                       Ifreprint:(NSString*)Ifreprint
                         DraftId:(NSString*)DraftId
                         TopicId:(NSString*)TopicId;



+ (NSArray *)getSeparatedLinesFromtext:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSMutableAttributedString *)changeLineSpacing:(NSArray *)stringList;
@end

