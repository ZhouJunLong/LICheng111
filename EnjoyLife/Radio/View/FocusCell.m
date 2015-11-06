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
#import "sortDetailController.h"
#import "PlayerViewController.h"
@interface FocusCell()<UIScrollViewDelegate>
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //轮播图
    self.imagesURLArrays = [NSMutableArray array];
    NSString *str = self.imageArray[0];
    [self.imagesURLArrays addObjectsFromArray:self.imageArray];
    [self.imagesURLArrays addObject:str];
  
    NSInteger count = self.imagesURLArrays.count;
   //NSLog(@"%ld",count);
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    
    self.scroll.contentOffset = CGPointMake(self.contentView.bounds.size.width, 0);
    [self.contentView addSubview:self.scroll];
    self.scroll.contentSize = CGSizeMake(self.contentView.bounds.size.width * count, self.scroll.bounds.size.height);
    
    self.scroll.pagingEnabled = YES;
     self.scroll.delegate = self;

    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < count; i++) {
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.contentView.bounds.size.width, 0, self.contentView.bounds.size.width, self.scroll.bounds.size.height)];
        _imageV.tag = 1000+i;
        _imageV.backgroundColor = [UIColor greenColor];
        [self.scroll addSubview:_imageV];
        
        _imageV.userInteractionEnabled = YES;
        
        [_imageV sd_setImageWithURL:[NSURL URLWithString:self.imagesURLArrays[i]] placeholderImage:nil];
        
        //手势
        self.tap = [[UITapGestureRecognizer alloc]
 initWithTarget:self action:@selector(tapClick:)];
        [_imageV addGestureRecognizer:self.tap];
        
        
        
    }
//滚动页面
    //1.创建
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width/3, 150, self.contentView.bounds.size.width/3, 40)];
    //2.设置属性
    _pageControl.numberOfPages = count-1;//
    
    _pageControl.currentPage = 0;//当前页面,index从0开始
   // _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];//当前指示器颜色
   // _pageControl.pageIndicatorTintColor = [UIColor yellowColor];//填充色
    //pageControl.backgroundColor = [UIColor blueColor];
    //添加事件
    [_pageControl addTarget:self action:@selector(changeScroll:) forControlEvents:(UIControlEventValueChanged)];
    //3.添加
    [self.contentView addSubview:_pageControl];
    
// 三.NStimer计时器
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoPlay:) userInfo:@"传递给timer信息" repeats:YES];
    
   
    
    
    
    
    
}
#pragma mark--手势
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    
    //UIImageView *imageV = [[UIImageView alloc]init];
    NSLog(@"我点击的是%ld张",tap.view.tag-1000);
    
    for (int i = 0; i < self.imagesURLArrays.count; i ++) {
        if (i == tap.view.tag-1000) {
        
            if (i == self.imagesURLArrays.count-1) {
                self.focusModel = [[FocusModel alloc]init];
                self.focusModel = self.focusModelArray[0];
            }else{
            self.focusModel = [[FocusModel alloc]init];
            self.focusModel = self.focusModelArray[i];
            
            }

        }
    }
    
    
    

    PlayerViewController *sortVC = [[PlayerViewController alloc]init];
    sortVC.focusModel = self.focusModel;
    UINavigationController *sortNC = [[UINavigationController alloc]initWithRootViewController:sortVC];
    
    
    [[self viewController] presentViewController:sortNC animated:YES completion:nil ];
    
    
    
}





- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)setFocusModel:(FocusModel *)focusModel{
    _focusModel = focusModel;
}

#pragma mark-pageControl触发方法
-(void)changeScroll:(UIPageControl *)pageControll{
    //1.获取到pageControll的当前页面
    NSInteger currentPage = pageControll.currentPage;
    //2.更改 scrollView的偏移量
    CGFloat width = _scroll.frame.size.width;
    [_scroll setContentOffset:CGPointMake((currentPage+1) * width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.x > (self.imagesURLArrays.count-1) * scrollView.bounds.size.width) {
        self.scroll.contentOffset = CGPointMake(0, 0);
    }
    else if (scrollView.contentOffset.x < 0){
        
        self.scroll.contentOffset = CGPointMake(self.imageArray.count * scrollView.bounds.size.width, 0);
        
    }
   
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滚动停止的时候,改变pageControl的当前页面
    //1.获取scrollView的宽度
    CGFloat width = scrollView.bounds.size.width;
    //2.获取内容的偏移量
    CGPoint offSet = scrollView.contentOffset;
    //3.计算当前显示的是第几张图片
    NSInteger page = offSet.x/width;
    //如果为第一张图片,因为第一张为衔接图与最后一张图片相同,pageControl设置为最后页面.
    if (page == 0) {
        //因为第一张图和最后一张图相同,在pageControl上面都显示为最后一个原点.
        _pageControl.currentPage = _pageControl.numberOfPages-1;
    }else{
        _pageControl.currentPage = page-1;
    }
    //NSLog(@"滚动停止,已经结束减速");
}

#pragma mark-实现自动轮播事件
-(void)autoPlay:(NSTimer *)timer{
    
    //[timer invalidate];//从runloop中移除该定时器
    
    
    //1.获取scrollView的宽度
    CGFloat width = _scroll.bounds.size.width;
    //2.获取scrollView的偏移量
    CGPoint offSet = _scroll.contentOffset;
    //3.让scorllView偏移 并且加动画
    //添加判断
    //如果已经是最后一张
    if (offSet.x +width == width*self.imagesURLArrays.count) {
        //切换到第一张
        [_scroll setContentOffset:CGPointZero animated:NO];//切换时候不加动画
        //切换后偏移width
        [_scroll setContentOffset:CGPointMake(width, offSet.y) animated:YES];
        
    }else{
        
        [_scroll setContentOffset:CGPointMake(offSet.x+width, offSet.y) animated:YES];
    }
    //更改pageControl的currentPage
    //获取更改后的偏移量,在获取一次
    offSet = _scroll.contentOffset;
    //2.计算当前显示的页面
    NSInteger page = offSet.x/width;
    
    _pageControl.currentPage =page;
    
    
    
    
    
    
}








-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
    
   
}

-(void)setFocusModelArray:(NSMutableArray *)focusModelArray{
    _focusModelArray = focusModelArray;
    //NSLog(@"%@",focusModelArray);
}





- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
