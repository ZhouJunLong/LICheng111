//
//  HappyDetailViewController.h
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailView.h"
#import "VedioDetailModel.h"
#import "RelatedModel.h"
#import "HotView.h"
#import "Model2.h"
@interface HappyDetailViewController : UIViewController

@property (nonatomic, strong)NSString *str;

@property (nonatomic, strong)VideoDetailView *videoDetailView;

@property (nonatomic, strong)HotView *hotView;

@property (nonatomic, strong)VedioDetailModel *vedailDetailModel;

@property (nonatomic, strong)RelatedModel *relatedModel;

@property (nonatomic, strong)Model2 *model;





@end
