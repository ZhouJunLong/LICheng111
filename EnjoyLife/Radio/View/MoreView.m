//
//  MoreView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "MoreView.h"
#import "SortListCell.h"
@interface MoreView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation MoreView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:(UITableViewStylePlain)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.rowHeight = 100;
        
        [self addSubview:self.tableView];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModelArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    SortListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (cell == nil) {
        cell = [[SortListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier] ;
        
    }
    cell.sortModel = self.listModelArray[indexPath.row];
    
    
    
    return cell;

}

-(void)setListModelArray:(NSMutableArray *)listModelArray{
    _listModelArray = [NSMutableArray arrayWithArray:listModelArray];
    [self.tableView reloadData];
}




@end
