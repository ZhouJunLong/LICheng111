//
//  NewsScrollView.m
//  EnjoyLife
//
//  Created by lanou on 15/11/5.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsScrollView.h"
#import "UIColor+CustomColor.h"
#import "AFNetworking.h"
#import "HeaderModel.h"
#import "UIImageView+WebCache.h"
@interface NewsScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation NewsScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        
    
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width - 50, self.frame.size.height - 30, 40, 20)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor jinjuse];
        self.pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
        self.pageControl.numberOfPages = 4;
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        
        //解析数据
        [self handle];
        
        
        
    }
    return self;
}

//创建轮播图
- (void)createScrollImage{
    
    //图片无线滑动的数组
    self.imagesURLArrays = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        HeaderModel *headerModel = self.modelArr[i];
        
        [self.imagesURLArrays addObject:headerModel];
    }
    //把数组最后一个添加到前面
    [self.imagesURLArrays insertObject:[self.imagesURLArrays lastObject] atIndex:0];
    
    //
    for (int i = 0; i < self.imagesURLArrays.count; i++) {
        
        if (i == self.imagesURLArrays.count) {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width , self.frame.size.height - 40 )];
        HeaderModel *headerModel = self.imagesURLArrays[i];
        NSURL *url = [NSURL URLWithString:headerModel.imgsrc];
        [imageView sd_setImageWithURL:url placeholderImage:nil];
        imageView.tag = i + 1;
        [self.scrollView addSubview:imageView];
        
        //图片下面的label
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * i + 10, self.frame.size.height - 40, self.frame.size.width - 50, 40)];
        label.textColor = [UIColor tomatoColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = headerModel.title;
        [self.scrollView addSubview:label];
        
        //添加一个手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
    }
    //scrollView 的偏移量
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.imagesURLArrays.count, self.frame.size.height);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
}

#pragma mark - 轻拍手势实现方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat width = scrollView.frame.size.width;
    if (offset.x > width * 4) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    if (offset.x < 0) {
        scrollView.contentOffset = CGPointMake(width * 4, 0);
    }
    
}
//停止减速的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算是第几页
    NSInteger page = scrollView.contentOffset.x / self.frame.size.width;
    if (page == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages -1;
    }else{
        self.pageControl.currentPage = page - 1;
    }
    
}
//解析数据
- (void)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
    [manager GET:@"http://c.3g.163.com/nc/ad/headline/0-4.html" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self.modelArr = [NSMutableArray array];
        
        NSMutableArray *arr = [rootDic objectForKey:@"headline_ad"];
        for (NSDictionary *dic in arr) {
            
            HeaderModel *headerModel = [[HeaderModel alloc] init];
            [headerModel setValuesForKeysWithDictionary:dic];
            [self.modelArr addObject:headerModel];
        }
        
        [self createScrollImage];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息: %@", error);
    }];

}

@end
