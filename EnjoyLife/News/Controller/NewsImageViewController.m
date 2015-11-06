//
//  NewsImageViewController.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsImageViewController.h"

@interface NewsImageViewController ()<UIScrollViewDelegate>

@end

@implementation NewsImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    // Do any additional setup after loading the view.
}

- (void)scrollView{
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    self.scrollV.contentSize = CGSizeMake(self.imageArr.count *self.view.frame.size.width, 0);
    self.scrollV.pagingEnabled = YES;
    self.scrollV.delegate = self;
    [self.view addSubview:self.scrollV];
    
    
}

- (void)createImageView{
    for (int i = 0; i < self.imageArr.count; i++) {
        
        
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
