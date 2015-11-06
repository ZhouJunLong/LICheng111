//
//  ButtonScrollView.m
//  EnjoyLife
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "ButtonScrollView.h"
#import "ButtonScrollViewCell.h"

@interface ButtonScrollView()<UICollectionViewDelegate, UICollectionViewDataSource>



@end

@implementation ButtonScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(frame.size.width / 6, frame.size.height);
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.collectionView registerClass:[ButtonScrollViewCell class] forCellWithReuseIdentifier:@"Cell1"];
        [self addSubview:self.collectionView];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
       
        
    }
    return self;
}

- (void)setButtonArr:(NSMutableArray *)buttonArr{
    
        
        _buttonArr = [NSMutableArray arrayWithArray:buttonArr];
        
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.buttonArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ButtonScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
    
    cell.label.text = [self.buttonArr[indexPath.item] objectForKey:@"title"];
    
    return cell;
    
}

@end
