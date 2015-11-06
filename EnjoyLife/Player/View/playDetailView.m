//
//  playDetailView.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "playDetailView.h"
#import "UIColor+CustomColor.h"
@implementation playDetailView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        
        self.player= [AudioStreamer shareManager];
        
        self.imageLagerV = [[UIImageView alloc]init];
        //self.imageLagerV.alpha = 0.2;
        [self addSubview:self.imageLagerV];
        
        self.imageV = [[UIImageView alloc]init];
        //        self.imageV.layer.cornerRadius = self.contentView.bounds.size.width*2/6;
        [self addSubview:self.imageV];
        self.imageV.frame = CGRectMake(self.bounds.size.width/6, self.bounds.size.height/6, self.bounds.size.width*2/3, self.bounds.size.width*2/3);
        self.imageV.layer.cornerRadius = self.bounds.size.width*2/6;
       // self.imageV.layer.borderWidth = 3;
        self.imageV.layer.borderColor = [UIColor tiankonglan].CGColor;
        self.imageV.clipsToBounds = YES;
        //self.imageV.backgroundColor = [UIColor redColor];
        // 旋转动画
        [self animation:_imageV];

        
//        // 旋转动画
//        [self animation:_imageV];
        
        
        
        
        
        self.favourB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.favourB];
        [self.favourB setImage:[[UIImage imageNamed:@"zan1"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [self.favourB setImage:[[UIImage imageNamed:@"zan2"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateHighlighted)];
        
        
        self.collectB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.collectB];
        [self.collectB setImage:[[UIImage imageNamed:@"soucang"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ] forState:(UIControlStateNormal)];
        
        
        
        
        self.shareB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.shareB];
        [self.shareB setImage:[[UIImage imageNamed:@"fenxiang"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
        
        
        self.timeB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.timeB];
        [self.timeB setImage:[[UIImage imageNamed:@"dingshi"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
        
        self.favourL = [[UILabel alloc]init];
        self.favourL.text = @"赞";
        self.favourL.font = [UIFont systemFontOfSize:12];
        self.favourL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.favourL];
        
        
        
        self.collectL = [[UILabel alloc]init];
        self.collectL.text = @"收藏";
        self.collectL.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.collectL];
        
        
        self.shareL = [[UILabel alloc]init];
        self.shareL.text = @"分享";
        self.shareL.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.shareL];
        
        
        self.timeL = [[UILabel alloc]init];
        self.timeL.text = @"定时";
        self.timeL.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.timeL];
        
        
        self.slider = [[UISlider alloc]init];
        
        self.slider.minimumTrackTintColor=[UIColor jinjuse];
        [self addSubview:self.slider];
        //设置拇指按钮图片
        //[self.slider setThumbImage:[UIImage imageNamed:@"muzhi@2x"] forState:(UIControlStateNormal)];
        
        
        //**** 添加事件
//        [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
        
        
        
        
        self.listB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.listB];
        [self.listB setImage:[[UIImage imageNamed:@"caidan"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
        
        self.upB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.upB];
        [self.upB setImage:[UIImage imageNamed:@"up"] forState:(UIControlStateNormal)];
        
        
        self.playB = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.playB];
        [self.playB setImage:[[UIImage imageNamed:@"bofang"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
       // [self.playB addTarget:self action:@selector(bofang:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        
        
        
        
        self.pauseB = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.pauseB];
        
        [self.pauseB setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
       //self.pauseB.alpha = 0;
//        [self.pauseB addTarget:self action:@selector(pause:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        
        self.nextB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.nextB];
        [self.nextB setImage:[UIImage imageNamed:@"next"] forState:(UIControlStateNormal)];
        
        
        self.currentL = [[UILabel alloc]init];
        [self addSubview:self.currentL];
        //self.currentL.text = @"04:38";
        self.currentL.font = [UIFont systemFontOfSize:14];
        
        self.endL = [[UILabel alloc]init];
        [self addSubview:self.endL];
        //self.endL.text = @"04:38";
        self.endL.font = [UIFont systemFontOfSize:14];

        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        
        
        
        
        
        
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    

    
    self.favourB.frame = CGRectMake(self.bounds.size.width/9,  self.bounds.size.height*2/3, 30, 30);
    
    self.favourL.frame = CGRectMake(self.favourB.frame.origin.x, self.favourB.frame.origin.y+self.favourB.bounds.size.height+5 , 30, 30);
    
    
    
    self.collectB.frame = CGRectMake(self.bounds.size.width*3/9, self.favourB.frame.origin.y , 30,30);
    self.collectL.frame = CGRectMake(self.collectB.frame.origin.x, self.favourL.frame.origin.y , 30, 30);
    
    
    
    self.shareB.frame = CGRectMake(self.bounds.size.width*5/9, self.favourB.frame.origin.y , 30, 30);
    self.shareL.frame = CGRectMake(self.shareB.frame.origin.x, self.favourL.frame.origin.y , 30, 30);
    
    
    
    self.timeB.frame = CGRectMake(self.bounds.size.width*7/9, self.favourB.frame.origin.y,30 , 30);
    self.timeL.frame = CGRectMake(self.timeB.frame.origin.x, self.favourL.frame.origin.y,30 , 30);
    
    self.currentL.frame = CGRectMake(5, self.favourL.frame.origin.y + self.favourL.bounds.size.height+20, 50, 20);
    self.endL.frame = CGRectMake(self.bounds.size.width - 40 , self.currentL.frame.origin.y, 50, 20);
    
    
    self.slider.frame = CGRectMake(0, self.currentL.frame.origin.y + self.currentL.bounds.size.height+5, self.bounds.size.width, 10);
    
    
    
    
    self.listB.frame = CGRectMake(20, self.slider.frame.origin.y + self.slider.bounds.size.height + 40, 20, 20);
    
    
    
    self.playB.frame = CGRectMake(self.bounds.size.width/2-25, self.listB.frame.origin.y - 15, 50, 50);
    self.pauseB.frame = self.playB.frame;
    
    
    
    self.upB.frame = CGRectMake(self.playB.frame.origin.x-70, self.listB.frame.origin.y, 20, 20);
    
    self.nextB.frame = CGRectMake(self.playB.frame.origin.x+120, self.upB.frame.origin.y, 20, 20);
    
    self.imageLagerV.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*5/6);
    
    //设置时间，每一秒钟调用一次绑定的方法
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    
    //标题
    self.titleLabel.frame = CGRectMake(self.bounds.size.width/6, 20, self.bounds.size.width*4/6, 30);
    
    
    
    
    
}


#pragma mark -- 旋转动画
//static int k = 1;
-(void)animation:(UIImageView *)imageView{
    
    
    [UIView animateWithDuration:0.01 animations:^{
        //基于上一次状态
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI/180);
    } completion:^(BOOL finished) {
        
        [self animation:imageView];
    }];
}

-(void)setPlayDetailModel:(PlayDetailModel *)playDetailModel{
    _playDetailModel = playDetailModel;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:playDetailModel.coverMiddle] placeholderImage:nil];
    [self.imageLagerV sd_setImageWithURL:[NSURL URLWithString:playDetailModel.coverMiddle] placeholderImage:nil];
    
    self.titleLabel.text = playDetailModel.title;
    
}



-(void)setSortDetailList:(SortDetailList *)sortDetailList{
    _sortDetailList = sortDetailList;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:sortDetailList.coverMiddle] placeholderImage:nil];
    [self.imageLagerV sd_setImageWithURL:[NSURL URLWithString:sortDetailList.coverMiddle] placeholderImage:nil];
    
   
    
    self.titleLabel.text = sortDetailList.title;
    
   // [self.player initWithURL:[NSURL URLWithString:sortDetailList.playUrl64]];
    
    
    
    
//    NSTimeInterval totalTimer = sortDetailList.duration;
//    //分钟数
//    
//    NSTimeInterval totalM = (int)totalTimer/60;
//    
//   NSTimeInterval totalTimer1 = (int)totalTimer%60;
//    
//    
//    self.endL.text = [NSString stringWithFormat:@"%02.0f:%02.0f",totalM,totalTimer1];
    

}






//-(void)time{
//    self.slider.minimumValue = 0;
//    self.slider.maximumValue = self.playDetailModel.duration;
//    
//    //self.player.progress
//    NSTimeInterval totalTimer = self.playDetailModel.duration;
//    NSTimeInterval currentTime = self.player.progress;
//    if (currentTime == totalTimer) {
//        self.playB.alpha =1 ;
//        self.pauseB.alpha = 0;
//    }
//    
//    
//    //NSLog(@"%0.0f",self.player.progress);
//    
//    self.slider.value = self.player.progress;
//    //NSLog(@"%0.0f",self.slider.value);
//    //把秒转换成分钟
//    NSTimeInterval currentM = currentTime/60;
//    currentTime = (int)currentTime%60;
//    
//    //NSTimeInterval totalM = totalTimer/60;
//    totalTimer = (int)totalTimer%60;
//    
//    //把时间显示在lable上
//    NSString *timeString = [NSString stringWithFormat:@"%02.0f:%02.0f",currentM, currentTime];
//    self.currentL.text = timeString;
//    
//    
//    
//    
//}

//#pragma mark--滑块
//-(void)sliderValueChange:(UISlider *)slider{
//    self.player.progress = slider.value;
//}












//#pragma mark--播放和暂停
//-(void)bofang:(UIButton *)button{
//    [self.player start];
//    
//    self.playB.alpha = 0;
//    self.pauseB.alpha = 1;
//    
//}
//
//
//-(void)pause:(UIButton *)button{
//    
//    [self.player pause];
//    
//    self.playB.alpha = 1;
//    self.pauseB.alpha = 0;
//    
//}











@end
