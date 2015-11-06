//
//  ViewController.m
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//

#import "ViewController.h"

#import "NewsListViewController.h"
#import "RadioListViewController.h"
#import "VideoListViewController.h"
#import "MyInfoViewController.h"
#import "PlayerViewController.h"
#import "AudioStreamer.h"
#import <AVFoundation/AVFoundation.h>

#import "UIColor+CustomColor.h"
@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic, strong)UIViewController *bofang;
@property (nonatomic,strong)NSString *picString;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 电台 controll
    RadioListViewController *radioVC = [[RadioListViewController alloc] init];
    radioVC.title = @"电台";
    radioVC.tabBarItem.image = [UIImage imageNamed:@"radio@2x"];
    UINavigationController *radioNC = [[UINavigationController alloc] initWithRootViewController:radioVC];
    
    // 新闻 controller
    NewsListViewController *newsVC = [[NewsListViewController alloc] init];
    newsVC.title = @"新闻";
    newsVC.tabBarItem.image = [UIImage imageNamed:@"news@2x"];
    UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    // 播放器 controller
    self.bofang = [[UIViewController alloc] init];
    
    // 视频 controller
    VideoListViewController *videoVC = [[VideoListViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.tabBarItem.image = [UIImage imageNamed:@"video@2x"];
    UINavigationController *videoNC = [[UINavigationController alloc] initWithRootViewController:videoVC];
    
    // 我的 controller
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
    myInfoVC.title = @"我的";
    myInfoVC.tabBarItem.image = [UIImage imageNamed:@"wode@2x"];
    UINavigationController *myInfoNC = [[UINavigationController alloc] initWithRootViewController:myInfoVC];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgnav"]forBarMetrics:(UIBarMetricsDefault)];

    
    // tabbarController
    self.viewControllers = @[radioNC, newsNC,_bofang,videoNC, myInfoNC];
    
    
    // 播放器 背景图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width/2 - 28.75, self.view.bounds.size.height - 61, 57.5, 61))];
    image.image = [UIImage imageNamed:@"zhanting@2x"];
    [self.view addSubview:image];
    
     // 推出 播放器视图 按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button addTarget:self action:@selector(player:) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = image.frame;
    [self.view addSubview:button];
    
    
    // 旋转图片
    _imageView= [[UIImageView alloc ] init];
    _imageView.frame = CGRectMake(4, 4, 50, 50);
    _imageView.layer.cornerRadius = 50 / 2.f;
    _imageView.clipsToBounds = YES;
    
    [button addSubview:_imageView];
    
    // 旋转动画
  
    
    // 图标点击后的颜色
    self.tabBar.tintColor = [UIColor darkOrangeColor];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action:) name:@"notificationName1" object:nil];
    
    
    //通知2.改变动画
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action2:) name:@"pause" object:nil];
    [button addSubview:_imageView];

    
}

//通知1事件

-(void)action:(NSNotification *)object{
    
    self.imageView.layer.speed = 0.5;
    
    self.picString = object.object ;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.picString] placeholderImage:nil];
    
    [self animation:self.imageView isRotate:YES];
    
    
    
    
    
    
    
    
}

//通知2事件
-(void)action2:(NSNotification *)object{
    
    
    
    
    _imageView.layer.speed = 0;
    
    
    
}

#pragma mark -- 模态推出播放器视图
-(void)player:(UIButton *)button
{
    PlayerViewController *playVC = [PlayerViewController sharedController];

    UINavigationController *playNC = [[UINavigationController alloc]initWithRootViewController: playVC];

    
    [self presentViewController:playNC animated:YES completion:nil];
}



#pragma mark -- 旋转动画
-(void)animation:(UIImageView *)imageView isRotate:(BOOL)isrotate{
    
    if (isrotate == YES) {
        imageView.layer.speed = 0.5;
        
        [UIView animateWithDuration:0.02 animations:^{
            //基于上一次状态
            _imageView.transform = CGAffineTransformRotate(_imageView.transform, M_PI/180);
        } completion:^(BOOL finished) {
            
            [self animation:self.imageView isRotate:YES];
        }];
    }else{
        
    }
    
    
    
    
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
