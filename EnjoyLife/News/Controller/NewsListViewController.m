//
//  NewsListViewController.m
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//

#import "NewsListViewController.h"
#import "UIColor+CustomColor.h"
#import "NewsListView.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "ButtonCollectionView.h"
#import "ButtonScrollView.h"
#import "MJRefresh.h"
#import "NewsDetailViewController.h"
#import "WZSnakeHUD.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height
@interface NewsListViewController ()<UICollectionViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) ButtonCollectionView *buttonCollection;

@property (nonatomic, strong) ButtonScrollView *buttonScrollCollection;

@property (nonatomic, strong) NewsListView *newsListView;

@property (nonatomic, strong) UIView *topView;//scrollView底部的view

@property (nonatomic, strong) UIView *buttonView;//全部button的View

@property (nonatomic, strong) UIButton *moreButton;//跳转到buttonView

@property (nonatomic, strong) NSMutableArray *buttonArray1;

@property (nonatomic, strong) NSMutableArray *buttonArray2;

@property (nonatomic, strong) NSMutableArray *ButtonScrollArr;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSMutableArray *allModelArr;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;

@end

@implementation NewsListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self createDefaults];
        
    }
    return self;
}

#pragma mark -- 创建本地存储栏目
- (void)createDefaults{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //取到 取消 和 添加 存放button的数组
    NSArray *cancelArr = [defaults objectForKey:@"buttonArray1"];
    NSArray *addArr = [defaults objectForKey:@"buttonArray2"];
    
    if (!cancelArr) {
        NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"头条", @"title", @"http://c.3g.163.com/nc/article/headline/T1348647853363/0-140.html", @"url", @"T1348647853363", @"name", nil];
        
        NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"体育", @"title", @"http://c.3g.163.com/nc/article/list/T1348649079062/0-20.html", @"url", @"T1348649079062", @"name", nil];
        
        NSDictionary * dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"财经", @"title", @"http://c.3g.163.com/nc/article/list/T1348648756099/0-20.html", @"url", @"T1348648756099", @"name", nil];
        
        NSDictionary * dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"科技", @"title", @"http://c.3g.163.com/nc/article/list/T1348649580692/0-20.html", @"url", @"T1348649580692", @"name", nil];
        
        NSDictionary * dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"NBA", @"title", @"http://c.3g.163.com/nc/article/list/T1348649145984/0-20.html", @"url", @"T1348649145984", @"name", nil];
        
        NSDictionary * dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"军事", @"title", @"http://c.3g.163.com/nc/article/list/T1348648141035/0-20.html", @"url", @"T1348648141035", @"name", nil];
        
        NSDictionary * dic7 = [NSDictionary dictionaryWithObjectsAndKeys:@"汽车", @"title", @"http://c.3g.163.com/nc/article/list/T1348654060988/0-20.html", @"url", @"T1348654060988", @"name", nil];
        
        NSDictionary * dic8 = [NSDictionary dictionaryWithObjectsAndKeys:@"轻松一刻", @"title", @"http://c.3g.163.com/nc/article/list/T1350383429665/0-20.html", @"url", @"T1350383429665", @"name", nil];
        
        NSDictionary * dic9 = [NSDictionary dictionaryWithObjectsAndKeys:@"房产", @"title", @"http://c.3g.163.com/nc/article/house/5YWo5Zu9/0-20.html", @"url", @"全国", @"name", nil];
        
        NSDictionary * dic10 = [NSDictionary dictionaryWithObjectsAndKeys:@"时尚", @"title", @"http://c.3g.163.com/nc/article/list/T1348650593803/0-20.html", @"url", @"T1348650593803", @"name", nil];
        
        NSDictionary * dic11 = [NSDictionary dictionaryWithObjectsAndKeys:@"娱乐", @"title", @"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html",  @"url", @"T1348648517839", @"name", nil];
        
        NSArray *array = @[dic1, dic2, dic3, dic4, dic5, dic6, dic7, dic8, dic9, dic10, dic11];
        self.buttonArray1 = [NSMutableArray arrayWithArray:array];
        
        [defaults setObject:self.buttonArray1 forKey:@"buttonArray1"];
        
        
        NSDictionary * dic12 = [NSDictionary dictionaryWithObjectsAndKeys:@"跑步", @"title", @"http://c.3g.163.com/nc/article/list/T1411113472760/0-20.html", @"url", @"T1411113472760", @"name", nil];
        
        NSDictionary * dic13 = [NSDictionary dictionaryWithObjectsAndKeys:@"社会", @"title", @"http://c.3g.163.com/nc/article/list/T1348648037603/0-20.html", @"url", @"T1348648037603", @"name", nil];
        
        NSDictionary * dic14 = [NSDictionary dictionaryWithObjectsAndKeys:@"历史", @"title", @"http://c.3g.163.com/nc/article/list/T1368497029546/0-20.html", @"url", @"T1368497029546", @"name", nil];
        
        NSDictionary * dic15 = [NSDictionary dictionaryWithObjectsAndKeys:@"彩票", @"title", @"http://c.3g.163.com/nc/article/list/T1356600029035/0-20.html", @"url", @"T1356600029035", @"name", nil];
        
        NSDictionary * dic16 = [NSDictionary dictionaryWithObjectsAndKeys:@"健康", @"title", @"http://c.3g.163.com/nc/article/list/T1414389941036/0-20.html", @"url", @"T1414389941036", @"name", nil];
        
        NSDictionary * dic17 = [NSDictionary dictionaryWithObjectsAndKeys:@"旅游", @"title", @"http://c.3g.163.com/nc/article/list/T1348654204705/0-20.html", @"url", @"T1348654204705", @"name", nil];
        
        NSDictionary * dic18 = [NSDictionary dictionaryWithObjectsAndKeys:@"游戏", @"title", @"http://c.3g.163.com/nc/article/list/T1348654151579/0-20.html", @"url", @"T1348654151579", @"name", nil];
        
        NSDictionary * dic19 = [NSDictionary dictionaryWithObjectsAndKeys:@"教育", @"title", @"http://c.3g.163.com/nc/article/list/T1348654225495/0-20.html", @"url", @"T1348654225495", @"name", nil];
        
        NSDictionary * dic20 = [NSDictionary dictionaryWithObjectsAndKeys:@"数码", @"title", @"http://c.3g.163.com/nc/article/list/T1348649776727/0-20.html", @"url", @"T1348649776727", @"name", nil];
        
        
        NSArray * arr = @[dic12, dic13, dic14, dic15, dic16, dic17, dic18, dic19, dic20];
        self.buttonArray2 = [NSMutableArray arrayWithArray:arr];
        
        [defaults setObject:self.buttonArray2 forKey:@"buttonArray2"];
        [defaults synchronize];
        
    } else {
        self.buttonArray1 = [NSMutableArray arrayWithArray:cancelArr];
        self.buttonArray2 = [NSMutableArray arrayWithArray:addArr];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WZSnakeHUD show:@"闻 • 加载"];
    
//    self.ButtonScrollArr = [NSMutableArray array];
    //导航栏控制器的透明度
    self.navigationController.navigationBar.translucent = NO;
    
   self.navigationController.tabBarController.tabBar.translucent = NO;
    
    //滚动视图 底部的view
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight/ 18)];
    
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    //创建滚动视图
    [self createScrollView];
    
    //跳转对应的view
    _newsListView = [[NewsListView alloc] initWithFrame:CGRectMake(0, self.topView.frame.origin.y + self.topView.frame.size.height, kWidth, self.view.frame.size.height - self.topView.frame.origin.y - self.topView.frame.size.height - 66)];
    self.newsListView.tableV.delegate = self;
    
    [self.view addSubview:_newsListView];
    
    
    //解析第一个数据 ??????????????????????????????? (最后还剩下一个, 没法添加)
    NSString *url = [self.buttonArray1[0] objectForKey:@"url"];
    NSString *name = [self.buttonArray1[0] objectForKey:@"name"];
    [self handle:url name:name];
    //点击item 取到的name 和 url
//    self.name = name;
//    self.url = url;
    
    //下拉刷新方法
//    [self setupRefresh];
    
    //创建buttonView
    self.buttonCollection = [[ButtonCollectionView alloc] initWithFrame:CGRectMake(0, -self.newsListView.frame.size.height - 60, kWidth, kHeight)];
    

    self.buttonCollection.collectionView.delegate = self;
    
    [self.buttonCollection setHidden:YES];
    self.buttonCollection.backgroundColor = [UIColor whiteColor];
    
    //赋值
    self.buttonCollection.buttonArr1 = self.buttonArray1;
    self.buttonCollection.buttonArr2 = self.buttonArray2;
    
    //赋值
    self.buttonScrollCollection.buttonArr = self.buttonArray1;
    
    [self.view addSubview:self.buttonCollection];
    
    self.allModelArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建scrollView
- (void)createScrollView{
    
    //隐藏视图的button
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButton.frame = CGRectMake(self.topView.frame.size.width - 40, 0, 40, self.topView.frame.size.height);
    
    [self.moreButton setImage:[UIImage imageNamed:@"向下.png"] forState:(UIControlStateNormal)];
    [self.topView addSubview:self.moreButton];
    
    [self.moreButton addTarget:self action:@selector(showSelectView:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.buttonScrollCollection = [[ButtonScrollView alloc] initWithFrame:CGRectMake(0, self.topView.frame.origin.y, kWidth - 40, 30)];
    
    self.buttonScrollCollection.collectionView.delegate = self;
    
    [self.topView addSubview:self.buttonScrollCollection];
    
    
}

#pragma mark - tableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newsModel = self.allModelArr[indexPath.row];
    
    if (newsModel.hasHead == YES && ![newsModel.tname isEqualToString:@"头条"]) {
        return kHeight * 1 / 3;
    }else if([newsModel.skipType isEqualToString:@"photoset"]){
        return kHeight / 5.5;
    }else{
        return kHeight / 6;
    }
}

//点击单元格触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    //赋值给detailModel
    NewsModel *newsModel = self.allModelArr[indexPath.row];
    
    newsDetailVC.docid = newsModel.docid;
    
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}


#pragma mark - collection代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (collectionView == self.buttonCollection.collectionView) {
        
        if (indexPath.section == 0) {
            NSDictionary *dic = self.buttonArray1[indexPath.item];
            
            if (self.buttonArray1.count != 0) {
                [self.buttonArray1 removeObject:dic];
            }
            
            [self.buttonArray2 addObject:dic];
            
            //给buttonCollection 传值
            self.buttonCollection.buttonArr1 = self.buttonArray1;
            self.buttonCollection.buttonArr2 = self.buttonArray2;
            [self.buttonCollection.collectionView reloadData];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.buttonArray1 forKey:@"buttonArray1"];
            [defaults setObject:self.buttonArray2 forKey:@"buttonArray2"];
            [defaults synchronize];
            
            //重新给改变数组的 数组赋值
            self.buttonScrollCollection.buttonArr = self.buttonArray1;
            
            [self.buttonScrollCollection.collectionView reloadData];
            
        }else{
            NSDictionary *dic = self.buttonArray2[indexPath.item];
            
            [self.buttonArray2 removeObject:dic];
            
            [self.buttonArray1 addObject:dic];
            
            //赋值
            self.buttonCollection.buttonArr1 = self.buttonArray1;
            
            self.buttonCollection.buttonArr2 = self.buttonArray2;
            [self.buttonCollection.collectionView reloadData];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.buttonArray1 forKey:@"buttonArray1"];
            [defaults setObject:self.buttonArray2 forKey:@"buttonArray2"];
            [defaults synchronize];
            
            //重新赋值
            self.buttonScrollCollection.buttonArr = self.buttonArray1;
            
            [self.buttonScrollCollection.collectionView reloadData];
            
            //再次实现点击按钮方法
            [self showSelectView:self.moreButton];
            
            //判断 改变scrollView的偏移量
            if (self.buttonArray1.count > 6) {
                [self.buttonScrollCollection.collectionView setContentOffset:CGPointMake(60 * (self.buttonArray1.count - 3), 0) animated:YES];
            }
            
        
    
            
            NSString *url = [[self.buttonArray1 lastObject] objectForKey:@"url"];
            NSString *name = [[self.buttonArray1 lastObject] objectForKey:@"name"];
            
            
            //点击item 取到的name 和 url
            self.name = name;
            self.url = url;
            [self setupRefresh];
        }
    }else{
        
        NSString *url = [self.buttonArray1[indexPath.item] objectForKey:@"url"];
        NSString *name = [self.buttonArray1[indexPath.item] objectForKey:@"name"];

        
        //点击item 取到的name 和 url
        self.name = name;
        self.url = url;
        
        //下拉刷新方法
        [self setupRefresh];
        
        //改变collectionView的偏移量
        if (indexPath.item > 3) {
            [UIView animateWithDuration:0.6 animations:^{
                self.buttonScrollCollection.collectionView.contentOffset = CGPointMake(60 * (indexPath.item - 3) + 20, 0);
            } completion:^(BOOL finished) {
               
            }];
            
        }else{
            [UIView animateWithDuration:0.6 animations:^{
                self.buttonScrollCollection.collectionView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}


#pragma mark - 下拉刷新
- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    [self.newsListView.tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.newsListView.tableV headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.newsListView.tableV addFooterWithTarget:self action:@selector(footerRereshing)];
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    
    [self handle:self.url name:self.name];
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.newsListView.tableV reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.newsListView.tableV headerEndRefreshing];
    });
}

//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    NSInteger ID = self.allModelArr.count ;
    
    // 请求加载数据
    [self handel:self.url name:self.name ID:ID];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.newsListView.tableV reloadData];
        [self.newsListView.tableV footerEndRefreshing];
    });
}

#pragma mark - 下拉加载更多的数据
- (void)handel:(NSString *)url name:(NSString *)name ID:(NSInteger)ID{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
    NSString *url1 = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/%@/%ld-20.html", name, ID];
    [manager GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.modelArr = [NSMutableArray array];
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        NSMutableArray *arr = [rootDic objectForKey:name];
      
        for (NSDictionary *dic in arr) {
            
            NewsModel *newsModel = [[NewsModel alloc] init];
            [newsModel setValuesForKeysWithDictionary:dic];
            
            [self.modelArr addObject:newsModel];
            
        }
        [self.allModelArr addObjectsFromArray:self.modelArr];
        
        self.newsListView.modelArr = self.allModelArr;
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        }];

}

#pragma mark - 解析数据
- (void)handle:(NSString *)url name:(NSString *)name{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
   
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self.modelArr = [NSMutableArray array];
        
        NSMutableArray *arr = [rootDic objectForKey:name];
        
        if (arr.count != 0) {
            [WZSnakeHUD hide];
        }
        for (NSDictionary *dic in arr) {
            
            NewsModel *newsModel = [[NewsModel alloc] init];
            [newsModel setValuesForKeysWithDictionary:dic];
            
            [self.modelArr addObject:newsModel];
            
        }
        self.allModelArr = self.modelArr;
        
        self.newsListView.modelArr = self.modelArr;
    
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];
    }];

}

#pragma mark - 显示出添加删除页面
- (void)showSelectView:(UIButton *)button{
    
    if ([self.buttonCollection isHidden] == YES) {
        
        [self.buttonCollection setHidden:NO];
        [UIView animateWithDuration:0.6 animations:^{
            [self.buttonCollection setFrame:CGRectMake(0, self.topView.frame.origin.y + self.topView.frame.size.height , kWidth, kHeight)];
            

        } completion:^(BOOL finished) {
            [self.moreButton setImage:[UIImage imageNamed:@"向上"] forState:(UIControlStateNormal)];
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.6 animations:^{
            [self.buttonCollection setFrame:CGRectMake(0, -self.newsListView.frame.size.height - 60, kWidth, kHeight)];

        } completion:^(BOOL finished) {
            [self.moreButton setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
            [self.buttonCollection setHidden:YES];
            
        }];
    }
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
