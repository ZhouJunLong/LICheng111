//
//  SortDetailListCell.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortDetailListCell.h"
#import "SortDetailList.h"
#import "UIImageView+WebCache.h"

@implementation SortDetailListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        
        self.playV= [[UIImageView alloc] init];
        self.playV.image = [UIImage imageNamed:@"yuanniubofang@2x"];
        [self.contentView addSubview:self.playV];
        
        self.titleV = [[UILabel alloc] init];
        self.titleV.font = [UIFont systemFontOfSize:16];
        self.titleV.numberOfLines = 0;
        [self.contentView addSubview:self.titleV];
        
        self.desL = [[UILabel alloc] init];
        self.desL.textColor = [UIColor grayColor];
        self.desL.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.desL];
        
        self.playCV =[[UIImageView alloc] init];
        self.playCV.image = [UIImage imageNamed:@"bof"];
        [self.contentView addSubview:self.playCV];
        
        self.playCountL = [[UILabel alloc] init];
        self.playCountL.font = [UIFont systemFontOfSize:13];
        self.playCountL.textColor = [UIColor  grayColor];
        [self.contentView addSubview:self.playCountL];
        
        self.shijianV = [[UIImageView alloc] init];
        self.shijianV.image = [UIImage imageNamed:@"shijian@2x"];
        [self.contentView addSubview:self.shijianV];
        
        self.durationL = [[UILabel alloc] init];
        self.durationL.textColor = [UIColor grayColor];
        self.durationL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.durationL];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(10, 10, self.frame.size.width /5.6, self.frame.size.width /5.6);
    self.imageV.layer.cornerRadius = self.frame.size.width/ 5.6 /2.f;
    self.imageV.backgroundColor = [UIColor grayColor];
    self.imageV.clipsToBounds = YES;
    
    self.playV.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.bounds.size.width/2 -10, self.imageV.frame.origin.y + self.imageV.bounds.size.height/2 -10, 20, 20);
    
    self.titleV.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.bounds.size.width + 10, self.imageV.frame.origin.y, self.frame.size.width - 50 - self.imageV.bounds.size.width, 40);
    [self.titleV sizeToFit];
    
    self.desL.frame = CGRectMake(self.titleV.frame.origin.x , self.titleV.frame.origin.y + self.titleV.bounds.size.height +5, self.titleV.bounds.size.width, 20);
    self.playCV.frame = CGRectMake(self.desL.frame.origin.x, self.desL.frame.origin.y + self.desL.bounds.size.height + 5, 17, 15);
    self.playCountL.frame = CGRectMake(self.playCV.frame.origin.x + self.playCV.bounds.size.width + 5, self.playCV.frame.origin.y, self.frame.size.width / 5, 15);
    
    self.shijianV.frame = CGRectMake(self.playCountL.frame.origin.x + self.playCountL.bounds.size.width + 10, self.playCV.frame.origin.y, 15, 15);
    
    self.durationL.frame = CGRectMake(self.shijianV.frame.origin.x + self.shijianV.bounds.size.width + 5, self.shijianV.frame.origin.y, self.playCountL.bounds.size.width, 15);
}

-(void)setDetailList:(SortDetailList *)detailList
{
    _detailList = detailList;
   

    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:detailList.coverSmall]];
    self.titleV.text =detailList.title;
    
    self.desL.text = [NSString stringWithFormat:@"by %@",detailList.nickname];
    self.playCountL.text = [NSString stringWithFormat:@"%.2lf万", (CGFloat)detailList.playtimes / 10000];
    
    self.durationL.text = [NSString stringWithFormat:@"%ld:%ld",detailList.duration/60, (detailList.duration % 60 % 60)];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
