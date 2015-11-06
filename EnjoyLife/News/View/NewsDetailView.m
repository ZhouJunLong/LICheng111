//
//  NewsDetailView.m
//  EnjoyLife
//
//  Created by lanou on 15/11/3.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsDetailView.h"
#import "NewsDetailViewCell.h"
#import "NewsDetailModel.h"
@interface NewsDetailView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger imageHeight;

@end
@implementation NewsDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:(UITableViewStylePlain)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.tableView];
        
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (void)setModelArr:(NSMutableArray *)modelArr{
    _modelArr = [NSMutableArray arrayWithArray:modelArr];
    
    
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.imageHeight = 0;

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil];
    
    
    CGRect rect = [self.str boundingRectWithSize:CGSizeMake(self.bounds.size.width- 20, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _newsDetailModel = self.modelArr[0];
    if (self.newsDetailModel.img.count) {
        for (int i = 0; i < self.newsDetailModel.img.count; i++) {
            
            NSString *length = [self.newsDetailModel.img[i] objectForKey:@"pixel"];
            NSArray *arr = [length componentsSeparatedByString:@"*"];
            NSInteger width = [arr[0] integerValue];
            NSInteger height = [arr[1] integerValue];
            
            CGFloat size = width * 1.0 / height *1.0;
            CGFloat height1 =  (self.bounds.size.width - 20) / size;
            
            if (length != 0) {
                self.imageHeight += height1;
            
            }
        }
    }

    return rect.size.height + 220 + self.imageHeight + self.newsDetailModel.img.count * 10;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIndentifier = @"coll";
    
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    
    if (_cell == nil) {
        _cell = [[NewsDetailViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIndentifier];
    }
    _cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    NewsDetailModel *newsDetailModel = self.modelArr[indexPath.row];
    //赋值
    _cell.newsDetailModel = newsDetailModel;
    _cell.BodyLabel.text = self.str;
    
    

    return _cell;
}


@end
