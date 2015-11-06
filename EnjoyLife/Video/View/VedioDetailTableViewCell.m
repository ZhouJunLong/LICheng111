//
//  VedioDetailTableViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "VedioDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation VedioDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageView1 = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView1];
        
        _lable = [[UILabel alloc]init];
        _lable.font = [UIFont systemFontOfSize:16];
        _lable.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lable];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _imageView1.frame =  CGRectMake(10, 10, self.contentView.bounds.size.width/3, self.contentView.bounds.size.height-20);
    

    _lable.frame = CGRectMake(self.contentView.bounds.size.width/3+20, 10, self.contentView.bounds.size.width -self.contentView.bounds.size.width / 3 -30, self.imageView.bounds.size.height);
    _lable.numberOfLines = 0;
    [_lable sizeToFit];
}



-(void)setRelatedModel:(RelatedModel *)relatedModel
{
    _relatedModel = relatedModel;
    _lable.text = relatedModel.name;
    
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:relatedModel.mediaUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
