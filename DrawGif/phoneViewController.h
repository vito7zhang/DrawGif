//
//  phoneViewController.h
//  DrawGif
//
//  Created by Ibokan on 15/9/7.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "EditViewController.h"
#import "DrawView.h"

@interface phoneViewController : UIViewController

@property (nonatomic,strong)DrawView *drawView;
@property (nonatomic,strong)UIScrollView *titleView;
@property (nonatomic,strong)UIScrollView *scrollView  ;
@property (nonatomic,strong) NSMutableArray *images ;

//addAction
@property (nonatomic,assign)BOOL isInViewController ;

@end
