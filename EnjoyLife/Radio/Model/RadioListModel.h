//
//  RadioListModel.h
//  EnjoyLife
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioListModel : NSObject

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL isChecked;

@property (nonatomic, assign) NSInteger orderNum;

@property (nonatomic, strong) NSString *coverPath;

@property (nonatomic, assign) BOOL selectedSwitch;

@property (nonatomic, assign) BOOL isFinished;

@property (nonatomic, strong) NSString *contentType;

@end
