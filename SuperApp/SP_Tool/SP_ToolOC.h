//
//  SP_ToolOC.h
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


@interface SP_ToolOC : NSObject
+ (NSArray *) sp_returnTuPianStringWithType:(NSString *)mallType;


+(NSString *) sp_subStringWithString:(NSString *)string withRegex:(NSString *)regexString;
+ (NSString*) sp_removeStringWithString:(NSString *)string withRegex:(NSString *)regexString;

+ (NSString *)sp_getIPAddress;

+ (UIViewController *)sp_getCurrentVC;
+ (UIViewController *)sp_getPresentedVC;
// 根据图片url获取图片尺寸
//+(CGSize)getImageSizeWithURL:(id)imageURL;

+ (NSString *)sha1String:(NSData*)data;
+ (NSString*)sign:(NSString*)hash withFileName:(NSString*)fileName;
+ (NSString*)imagePathForVideo:(NSURL *)videoURL;
+ (NSURL*) sp_getFilePathWithSuffix:(NSString*)suffix;
+ (NSString *)sp_recordPath;
+ (NSString*)sp_audio_PCMtoMP3WithFilePath:(NSString*)filePath;

+ (void)clickUpload:(NSString*)sign customFolderPath:(NSString*)customFolderPath tempImage:(NSString*)tempImage;

+ (void) zipVideoWithInputURL:(NSURL*)inputURL
                completeBlock:(void (^)(NSURL *))completeBlock;

//+ (AVAssetExportSession*) zipVideoWithModel:(HXPhotoModel *) model;
/*
 
 
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
 
 */

+ (NSArray *)getSeparatedLinesFromtext:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSMutableAttributedString *)changeLineSpacing:(NSArray *)stringList;

+ (NSString *) stringByReplacingOccurrences:(NSString*)string;
@end

