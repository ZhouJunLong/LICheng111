//
//  RadioListViewController.m
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//

#import "RadioListViewController.h"
#import "AppDelegate.h"
#import "RadioListView.h"
#import "SortListViewController.h"
#import "SortListView.h"

#import "DataBaseHandle.h"
// 第三方类库
#import "UIColor+CustomColor.h"
#import "AFNetworking.h"

@interface RadioListViewController ()

//@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, strong)RadioListView *radioListView; // 九个按钮视图
@property (nonatomic, strong)SortListViewController *sortListVC; // 某一分类下 列表视图控制器

@property (nonatomic, strong)NSMutableArray *segArr;


@property (nonatomic,assign)NSInteger currentTag;
@property (nonatomic, assign)CGPoint orginPoint;
@property (nonatomic, assign)CGPoint mPoint;


@end


@implementation RadioListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteSmokeColor];

     // 视图
    self.radioListView = [[RadioListView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];

    [self.view addSubview:self.radioListView];
    
    
    // 按钮添加方法
    [self.radioListView.button1 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button2 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button3 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button4 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button5 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button6 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button7 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.radioListView.button8 addTarget:self action:@selector(classList:) forControlEvents:(UIControlEventTouchUpInside)];

    

//    self.arr = @[[self handle:@"3"], [self handle:@"2"]];
//    NSLog(@"%@",self.arr);
    
    
}

#pragma mark -- 按钮方法 进入分类列表
- (void)classList:(UIButton *)button
{

    self.sortListVC = [[SortListViewController alloc] init];

    
    
    // 设置 标题
    NSArray *titleArr = @[@"有声书",@"音乐", @"综艺娱乐", @"校园", @"城市电台", @"生活情感", @"电影" ,@"旅游"];
    NSInteger i = button.tag - 1000;
    self.sortListVC.title = titleArr[i];
    
    if (i == 0) {
        self.sortListVC.string = @"3";
    }
    else if (i == 1) {
        self.sortListVC.string = @"2";
    }
    else if (i == 2) {
        self.sortListVC.string = @"4";
    }
    else if (i == 3) {
        self.sortListVC.string = @"20";
    }
    else if (i == 4) {
        self.sortListVC.string = @"17";
    }
    else if (i == 5) {
        self.sortListVC.string = @"10";
    }
    else if (i == 6) {

        self.sortListVC.string = @"23";
    }
    else{
        self.sortListVC.string = @"22";
    }

    [self.navigationController pushViewController:self.sortListVC animated:YES];
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
