//
//  LMusicPlay.h
//  vNews
//
//  Created by lanou on 15/11/4.
//  Copyright (c) 2015年 vNewsTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
//#import "AudioStreamer.h"
@class LMusicPlay;

@protocol LMusicPlayDelegate <NSObject>

//获取当前的播放的时间
- (void)audioManagerStreamer:(LMusicPlay *)streamer songProgress:(float)songProgress;

@end

@interface LMusicPlay : NSObject

//@property(nonatomic, strong)AudioStreamer *play;


@property(nonatomic, strong)AVPlayer *player;

@property(nonatomic, strong)AVPlayerItem *playItem;

@property (nonatomic, strong) id<LMusicPlayDelegate>delegate;
@property (nonatomic, strong) NSTimer *timer;


+(LMusicPlay *)shareLmusicPlay;
//+ (AudioStreamer *)shareManager;

//缓存成功
@property (nonatomic, assign) BOOL readyToPlay;
@property(nonatomic, assign)BOOL isplay;

//根据歌曲URL来播放
-(void)playWithUrl:(NSString *)usl;

//开始播放
-(void)startPlay;

//停止播放
-(void)stopPlay;

//指定位置播放
- (void)seekToTime:(CGFloat)time;


@end
