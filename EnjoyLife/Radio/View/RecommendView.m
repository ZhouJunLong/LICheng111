//
//  RecommendView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "RecommendView.h"
#import "TitleModel.h"
#import "FocusCell.h"
#import "TitleCell.h"

#import "FocusModel.h"
#import "SortListCell.h"
#import "UIColor+CustomColor.h"
//#import "SDCycleScrollView.h"
@interface RecommendView()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation RecommendView


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
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
    
    
        return 4;
    }
    
}
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleModelArray.count;
}
//设置分区头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return 0;
}


//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 200;
    }else{
    if (indexPath.row == 0) {
        return 40;
    }
    else{
        return 100;
    }
    }
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
       
        
        FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" ];
        if (cell == nil) {
            cell = [[FocusCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell2"];
            
        }
        
        //cell.backgroundColor = [UIColor redColor];
        
        cell.imageArray = self.imageArray;
        cell.focusModelArray = self.focusModelArray;
        
       
        return cell;

    }else{
    
    
    if ( indexPath.row == 0) {
        
        
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[TitleCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            
        }
        cell.titleModel = self.titleModelArray[indexPath.section-1];
//        cell.moreLabel.textColor = [UIColor jinjuse];
        
       // NSLog(@"%ld",indexPath.section);
        
        
        
        return cell;

    }else{
        
    
    SortListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[SortListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
        
    }
        
        TitleModel *model = self.titleModelArray[indexPath.section-1];
        cell.sortModel = [[model list] objectAtIndex:indexPath.row - 1];
        

        
       
        return cell;
    }
    
    }

}







-(void)setFocusModelArray:(NSMutableArray *)focusModelArray{
    _focusModelArray = focusModelArray;
    [self.tableView reloadData];
}

-(void)setTitleModelArray:(NSMutableArray *)titleModelArray{
    _titleModelArray = [NSMutableArray arrayWithArray:titleModelArray];
    [self.tableView reloadData];
}

-(void)setFocusModel:(FocusModel *)focusModel{
    _focusModel = focusModel;
    
    [self.tableView reloadData];
    //NSLog(@"%@",focusModel);
}






@end
