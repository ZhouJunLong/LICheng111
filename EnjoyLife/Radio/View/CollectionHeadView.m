//
//  CollectionHeadView.m
//  EnjoyLife
//
//  Created by LiCheng on 15/11/4.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "CollectionHeadView.h"
#import "UIColor+CustomColor.h"

@implementation CollectionHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, 30))];
        self.label.textColor = [UIColor grayColor];
        self.label.text = @"全部分类:";
        self.label.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.label];
    }
    return self;
}
@end
