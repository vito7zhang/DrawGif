//
//  CameraViewController.m
//  DrawGif
//
//  Created by ibokan on 15/9/11.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "CameraViewController.h"
#import "PlayViewController.h"
#import "LocalPhotoViewController.h"
#import "ViewController.h"
#import "PostViewController.h"

@interface CameraViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
{
    int count ;
    UIView *colorView ;
    UIView *lineView;
    int page;
    int currentPage ;
}
@end

@implementation CameraViewController

@synthesize titleView = titleView ;
@synthesize scrollView = scrollView ;
@synthesize cameraPhotos = cameraPhotos ;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    count = 1;
    currentPage = 1 ;
    self.navigationController.toolbarHidden = NO ;
    /*--------------toolBarButton---------------------------*/
    NSMutableArray *baritems = [NSMutableArray array];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [baritems addObject:space];
    
    UIImage *image = [UIImage imageNamed:@"color_new"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(colorAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem1 = [[UIBarButtonItem alloc]initWithCustomView:button];
    [baritems addObject:barbuttonItem1];
    [baritems addObject:space];
    
    image = [UIImage imageNamed:@"lineWidth_new"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lineWidthAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem2 = [[UIBarButtonItem alloc]initWithCustomView:button];
    [baritems addObject:barbuttonItem2];
    [baritems addObject:space];
    
    image = [UIImage imageNamed:@"delecate_new"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem4 = [[UIBarButtonItem alloc]initWithCustomView:button];
    [baritems addObject:barbuttonItem4];
    [baritems addObject:space];
    
    image = [UIImage imageNamed:@"clear_new"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem5 = [[UIBarButtonItem alloc]initWithCustomView:button];
    [baritems addObject:barbuttonItem5];
    [baritems addObject:space];
    
    image = [UIImage imageNamed:@"target_new"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tragetAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem6 = [[UIBarButtonItem alloc]initWithCustomView:button];
    [baritems addObject:barbuttonItem6];
    [baritems addObject:space];
    self.toolbarItems = baritems;
    
    self.navigationController.toolbar.tintColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:232/255.0 alpha:1];
    
    /*--------------Bartitle---------------------------*/
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30 , 30);
    [button setTitle:@"图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button ;
    
    /*-----------------rightBarButton--------------------------------*/
    image = [UIImage imageNamed:@"add_new2"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25 , 25);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = addBarButton ;
    
    /*-----------------leftBarButton-------------------------------------*/
    image = [UIImage imageNamed:@"save_new2"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBarButton ;
    
    /*---------------图形编辑------------------------*/
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)];
    //内容大小
    //    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
    //偏移量
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self ;
    //    scrollView.pagingEnabled = YES ;
    scrollView.showsHorizontalScrollIndicator = NO ;
    scrollView.scrollEnabled = NO;
    
//    NSLog(@"cameraContrller.photos = %@",self.cameraPhotos);
    
    //拿到Images
    NSArray *array = [self.cameraPhotos objectAtIndex:0];
    int number = (int)array.count;
    for (int i = 0 ; i < number; i++)
    {
        UIImage *cPhotos = array[i];
        /*-----------DrawView---------------------*/
        _drawView = [[DrawView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        _drawView.tag = 1000+count;
        [scrollView addSubview:_drawView];
        _drawView.backgroundImage = cPhotos;
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
        count++;
    }
    count--;
    
    [self.view addSubview:scrollView];
    
    /*------------colorView-------------------------------*/
    colorView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height - 44 -30, Screen_Width, 30)];
    [self.view addSubview:colorView];
    colorView.hidden = YES ;
    
    UIButton *colorButton ;
    NSArray *colorItems = @[@"红",@"橙",@"黄",@"绿",@"蓝",@"定",@"紫",@"黑"];
    
    //红
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(0, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[0] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(redColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor redColor];
    [colorView addSubview:colorButton];
    
    //橙
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[1] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(orignColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor orangeColor];
    [colorView addSubview:colorButton];
    
    //黄
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(2*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[2] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(yellowColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor yellowColor];
    [colorView addSubview:colorButton];
    
    //绿
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(3*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[3] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(greenColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor greenColor];
    [colorView addSubview:colorButton];
    
    //蓝
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(4*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[4] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(blueColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor blueColor];
    [colorView addSubview:colorButton];
    //定
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(5*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[5] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(cyanColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor cyanColor];
    [colorView addSubview:colorButton];
    //紫
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(6*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[6] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(purpleColorAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor purpleColor];
    [colorView addSubview:colorButton];
    
    //黑
    colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    colorButton.frame = CGRectMake(7*Screen_Width/8, 0, Screen_Width/8, 30);
    [colorButton setTitle:colorItems[7] forState:UIControlStateNormal];
    [colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(blackAction:) forControlEvents:UIControlEventTouchUpInside];
    colorButton.layer.cornerRadius = 5;
    colorButton.layer.masksToBounds = YES ;
    colorButton.backgroundColor = [UIColor blackColor];
    [colorView addSubview:colorButton];
    
    /*-----------lineView设置-------------------------*/
    lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44-30, Screen_Width, 30)];
    lineView.backgroundColor = [UIColor clearColor];
    lineView.hidden = YES ;
    [self.view addSubview:lineView];
    
    //1
    UIButton *lineWidthButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lineWidthButton.frame = CGRectMake(0, 0, Screen_Width/5, 30);
    lineWidthButton.layer.borderWidth =1;
    lineWidthButton.layer.borderColor = [UIColor grayColor].CGColor;
    lineWidthButton.layer.cornerRadius = 5;
    lineWidthButton.layer.masksToBounds = YES;
    [lineWidthButton setTitle:@"1" forState:UIControlStateNormal];
    [lineWidthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(oneAction:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:lineWidthButton];
    
    //2
    lineWidthButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lineWidthButton.frame = CGRectMake(Screen_Width/5, 0, Screen_Width/5, 30);
    lineWidthButton.layer.borderWidth =1;
    lineWidthButton.layer.borderColor = [UIColor grayColor].CGColor;
    lineWidthButton.layer.cornerRadius = 5;
    lineWidthButton.layer.masksToBounds = YES;
    [lineWidthButton setTitle:@"2" forState:UIControlStateNormal];
    [lineWidthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(twoAction:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:lineWidthButton];
    
    //3
    lineWidthButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lineWidthButton.frame = CGRectMake(2*Screen_Width/5, 0, Screen_Width/5, 30);
    lineWidthButton.layer.borderWidth =1;
    lineWidthButton.layer.borderColor = [UIColor grayColor].CGColor;
    lineWidthButton.layer.cornerRadius = 5;
    lineWidthButton.layer.masksToBounds = YES;
    [lineWidthButton setTitle:@"3" forState:UIControlStateNormal];
    [lineWidthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(threeAction:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:lineWidthButton];
    
    //4
    lineWidthButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lineWidthButton.frame = CGRectMake(3*Screen_Width/5, 0, Screen_Width/5, 30);
    lineWidthButton.layer.borderWidth =1;
    lineWidthButton.layer.borderColor = [UIColor grayColor].CGColor;
    lineWidthButton.layer.cornerRadius = 5;
    lineWidthButton.layer.masksToBounds = YES;
    [lineWidthButton setTitle:@"4" forState:UIControlStateNormal];
    [lineWidthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(fourAction:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:lineWidthButton];
    
    //5
    lineWidthButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lineWidthButton.frame = CGRectMake(4*Screen_Width/5, 0, Screen_Width/5, 30);
    lineWidthButton.layer.borderWidth =1;
    lineWidthButton.layer.borderColor = [UIColor grayColor].CGColor;
    lineWidthButton.layer.cornerRadius = 5;
    lineWidthButton.layer.masksToBounds = YES;
    [lineWidthButton setTitle:@"5" forState:UIControlStateNormal];
    [lineWidthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(fiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:lineWidthButton];
    
    
    /*--------------titleView----------------------*/
    titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(Screen_Width/2-100, 64, 200, 35*count+5)];
    titleView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    titleView.layer.cornerRadius = 5;
    titleView.layer.masksToBounds = YES ;
    titleView.tag = 300;
    titleView.hidden = YES ;
    [self.view addSubview:titleView];
    if (35*(count-1) >= Screen_Height - 64 - 44 )
    {
        int number = count - (int)( (Screen_Height-64-44) / 35 ) ;
        titleView.contentSize = CGSizeMake(0, 35*(count + number));
    }
    else
    {
        titleView.contentSize = CGSizeMake(0, 35*(count+1)+5);
    }
    titleView.showsVerticalScrollIndicator = NO ;
    [self.view addSubview:titleView];
    
    /*--------------titleButton---------------------------*/
    for (int i = 1 ; i<= count ; i++)
    {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        titleButton.frame = CGRectMake(25, 5*i + 30*(i-1), 150, 30);
        [titleButton setTitle:[NSString stringWithFormat:@"图片%d",i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(changePageAction:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.backgroundColor = [UIColor orangeColor];
        titleButton.layer.cornerRadius = 5;
        titleButton.layer.masksToBounds = YES ;
        titleButton.tag = 200+i ;
        [titleView addSubview:titleButton];
    }
    
}

#pragma mark --------toorBarAction------------
-(void)colorAction:(UIButton *)sender
{
    colorView.hidden = !colorView.hidden ;
    if (colorView.hidden == NO)
    {
        lineView.hidden = YES;
    }
}

-(void)lineWidthAction:(UIButton *)sender
{
    lineView.hidden = !lineView.hidden ;
    if (lineView.hidden == NO)
    {
        colorView.hidden = YES ;
    }
}

-(void)deleAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RepealNotification object:self];
    DrawView *drawView = (DrawView *)[self.view viewWithTag:1000+currentPage];
    [drawView.lines removeLastObject];
}

-(void)clearAction:(UIButton *)sender
{
    [[[UIAlertView alloc]initWithTitle:@"删除当前画板" message:@"是否要清空" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil] show];
}

/*------------UIAlertView-------------------*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (currentPage == count)
        {
            //最后一张DrawView的删除
            DrawView * drawView = (DrawView *)[self.view viewWithTag:1000+currentPage];
            [drawView removeFromSuperview];
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(currentPage-2), 0) animated:YES];
            
            //最后一个button的删除
            UIButton *titleButton = (UIButton *)[self.view viewWithTag:200+currentPage];
            [titleButton removeFromSuperview];
            count--;
            currentPage--;
            
            //完善只有一张画的情况
            if (currentPage == 0)
            {
                count++;
                currentPage++;
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
                DrawView *drawView = [[DrawView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width*(count-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                drawView.tag = 1000+count ;
                [scrollView addSubview:drawView];
                [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(count-1), 0) animated:YES];
                
                //添加titleView中的button
                UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
                titleButton.frame = CGRectMake(25, 30*(count -1)+5*count, 150, 30);
                [titleButton setTitle:[NSString stringWithFormat:@"图片%d",(count)]forState:UIControlStateNormal];
                [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [titleButton addTarget:self action:@selector(changePageAction:) forControlEvents:UIControlEventTouchUpInside];
                titleButton.backgroundColor = [UIColor orangeColor];
                titleButton.layer.cornerRadius = 5;
                titleButton.layer.masksToBounds = YES ;
                titleButton.tag = 200+ count;
                [titleView addSubview:titleButton];
            }
        }
        else if ( currentPage < count && currentPage == 1)
        {
            DrawView *drawView = (DrawView *)[self.view viewWithTag:1000+currentPage];
            [drawView removeFromSuperview];
            count--;
            
            for (int i = 2 ; i <= scrollView.subviews.count; i++)
            {
                drawView = (DrawView *)[self.view viewWithTag:1000+i];
                drawView.tag = 1000+i-1;
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
                drawView.frame = CGRectMake(scrollView.frame.size.width*(i-2), 0, scrollView.frame.size.width, scrollView.frame.size.height);
            }
            
            for (int i = 2 ; i <= titleView.subviews.count; i++)
            {
                UIButton *titleButton = (UIButton *)[self.view viewWithTag:200+i];
                titleButton.tag = 200+i-1;
                titleButton.frame = CGRectMake(25, 30*(i-2)+5*(i-1), 150, 30);
                [titleButton setTitle:[NSString stringWithFormat:@"图片%d",(i-1)] forState:UIControlStateNormal];
            }
        }
        else if (currentPage < count)
        {
            DrawView *drawView = (DrawView *)[self.view viewWithTag:1000+currentPage];
            [drawView removeFromSuperview];
            count--;
            
            for (int i = currentPage+1 ; i <= scrollView.subviews.count; i++)
            {
                drawView = (DrawView *)[self.view viewWithTag:1000+i];
                drawView.tag = 1000+i-1;
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, 0);
                drawView.frame = CGRectMake(scrollView.frame.size.width*(i-2), 0, scrollView.frame.size.width, scrollView.frame.size.height);
            }
            
            
            UIButton *titleButoon;
            for (int i = currentPage+1; i < titleView.subviews.count+1; i++)
            {
                titleButoon = (UIButton *)[self.view viewWithTag:200+i];
                titleButoon.tag = 200+i-1;
                titleButoon.frame = CGRectMake(25, 30*(i-2)+5*(i-1), 150, 30);
                [titleButoon setTitle:[NSString stringWithFormat:@"图片%d",(i-1)] forState:UIControlStateNormal];
            }
            titleButoon = (UIButton *)[self.view viewWithTag:200+count+1];
            [titleButoon removeFromSuperview];
        }
        //删除后修改titleView的高度
        titleView.frame = CGRectMake(Screen_Width/2-100, 64, 200, 35*(count)+5);
        if (35*(count-1) >= Screen_Height - 64 - 44 )
        {
            int number = count - (int)( (Screen_Height-64-44) / 35 ) ;
            titleView.contentSize = CGSizeMake(0, 35*(count + number));
        }
        else
        {
            titleView.contentSize = CGSizeMake(0, 35*(count+1)+5);
        }
        titleView.showsVerticalScrollIndicator = NO ;
    }
}

-(void)tragetAction:(UIButton *)sender
{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= count; i++) {
        DrawView *drawView = (DrawView *)[self.view viewWithTag:1000+i];
        UIGraphicsBeginImageContext(drawView.bounds.size);
        [drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
        [images addObject:image];
        UIGraphicsEndImageContext();
    }
    PlayViewController *playViewController = [[PlayViewController alloc] init];
    playViewController.images = images;
    
//    [self presentViewController:playViewController animated:YES completion:nil];
    if (count == 1 )
    {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，合成GIF至少需要2幅图片哦!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
    else
    {
        playViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
        [self presentViewController:playViewController animated:YES completion:nil];
    }
}

-(void)addAction:(UIButton *)sender
{
      [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)backAction:(UIButton *)sender
{
    ViewController *viewController = [ViewController new];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)titleAction:(UIButton *)sender
{
    titleView.hidden = !titleView.hidden ;
}

#pragma mark --------scrollerView Delegate------------
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//}
//
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//
//}

#pragma mark ----------colorButtonAction------------------
-(void)redColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(1),@"G":@(0),@"B":@(0)}];
}

-(void)orignColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(1),@"G":@(0.5),@"B":@(0)}];
}

-(void)yellowColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(1),@"G":@(1),@"B":@(0)}];
}

-(void)greenColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(0),@"G":@(1),@"B":@(0)}];
}

-(void)cyanColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(0),@"G":@(1),@"B":@(1)}];
}

-(void)blueColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(0),@"G":@(0),@"B":@(1)}];
}

-(void)purpleColorAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(0.5),@"G":@(0),@"B":@(0.5)}];
}

-(void)blackAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ColorChangeNotification object:self userInfo:@{@"R":@(0),@"G":@(0),@"B":@(0)}];
}

#pragma mark ------------lineWidthButton---------------------
-(void)oneAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWithChangeNotification object:self userInfo:@{@"lineWidth":@(1)}];
}

-(void)twoAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWithChangeNotification object:self userInfo:@{@"lineWidth":@(2)}];
}

-(void)threeAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWithChangeNotification object:self userInfo:@{@"lineWidth":@(3)}];
}

-(void)fourAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWithChangeNotification object:self userInfo:@{@"lineWidth":@(4)}];
}

-(void)fiveAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LineWithChangeNotification object:self userInfo:@{@"lineWidth":@(5)}];
}

#pragma mark -----------changePageAction-------------------
-(void)changePageAction:(UIButton *)sender
{
    page = (int)(sender.tag - 200) ;
    currentPage = page ;
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(page-1), 0) animated:NO];
    
    if (_isInViewController == NO)
    {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(page-1), 0) animated:NO];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
