//
//  HeaderCollectionReusableView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

/**
 区头的自定义视图, 继承于UICollectionReusableView
 */
#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, 40)];
        self.lable.font = [UIFont systemFontOfSize:19];
        [self addSubview:self.lable];
    }
    return self;
}

@end
