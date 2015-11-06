//
//  ButtonCollectionView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "ButtonCollectionView.h"
#import "ButtonViewCell.h"
#import "HeaderCollectionReusableView.h"
@interface ButtonCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *reusableView;



@end

@implementation ButtonCollectionView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 20;
        layout.itemSize = CGSizeMake(self.frame.size.width / 5, self.frame.size.height / 15);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 10);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册单元格
        [self.collectionView registerClass:[ButtonViewCell class] forCellWithReuseIdentifier:@"buttonCell"];
        
        layout.headerReferenceSize = CGSizeMake(0, 40);
        
        
        
        //注册区头
        [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
 
        
    }
    return self;
}

- (void)setButtonArr1:(NSMutableArray *)buttonArr1{
    _buttonArr1 = [NSMutableArray arrayWithArray:buttonArr1];
    
    
//    [self.collectionView reloadData];
}
- (void)setButtonArr2:(NSMutableArray *)buttonArr2{
    _buttonArr2 = [NSMutableArray arrayWithArray:buttonArr2];
    
//    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.buttonArr1.count;
    }else{
        return self.buttonArr2.count;
    }
    
}

//加载区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    if (indexPath.section == 0) {
        headerView.lable.text = @"取消栏目";
    }else{
        headerView.lable.text = @"点击添加更多栏目";
    }
    
    
    return headerView;

    
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ButtonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSString *title = [self.buttonArr1[indexPath.item] objectForKey:@"title"];
        [cell.button setTitle:title forState:(UIControlStateNormal)];
        
    }else{
        NSString *title = [self.buttonArr2[indexPath.item] objectForKey:@"title"];
        [cell.button setTitle:title forState:(UIControlStateNormal)];
    }
    
    
    return cell;
    
}

@end
