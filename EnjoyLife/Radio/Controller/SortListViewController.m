//
//  SortListViewController.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright © 2015年 Drop. All rights reserved.
//

#import "SortListViewController.h"

// controller
#import "SortDetailViewController.h"
#import "PlayerViewController.h"
#import "MoreViewController.h"

// view
#import "SortListView.h"
#import "RecommendView.h"
#import "FocusCell.h"
#import "SegCell.h"
#import "CollectionHeadView.h"

// model
#import "TitleModel.h"
#import "FocusModel.h"
#import "SortListModel.h"

// 第三方类库
#import "AFNetworking.h"
#import "UIColor+CustomColor.h"
#import "MJRefresh.h"
#import "WZSnakeHUD.h"




#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


@interface SortListViewController ()<UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *sortListArr;
@property (nonatomic, strong)NSString *soid;
@property (nonatomic, strong)NSString *name;

@property (nonatomic, assign)BOOL isTableShow;
@property (nonatomic, assign)BOOL isRemShow;

@property (nonatomic,strong)NSMutableArray *imagesURLArrays;
@property (nonatomic,strong)NSMutableArray *titleModelArray; // 标题
@property (nonatomic,strong)NSMutableArray *focusModelArray; 
@property (nonatomic,strong)FocusCell *cell;
@property (nonatomic,strong)NSMutableArray *imageArray; // 推荐
@property (nonatomic,strong)RecommendView *recommendView;


@property (nonatomic, strong)UIScrollView *scrollV; // 滑动视图
@property (nonatomic, strong)UISegmentedControl *seg; // 分页导航
@property (nonatomic, strong)UICollectionView *moreView; // 更多
@property (nonatomic, assign)BOOL isShowMore; // 是否显示更多视图
@property (nonatomic, strong)UIButton *button; // 点击更多
@property (nonatomic,strong)NSMutableArray *allArray;

@end

@implementation SortListViewController    



-(void)viewWillAppear:(BOOL)animated{
    self.allArray = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRemShow = YES;
    self.isTableShow = NO;
    
    self.view.backgroundColor = [UIColor whiteSmokeColor];
    
    // 导航条数据解析
    [self handle1:self.string];

    // 推荐页面
    self.recommendView = [[RecommendView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.recommendView.tableView.delegate = self;
    
    [WZSnakeHUD show:@"简 • 加载"];

    [self.view addSubview:self.recommendView];
    
    [self handle:self.string];
    
    // tableView
    self.sortListView = [[SortListView alloc] initWithFrame:(CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - 60))];
    self.sortListView.array = self.segArr;
    self.sortListView.backgroundColor = [UIColor whiteSmokeColor];
    self.sortListView.tableV.delegate = self;

}


#pragma mark -- 创建seg导航条
- (void)setUpSeg:(NSMutableArray *)arr
{
    CGFloat newWidth = 70;
    CGFloat scrollWidth = arr.count * 70 +70;
    // 滑动视图
    self.scrollV = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width- 35, 40))];
    self.scrollV.contentSize = CGSizeMake(scrollWidth,40);
    self.scrollV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollV];
    
    // 全部按钮
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(self.scrollV.frame.origin.x +self.scrollV.bounds.size.width, 0, 35, 40);
    [self.button setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(more:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
    
    // seg分页导航
    self.seg = [[UISegmentedControl alloc] initWithItems:arr];
    [self.scrollV addSubview:self.seg];
    
    NSUInteger count = arr.count;
    for (int i = 1; i <  count + 1 ; i++)
    {
        NSString *title = arr[i-1];
        // 设置标题
        [self.seg setTitle:title forSegmentAtIndex:i-1];
        // 设置宽度
        [self.seg setWidth:70 forSegmentAtIndex:i-1];
    }
    
    self.seg.frame = CGRectMake(0, 0 ,scrollWidth - newWidth, 40);
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor  = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"underline_selected@2x.png"];
    image = [image resizableImageWithCapInsets:(UIEdgeInsetsMake(0,0,0,0)) resizingMode:(UIImageResizingModeStretch)];
    UIImage *image2 = [UIImage imageNamed:@"underline2.png"];
    image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:(UIImageResizingModeStretch)];
    
    [self.seg setBackgroundImage:image forState:(UIControlStateSelected) barMetrics:(UIBarMetricsDefault)];
    [self.seg setBackgroundImage:image2 forState:(UIControlStateNormal) barMetrics:(UIBarMetricsDefault)];
    
    NSDictionary *textAttibutesSelected = [NSDictionary dictionaryWithObjectsAndKeys:RGB(241, 137, 37, 1),NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil];
    NSDictionary *textAttibutesUnSelected = [NSDictionary dictionaryWithObjectsAndKeys:RGB(0, 0, 0, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    [self.seg setTitleTextAttributes:textAttibutesSelected forState:(UIControlStateSelected)];
    [self.seg setTitleTextAttributes:textAttibutesUnSelected forState:(UIControlStateNormal)];
    
    // seg 点击方法
    [self.seg addTarget:self action:@selector(segmControlAction:) forControlEvents:(UIControlEventValueChanged)];

    
    // 全部 视图 collectionView
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(70, 30);
    layout.headerReferenceSize = CGSizeMake(0, 30);

    layout.sectionInset = UIEdgeInsetsMake(20, 20, 10, 20);
    
    self.moreView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 200)) collectionViewLayout:layout];
    self.moreView.backgroundColor = [UIColor whiteSmokeColor];
    self.moreView.showsVerticalScrollIndicator = NO;
    self.moreView.showsHorizontalScrollIndicator = NO;
    self.moreView.delegate = self;
    self.moreView.dataSource = self;
    [self.moreView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.moreView registerClass:[SegCell class] forCellWithReuseIdentifier:@"coll1"];
    
    // 隐藏
    [self.moreView setHidden:YES];
}


#pragma mark -- 点击全部按钮,显示全部视图
-(void)more:(NSMutableArray *)arr
{
    // 判断当前是哪一个页面
    if (self.seg.selectedSegmentIndex == 0) {
        [self.recommendView addSubview:self.moreView];
    }else{
        [self.sortListView addSubview:self.moreView];
    }
    
    // 判断collectionView是否显示
    if (self.moreView.isHidden == YES) {
        
        [self.moreView setHidden:NO];
        // 动画
        [self moreViewShow];
        
    }else{

        [self moreViewDisappear];
    }
}

#pragma mark -- 全部列表 显示动画
- (void)moreViewShow
{
    [UIView animateWithDuration:0.6 animations:^{
        [self.moreView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
        [self.button setImage:[UIImage imageNamed:@"向上"] forState:(UIControlStateNormal)];

        
    } completion:^(BOOL finished) {
        // 改变图片
    }];
}
#pragma mark -- 全部列表 消失动画
- (void)moreViewDisappear
{
    [UIView animateWithDuration:0.6 animations:^{
    [self.moreView setFrame:CGRectMake(0, -self.view.bounds.size.height - 60, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
        [self.button setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];

    } completion:^(BOOL finished) {
        [self.moreView setHidden:YES];
    }];
}

#pragma mark -- collectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.segArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SegCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coll1" forIndexPath:indexPath];
    cell.label.text = self.segArr[indexPath.row];
    return cell;
}
#pragma mark -- 加载区头 区尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    return headerView;
}


#pragma mark -  点击seg 触发方法
- (void)segmControlAction:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    // 赋值
    
    self.soid = self.string;
    self.name =self.segArr[index];
    
    CGFloat offSetX = (index -1) * 70;
    
   
    if (index ==0 ) {
        // 推荐页面
        self.scrollV.contentOffset = CGPointMake(0, 0);
        if (self.isTableShow == NO) {
            [self handle:self.string];
        }else{
            [self.sortListView removeFromSuperview];
            [self.view addSubview:self.recommendView];
            [self handle:self.string];
            self.isRemShow = YES;
            self.isTableShow = NO;
        }
        if (self.moreView.hidden == NO) {
            [self moreViewDisappear];
        }
        
    }else{
        if (self.isRemShow == YES) {
            [self.recommendView removeFromSuperview];
            [self.view addSubview:self.sortListView];
            self.isRemShow= NO;
            self.isTableShow = YES;
            [self setupRefresh];

            
        }else
        {
            [self setupRefresh];

        }
        
        [UIView animateWithDuration:0.6 animations:^{
            self.scrollV.contentOffset = CGPointMake(offSetX, 0);
        } completion:^(BOOL finished) {
            
        }];
        if (self.moreView.hidden == NO) {
            [self moreViewDisappear];
        }
    }
}
#pragma mark -- 点击单元格触发方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortDetailViewController *sortDetailVC = [[SortDetailViewController alloc] init];

    // 如果是推荐页面
    if (tableView == self.recommendView.tableView) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            // 轮播图
        }else{
            
            if(indexPath.row == 0) {
                
                // 更多视图
                MoreViewController *moreVC = [[MoreViewController alloc]init];
                moreVC.titleModel =  self.titleModelArray[indexPath.section-1];
                moreVC.Aid = self.string;
                [self.navigationController pushViewController:moreVC animated:YES];
                //选中取消这行的灰色
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
            }else{
                
                // table单元格
                TitleModel *model = self.titleModelArray[indexPath.section-1];
                SortListModel *model1 = [[model list] objectAtIndex:indexPath.row - 1];
                sortDetailVC.albumId = model1.albumId;
                sortDetailVC.hidesBottomBarWhenPushed = NO;
                sortDetailVC.jiShu = model1.tracksCounts;
                [self.navigationController pushViewController:sortDetailVC animated:YES];
                
            }
        }
    }
    // 如果是普通页面
    else{
       
        if (tableView == self.sortListView.tableV) {
            
            SortListModel *sort = self.sortListArr[indexPath.row];
            sortDetailVC.albumId =sort.albumId;
            [self.navigationController pushViewController:sortDetailVC animated:YES];
            sortDetailVC.hidesBottomBarWhenPushed = NO;
        }
    }
}

#pragma mark -- tableView自定义高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.recommendView.tableView) {
        if (indexPath.section == 0) {
            return 200;
        }else{
            if (indexPath.row == 0) {
                return 30;
            }
            else{
                return self.view.bounds.size.width / 5 + 20;
            }
        }
    }
    return self.view.bounds.size.width / 5 + 20;
}

#pragma mark -- 点击collectionView 触发方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    self.soid = self.string;
    self.name =self.segArr[indexPath.item];
    NSLog(@"%@",self.name);
    
    CGFloat offSetX = (indexPath.row -1) * 70;

    // 如果是 推荐
    if (indexPath.item == 0) {
        
        if (self.isTableShow == NO) {
            [self moreViewDisappear];
            self.seg.selectedSegmentIndex = 0;
            [self handle:self.string];
            
        }else{
            [self.sortListView removeFromSuperview];
            [self.view addSubview:self.recommendView];
            [self handle:self.string];
            [self moreViewDisappear];
            self.seg.selectedSegmentIndex = 0;
            self.isRemShow = YES;
            self.isTableShow = NO;
            [UIView animateWithDuration:0.6 animations:^{
                self.scrollV.contentOffset = CGPointMake(offSetX+70, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
    }else
    {
        if (self.isRemShow == YES) {
            [self.recommendView removeFromSuperview];
            [self.view addSubview:self.sortListView];
            self.isRemShow= NO;
            self.isTableShow = YES;
            self.seg.selectedSegmentIndex = indexPath.row;
            [self setupRefresh];
            [self moreViewDisappear];
            [UIView animateWithDuration:0.6 animations:^{
                self.scrollV.contentOffset = CGPointMake(offSetX, 0);
            } completion:^(BOOL finished) {
                
            }];

        }else
        {
            self.seg.selectedSegmentIndex = indexPath.row;
            [self moreViewDisappear];
            [self setupRefresh];
            [UIView animateWithDuration:0.6 animations:^{
                self.scrollV.contentOffset = CGPointMake(offSetX, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

//上拉加载解析
#pragma mark -- 某一分类下某一模块 数据解析
-(void)sortListHandle:(NSString *)sortId str:(NSString *)string
{
    self.sortListArr = [NSMutableArray array];
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=%@&device=iPhone&pageId=1&pageSize=20&status=0&tagName=%@", sortId, string];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = [dic objectForKey:@"list"];
        
        if (arr.count != 0) {
            [WZSnakeHUD hide];
        }
        
        for (NSDictionary *dic in arr) {
            SortListModel *sort = [[SortListModel alloc] init];
            [sort setValuesForKeysWithDictionary:dic];
            [self.sortListArr addObject:sort];
        }
        self.sortListView.array = self.sortListArr;
        self.allArray =self.sortListArr;

        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

//下拉刷新解析
#pragma mark -- 某一分类下某一模块 数据解析
-(void)sortListHandle1:(NSString *)sortId str:(NSString *)string pageId:(NSInteger)pageId
{
    
     self.sortListArr = [NSMutableArray array];
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=%@&device=iPhone&pageId=%ld&pageSize=20&status=0&tagName=%@", sortId,pageId, string];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = [dic objectForKey:@"list"];
        
        if (arr.count != 0) {
            [WZSnakeHUD hide];
        }
       
        for (NSDictionary *dic in arr) {
            SortListModel *sort = [[SortListModel alloc] init];
            [sort setValuesForKeysWithDictionary:dic];
            [self.sortListArr addObject:sort];
        }
        [self.allArray addObjectsFromArray:self.sortListArr];
        self.sortListView.array = self.allArray;
        
        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}


#pragma mark -- 某一分类 seg 数组 解析
-(void)handle1:(NSString *)sortId
{
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/tagsWithoutCover?categoryId=%@&contentType=album&device=iPhone", sortId ];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = [dic objectForKey:@"list"];
        
        self.segArr = [NSMutableArray arrayWithObjects:@"推荐", nil];
        for (NSDictionary *dic in arr) {
            NSString *name = [dic objectForKey:@"tname"];
            [self.segArr addObject:name];
        }
        
        //创建seg
        [self setUpSeg:self.segArr];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

#pragma mark -- 推荐页面解析
-(void)handle:(NSString *)string
{
    
    self.imageArray = [NSMutableArray array];
    self.titleModelArray = [NSMutableArray array];
    self.focusModelArray = [NSMutableArray array];
    
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends?categoryId=%@&contentType=album&device=iPhone&scale=2&version=4.3.20",string];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSDictionary *categoryDic = [dic objectForKey:@"categoryContents"];
        NSArray *listArr = [categoryDic objectForKey:@"list"];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:listArr];
        [array removeObjectAtIndex:0];
        
        if ([string isEqualToString:@"4"]) {
            [array removeObjectAtIndex:1];
            [array removeObjectAtIndex:0];
        }
        if ([string isEqualToString:@"10"]) {
            [array removeObjectAtIndex:1];
        }
        
        if (array.count != 0) {
            [WZSnakeHUD hide];
        }
        for (NSDictionary *listDic in array) {
            TitleModel *titleModel = [[TitleModel alloc]init];
            [titleModel setValuesForKeysWithDictionary:listDic];
            
            [self.titleModelArray addObject:titleModel];
        }
        
        self.recommendView.titleModelArray = self.titleModelArray;
        
        //==============================================
        //焦点图解析
        
        NSDictionary *focusDic = [dic objectForKey:@"focusImages"];
        
        NSArray *listArr1 = [focusDic objectForKey:@"list"];
      
        for (NSDictionary *listDic in listArr1) {
            FocusModel *focusModel = [[FocusModel alloc]init];
            [focusModel setValuesForKeysWithDictionary:listDic];
            
            [self.focusModelArray addObject:focusModel];
            self.recommendView.focusModel = focusModel;
            [self.imageArray addObject:focusModel.pic];
        }
        self.recommendView.focusModelArray = self.focusModelArray;
        self.recommendView.imageArray = self.imageArray;
        //NSLog(@"%@", self.recommendView.focusModelArray);
       // NSLog(@"%@", self.recommendView.imageArray);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}


#pragma mark -- 下拉刷新, 上啦加载
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    [self.sortListView.tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.sortListView.tableV  headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.sortListView.tableV  addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //1. 在这调用请求网络数据方法（刷新数据）
    [self sortListHandle:self.soid str:self.name];

    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.sortListView.tableV reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.sortListView.tableV headerEndRefreshing];
    });
}
//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    
    // 请求加载数据
    [self sortListHandle1:self.soid str:self.name pageId:self.allArray.count/20+1];
   
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.sortListView.tableV reloadData];
        [self.sortListView.tableV footerEndRefreshing];
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
