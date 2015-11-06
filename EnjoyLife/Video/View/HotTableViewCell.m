//
//  HotTableViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "HotTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HotTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageView1 = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView1];
        
        _lable = [[UILabel alloc]init];
        _lable.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lable];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _imageView1.frame =  CGRectMake(20, 10, self.contentView.bounds.size.width/3, self.contentView.bounds.size.height-20);
    
    
    _lable.frame = CGRectMake(self.contentView.bounds.size.width/3+30, 10, self.contentView.bounds.size.width/3*2-30, self.contentView.bounds.size.height-20);
    _lable.numberOfLines = 0;
    [_lable sizeToFit];
}



-(void)setModel:(Model2 *)model
{
    _model = model;
    _lable.text = model.title;
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
