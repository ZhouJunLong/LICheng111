//
//  SortDetailViewController.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortDetailViewController.h"

#import "SortListViewController.h"
#import "SortDetailTopView.h"
#import "SortDetailTableView.h"
#import "SortDetailList.h"
#import "SortDetailTop.h"
#import "PlayerViewController.h"
#import "RadioDescriptViewController.h"
#import "LMusicPlay.h"


//第三方
#import "UIColor+CustomColor.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>

@interface SortDetailViewController ()<UITableViewDelegate>

@property (nonatomic,strong)SortDetailTopView *topView;
@property (nonatomic, strong)SortDetailTableView *tableV;
@property (nonatomic, strong)NSMutableArray *detailArr;
@end

@implementation SortDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    
    // 隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 隐藏 tabbar
    [self hideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景颜色
    self.view.backgroundColor = [UIColor whiteSmokeColor];
    
    self.navigationController.title = self.title;


    // 隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    // 上部分
    self.topView = [[SortDetailTopView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height /4.7))];
    [self.view addSubview:self.topView];
    
    // 下部分
    self.tableV = [[SortDetailTableView alloc] initWithFrame:(CGRectMake(0, self.topView.frame.origin.y +self.topView.bounds.size.height +45, self.view.bounds.size.width, self.view.bounds.size.height - self.topView.bounds.size.height - 45))];
    self.tableV.tableV.delegate = self;
    [self.view addSubview:self.tableV];
    
    
    // 返回按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15, 25, 30, 30);
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    [button setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    
    [self.topView.desB addTarget:self action:@selector(desAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self handleTop];
    [self setupRefresh];
    
}
#pragma mark -- 电台描述页面
-(void)desAction:(UIButton *)button
{
    RadioDescriptViewController *desVC = [[RadioDescriptViewController alloc] init];
    
    desVC.detailTop = self.topView.detailTop;
    [self.navigationController pushViewController:desVC animated:YES];
    desVC.title = @"简介";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortDetailList *detail = self.detailArr[indexPath.row];
    CGFloat height = self.view.bounds.size.width/ 5.6 +  [self getHeight:16 data:detail.title width:self.view.bounds.size.width - self.view.bounds.size.width/ 5.6 - 50];
    
    return height;
    
}

#pragma mark -- 内容自适应高度
- (CGFloat)getHeight:(NSInteger)font data:(NSString *)data width:(CGFloat)width
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [data boundingRectWithSize:(CGSizeMake(width , NSIntegerMax)) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayerViewController *playVC = [PlayerViewController sharedController];
    UINavigationController *playNC = [[UINavigationController alloc]initWithRootViewController: playVC];
    [PlayerViewController sharedController].sortDetailListModelArray = self.detailArr;
    if (playVC.isPlaying == NO) {
        playVC.sortDetailList = self.detailArr[indexPath.row];
        
        playVC.musicNumber = indexPath.row;
        [[LMusicPlay shareLmusicPlay] playWithUrl:playVC.sortDetailList.playUrl64];
        [[LMusicPlay shareLmusicPlay] startPlay];
        playVC.isPlaying = YES;
        
    }else{
        
        playVC.sortDetailList = self.detailArr[indexPath.row];
        playVC.musicNumber = indexPath.row;
        
        
    }
    [self.navigationController presentViewController:playNC animated:YES completion:nil];
}


#pragma mark -- 数据解析
-(void)handleTop
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
    
    NSString *url=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20?device=iPhone", self.albumId];
    
    [manager GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic=[NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dic = [rootDic objectForKey:@"album"];
        
        SortDetailTop *detailTop = [[SortDetailTop alloc] init];
        [detailTop setValuesForKeysWithDictionary:dic];
        
        // 赋值
        self.topView.detailTop = detailTop;

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];
    }];
}

#pragma mark -- 数据解析
-(void)handleTableView
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
    
    NSString *url=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20?device=iPhone", self.albumId];
    
    [manager GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic=[NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dic = [rootDic objectForKey:@"tracks"];
        NSArray *arr = [dic objectForKey:@"list"];
        
        self.detailArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            SortDetailList *model = [[SortDetailList alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.detailArr addObject:model];
        }
        self.tableV.detailArr = self.detailArr;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"当前没有网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [a show];
    }];
}

#pragma mark -- 返回按钮
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
    [self showTabBar];
}

#pragma mark -- 显示tabbar
- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}


#pragma mark -- 隐藏tabbar
- (void)hideTabBar {
    
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else{
        contentView = [self.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    
    self.tabBarController.tabBar.hidden = YES;
}



- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    [self.tableV.tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.tableV.tableV  headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableV.tableV addFooterWithTarget:self action:@selector(footerRereshing)];
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    [self handleTableView];
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableV.tableV reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableV.tableV headerEndRefreshing];
    });
}
//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    
    
    // 请求加载数据
    [self handleTableView];
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableV.tableV reloadData];
        [self.tableV.tableV footerEndRefreshing];
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
