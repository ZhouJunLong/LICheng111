//
//  SortListView.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortListView.h"
#import "SortListCell.h"
#import "UIColor+CustomColor.h"

@interface SortListView ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation SortListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        

        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height- 30))];
        
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        self.tableV.backgroundColor = [UIColor whiteSmokeColor];
        [self addSubview:self.tableV];
        
    }
    return self;
}

-(void)setArray:(NSMutableArray *)array
{
    _array = [NSMutableArray arrayWithArray:array];
    // 刷新视图
    [self.tableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortList"];
    
    if (cell == nil) {
        
        cell = [[SortListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SortList"];
    }
    // 赋值
    cell.sortModel = self.array[indexPath.row];
//    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
