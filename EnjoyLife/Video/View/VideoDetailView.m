//
//  VideoDetailView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "VideoDetailView.h"
#import "VedioDetailTableViewCell.h"
@interface VideoDetailView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation VideoDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-80)];
        _tableView.dataSource = self;
        _tableView.delegate =self;
        _tableView.rowHeight = 100;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_tableView];
        
        
    }
    return self;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell =[[VedioDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    if (indexPath.row == 0) {
        cell.lable.textColor = [UIColor grayColor];
    }else{
        cell.lable.textColor = [UIColor blackColor];
    }
    cell.relatedModel = _arrayModel[indexPath.row];
    
    return cell;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayModel.count;
}




-(void)setArrayModel:(NSMutableArray *)arrayModel
{
    _arrayModel = arrayModel;
    [self.tableView reloadData];
    
    
    
    
}








@end
