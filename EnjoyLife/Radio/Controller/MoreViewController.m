//
//  MoreViewController.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "MoreViewController.h"
#import "UIColor+CustomColor.h"
#import "TitleModel.h"

#import "AFHTTPRequestOperation.h"
#import "MoreView.h"

#import "SortListModel.h"
#import "MJRefresh.h"
#import "sortDetailController.h"


@interface MoreViewController ()<UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *listModelArray;
@property (nonatomic,strong)MoreView *moreView;

//在seg点击中给calcStr赋值
@property (nonatomic,strong)NSString *segStr;

@property (nonatomic,strong)NSMutableArray *allArray;
@end

@implementation MoreViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"最火", @"最近更新", @"经典"]];
    seg.selectedSegmentIndex = 0;
    seg.frame = CGRectMake(0, 66, self.view.bounds.size.width, 30);
    seg.tintColor = [UIColor jinjuse];
    [self.view addSubview:seg];
    
     self.segStr = @"hot";
    
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    //self.view.backgroundColor = [UIColor redColor];
    
    self.moreView = [[MoreView alloc]initWithFrame:CGRectMake(0, seg.frame.origin.y+seg.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-seg.frame.origin.y-seg.bounds.size.height-66)];
    [self.view addSubview:self.moreView];
    
    
    if ([self.titleModel.tagName isEqualToString:@""]) {
        self.title = @"全部";
    }else{
    self.title = self.titleModel.tagName;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.allArray = [NSMutableArray array];
    
    
   
    //calcStr
    //hot最热
    //recent最近更新
    //mostplay经典
    //categoryId 3有声书,2音乐,4综艺,20校园,22旅游,23电影
    //pageId 页数
   // [self handle1:@"hot" categoryId:@"2"pageId:1];
   
    [self setupRefresh];
    self.moreView.tableView.delegate = self;
   
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sortDetailController *sortVC =[[ sortDetailController alloc]init];
    sortVC.sortListModel = self.allArray[indexPath.row];
    [self.navigationController pushViewController:sortVC animated:YES];
}

- (void)segChange:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 0) {
        [self handle1:@"hot" categoryId:@"2"pageId:1];
        self.segStr = @"hot";
    }
    if (seg.selectedSegmentIndex == 1) {
         [self handle1:@"recent" categoryId:@"2"pageId:1];
          self.segStr = @"recent";
        
    }
    if (seg.selectedSegmentIndex == 2) {
        [self handle1:@"mostplay" categoryId:@"2"pageId:1];
        self.segStr = @"mostplay";
    }
    
}

//上拉刷新的解析
-(void)handle1:(NSString *)calcStr categoryId:(NSString*)categoryId pageId:(NSInteger)pageId{
    //self.allArray = [NSMutableArray array];
    self.listModelArray = [NSMutableArray array];
    
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=%@&categoryId=%@&device=iPhone&pageId=%ld&pageSize=20&status=0&tagName=%@",calcStr,categoryId,pageId,self.titleModel.tagName];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        
        
        NSArray *listArr = [dic objectForKey:@"list"];
        
        
        
        
        
        for (NSDictionary *listDic in listArr) {
            SortListModel *sortListModel = [[SortListModel alloc]init];
            [sortListModel setValuesForKeysWithDictionary:listDic];
            
            [self.listModelArray addObject:sortListModel];
            
            
        }
        
        
        
        //self.moreView.listModelArray = self.allArray;
        self.moreView.listModelArray = self.listModelArray;
        self.allArray = self.listModelArray;
        NSLog(@"%ld",self.allArray.count);
        
        //
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}




//下拉加载的解析
-(void)handle2:(NSString *)calcStr categoryId:(NSString*)categoryId pageId:(NSInteger)pageId{
    //self.allArray = [NSMutableArray array];
    self.listModelArray = [NSMutableArray array];
    
    NSString *str=[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=%@&categoryId=%@&device=iPhone&pageId=%ld&pageSize=20&status=0&tagName=%@",calcStr,categoryId,pageId,self.titleModel.tagName];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        
       
        NSArray *listArr = [dic objectForKey:@"list"];
        
        
        
        
        
        for (NSDictionary *listDic in listArr) {
            SortListModel *sortListModel = [[SortListModel alloc]init];
            [sortListModel setValuesForKeysWithDictionary:listDic];
            
            [self.listModelArray addObject:sortListModel];
            
            
        }
        [self.allArray addObjectsFromArray:self.listModelArray];
        
        
        self.moreView.listModelArray = self.allArray;
        //self.moreView.listModelArray = self.listModelArray;
        NSLog(@"%ld",self.allArray.count);
        
        //
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}






- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.moreView.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.moreView.tableView headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.moreView.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
   // [self handle:@"hot" categoryId:@"2"pageId:3];
}







#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //NSInteger i =1;
    
    
    //1. 在这调用请求网络数据方法（刷新数据）
  [self handle1:self.segStr categoryId:@"2"pageId:1];
    //[self.allArray removeAllObjects];
    
    
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.moreView.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.moreView.tableView headerEndRefreshing];
    });
}


//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    [self handle2:self.segStr categoryId:@"2"pageId:self.allArray.count/20+1];
   // [self.moreView.listModelArray removeAllObjects];
    
    
    // 请求加载数据
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.moreView.tableView reloadData];
        [self.moreView.tableView footerEndRefreshing];
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
