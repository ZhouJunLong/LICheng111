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

#import "UIColor+CustomColor.h"
@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;

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
    UIViewController *bofang = [[UIViewController alloc] init];
    
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
    
    
    
    // tabbarController
    self.viewControllers = @[radioNC, newsNC,bofang,videoNC, myInfoNC];
    
    
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
    _imageView.layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"text.jpg"]].CGColor;
    [button addSubview:_imageView];
    
    // 旋转动画
    [self animation:_imageView];
    
    // 图标点击后的颜色
    self.tabBar.tintColor = [UIColor darkOrangeColor];

}

#pragma mark -- 模态推出播放器视图
-(void)player:(UIButton *)button
{
    PlayerViewController *play = [[PlayerViewController alloc] init];
    [self presentViewController:play animated:YES completion:nil];
    NSLog(@"%@",self.navigationController);
}

#pragma mark -- 旋转动画
static int k = 10;
-(void)animation:(UIImageView *)imageView{
    
    [UIView animateWithDuration:0.1 animations:^{
        CGAffineTransform angle = CGAffineTransformMakeRotation(k*M_PI/180);
        imageView.transform = angle;
    } completion:^(BOOL finished) {
        k+=10;
        [self animation:self.imageView];
    }];
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
