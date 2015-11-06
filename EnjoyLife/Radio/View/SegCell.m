//
//  SegCell.m
//  EnjoyLife
//
//  Created by LiCheng on 15/11/2.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SegCell.h"

@implementation SegCell

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        self.label.clipsToBounds = YES;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.label.layer.cornerRadius = 8;
}
@end
