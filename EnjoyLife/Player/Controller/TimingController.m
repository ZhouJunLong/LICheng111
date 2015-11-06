//
//  TimingController.m
//  EnjoyLife
//
//  Created by lanou on 15/11/6.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "TimingController.h"

@interface TimingController ()
@property (nonatomic,strong)UISwitch *mySwitch;
@end

@implementation TimingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"定时关闭";
    
   // UISwitch* mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(200.0,10.0,0.0,0.0)];
    
    
    
    
    // Do any additional setup after loading the view.
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
