//
//  PlayListViewController.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "PlayListViewController.h"
#import "SortDetailList.h"
#import "PlayerViewController.h"
#import "LMusicPlay.h"
@interface PlayListViewController ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic,strong)SortDetailList *sortDetailList;//下面的
@end

@implementation PlayListViewController


-(void)viewWillAppear:(BOOL)animated{
   //self.navigationController.navigationBar.hidden = YES;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"播放列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sortDetailListModelArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier] ;
        
    }
    
    SortDetailList *sortDetailList = self.sortDetailListModelArray[indexPath.row];
    
    cell.textLabel.text = sortDetailList.title;
   
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SortDetailList *sortDetailList = self.sortDetailListModelArray[indexPath.row];
    PlayerViewController *playVC = [PlayerViewController sharedController];
    playVC.sortDetailList = sortDetailList;

    if (playVC.isPlaying == NO) {
        playVC.sortDetailList = self.sortDetailListModelArray[indexPath.row];
        [[LMusicPlay shareLmusicPlay] startPlay];

        playVC.isPlaying = YES;
        
    }else{
        [[LMusicPlay shareLmusicPlay] stopPlay];
;
       // playVC.player = nil;
        playVC.sortDetailList = self.sortDetailListModelArray[indexPath.row];
       [[LMusicPlay shareLmusicPlay] startPlay];
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)setSortDetailListModelArray:(NSMutableArray *)sortDetailListModelArray{
    _sortDetailListModelArray = sortDetailListModelArray;
   
    [self.tableView reloadData];
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
