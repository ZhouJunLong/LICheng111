//
//  RadioDescriptViewController.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "RadioDescriptViewController.h"
#import "UIColor+CustomColor.h"
#import "SortDetailTop.h"
#import "RadioDescriptCell.h"
#import "UIImageView+WebCache.h"

@interface RadioDescriptViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation RadioDescriptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteSmokeColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];
    table.dataSource = self;
    table.delegate = self;
    table.rowHeight = 200;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    table.backgroundColor = [UIColor whiteSmokeColor];
    [self.view addSubview:table];
    
       
    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat des = [self getHeight:14 data:self.detailTop.intro width:self.view.bounds.size.width - 60];
    return 30 + 40 + 10 + 20 + 10 +des + 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioDescriptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"des"];
    
    if (cell == nil) {
        cell = [[RadioDescriptCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"des"];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:self.detailTop.avatarPath]];
    cell.nameL.text = self.detailTop.nickname;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.desL.text = self.detailTop.intro;
    
    return cell;
}


#pragma mark -- 内容自适应高度
- (CGFloat)getHeight:(NSInteger)font data:(NSString *)data width:(CGFloat)width
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [data boundingRectWithSize:(CGSizeMake(width , NSIntegerMax)) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
