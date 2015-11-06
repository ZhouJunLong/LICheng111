//
//  TitleModel.m
//  EnjoyLife
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "TitleModel.h"
#import "SortListModel.h"

@implementation TitleModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"list"])
    {
        self.list = [NSMutableArray array];
        for (NSDictionary *dic in value)
        {
            SortListModel *sortListModel = [[SortListModel alloc] initWithDictionary:dic];
            
            [self.list addObject:sortListModel];
        }
    }


}

@end
