//
//  SortDetailTableView.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "SortDetailTableView.h"
#import "SortListCell.h"
#import "SortDetailListCell.h"

@interface SortDetailTableView ()<UITableViewDataSource, UITableViewDelegate>


@end
@implementation SortDetailTableView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        [self addSubview:self.tableV];
    }
    return self;
}


-(void)setDetailArr:(NSMutableArray *)detailArr
{
    _detailArr = [NSMutableArray arrayWithArray:detailArr];
    [self.tableV reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  [NSString stringWithFormat:@"  共%ld集", self.jiShu];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sortDetail"];
    if (cell == nil) {
        cell = [[SortDetailListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"sortDetail"];
    }
    cell.detailList = self.detailArr[indexPath.row];
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
