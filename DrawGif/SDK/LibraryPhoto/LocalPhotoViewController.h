//
//  LocalPhotoViewController.h
//  AlbumTest
//
//  Created by ejiang on 14-7-28.
//  Copyright (c) 2014年 daijier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LocalPhotoCell.h"
#import "LocalAlbumTableViewController.h"
#import "AssetHelper.h"
#import "DrawView.h"
#import "ViewController.h"
#import "phoneViewController.h"
@class ViewController;
@protocol SelectPhotoDelegate<NSObject>
@optional
-(void)getSelectedPhoto:(NSMutableArray *)photos;

@end
@class LocalPhotoViewController;
typedef void(^conforms)(LocalPhotoViewController *localViewController,NSMutableArray *photos);

typedef void(^addActionConforms)(LocalPhotoViewController *localViewController,NSMutableArray *photos);

@interface LocalPhotoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,SelectAlbumDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *lbAlert;
- (IBAction)btnConfirm:(id)sender;
@property (nonatomic,retain) id<SelectPhotoDelegate> selectPhotoDelegate;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) ALAssetsGroup *currentAlbum;
@property (nonatomic, strong) NSMutableArray *selectPhotos;
//
@property (nonatomic,strong)DrawView *drawView;

@property (nonatomic,copy) conforms conformsBlock ;

//
@property (nonatomic,assign)BOOL isInViewController ;
@property (nonatomic,copy) addActionConforms addActionConformsBlock ;

@end
