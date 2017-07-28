//
//  SP_ToolOC.m
//  ihg
//
//  Created by sifenzi on 15/12/17.
//  Copyright © 2015年 Robin Zhang. All rights reserved.
//

#import "SP_ToolOC.h"
#import <CoreText/CoreText.h>


@implementation SP_ToolOC
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


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
//获取当前屏幕中present出来的viewcontroller
+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}


#pragma mark ------------------------------ 玩车乐园
+ (NSString *)sha1String:(NSData*)data {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}


+ (NSString*)sign:(NSString*)hash withFileName:(NSString*)fileName{
    NSString *urlAsString = [NSString stringWithFormat:@"https://app.wancheleyuan.com/AppIndex/Uvaa?f=%@&fs=%@&ft=mp4",fileName,hash];//
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (data!=nil) {
        NSString *ss = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        return ss;
        //        id id = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        return [responseDic objectForKey:@"sign"] ;
        
    }
    else{
        return nil;
    }
    
}


+ (NSString*)videoUrl{
    NSString *documentDir= [NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory , NSUserDomainMask , YES ) objectAtIndex : 0 ];
    //保存首页图片 写真背景图
    NSString *customFolderPath = [documentDir stringByAppendingPathComponent:@"tempVideo.mp4"];
    return customFolderPath;
}
+ (NSString*)imagePathForVideo:(NSURL *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    NSString *documentDir= [NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory , NSUserDomainMask , YES ) objectAtIndex : 0 ];
    
    NSData *imagedata=UIImageJPEGRepresentation(thumbnailImage, 0.5);
    NSString *tempImage = [documentDir stringByAppendingPathComponent:@"tempVideoImage.jpg"];
    [imagedata writeToFile:tempImage atomically:YES];
    
    
    return tempImage;
}

/*
+ (void)clickUpload:(NSString*)sign customFolderPath:(NSString*)customFolderPath tempImage:(NSString*)tempImage {
    
    TVCConfig *config = [[TVCConfig alloc] init];
    
    config.signature = sign;
    config.secretId = @"AKIDBUemj0VuSkxvfFmijgOrdARQ8etrv2HH";
    config.forceHttps = NO;
    TVCClient * client = [[TVCClient alloc] initWithConfig:config];
    
    TVCUploadParam *param = [[TVCUploadParam alloc] init];
    param.videoPath = customFolderPath;
    param.coverPath = tempImage;
    NSLog(@"customFolderPath=>%@",customFolderPath);
    [client uploadVideo:param result:^(TVCUploadResponse *resp) {
        NSLog(@"result : %d-%@-%@-%@-%@",
              resp.retCode,
              resp.descMsg,
              resp.videoId,resp.videoURL,
              resp.coverURL);
    } progress:^(NSInteger bytesUpload, NSInteger bytesTotal) {
        NSLog(@"progress : %ld-%ld",
              (long)bytesUpload,
              (long)bytesTotal);
    }];
}

+ (AVAssetExportSession*) zipVideoWithModel:(HXPhotoModel *) model
{
    NSString *filename = model.videoURL.absoluteString;
//    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
    NSString *videoPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
//
    NSString *sandBoxFilePath = [videoPath stringByAppendingPathComponent:filename];
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             //[NSString stringWithFormat:@"FinalVideo_%d.mp4",arc4random() % 1000]];
    NSURL *clipVideoURL = [NSURL fileURLWithPath:sandBoxFilePath];
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:model.videoURL options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = clipVideoURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    return exportSession;
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        int exportStatus = exportSession.status;
//        
//        switch (exportStatus)
//        {
//            case AVAssetExportSessionStatusFailed:
//            {
//                // log error to text view
//                NSError *exportError = exportSession.error;
//                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//                break;
//            }
//            case AVAssetExportSessionStatusCompleted:
//            {
//                //RZLog(@"视频转码成功");
//            
//            }
//        }
//    }];
}

+ (void) zipVideoWithInputURL:(NSURL*)inputURL
                         completeBlock:(void (^)(NSURL *))completeBlock
{
    
    
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output%@.mp4",[formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = newVideoUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 //NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 //NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                 //[self alertUploadVideo:outputURL];
                 if (completeBlock) {
                     completeBlock(newVideoUrl);
                 }
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 if (completeBlock) {
                     completeBlock(nil);
                 }
                 break;
         }
         
     }];
    
}

+ (NSDictionary*) prameWithTitle:(NSString*)Title
                         Content:(NSString*)Content
                             Ids:(NSString*)Ids
                     TypeNameIds:(NSString*)TypeNameIds
                       cheyouhui:(NSString*)cheyouhui
                        CityClub:(NSString*)CityClub
                         CarClub:(NSString*)CarClub
                       Ifreprint:(NSString*)Ifreprint
                         DraftId:(NSString*)DraftId
                         TopicId:(NSString*)TopicId
{
    
    NSDictionary * dict3 = @{@"Title":Title,
                             @"Content":Content,
                             @"Ids":Ids,
                             @"TypeNameIds":TypeNameIds,
                             @"cheyouhui":cheyouhui,
                             @"CityClub":CityClub,
                             @"CarClub":CarClub,
                             @"Ifreprint":Ifreprint,
                             @"DraftId":DraftId,
                             @"TopicId":TopicId};
    
    return dict3;
}
*/
/*/ 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}*/



/**
 *  获取每行的文字
 *
 *  @param text     文本内容
 *  @param font     字体
 *  @param maxWidth 容器的最大宽度
 *
 *  @return 存储每行文字的数组
 */

+ (NSArray *)getSeparatedLinesFromtext:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,maxWidth,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}
//判断是否含有Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}
//循环存储每行文字内容的数组，处理字符串
+ (NSMutableAttributedString *)changeLineSpacing:(NSArray *)stringList {
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] init];
    for (NSString *string in stringList) {
        //如果含有Emoji表情，不做处理
        if ([SP_ToolOC stringContainsEmoji:string]) {
            NSMutableAttributedString *contentEmojistring = [[NSMutableAttributedString alloc] initWithString:string];
            [mutableString appendAttributedString:contentEmojistring];
        }else { //否则设置段落样式，行高为4（这个高度要根据自己的需求慢慢的试）
            NSMutableAttributedString *unContentEmojistring = [[NSMutableAttributedString alloc] initWithString:string];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 4;
            [unContentEmojistring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [unContentEmojistring length])];
            [mutableString appendAttributedString:unContentEmojistring];
        }
    }
    return mutableString; //返回最后处理完成的字符串
}



@end
