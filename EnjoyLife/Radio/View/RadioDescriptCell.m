//
//  RadioDescriptCell.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "RadioDescriptCell.h"

@implementation RadioDescriptCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[ UIImageView alloc] initWithFrame:(CGRectMake(30, 30, 40, 40))];
        self.imageV.backgroundColor = [UIColor brownColor];
        self.imageV.layer.cornerRadius = 40 / 2.f;
        self.imageV.clipsToBounds = YES;
        [self.contentView addSubview: self.imageV];
        
        self.nameL = [[UILabel alloc] initWithFrame:(CGRectMake(self.imageV.frame.origin.x + self.imageV.bounds.size.width + 15, self.imageV.frame.origin.y, self.frame.size.width - 100, 30))];
        [self.contentView addSubview:self.nameL];
        
        UILabel *desT = [[UILabel alloc] initWithFrame:(CGRectMake(self.imageV.frame.origin.x, self.imageV.frame.origin.y + self.imageV.bounds.size.height + 10, 50, 20))];
        desT.text = @"简介";
        desT.font = [UIFont systemFontOfSize:14];
        desT.textColor = [UIColor grayColor];
        [self.contentView addSubview:desT];
        
        self.desL = [[UILabel alloc] initWithFrame:(CGRectMake(desT.frame.origin.x, desT.frame.origin.y +desT.bounds.size.height +5, self.frame.size.width, 40))];
        self.desL.font = [UIFont systemFontOfSize:14];
        self.desL.numberOfLines = 0;
        self.desL.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.desL];
//        [self.desL sizeToFit];

        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.desL sizeToFit];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
