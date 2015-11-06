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
@interface VideoListViewController ()<UICollectionViewDelegate>

//@property (nonatomic, strong)Model2 *model2;

@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong)NSMutableArray *modelArray1;


@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"娱乐",@"社会",@"原创",@"搞笑",@"历史"]];
    seg.frame = CGRectMake(0, 64, self.view.bounds.size.width, 30);
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];

    
    _view2 = [[View2 alloc]initWithFrame:CGRectMake(0, 94,self.view.bounds.size.width , self.view.bounds.size.height-94)];
    [self.view addSubview:_view2];
    _view2.collectionVeiw.delegate = self;
    
    _scrollVeiw = [[ScrollView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width,200)];
    [_scrollVeiw.imageView1 sd_setImageWithURL:[NSURL URLWithString:_modelArray[0][@"image"]] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]init];
    [tap1 addTarget:self action:@selector(tap1:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]init];
    [tap2 addTarget:self action:@selector(tap2:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]init];
    [tap3 addTarget:self action:@selector(tap3:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]init];
    [tap4 addTarget:self action:@selector(tap4:)];
    _scrollVeiw.imageView1.userInteractionEnabled = YES;
    [_scrollVeiw.imageView1 addGestureRecognizer:tap1];
    _scrollVeiw.imageView2.userInteractionEnabled = YES;
    [_scrollVeiw.imageView2 addGestureRecognizer:tap2];
    _scrollVeiw.imageView3.userInteractionEnabled = YES;
    [_scrollVeiw.imageView3 addGestureRecognizer:tap3];
    _scrollVeiw.imageView4.userInteractionEnabled = YES;
    [_scrollVeiw.imageView4 addGestureRecognizer:tap4];
    [self.view2.collectionVeiw addSubview:_scrollVeiw];
    self.string = @"100391-0";
    [self handle];
    [self setupRefresh];
    
}


-(void)handle
{
    self.modelArray = [NSMutableArray array];
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?useType=iPhone&adapterNo=6.6.2&isNotModified=0&channelId=%@",self.string] completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"header"];
        for (NSDictionary *dic1 in array) {
            _scrollModel = [[ScrollModel alloc]init];
            [_scrollModel setValuesForKeysWithDictionary:dic1];
            [_modelArray addObject:_scrollModel];
        }
        
        self.scrollVeiw.modelArray = self.modelArray;
        NSLog(@"%ld",self.scrollVeiw.modelArray.count);

    }];
    
    
    self.modelArray1 = [NSMutableArray array];
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?useType=iPhone&adapterNo=6.6.2&isNotModified=0&channelId=%@",self.string] completion:^(NSData *data){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dic objectForKey:@"bodyList"];
        for (NSDictionary *dic1 in array) {
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

-(void)tap1:(UITapGestureRecognizer *)tap
{
    HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
    self.scrollModel =self.modelArray[0];
    happyDetail.str =self.scrollModel.guid ;
    
    [self.navigationController pushViewController:happyDetail animated:YES];
    
    
}
-(void)tap2:(UITapGestureRecognizer *)tap
{
    HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
    self.scrollModel =self.modelArray[1];
    happyDetail.str =self.scrollModel.guid ;
    [self.navigationController pushViewController:happyDetail animated:YES];
}
-(void)tap3:(UITapGestureRecognizer *)tap
{
    HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
    self.scrollModel =self.modelArray[2];
    happyDetail.str =self.scrollModel.guid ;
        [self.navigationController pushViewController:happyDetail animated:YES];
}
-(void)tap4:(UITapGestureRecognizer *)tap
{
    HappyDetailViewController *happyDetail = [[HappyDetailViewController alloc]init];
    self.scrollModel =self.modelArray[2];
    happyDetail.str =self.scrollModel.guid ;
    [self.navigationController pushViewController:happyDetail animated:YES];
}

-(void)valuechanged:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 1) {
        self.string =@"100413-0";
        [self handle];
    }
    if (seg.selectedSegmentIndex == 2) {
        self.string =@"127952-0";
        [self handle];
    }
    if (seg.selectedSegmentIndex == 3) {
        self.string =@"100473-0";
        [self handle];
    }
    if (seg.selectedSegmentIndex == 4) {
        self.string =@"100384-0";
        [self handle];
    }
    if (seg.selectedSegmentIndex == 0) {
        self.string =@"100391-0";
        [self handle];
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
