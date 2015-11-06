//
//  HeaderViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "HeaderViewCell.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
@implementation HeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kWidth - 10, self.frame.size.width * 0.6)];
        [self.contentView addSubview:self.imagePic];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imagePic.frame.origin.y + self.imagePic.frame.size.height, kWidth - 20, 30)];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
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
