//
//  TitleCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "TitleCell.h"
#import "TitleModel.h"
@implementation TitleCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图标
        self.iconView = [[UIImageView alloc]init];
        
       self.iconView.image = [UIImage imageNamed:@"titleSanjiao"];
        [self.contentView addSubview:self.iconView];
        
        
        //标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        //更多
        self.moreLabel = [[UILabel alloc]init];
        self.moreLabel.font = [UIFont systemFontOfSize:14];
        self.moreLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.moreLabel];
        
        //箭头
        self.arrowsV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.arrowsV];
        self.arrowsV.image = [UIImage imageNamed:@"Arrow"];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(10, 0, 15, 15);
    
    self.titleLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.bounds.size.width + 5, self.iconView.frame.origin.y, 200, 30);
    
    self.moreLabel.frame = CGRectMake(self.bounds.size.width-50, self.iconView.frame.origin.y, 30, 30);
    self.moreLabel.text = @"更多";
    
    
    
    self.arrowsV.frame = CGRectMake(self.moreLabel.frame.origin.x + self.moreLabel.bounds.size.width + 5, self.moreLabel.frame.origin.y, 15, 15);
    
    
    
    
    
    
}
-(void)setTitleModel:(TitleModel *)titleModel{
    _titleModel = titleModel;
    self.titleLabel.text = titleModel.title;
   // NSLog(@"%@",titleModel.title);
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
