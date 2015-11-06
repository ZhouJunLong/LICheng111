//
//  NewsDetailViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsDetailViewCell.h"
#import "NewsDetailModel.h"
#import "UIImageView+WebCache.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width

@interface NewsDetailViewCell()
@property (nonatomic, assign) NSInteger height;

@end
@implementation NewsDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.sourceLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.sourceLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.digestLabel = [[UILabel alloc] init];
    
        [self.contentView addSubview:self.digestLabel];
        
        self.BodyLabel = [[UILabel alloc] init];
        self.BodyLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.BodyLabel];
        self.BodyLabel.numberOfLines = 0;

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 10, kWidth - 20, 30);
    self.titleLabel.font = [UIFont systemFontOfSize:24];
    
    self.sourceLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10, self.frame.size.width / 4, 20);
    self.sourceLabel.font = [UIFont systemFontOfSize:14];
    
    self.timeLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 10, self.sourceLabel.frame.origin.y, self.frame.size.width/2, self.sourceLabel.frame.size.height);
    self.timeLabel.font= [UIFont systemFontOfSize:14];
    //图片

    self.digestLabel.frame = CGRectMake(self.timeLabel.frame.origin.x, self.timeLabel.frame.origin.y +self.timeLabel.frame.size.height + 5, self.bounds.size.width / 2, self.timeLabel.frame.size.height);
    self.digestLabel.font = [UIFont systemFontOfSize:14];
    self.height = self.digestLabel.frame.origin.y;
    
    
    [self.BodyLabel sizeToFit];
    
}



- (void)setNewsDetailModel:(NewsDetailModel *)newsDetailModel{
    _newsDetailModel = newsDetailModel;

    self.titleLabel.text = newsDetailModel.Title;
    self.sourceLabel.text = newsDetailModel.source;
    self.timeLabel.text = newsDetailModel.ptime;
    self.digestLabel.text = newsDetailModel.digest;
    
    NSInteger count = self.newsDetailModel.img.count;
    if (count !=0) {
        for (int i = 0; i < count; i++) {
            
            NSString *length = [self.newsDetailModel.img[i] objectForKey:@"pixel"];
            NSArray *arr = [length componentsSeparatedByString:@"*"];
            NSInteger width = [arr[0] integerValue];
            NSInteger height = [arr[1] integerValue];
            
            CGFloat size = width * 1.0 / height * 1.0;
            if (length != 0) {
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.027 *kWidth, self.height, kWidth - 20, (kWidth - 20) / size)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self.newsDetailModel.img[i] objectForKey:@"src"]] placeholderImage:nil];
                
                [self.contentView addSubview:imageView];
                //高度变化
                self.height += imageView.frame.size.height + 10;
                
            }
            
        }
        
    }
    self.BodyLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.height, kWidth - 20, 1000);
    
    


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
