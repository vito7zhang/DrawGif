//
//  GifView.m
//  GifDemo
//
//  Created by vincent on 15/8/27.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "GifView.h"
#import <MobileCoreServices/MobileCoreServices.h> 
@implementation GifView


-(id)initWithFrame:(CGRect)frame FilePath:(NSString *)filePath{
    if (self = [super initWithFrame:frame]) {
        NSDictionary *dic = @{(NSString *)kCGImagePropertyGIFLoopCount:@0};
        gifProperties = @{(NSString *)kCGImagePropertyGIFDictionary:dic};
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:filePath], (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        
        _images = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, i, (CFDictionaryRef)gifProperties);
            UIImage *image = [UIImage imageWithCGImage:ref];
            [_images addObject:image];
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(play:) userInfo:nil repeats:YES];
    }
    return self;
}
-(void)changetime:(CGFloat)time{
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(play:) userInfo:nil repeats:YES];
}
-(void)play:(NSTimer *)_timer{
    
    index++;
    index = index % count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    
    
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

#pragma mark -----------
+(void)createGifViewWithImages:(NSArray *)sourceImages Speed:(CGFloat)speed{
    
    
    //创建输出路径
    NSString *gifDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifDir"];
    BOOL flag = [[NSFileManager defaultManager] fileExistsAtPath:gifDirectory];
    if (!flag) {
        [[NSFileManager defaultManager] createDirectoryAtPath:gifDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *gifFilePath = [gifDirectory stringByAppendingPathComponent:@"1.gif"];
    //    NSLog(@"gifFilePath = %@",gifFilePath);
    
    
    //创建gif动画
    //图像目标
    CGImageDestinationRef destination;
    //创建CFURL对象
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)gifFilePath, kCFURLPOSIXPathStyle, false);
    //通过一个url
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, sourceImages.count, NULL);
    //设置gif信息,播放时间，基本数据和delay时间
    NSDictionary *frameGifProperties = @{(NSString *)kCGImagePropertyGIFDictionary:@{(NSString *)kCGImagePropertyGIFDelayTime:[NSNumber numberWithFloat:speed]}};
    //设置gif信息
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:@YES forKey:(NSString *)kCGImagePropertyGIFHasGlobalColorMap];
    [dictionary setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    [dictionary setObject:@8 forKey:(NSString *)kCGImagePropertyDepth];
    [dictionary setObject:@0 forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary *theGifProperties = @{(NSString *)kCGImagePropertyGIFDictionary:dictionary};
    
    
    //合成gif
    for (int i = 0; i < sourceImages.count; i++) {
        UIImage *img = [sourceImages objectAtIndex:i];
        CGImageRef ref = img.CGImage;
        CGImageDestinationAddImage(destination, ref, (__bridge CFDictionaryRef)frameGifProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)theGifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
}


@end