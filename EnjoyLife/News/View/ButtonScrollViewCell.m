//
//  ButtonScrollViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "ButtonScrollViewCell.h"

@implementation ButtonScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, frame.size.height)];
        [self.contentView addSubview:self.label];
        
        
    }
    return self;
}


@end
