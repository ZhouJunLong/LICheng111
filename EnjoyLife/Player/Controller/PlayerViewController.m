//
//  PlayerViewController.m
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//

#import "PlayerViewController.h"
#import "FocusModel.h"
#import "PlayView.h"
#import "AFHTTPRequestOperation.h"
#import "PlayDetailModel.h"
#import "PlayListViewController.h"
#import "TimingController.h"

#import "ViewController.h"

#import "LMusicPlay.h"


@interface PlayerViewController ()

@property (nonatomic,strong)NSMutableArray *playModelArray;
@end

@implementation PlayerViewController

//在很多时候，我们使用某个类的唯一实例。最常见的就是一个程序的主类，以下是 创建的一个单例函数：

static PlayerViewController *sharedRootController = nil;

+(PlayerViewController *) sharedController{
    
    @synchronized(self)
    {
        if (sharedRootController == nil)
        {
            sharedRootController = [[self alloc] init] ;

        }
    }
    return sharedRootController;
}









-(void)viewWillAppear:(BOOL)animated{
    self.playView.playB.alpha = 0;
    self.playView.pauseB.alpha = 1;
    

    
    self.navigationController.navigationBar.hidden = YES;
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backButton.frame = CGRectMake(20, 20, 30, 30);
    //[backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [backButton setImage:[[UIImage imageNamed:@"xiangXia"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [[LMusicPlay shareLmusicPlay] startPlay];
    
    self.playView.sortDetailList = self.sortDetailList;

    
    
    if (self.playView.pauseB.alpha == 1 ) {
        
        
        //动画转
        self.playView.imageV.layer.speed = 1;
    }
    
    //播放列表
    [self.playView.listB addTarget:self action:@selector(playList:) forControlEvents:(UIControlEventTouchUpInside)];
   //上一首
    [self.playView.upB addTarget:self action:@selector(upChange:) forControlEvents:(UIControlEventTouchUpInside)];
    //下一首
    [self.playView.nextB addTarget:self action:@selector(nextChange:) forControlEvents:(UIControlEventTouchUpInside)];
    //滑块
    [self.playView.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
    //播放
     [self.playView.playB addTarget:self action:@selector(bofang:) forControlEvents:(UIControlEventTouchUpInside)];
    //暂停
    [self.playView.pauseB addTarget:self action:@selector(pause:) forControlEvents:(UIControlEventTouchUpInside)];
    //定时关闭
    [self.playView.timeB addTarget:self action:@selector(Timing:) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
    
   
}
-(void)viewDidDisappear:(BOOL)animated{
    if (self.playView.playB.alpha == 1 ) {
//        
        //1.创建通知
        NSNotification *pause = [NSNotification notificationWithName:@"pause" object:self.sortDetailList.coverSmall];
        //2.发布通知
        //方式1 直接发布通知对象
        [[NSNotificationCenter defaultCenter]postNotification:pause];
    }
}



//消失按钮
- (void)back:(UIButton *)button{
    
    
    //1.创建通知
   NSNotification *notification = [NSNotification notificationWithName:@"notificationName1" object:self.sortDetailList.coverSmall];
    //2.发布通知
    //方式1 直接发布通知对象
   [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
  

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    self.playView = [[playDetailView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.playView];
    

    //背景模糊效果
    
//    UIBlurEffectStyleExtraLight,
//    UIBlurEffectStyleLight,
//    UIBlurEffectStyleDark
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
    
    view.frame = self.playView.bounds;
    
    [self.playView.imageLagerV addSubview:view];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starPlay) name:@"readyToPlay" object:nil];
    
    
    
   
   
   

}



-(void)starPlay{
    [[LMusicPlay shareLmusicPlay] startPlay];
}




-(void)setSortDetailList:(SortDetailList *)sortDetailList{
    _sortDetailList = sortDetailList;
    
    self.playView.playB.alpha = 0;
    self.playView.pauseB.alpha = 1;
    
    [[LMusicPlay shareLmusicPlay] playWithUrl:sortDetailList.playPathAacv164];
    
    
  
    

    //设置时间，每一秒钟调用一次绑定的方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    [[LMusicPlay shareLmusicPlay] stopPlay];
    
    [[LMusicPlay shareLmusicPlay] startPlay];
    
   
  
    
}
//时间进度
-(void)time{
    
    
    //self.player.progress
    self.playView.slider.minimumValue = 0;
    self.playView.slider.maximumValue = self.sortDetailList.duration;
    
    
    
    
   
    CGFloat progress = 1.0 * [LMusicPlay shareLmusicPlay].player.currentTime.value / [LMusicPlay shareLmusicPlay].player.currentTime.timescale;

    
    self.playView.slider.value = progress;
    
     NSTimeInterval currentTime = progress;
    
    //总时间
    NSTimeInterval totalTimer = self.sortDetailList.duration;
    //分钟数
    
    NSTimeInterval totalM = (int)totalTimer/60;
    
    NSTimeInterval totalTimer1 = (int)totalTimer%60;
    
    
    NSString *allString = [NSString stringWithFormat:@"%02.0f:%02.0f",totalM,totalTimer1];
    self.playView.endL.text = allString;
   
   
    //当前时间
    
    //把秒转换成分钟
    NSTimeInterval currentM = (int)currentTime/60;
  NSTimeInterval  currentmiao = (int)currentTime%60;
    
   
    
 
    
    //把时间显示在lable上
    NSString *currentString = [NSString stringWithFormat:@"%02.0f:%02.0f",currentM, currentmiao];
    self.playView.currentL.text = currentString;
    
    
    
    if ([currentString isEqualToString: allString]) {
        [self next];
    }
   
    
    
}



-(void)setSortDetailListModelArray:(NSMutableArray *)sortDetailListModelArray{
    _sortDetailListModelArray = sortDetailListModelArray;
    
    
    
    
    
    
}



#pragma mark--播放列表的button事件
-(void)playList:(UIButton *)button{
    
    PlayListViewController *playListVC = [[PlayListViewController alloc]init];
    playListVC.sortDetailListModelArray =   self.sortDetailListModelArray;
    
    [self.navigationController pushViewController:playListVC animated:YES];
}
//#pragma mark--上一曲
-(void)upChange:(UIButton *)button{
    
    [[LMusicPlay shareLmusicPlay] stopPlay];
    

    
    if (self.musicNumber == 0) {
        self.sortDetailList = [self.sortDetailListModelArray lastObject];
        self.musicNumber = self.sortDetailListModelArray.count-1;
    }else{
        self.musicNumber = self.musicNumber - 1;
     self.sortDetailList = self.sortDetailListModelArray[self.musicNumber];
    }
    

    

    
   
    self.playView.sortDetailList = self.sortDetailList;
    
    
    
    
    
    
    

    
}






#pragma mark--下一曲
-(void)nextChange:(UIButton *)button{
    
    
    
   
    [self next];
    
    
}

//下一曲的方法
-(void)next{
    [[LMusicPlay shareLmusicPlay] stopPlay];
    if (self.musicNumber == self.sortDetailListModelArray.count-1) {
        self.sortDetailList = self.sortDetailListModelArray[0];
        self.musicNumber = 0;
    }else{
        self.musicNumber = self.musicNumber + 1;
        self.sortDetailList = self.sortDetailListModelArray[self.musicNumber];
    }
    
    
    
    self.playView.sortDetailList = self.sortDetailList;
}



#pragma mark--滑块
-(void)sliderValueChange:(UISlider *)slider{
    

    
    [[LMusicPlay shareLmusicPlay]seekToTime:slider.value];
    
}


-(void)propertyAnimation{
        //1.开始动画
        [UIView beginAnimations:@"动画名称" context:@"传递给代理的参数"];
    
        //2.设置动画
        //动画持续的时间,重复几次,是否翻转等等
        [UIView setAnimationDuration:5];//动画持续时间
        [UIView setAnimationDelegate:self];//设置代理
    
        //代理触发的两个方法
        //动画开始前触发 sel方法
    
        [UIView setAnimationWillStartSelector:@selector(animationWillStart: context:)];
    
        //动画结束后触发sel方法
        [UIView setAnimationDidStopSelector:@selector(animationDidStop: finished: context:)];
    
        //更改frame属性
    
        self.titleLabel.frame = CGRectMake(60, 0, self.titleView.bounds.size.width, 30);
        
        
        
        
        //3.提交动画
        [UIView commitAnimations];
}


//动画开始前执行的操作

-(void)animationWillStart:(NSString *)animationID context:(void *)context{

}

//动画结束后执行操作

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    
    
    
    //NSLog(@"动画结束");
    
    //从右边在移动到左边
    //1.动画开始
    [UIView beginAnimations:nil context:nil];
    //2设置动画
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(propertyAnimation)];
    
    //3.更改属性
    self.titleLabel.frame = CGRectMake(0, 0, self.titleView.bounds.size.width , 30);
    //4.提交动画
    
    
    [UIView commitAnimations];
    
}

//播放时执行
-(void)bofang:(UIButton *)button{
    [[LMusicPlay shareLmusicPlay] startPlay];
    
    self.playView.playB.alpha = 0;
    self.playView.pauseB.alpha = 1;
    //动画转
    self.playView.imageV.layer.speed = 1;
    
    
}

//暂停时执行
-(void)pause:(UIButton *)button{
    
    [[LMusicPlay shareLmusicPlay] stopPlay];
    
    self.playView.playB.alpha = 1;
    self.playView.pauseB.alpha = 0;
//动画不转
    self.playView.imageV.layer.speed = 0;
    
    
    
}
//定时关闭
-(void)Timing:(UIButton *)button{
    TimingController *timeVC = [[TimingController alloc]init];
    [self.navigationController pushViewController:timeVC animated:YES];
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
