//
//  NewsScrollView.h
//  EnjoyLife
//
//  Created by lanou on 15/11/5.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *imagesURLArrays;

@end
