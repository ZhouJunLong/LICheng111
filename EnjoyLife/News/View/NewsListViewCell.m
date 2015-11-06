//
//  NewsListViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsListViewCell.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height
@implementation NewsListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //图片
        self.imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth / 4 + 20, kWidth / 4)];
        
        [self.contentView addSubview:self.imagePic];
        
        //titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imagePic.frame.origin.x + self.imagePic.frame.size.width + 10, self.imagePic.frame.origin.y, kWidth - self.imagePic.frame.origin.x - self.imagePic.frame.size.width - 20, 40)];
        
        
        [self.contentView addSubview:self.titleLabel];
        
        //des
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, 50)];
        self.desLabel.font = [UIFont systemFontOfSize:14];
        self.desLabel.textColor = [UIColor darkGrayColor];
        self.desLabel.numberOfLines = 0;
        [self.contentView addSubview:self.desLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
