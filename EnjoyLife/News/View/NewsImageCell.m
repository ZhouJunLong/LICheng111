//
//  NewsImageCell.m
//  EnjoyLife
//
//  Created by lanou on 15/11/4.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsImageCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height / 5.5

@implementation NewsImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, kHeight / 4, (kWidth - 40) / 3, kHeight / 4 * 3 - 10)];
        [self.contentView addSubview:_imageView1];
        
        
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - 40) / 3 + 20, kHeight / 4, (kWidth - 40) / 3, kHeight / 4 * 3 - 10)];
        [self.contentView addSubview:_imageView2];
       
        
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - 40) / 3 * 2 + 30, kHeight / 4, (kWidth - 40) / 3, kHeight / 4 * 3 - 10)];
        [self.contentView addSubview:_imageView3];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth, kHeight / 4)];
        [self.contentView addSubview:_label];
        _label.font = [UIFont boldSystemFontOfSize:17];
        
        
        _comments = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 10 * 7, 0, kWidth / 10 * 3 - 10, kHeight / 4)];
        [self.contentView addSubview:_comments];
        _comments.font = [UIFont systemFontOfSize:14 weight:0.05];
        _comments.textColor = [UIColor grayColor];
        _comments.textAlignment = 2;
        
        
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
