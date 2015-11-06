
//
//  HotView.m
//  EnjoyLife
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "HotView.h"
#import "HotTableViewCell.h"

@interface HotView ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation HotView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate =self;
        _tableView.rowHeight = 100;
        
        _tableView.sectionFooterHeight = 200;
        [self addSubview:_tableView];
        
        
    }
    return self;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell =[[HotTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
//    if (indexPath.row == 0) {
//        cell.lable.textColor = [UIColor redColor];
//    }else{
//        cell.lable.textColor = [UIColor blackColor];
//    }
    cell.model = _arrayModel[indexPath.row];
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
