//
//  ButtonViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "ButtonViewCell.h"

@implementation ButtonViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        [self.button setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
        //设置button的样式
        self.button.layer.masksToBounds = YES;
        self.button.layer.cornerRadius = 15;
        [self.button.layer setBorderWidth:0.5];
        
        self.button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.button setBackgroundColor:[UIColor clearColor]];
        
        self.button.userInteractionEnabled = NO;
        [self.contentView addSubview:self.button];
    }
    return self;
}

@end
