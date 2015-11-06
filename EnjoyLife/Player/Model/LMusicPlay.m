//
//  LMusicPlay.m
//  vNews
//
//  Created by lanou on 15/11/4.
//  Copyright (c) 2015年 vNewsTeam. All rights reserved.
//

#import "LMusicPlay.h"


static LMusicPlay *musicplay;

@implementation LMusicPlay

+(LMusicPlay *)shareLmusicPlay
{
    if (musicplay == nil) {
        musicplay = [[LMusicPlay alloc] init];
    }
    return musicplay;
}

//+(AudioStreamer *)shareManager
//{
//    if (<#condition#>) {
//        <#statements#>
//    }
//}

-(AVPlayer *)musplayer
{
    if (!_player) {
        
        _player = [[AVPlayer alloc] init];
        
        
    }
    return _player;
    
}

-(void)playWithUrl:(NSString *)usl
{
    if (self.playItem) {
        [self.playItem removeObserver:self forKeyPath:@"status"];
    }
    
    self.playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:usl]];
    //添加观察者
    [self.playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self musplayer];
    [self.player replaceCurrentItemWithPlayerItem:self.playItem];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //根据字典内的新值来进行判断 integerValue会将值转换类型，根据我们的选择条件来进行执行其对应的方法

    switch ([change[@"new"] integerValue]) {
        case AVPlayerItemStatusFailed:
            NSLog(@"缓冲失败");
            break;
        case AVPlayerStatusReadyToPlay:
            NSLog(@"缓冲成功");
            self.readyToPlay = YES;
            //创建一个通知发送一条消息告知可以播放
            [[NSNotificationCenter defaultCenter] postNotificationName:@"readyToPlay" object:nil];
            break;
        case AVPlayerStatusUnknown:
            NSLog(@"状态未知");
            break;
        default:
            break;
    }
}


//开始播放
-(void)startPlay
{
    if (self.readyToPlay == YES) {
        [self.player play];
        self.isplay = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(silderRun) userInfo:nil repeats:YES];
    }
    
    
}

//停止播放
-(void)stopPlay
{
    [self.player pause];
    self.isplay = NO;
    [_timer invalidate];
    _timer = nil;
}
//指定位置播放
-(void)seekToTime:(CGFloat)time
{
    if (self.isplay == YES) {
        [self stopPlay];
        [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {

            [self startPlay];
            
        }];

    } else {
        //暂停状态
        [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:nil];
    }
    
    
}

-(void)silderRun
{
    
    //float to = self.player.currentItem.duration.value;
    //NSLog(@"%f", to);
   
        CGFloat progress = 1.0 * self.player.currentTime.value / self.player.currentTime.timescale;
        [self.delegate audioManagerStreamer:self songProgress:progress];
    

}


@end
