#import "ViewController.h"
#import "EditViewController.h"
#import "phoneViewController.h"
#import "LocalPhotoViewController.h"
#import "CameraViewController.h"
@interface ViewController ()
{
    UIButton *drawButton;
    UIButton *phoneButton;
    UIButton *cameraButton;
    NSMutableArray *cameraPhotos ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#define make 主页背景图片设计
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backgroundImage"]];
    backgroundImage.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self.view addSubview:backgroundImage];
    
#define mark 主页上方图标
    UIImageView *topLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gIcon128"]];
    topLeftImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topLeftImage];
    float shewX = -0.23*Screen_Width;
    float shewY = -0.3*Screen_Height;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:topLeftImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:shewX];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topLeftImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topLeftImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.34 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topLeftImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.19 constant:0];
    [self.view addConstraint:constraint];
    
    UIImageView *topRightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"word"]];
    topRightImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topRightImage];
    shewX = 0.12*Screen_Width;
    shewY = -0.3*Screen_Height;
    constraint = [NSLayoutConstraint constraintWithItem:topRightImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:shewX];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topRightImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topRightImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.75 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:topRightImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.12 constant:0];
    [self.view addConstraint:constraint];
    
    drawButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [drawButton setTitle:@"绘图制GIF" forState:UIControlStateNormal];
    [drawButton setTintColor:[UIColor whiteColor]];
    drawButton.translatesAutoresizingMaskIntoConstraints = NO;
    drawButton.layer.masksToBounds = YES;
    drawButton.layer.cornerRadius = 15;
    drawButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:123/255.0 blue:1 alpha:1];
    [self.view addSubview:drawButton];
    shewY = -0.09*Screen_Height;
    constraint = [NSLayoutConstraint constraintWithItem:drawButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.045 constant:0];
    [self.view addConstraint:constraint];
    
    //---------------------------------------------
    phoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [phoneButton setTitle:@"相册GIF" forState:UIControlStateNormal];
    [phoneButton setTintColor:[UIColor whiteColor]];
    phoneButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:123/255.0 blue:1 alpha:1];
    phoneButton.translatesAutoresizingMaskIntoConstraints = NO;
    phoneButton.layer.masksToBounds = YES;
    phoneButton.layer.cornerRadius = 15;
    phoneButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:123/255.0 blue:1 alpha:1];
    [self.view addSubview:phoneButton];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.045 constant:0];
    [self.view addConstraint:constraint];
    
    //---------------------------------------------
    cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cameraButton setTitle:@"相机GIF" forState:UIControlStateNormal];
    [cameraButton setTintColor:[UIColor whiteColor]];
    cameraButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:123/255.0 blue:1 alpha:1];
    cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
    cameraButton.layer.masksToBounds = YES;
    cameraButton.layer.cornerRadius = 15;
    cameraButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:123/255.0 blue:1 alpha:1];
    [self.view addSubview:cameraButton];
    shewY = 0.09*Screen_Height;
    constraint = [NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.045 constant:0];
    [self.view addConstraint:constraint];
    
    //---------------------------------------------
    UIImageView *drawButtonImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"drawButtonImage"]];
    [self.view addSubview:drawButtonImage];
    shewX = -0.3*Screen_Width;
    shewY = -0.09*Screen_Height;
    drawButtonImage.translatesAutoresizingMaskIntoConstraints = NO;
    constraint = [NSLayoutConstraint constraintWithItem:drawButtonImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:shewX];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButtonImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButtonImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.117 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:drawButtonImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.066 constant:0];
    [self.view addConstraint:constraint];
    
    UIImageView *phoneButtonImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneButtonImage"]];
    [self.view addSubview:phoneButtonImage];
    shewX = -0.3*Screen_Width;
    phoneButtonImage.translatesAutoresizingMaskIntoConstraints = NO;
    constraint = [NSLayoutConstraint constraintWithItem:phoneButtonImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:shewX];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButtonImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButtonImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.117 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:phoneButtonImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.066 constant:0];
    [self.view addConstraint:constraint];
    
    UIImageView *cameraButtonImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cameraButtonImage"]];
    [self.view addSubview:cameraButtonImage];
    shewX = -0.3*Screen_Width;
    shewY = 0.09*Screen_Height;
    cameraButtonImage.translatesAutoresizingMaskIntoConstraints = NO;
    constraint = [NSLayoutConstraint constraintWithItem:cameraButtonImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:shewX];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButtonImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:shewY];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButtonImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.117 constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:cameraButtonImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.066 constant:0];
    [self.view addConstraint:constraint];
    
    [drawButton addTarget:self action:@selector(drawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton addTarget:self action:@selector(phoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self configureNotification:YES];
    //初始化cameraPhotos
    cameraPhotos = [NSMutableArray array];
    
}
-(void)drawButtonAction:(UIButton *)sender{
    EditViewController *editViewController = [[EditViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:editViewController];
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    [self presentViewController:navigationController animated:YES completion:^{}];
}

-(void)phoneButtonAction:(UIButton *)sender{
    LocalPhotoViewController *pick=[[LocalPhotoViewController alloc] init];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    pick.selectPhotoDelegate=self;
    UINavigationController *photoNavigationController = [[UINavigationController alloc]initWithRootViewController:pick];

    pick.conformsBlock = ^(LocalPhotoViewController *localViewController,NSMutableArray *photos)
    {
        phoneViewController *edit  = [[phoneViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:edit];
//        NSLog(@"ViewControllerPhotos = %@",photos);
        edit.images = photos ;
        
        if (photos.count == 0)
        {
        [[[UIAlertView alloc]initWithTitle:@"选择照片" message:@"亲，请先选择图片" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
        [localViewController presentViewController:navigationController animated:YES completion:^{
            }];
        }
    };

    [self presentViewController:photoNavigationController animated:YES completion:nil];
}

-(void)cameraButtonAction:(UIButton *)sender{
    SCNavigationController *nav = [[SCNavigationController alloc] init];
    nav.scNaigationDelegate = self;
    [nav showCameraWithParentController:self];
}

- (void)dealloc {
    [self configureNotification:NO];
}

- (void)configureNotification:(BOOL)toAdd {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTakePicture object:nil];
    if (toAdd) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackNotificationForFilter:) name:kNotificationTakePicture object:nil];
    }
}

- (void)callbackNotificationForFilter:(NSNotification*)noti {
    UIViewController *cameraCon = noti.object;
    if (!cameraCon) {
        return;
    }
    UIImage *finalImage = [noti.userInfo objectForKey:kImage];
    if (!finalImage) {
        return;
    }
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = finalImage;
    
    if (cameraCon.navigationController) {
        [cameraCon.navigationController pushViewController:con animated:YES];
    } else {
        [cameraCon presentModalViewController:con animated:YES];
    }
}

#pragma mark - SCNavigationController delegate
- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = image;
    [navigationController pushViewController:con animated:YES];
    
    [cameraPhotos addObject:image];
    
//    NSLog(@"cameraPhotos = %@",cameraPhotos);
    con.photosArray = [NSMutableArray array];
    [con.photosArray addObject:cameraPhotos] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
 @end
