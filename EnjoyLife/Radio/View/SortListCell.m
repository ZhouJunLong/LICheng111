//
//  SortListCell.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortListCell.h"

#import "SortListModel.h"

// 第三方
#import "UIColor+CustomColor.h"
#import "UIImageView+WebCache.h"

@implementation SortListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc] init];
        self.titleL.font = [UIFont systemFontOfSize:16];
        self.titleL.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleL];
        
        self.introL = [[UILabel alloc] init];
        self.introL.font = [UIFont systemFontOfSize:14];
        self.introL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.introL];
        
        self.playCountL = [[UILabel alloc] init];
        self.playCountL.font = [UIFont systemFontOfSize:13];
        self.playCountL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.playCountL];
        
        self.trackCountL = [[UILabel alloc] init];
        self.trackCountL.font = [UIFont systemFontOfSize:13];
        self.trackCountL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.trackCountL];
        
        // 图标
        self.playV = [[UIImageView alloc] init];
        self.playV.image = [UIImage imageNamed:@"bof"];
        [self.contentView addSubview:self.playV];
        
        self.trackV = [[UIImageView alloc] init];
        self.trackV.image = [UIImage imageNamed:@"jishu"];
        [self.contentView addSubview:self.trackV];
        
        self.nextV = [[UIImageView alloc] init];
        self.nextV.image = [UIImage imageNamed:@"xiayiye"];
        [self.contentView addSubview:self.nextV];
        
        
        
    }
    return self;
}

-(void)setSortModel:(SortListModel *)sortModel
{
    _sortModel = sortModel;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:sortModel.albumCoverUrl290]];
    self.titleL.text = sortModel.title;
    self.introL.text = sortModel.intro;
    self.playCountL.text = [NSString stringWithFormat:@"%.1lf万",(CGFloat)sortModel.playsCounts / 10000];
    self.trackCountL.text = [NSString stringWithFormat:@"%d集",sortModel.tracks];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(10, 10, self.frame.size.width / 5, self.frame.size.width / 5);
    self.titleL.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.bounds.size.width + 10, self.imageV.frame.origin.y, self.frame.size.width - 30 - self.imageV.bounds.size.width, (self.imageV.bounds.size.height - 10)/ 3);

    self.introL.frame = CGRectMake(self.titleL.frame.origin.x, self.titleL.frame.origin.y + self.titleL.bounds.size.height + 5, self.titleL.bounds.size.width - 40, self.titleL.bounds.size.height);
    self.nextV.frame = CGRectMake(self.introL.frame.origin.x + self.introL.bounds.size.width +15, self.introL.frame.origin.y, 17, 17);
    
    self.playV.frame = CGRectMake(self.introL.frame.origin.x- 3, self.introL.frame.origin.y + self.introL.bounds.size.height + 5, 15, 15);
    self.playCountL.frame = CGRectMake(self.playV.frame.origin.x+1 + self.playV.bounds.size.width, self.playV.frame.origin.y, self.introL.bounds.size.width / 2 - 50, 15);
    
    self.trackV.frame = CGRectMake(self.playCountL.frame.origin.x + self.playCountL.bounds.size.width , self.playCountL.frame.origin.y, 15, 15);
    self.trackCountL.frame = CGRectMake(self.trackV.frame.origin.x + self.trackV.bounds.size.width +5, self.playCountL.frame.origin.y, self.playCountL.bounds.size.width, 15);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
