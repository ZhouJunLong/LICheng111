//
//  NewsImageViewController.h
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsImageViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollV;

//接收传过来的参数
@property (nonatomic, strong) NSString *skipid;
@property (nonatomic, strong) NSString *setname;

@property (nonatomic, strong) NSMutableArray *imageArr;
@end
