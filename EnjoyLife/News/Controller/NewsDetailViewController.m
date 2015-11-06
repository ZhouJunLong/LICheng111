//
//  NewsDetailViewController.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AFNetworking.h"
#import "NewsDetailModel.h"
#import "NewsDetailView.h"
@interface NewsDetailViewController ()

@property (nonatomic, strong) NewsDetailView *newsDetailView;
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSString *note;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.newsDetailView = [[NewsDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.newsDetailView];
    
    [self handle];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 解析数据
- (void)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应格式为 二进制流格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil];
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html", self.docid];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.modelArr = [NSMutableArray array];
        
        NSMutableDictionary *sourceDic = [rootDic objectForKey:self.docid];
        
        self.note = [self filterHTML:[sourceDic objectForKey:@"body"]];
        
        NewsDetailModel *newsDetailModel = [[NewsDetailModel alloc] init];
        [newsDetailModel setValuesForKeysWithDictionary:sourceDic];
            
        [self.modelArr addObject:newsDetailModel];
        //赋值
        self.newsDetailView.modelArr = self.modelArr;
        self.newsDetailView.str = [NSString stringWithFormat:@"%@", self.note];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息: %@", error);
    }];
    
}

#pragma mark 去掉HTML标签
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = @"p";
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"\n"];
    }
    
    return html;
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
