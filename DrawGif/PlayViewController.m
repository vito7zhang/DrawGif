//
//  PlayViewController.m
//  MakeGif
//
//  Created by vincent on 15/8/27.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "PlayViewController.h"
#import "GifView.h"
#import "TencentOpenAPI/QQApiInterfaceObject.h"
#import "TencentOpenAPI/QQApiInterface.h"
@interface PlayViewController ()
{
    GifView *gifView;
}
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    imageView.image = [UIImage imageNamed:@"Launcha"];
    [self.view addSubview:imageView];
    
    [GifView createGifViewWithImages:_images Speed:0.3];
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifDir"];
    filePath = [filePath stringByAppendingPathComponent:@"1.gif"];
    
    gifView = [[GifView alloc] initWithFrame:CGRectMake(100,100, Screen_Width-200,Screen_Width-200) FilePath:filePath];
    [self.view addSubview:gifView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 300, Screen_Width, 80)];
    [self.view addSubview:scrollView];
    for (int i = 0; i < gifView.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*60, 0, 60, 80)];
        imageView.image = gifView.images[i];
        [scrollView addSubview:imageView];
    }
    gifView.tag = 10086;
    scrollView.contentSize = CGSizeMake(gifView.images.count*60, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    //    button.frame = CGRectMake(Screen_Width/2-17.5, Screen_Height/2+100, 35, 35);
    button.frame = CGRectMake(0, 44, 35, 35);
    [button addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(100, 70, Screen_Width-200, 28)];
    slider.minimumValue = 0.01;
    slider.maximumValue = 0.4;
    slider.value = 0.2;
    slider.tag = 10001;
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(speedAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
    UIButton * qqSharebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qqSharebutton.frame = CGRectMake((self.view.bounds.size.width-216)/2,self.view.bounds.size.height-24, 96, 24);
    [qqSharebutton setBackgroundImage:[UIImage imageNamed:@"QQShareButton"] forState:UIControlStateNormal];
    [qqSharebutton addTarget:self action:@selector(share1ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    qqSharebutton.layer.cornerRadius = 5;
    qqSharebutton.layer.masksToBounds = YES;
    [self.view addSubview:qqSharebutton];
    
    UIButton *qZontShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    qZontShareButton.frame = CGRectMake((self.view.bounds.size.width-216)/2+96,self.view.bounds.size.height-24, 120, 24);
    [qZontShareButton setBackgroundImage:[UIImage imageNamed:@"QZoneShareButton"] forState:UIControlStateNormal];
    
    [qZontShareButton addTarget:self action:@selector(share2ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    qZontShareButton.layer.cornerRadius = 5;
    qZontShareButton.layer.masksToBounds = YES;
    [self.view addSubview:qZontShareButton];
    
    
}
-(void)speedAction:(UISlider *)sender{
    GifView *gifView = (GifView *)[self.view viewWithTag:10086];
    [gifView changetime:sender.value];
}
-(void)share1ButtonAction:(UIButton *)sender{
    UISlider *slider = (UISlider *)[self.view viewWithTag:10001];
    [GifView createGifViewWithImages:_images Speed:slider.value];
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifDir"];
    filePath = [filePath stringByAppendingPathComponent:@"1.gif"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:@"drawGif" description:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    [QQApiInterface sendReq:req];
}
-(void)share2ButtonAction:(UIButton*)sender{
//    UISlider *slider = (UISlider *)[self.view viewWithTag:10001];
//    [GifView createGifViewWithImages:_images Speed:slider.value];
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifDir"];
//    filePath = [filePath stringByAppendingPathComponent:@"1.gif"];
//    NSData* data = [NSData dataWithContentsOfFile:filePath];
//    QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:@"drawGif" description:nil];
//    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
//    [QQApiInterface  SendReqToQZone:req];
    UISlider *slider = (UISlider *)[self.view viewWithTag:10001];
    [GifView createGifViewWithImages:_images Speed:slider.value];
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifDir"];
    filePath = [filePath stringByAppendingPathComponent:@"1.gif"];
    
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:@"drawGif" description:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    [QQApiInterface sendReq:req];
}
-(void)goback:(UIButton *)sender
{
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end