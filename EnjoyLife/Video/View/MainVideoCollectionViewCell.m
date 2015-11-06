//
//  MainVideoCollectionViewCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "MainVideoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MainVideoCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView];
        
        _title = [[UILabel alloc]init];
        [self.contentView addSubview:_title];
        
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height-60);
    _imageView.backgroundColor = [UIColor redColor];
    
    
    
    _title.frame = CGRectMake(0, self.contentView.bounds.size.height-60, self.contentView.bounds.size.width, 40);
    _title.textColor = [UIColor blackColor];
    _title.numberOfLines = 0;
    [_title sizeToFit];
    
  
    
}

-(void)setModel2:(Model2 *)model2
{
    _model2 = model2;
    _title.text = model2.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model2.image] placeholderImage:nil];
}




@end
