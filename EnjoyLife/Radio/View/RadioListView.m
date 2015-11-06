//
//  RadioListView.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright © 2015年 Drop. All rights reserved.
//

#import "RadioListView.h"

@interface RadioListView ()

@property (nonatomic,strong)UIScrollView *scrollView;

@end
@implementation RadioListView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 滑动视图
        self.scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))];
        self.scrollView.contentSize =CGSizeMake(0, 680);
        [self addSubview:self.scrollView];
        
        
        // 音乐
        
        // 图片
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:(CGRectMake(10, 10, (self.frame.size.width - 40) *2 / 3 + 10, (self.frame.size.width - 40) * 2/ 3 + 10))];
        image1.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image1];
        image1.image = [UIImage imageNamed:@"tushu"];
        
        // label
        self.shu = [[UILabel alloc] initWithFrame:(CGRectMake(10, image1.frame.origin.y + image1.bounds.size.height - 60, image1.bounds.size.width, 20))];
        self.shu.text = @"有声书";
        self.shu.tag = 1200;
        self.shu.font = [UIFont systemFontOfSize:28];
        self.shu.textColor = [UIColor whiteColor];
        self.shu.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.shu];
        
        // button
        self.button1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button1.frame = image1.frame;
        self.button1.tag = 1000;
        [self.scrollView addSubview:self.button1];
        
        
        // 有声书
        
        // 图片
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:(CGRectMake(image1.frame.origin.x + image1.bounds.size.width + 10 , 10, (self.frame.size.width - 40) / 3, (self.frame.size.width - 40) / 3))];
        image2.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image2];
        image2.image = [UIImage imageNamed:@"yinyue"];
        
        // label
        self.yinyue = [[UILabel alloc] initWithFrame:(CGRectMake(image2.frame.origin.x, image2.frame.origin.y + image2.bounds.size.height - 30, image2.bounds.size.width, 20))];
        self.yinyue.text = @"音乐";
        self.yinyue.font = [UIFont systemFontOfSize:17];
        self.yinyue.textColor = [UIColor whiteColor];
        self.yinyue.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.yinyue];
        
        // button
        self.button2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button2.frame = image2.frame;
        self.button2.tag = 1001;
        [self.scrollView addSubview:self.button2];
        
        
        
        // 综艺娱乐
        
        // 图片
        UIImageView *image3 = [[UIImageView alloc] initWithFrame:(CGRectMake(image2.frame.origin.x, image2.bounds.size.height + 10 + image2.frame.origin.y, (self.frame.size.width - 40) / 3, (self.frame.size.width - 40) / 3))];
        image3.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image3];
        image3.image = [UIImage imageNamed:@"yule"];
        
        // label
        self.yule = [[UILabel alloc] initWithFrame:(CGRectMake(image3.frame.origin.x, image3.frame.origin.y + image3.bounds.size.height - 30, image3.bounds.size.width, 20))];
        self.yule.text = @"综艺娱乐";
        self.yule.font = [UIFont systemFontOfSize:17];
        self.yule.textColor = [UIColor whiteColor];
        self.yule.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.yule];
        
        //button
        self.button3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button3.frame = image3.frame;
        self.button3.tag = 1002;
        [self.scrollView addSubview:self.button3];
        
        
        // 校园
        
        // 图片
        UIImageView *image4 = [[UIImageView alloc] initWithFrame:(CGRectMake(10, image1.frame.origin.y + 10 + image1.bounds.size.height, (self.frame.size.width - 40) / 3, (self.frame.size.width - 40)/ 3))];
        image4.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image4];
        image4.image = [UIImage imageNamed:@"xiaoyuan"];
        
        // label
        self.xiaoyuan = [[UILabel alloc] initWithFrame:(CGRectMake(image4.frame.origin.x, image4.frame.origin.y + image4.bounds.size.height - 30, image4.bounds.size.width, 20))];
        self.xiaoyuan.text = @"校园";
        self.xiaoyuan.font = [UIFont systemFontOfSize:17];
        self.xiaoyuan.textColor = [UIColor whiteColor];
        self.xiaoyuan.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.xiaoyuan];
        
        // button
        self.button4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button4.frame = image4.frame;
        self.button4.tag = 1003;
        [self.scrollView addSubview:self.button4];
        
        
        // 电台
        
        // 图片
        UIImageView *image5 = [[UIImageView alloc] initWithFrame:(CGRectMake(image4.frame.origin.x + 10 + image4.bounds.size.width, image4.frame.origin.y, (self.frame.size.width - 40) *2 / 3 + 10, (self.frame.size.width - 40) * 2 / 3 +10))];
        image5.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image5];
        image5.image = [UIImage imageNamed:@"diantai"];
        
        // label
        self.diantai = [[UILabel alloc] initWithFrame:(CGRectMake(image5.frame.origin.x, image5.frame.origin.y + image5.bounds.size.height - 60, image5.bounds.size.width, 20))];
        self.diantai.text = @"城市电台";
        self.diantai.font = [UIFont systemFontOfSize:28];
        self.diantai.textColor = [UIColor whiteColor];
        self.diantai.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.diantai];
        
        // button
        self.button5 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button5.frame = image5.frame;
        self.button5.tag = 1004;
        [self.scrollView addSubview:self.button5];
        
        
        
        // 生活情感
        
        // 图片
        UIImageView *image6 = [[UIImageView alloc] initWithFrame:(CGRectMake(image4.frame.origin.x, image4.bounds.size.height + 10 + image4.frame.origin.y, (self.frame.size.width - 40) / 3, (self.frame.size.width - 40) / 3))];
        image6.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image6];
        image6.image = [UIImage imageNamed:@"qinggan"];
        
        // label
        self.qinggan = [[UILabel alloc] initWithFrame:(CGRectMake(image6.frame.origin.x, image6.frame.origin.y + image6.bounds.size.height - 30, image6.bounds.size.width, 20))];
        self.qinggan.text = @"生活情感";
        self.qinggan.font = [UIFont systemFontOfSize:17];
        self.qinggan.textColor = [UIColor whiteColor];
        self.qinggan.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.qinggan];
        
        // button
        self.button6 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button6.frame = image6.frame;
        self.button6.tag = 1005;
        [self.scrollView addSubview:self.button6];
        
        
        // 电影
        
        // 图片
        UIImageView *image7 = [[UIImageView alloc] initWithFrame:(CGRectMake(image4.frame.origin.x, image6.frame.origin.y + 10 + image6.bounds.size.height, (self.frame.size.width - 40) *2 / 3 + 10, (self.frame.size.width - 40) /3))];
        image7.backgroundColor = [UIColor cyanColor];
        [self.scrollView addSubview:image7];
        image7.image = [UIImage imageNamed:@"dianying"];
        
        // label
        self.dianying = [[UILabel alloc] initWithFrame:(CGRectMake(image7.frame.origin.x, image7.frame.origin.y + image7.bounds.size.height - 60, 100, 20))];
        self.dianying.text = @"电影";
        self.dianying.font = [UIFont systemFontOfSize:28];
        self.dianying.textColor = [UIColor whiteColor];
        self.dianying.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.dianying];
        
        // button
        self.button7 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button7.frame = image7.frame;
        self.button7.tag = 1006;
        [self.scrollView addSubview:self.button7];
        
        
        // 旅游
        
        // 图片
        UIImageView *image8 = [[UIImageView alloc] initWithFrame:(CGRectMake(image2.frame.origin.x, image7.frame.origin.y, (self.frame.size.width - 40) / 3, (self.frame.size.width - 40) / 3))];
        image8.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:image8];
        image8.image = [UIImage imageNamed:@"lvyou"];
        
        // label
        self.lvyou = [[UILabel alloc] initWithFrame:(CGRectMake(image8.frame.origin.x, image8.frame.origin.y + image8.bounds.size.height - 30, image8.bounds.size.width, 20))];
        self.lvyou.text = @"旅游";
        self.lvyou.font = [UIFont systemFontOfSize:17];
        self.lvyou.textColor = [UIColor whiteColor];
        self.lvyou.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.lvyou];
        
        // button
        self.button8 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.button8.frame = image8.frame;
        self.button8.tag = 1007;
        [self.scrollView addSubview:self.button8];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
