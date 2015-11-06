//
//  PlayerViewController.h
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "playDetailView.h"
#import "SortDetailList.h"
@class FocusModel;
@class PlayDetailModel;


@interface PlayerViewController : UIViewController

@property (nonatomic,strong)PlayDetailModel *playDetailModel;


//timer，来更新歌曲的当前时间
@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic,assign)BOOL isPlaying;

//用来接收现在在播放第几首歌
@property (nonatomic,assign)NSInteger musicNumber;

//用于接收播放列表的数组
@property (nonatomic,strong)NSMutableArray *sortDetailListModelArray;
@property (nonatomic,strong)SortDetailList *sortDetailList;




@property (nonatomic,strong)playDetailView *playView;
@property (nonatomic,strong)FocusModel *focusModel;



@property (nonatomic,assign)NSInteger trackId;
@property (nonatomic,strong)NSString *titleName;

@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;

@property (nonatomic,strong)UILabel *titleLabel;

+(PlayerViewController *) sharedController;


//-(void)show;



@end
