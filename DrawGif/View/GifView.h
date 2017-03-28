//
//  GifView.h
//  GifDemo
//
//  Created by vincent on 15/8/27.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
@interface GifView : UIView
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    NSTimer *timer;
    
    NSMutableArray *_images;
    
}

@property (nonatomic,readonly,strong)NSMutableArray *images;

@property (nonatomic,strong)NSString *gifPath;

-(id)initWithFrame:(CGRect)frame FilePath:(NSString *)filePath;
-(void)changetime:(CGFloat)time;
//-(id)initWithFrame:(CGRect)frame Data:(NSData *)data;

+(void)createGifViewWithImages:(NSArray *)sourceImages Speed:(CGFloat)speed;

@end