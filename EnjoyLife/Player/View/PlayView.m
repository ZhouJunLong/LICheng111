//
//  PlayView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "PlayView.h"
#import "PlayCell.h"

@interface PlayView()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation PlayView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:(UITableViewStylePlain)];
        self.tableView.rowHeight = 600;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        
        
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    PlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[PlayCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"] ;
        
    }
    cell.playDetailModel = self.playModelArray[indexPath.row];
    
  
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)setPlayModelArray:(NSMutableArray *)playModelArray{
    _playModelArray = [NSMutableArray arrayWithArray:playModelArray];
    
    [self.tableView reloadData];
}










@end
