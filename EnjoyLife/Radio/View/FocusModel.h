//
//  FocusModel.h
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//


//焦点图model
#import <Foundation/Foundation.h>

@interface FocusModel : NSObject

@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,strong)NSString *shortTitle;
@property (nonatomic,strong)NSString *longTitle;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger uid;
@property (nonatomic,assign)NSInteger trackId;



@end
