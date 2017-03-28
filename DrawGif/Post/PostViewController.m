//
//  PostViewController.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-21.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "PostViewController.h"
#import "CameraViewController.h"
#import "SCNavigationController.h"
@interface PostViewController ()

@end

@implementation PostViewController
@synthesize photosArray = photosArray ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    if (_postImage) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:_postImage];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
        imgView.center = self.view.center;
        [self.view addSubview:imgView];
    }
    
    //需重新布局以及改变样式
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame= CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width-5, 40);
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBtn setTitle:@"继续拍照" forState:UIControlStateNormal];
    backBtn.frame= CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width-5, 40);
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

-(void)doneAction:(UIButton *)sender
{
    CameraViewController *cameraViewController = [[CameraViewController alloc]init];
    UINavigationController *cameraNavigationController = [[UINavigationController alloc]initWithRootViewController:cameraViewController];
    [self presentViewController:cameraNavigationController animated:YES completion:^{
    }];
    cameraViewController.cameraPhotos = [NSMutableArray array];
//    [cameraViewController.cameraPhotos addObject:self.photosArray];
    cameraViewController.cameraPhotos = self.photosArray ;
//    NSLog(@"photosARRAY = %@",self.photosArray);
}

-(void)backAction:(UIButton *)sender
{
    [photosArray addObject:self.postImage];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
