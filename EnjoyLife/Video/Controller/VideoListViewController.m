//
//  VideoListViewController.m
//  EnjoyLive
//
//  Created by LiCheng on 15/10/28.
//  Copyright © 2015年 LiCheng. All rights reserved.
//

#import "VideoListViewController.h"
#import "UIImageView+WebCache.h"
#import "HappyDetailViewController.h"
#import "NetHandler.h"
#import "ScrollModel.h"
#import "MJRefresh.h"
#import "UIColor+CustomColor.h"
#import "PlayerViewController.h"
#import "AudioStreamer.h"
#import "LMusicPlay.h"
#import "WZSnakeHUD.h"

#import "SDCycleScrollView.h"

static NSInteger i = 0;

@interface VideoListViewController ()<UICollectionViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic ,strong)SDCycleScrollView *cycleScrollView2;

@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong)NSMutableArray *modelArray1;


@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WZSnakeHUD show:@"视 • 加载"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.translucent = NO;

    // seg导航
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"社会",@"娱乐",@"原创",@"搞笑",@"历史"]];
    seg.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    seg.tintColor = [UIColor jinjuse];
    [self.view addSubview:seg];

    // 集合视图
    _view2 = [[View2 alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height / 3.5 +20,self.view.bounds.size.width , self.view.bounds.size.height-self.view.bounds.size.height / 3.5 - 30 - 70)];
    [self.view addSubview:_view2];
    _view2.collectionVeiw.delegate = self;
    self.view2.backgroundColor = [UIColor brownColor];
    
    [self.view addSubview:self.view2];
    self.string = @"100413-0";

    [self setupRefresh];
    
}


-(void)handle
{
    // 轮播图
    self.modelArray = [NSMutableArray array];
    self.modelArray1 = [NSMutableArray array];
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?useType=iPhone&adapterNo=6.6.2&isNotModified=0&channelId=%@",self.string] completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"header"];
        for (NSDictionary *dic1 in array) {
            _scrollModel = [[ScrollModel alloc]init];
            [_scrollModel setValuesForKeysWithDictionary:dic1];
            [_modelArray addObject:_scrollModel];
        }
        
        [self setUpImageScroll:self.modelArray];
        
        NSArray *array1 = [dic objectForKey:@"bodyList"];
        
        if (array.count != 0) {
            [WZSnakeHUD hide];
        }
        for (NSDictionary *dic1 in array1) {
            NSArray *arr = [dic1 objectForKey:@"videoList"];
            for (NSDictionary *dic2 in arr) {
                _model2 = [[Model2 alloc]init];
                [_model2 setValuesForKeysWithDictionary:dic2];
                [_modelArray1 addObject:_model2];
            }
            
        }
        self.view2.modelArray = self.modelArray1;

    }];
 
}


-(void)setUpImageScroll:(NSMutableArray *)mArr
{
    i +=1;

    if (i > 0) {
        [self.cycleScrollView2 removeFromSuperview];
    }
    NSMutableArray *url = [NSMutableArray array];
    NSMutableArray *title = [NSMutableArray array];
    
    for (NSInteger i= 0; i< mArr.count; i++) {
        ScrollModel  *model= mArr[i];
        [url addObject:model.image];
        [title addObject:model.title];
        
    }
    
    CGFloat newWidth = self.view.bounds.size.width;
    self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 30, newWidth, self.view.bounds.size.height / 3.5) imageURLStringsGroup:nil]; // 模拟网络延时情景
    self.cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView2.delegate = self;
    self.cycleScrollView2.titlesGroup = title;
    self.cycleScrollView2.dotColor = [UIColor jinjuse]; // 自定义分页控件小圆标颜色
    self.cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:self.cycleScrollView2];
    

    //  --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView2.imageURLStringsGroup = url;

    });

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [[LMusicPlay shareLmusicPlay] stopPlay];
    
    HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
    self.model2 =self.modelArray[index];
    happyDetail.str =self.model2.guid ;
    [self.navigationController pushViewController:happyDetail animated:YES];
}

-(void)valuechanged:(UISegmentedControl *)seg
{
//    [self.cycleScrollView2 removeFromSuperview];
    if (seg.selectedSegmentIndex == 1) {
        self.string =@"100391-0";

        [self setupRefresh];

    }
    if (seg.selectedSegmentIndex == 2) {
        self.string =@"127952-0";
        [self setupRefresh];
    }
    if (seg.selectedSegmentIndex == 3) {
        self.string =@"100473-0";
        [self setupRefresh];
    }
    if (seg.selectedSegmentIndex == 4) {
        self.string =@"100384-0";
        [self setupRefresh];
    }
    if (seg.selectedSegmentIndex == 0) {
        self.string =@"100413-0";
        [self setupRefresh];
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PlayerViewController *player = [PlayerViewController playInterface];
//    [player.audio pause];
    [[LMusicPlay shareLmusicPlay] stopPlay];
    
    if (collectionView == self.view2.collectionVeiw) {
        HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
        self.model2 =self.modelArray1[indexPath.item];
        happyDetail.str =self.model2.guid ;
        [self.navigationController pushViewController:happyDetail animated:YES];
    }
}

- (void)setupRefresh
{
    [self.view2.collectionVeiw addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.view2.collectionVeiw headerBeginRefreshing];
    
    
}
- (void)headerRereshing
{
    [self handle];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC) ), dispatch_get_main_queue(), ^{
        [self.view2.collectionVeiw reloadData];
        [self.view2.collectionVeiw headerEndRefreshing];
    });

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
