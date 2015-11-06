//
//  FocusCell.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "FocusCell.h"
#import "FocusModel.h"
#import "UIColor+CustomColor.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "PlayerViewController.h"
@interface FocusCell()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic,strong)NSMutableArray *imagesURLArrays;

@property (nonatomic,retain)UIPageControl *pageControl;
@end


@implementation FocusCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        
      

    }
    return self;
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
   // NSLog(@"---点击了第%ld张图片", index);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //轮播图
    self.imagesURLArrays = [NSMutableArray array];
    
    self.imagesURLArrays = self.imageArray;
    

    
    
    
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    cycleScrollView2.delegate = self;
    //cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self addSubview:cycleScrollView2];
    
    //             --- 模拟加载延迟
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = self.imagesURLArrays;
    //});
    

    
    
    
    
    
    
    
    
}













-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = [NSMutableArray arrayWithArray:imageArray];
}

-(void)setFocusModelArray:(NSMutableArray *)focusModelArray{
    
    _focusModelArray = [NSMutableArray arrayWithArray:focusModelArray];

}





- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
