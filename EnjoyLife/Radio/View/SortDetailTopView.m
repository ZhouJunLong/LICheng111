//
//  SortDetailTopView.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortDetailTopView.h"

#import "SortDetailTop.h"
#import "UIImageView+WebCache.h"
#import "UIColor+CustomColor.h"
@implementation SortDetailTopView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.bgImageV = [[UIImageView alloc] init];
        self.bgImageV.image = [UIImage imageNamed:@"dianying"];
        [self addSubview:self.bgImageV];
        
        self.bgImageVV = [[UIImageView alloc] init];
        self.bgImageVV.backgroundColor = [UIColor blackColor];
        self.bgImageVV.alpha = 0.7;
        [self.bgImageV addSubview:self.bgImageVV];
        
        self.titleL = [[UILabel alloc] init];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        self.titleL.textColor = [UIColor whiteColor];
        self.titleL.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:self.titleL];
        
        self.sideV = [[UIImageView alloc] init];
        [self addSubview:self.sideV];
        
        self.sideVV = [[UIImageView alloc] init];
        self.sideVV.image = [UIImage imageNamed:@"3"];
        [self addSubview:self.sideVV];
        
        self.play = [[UIImageView alloc] init];
        self.play.image = [UIImage imageNamed:@"bo1"];
        [self addSubview:self.play];
        
        self.playCountL = [[UILabel alloc] init];
        self.playCountL.textColor = [UIColor whiteColor];
        self.playCountL.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:self.playCountL];
        
        self.circleV = [[UIImageView alloc] init];
        [self addSubview:self.circleV];
        
        
        self.nameL = [[UILabel alloc] init];
        self.nameL.textColor = [UIColor whiteColor];
        self.nameL.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.nameL];
        
        self.desL = [[UILabel alloc] init];
        self.desL.textColor = [UIColor silverColor];
        self.desL.numberOfLines = 0;
        self.desL.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.desL];
        
        
        self.des = [[UIImageView alloc] init];
        self.des.image = [UIImage imageNamed:@"xiayiye"];
        [self addSubview:self.des];
        
        self.desB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.desB];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bgImageVV.frame = self.bgImageV.frame;
    
    self.titleL.frame = CGRectMake(self.frame.size.width/2 - self.frame.size.width/3, 25, self.frame.size.width / 1.5, 30);
    
    self.sideV.frame = CGRectMake(20, self.titleL.frame.origin.y + self.titleL.bounds.size.height + 20, self.frame.size.width / 4, self.frame.size.width / 4);
    self.sideVV.frame = self.sideV.frame;
    
    self.play.frame = CGRectMake(self.sideV.frame.origin.x + 10, self.sideV.frame.origin.y+ self.sideV.bounds.size.height - 15, 15, 15);
    
    self.playCountL.frame = CGRectMake(self.sideV.bounds.size.width / 2 + 10, self.sideV.frame.origin.y+ self.sideV.bounds.size.height - 15, 45, 15);
    
    self.circleV.frame = CGRectMake(self.sideV.frame.origin.x + self.sideV.bounds.size.width + 15, self.sideV.frame.origin.y , 30, 30);
    self.circleV.layer.cornerRadius = 30 / 2.f;
    self.circleV.clipsToBounds = YES;
    
    self.nameL.frame = CGRectMake(self.circleV.frame.origin.x + self.circleV.bounds.size.width + 5, self.circleV.frame.origin.y+5, self.frame.size.width / 2, 20);

    self.desL.frame = CGRectMake(self.circleV.frame.origin.x , self.circleV.frame.origin.y + self.circleV.bounds.size.height + 10, self.frame.size.width - 80 - self.sideV.bounds.size.width, 40);
    self.des.frame = CGRectMake(self.desL.frame.origin.x + self.desL.bounds.size.width + 15, self.desL.frame.origin.y + 10, 20, 20);
    
    self.desB.frame = CGRectMake(self.desL.frame.origin.x , self.desL.frame.origin.y, self.desL.bounds.size.width + self.des.bounds.size.width + 15, self.desL.bounds.size.height);

    
}

-(void)setDetailTop:(SortDetailTop *)detailTop
{
    _detailTop = detailTop;
    self.titleL.text = detailTop.title;
    [self.bgImageV sd_setImageWithURL:[NSURL URLWithString:detailTop.coverOrigin]];
    [self.sideV sd_setImageWithURL:[NSURL URLWithString:detailTop.coverOrigin]];
    [self.circleV sd_setImageWithURL:[NSURL URLWithString:detailTop.avatarPath]];


    self.nameL.text = detailTop.nickname;
    
    if (detailTop.intro.length == 0) {
        self.desL.text = @"无";
    }else{
        self.desL.text = detailTop.intro;
    }
    self.playCountL.text = [NSString stringWithFormat:@"%.1lf万",(CGFloat)detailTop.playTimes/10000];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
