//
//  CameraViewController.h
//  DrawGif
//
//  Created by ibokan on 15/9/11.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"
@interface CameraViewController : UIViewController

@property (nonatomic,strong)DrawView *drawView;
@property (nonatomic,strong)UIScrollView *titleView;
@property (nonatomic,strong)UIScrollView *scrollView  ;
@property (nonatomic,strong) NSMutableArray *images ;
@property (nonatomic,strong) NSMutableArray *cameraPhotos ;

//addAction
@property (nonatomic,assign)BOOL isInViewController ;

@end
