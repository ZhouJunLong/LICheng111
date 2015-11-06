//
//  View2.m
//  EnjoyLife
//
//  Created by LiCheng on 15/10/29.
//  Copyright © 2015年 Drop. All rights reserved.
//

#import "View2.h"
#import "UIImageView+WebCache.h"
#import "MainVideoCollectionViewCell.h"
@interface View2 ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation View2

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((self.bounds.size.width-30)/2, (self.bounds.size.width-10)/2);
        
        layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 200);
        
        self.collectionVeiw = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
        self.collectionVeiw.delegate = self;
        self.collectionVeiw.dataSource = self;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.collectionVeiw registerClass:[MainVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.collectionVeiw.backgroundColor = [UIColor whiteColor];
        
    
        [self.collectionVeiw registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
        [self addSubview:self.collectionVeiw];
        
         
    }
    
    return  self;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.model2 = _modelArray[indexPath.row];
    
    return cell;
    

    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
    header.backgroundColor = [UIColor yellowColor];
    
    return header;
    
    
}





-(void)setModelArray:(NSMutableArray *)modelArray
{
    _modelArray = modelArray;
    [self.collectionVeiw reloadData];
}








@end
