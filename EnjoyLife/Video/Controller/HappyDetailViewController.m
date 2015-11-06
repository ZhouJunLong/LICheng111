//
//  HappyDetailViewController.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "HappyDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NetHandler.h"
#import "MBProgressHUD.h"
#import "UIColor+CustomColor.h"
#import "LMusicPlay.h"

#import "PlayerViewController.h"
#import "AudioStreamer.h"

@interface HappyDetailViewController ()<UITableViewDelegate>

@property (nonatomic, strong)MPMoviePlayerController *mpc;

@property (nonatomic, strong)NSMutableArray *arrayModel;

@property (nonatomic, strong)NSMutableArray *arrayModel1;

@property (nonatomic,retain) MBProgressHUD *progressHUD;

@end

@implementation HappyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteSmokeColor];

    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = back;
    
    // seg导航
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"相关",@"热点",@"排行"]];
    seg.frame = CGRectMake(0, self.view.bounds.size.height/3-25, self.view.bounds.size.width, 30);
    seg.selectedSegmentIndex = 0;
    seg.tintColor = [UIColor jinjuse];
    [seg addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    // 热点
    _hotView = [[HotView alloc]initWithFrame:CGRectMake(0, seg.bounds.size.height +seg.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height*2/3 - 35)];
    _hotView.tableView.delegate = self;
    [self.view addSubview:_hotView];

    
    
    _videoDetailView = [[VideoDetailView alloc]initWithFrame:CGRectMake(0, self.hotView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height*2/3 - 35)];
    _videoDetailView.tableView.delegate = self;
    [self.view addSubview:_videoDetailView];
    self.videoDetailView.backgroundColor = [UIColor brownColor];
    
   
    
    [self loadVedio];
    [self handle];

}

-(void)back:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [[LMusicPlay shareLmusicPlay] startPlay];
    //        [player.audio start];#import "LMusicPlay.h"

}
-(void)loadVedio
{
    NSString *string = [NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/videoGuid.do?guid=%@",self.str];
    [NetHandler getDataWithUrl:string completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic1 = [dic objectForKey:@"videoFiles"];
        NSDictionary *dic2 = [dic1 objectForKey:@"102"];
        NSString *string1 = [dic2 objectForKey:@"mediaUrl"];
        NSURL *url = [NSURL URLWithString:string1];
        _mpc = [[MPMoviePlayerController alloc]initWithContentURL:url];
        
        _mpc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3-10);
        [self.view addSubview:_mpc.view];
        _mpc.shouldAutoplay = NO;
        [_mpc prepareToPlay];
    }];
}

-(void)handle
{
    
    
    _arrayModel = [NSMutableArray array];
    NSString *string1 = [NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/getGuidRelativeVideoList.do?pageSize=20&guid=%@",self.str];
    [NetHandler getDataWithUrl:string1 completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"guidRelativeVideoInfo"];
        for (NSDictionary *dic1  in array) {
            self.relatedModel = [[RelatedModel alloc]init];
            [self.relatedModel setValuesForKeysWithDictionary:dic1];
            [_arrayModel  addObject:self.relatedModel];
        }
        self.videoDetailView.arrayModel = _arrayModel;
    }];
}


-(void)handle1
{

    _arrayModel1 = [NSMutableArray array];
    [NetHandler getDataWithUrl:@"http://vcsp.ifeng.com/vcsp/appData/recommend.do?useType=iPhone&channelId=hotList&pageSize=10" completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"bodyList"];
        for (NSDictionary *dic1  in array) {
            self.model = [[Model2 alloc]init];
            [self.model setValuesForKeysWithDictionary:dic1];
            [_arrayModel1  addObject:self.model];
        }
        self.hotView.arrayModel = _arrayModel1;
    }];
}


-(void)handle2
{
    
    _arrayModel1 = [NSMutableArray array];
    [NetHandler getDataWithUrl:@"http://vcsp.ifeng.com/vcsp/appData/recommend.do?useType=iPhone&channelId=rankList&pageSize=10" completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"bodyList"];
        for (NSDictionary *dic1  in array) {
            self.model = [[Model2 alloc]init];
            [self.model setValuesForKeysWithDictionary:dic1];
            [_arrayModel1  addObject:self.model];
        }
        self.hotView.arrayModel = _arrayModel1;
    }];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (tableView == _videoDetailView.tableView) {
        if (_arrayModel.count != 0) {
            self.relatedModel = _arrayModel[indexPath.row];
            self.str = self.relatedModel.guid;
            [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            [self loadVedio];
            [self handle];
        }
    }
    if (tableView == _hotView.tableView) {
        if (_arrayModel1.count != 0 ) {
            self.model = _arrayModel1[indexPath.row];
            self.str = self.model.guid;
            
            [tableView setContentOffset:CGPointMake(0, 100* indexPath.row) animated:YES];
            [self loadVedio];
            [self handle];
        }
    }
}



-(void)valueChange:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        [self handle];
        [self.view bringSubviewToFront:_videoDetailView];
        
    }
    if (seg.selectedSegmentIndex == 1) {
        [self handle1];
        [self.view bringSubviewToFront:_hotView];
    }
    if (seg.selectedSegmentIndex == 2) {
        [self handle2];
        [self.view bringSubviewToFront:_hotView];
    }
    
    
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
