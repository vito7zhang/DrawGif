//
//  DrawView.h
//  DrawGif
//
//  Created by ibokan on 15/9/1.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
{
//    NSMutableArray *lines ;
    UIColor *lineColor ;
    id lineWidth ;
}

@property (nonatomic,strong) NSMutableArray *lines ;
@property (nonatomic,strong) UIImage *backgroundImage;

//@property (nonatomic,strong)UIImage *backgroundImage ;

@end
