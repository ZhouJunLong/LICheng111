//
//  NewsListView.m
//  EnjoyLife
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 Drop. All rights reserved.
//

#import "NewsListView.h"
#import "NewsListViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "HeaderViewCell.h"
#import "MJRefresh.h"
#import "NewsDetailViewController.h"
#import "NewsImageCell.h"
#import "NewsScrollView.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height

@interface NewsListView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NewsModel *newsModel;

@end

@implementation NewsListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, frame.size.height) style:(UITableViewStylePlain)];
        
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        
        [self addSubview:self.tableV];
        
        
    }
    return self;
}

- (void)setModelArr:(NSMutableArray *)modelArr{
    _modelArr = [NSMutableArray arrayWithArray:modelArr];
    
    //头条新闻的区头
    NewsModel *newsModel = self.modelArr[0];
    if ([newsModel.tname isEqualToString:@"头条"]) {
        
        NewsScrollView *newsScrollView = [[NewsScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kHeight / 4 + 40)];
        
        self.tableV.tableHeaderView = newsScrollView;
    }else{
        self.tableV.tableHeaderView = nil;
    }

    
    [self.tableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.newsModel = self.modelArr[indexPath.row];
    
    if (self.newsModel.hasHead == YES && ![self.newsModel.tname isEqualToString:@"头条"]) {
        static NSString *reuseIndentifier = @"cell1";
        
        HeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        
        if (cell == nil) {
            cell = [[HeaderViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NewsModel *newsModel = self.modelArr[indexPath.row];
        [cell.imagePic sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
        cell.titleLabel.text = newsModel.title;
        return cell;
        
    }else if([self.newsModel.skipType isEqualToString:@"photoset"]){
        static NSString *reuseIndentifier = @"cell2";
        
        NewsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        
        if (cell == nil) {
            cell = [[NewsImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //赋值
        NewsModel *newsModel = self.modelArr[indexPath.row];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:[newsModel.imgextra firstObject][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
        [cell.imageView3 sd_setImageWithURL:[NSURL URLWithString:[newsModel.imgextra lastObject][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
        cell.label.text = newsModel.title;
        return cell;
        
    }else{
        static NSString *reuseIndentifier = @"cell3";
        NewsListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        
        if (cell == nil) {
            cell = [[NewsListViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NewsModel *newsModel = self.modelArr[indexPath.row];
        //赋值
        cell.titleLabel.text = newsModel.title;
        cell.desLabel.text = newsModel.digest;
        
        [cell.imagePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", newsModel.imgsrc]] placeholderImage:nil];
        
        return cell;
    }
}



@end
