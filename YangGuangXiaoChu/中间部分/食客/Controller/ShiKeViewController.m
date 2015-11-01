//
//  ShiKeViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ShiKeViewController.h"
#import "BtnTabCell.h"
#import "HUScrollAndPageView.h"


@interface ShiKeViewController ()<UITableViewDelegate,UITableViewDataSource,HUcrollViewViewDelegate>
{
    NSArray *_data;
    NSArray *_topData;
}

@end

@implementation ShiKeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = NO;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self loadData];

}

#pragma  mark 加载数据
- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"CourseIndex" forKey:@"methodName"];
    [params setObject:@"4.01" forKey:@"version"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];

        NSMutableArray *mArr = [NSMutableArray array];

        
        for (NSDictionary *dic in arr) {
            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        _data = mArr;

        _topData = [[data objectForKey:@"data"] objectForKey:@"top"];
        [self _initGuangGao];
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        
        
    }];
    
    
}

#pragma mark  构造广告条
- (void)_initGuangGao
{
    HUScrollAndPageView *_huView = [[HUScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    
    
    _huView.delegate = self;
    [_huView shouldAutoShow:YES];
    
    _huView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i < _topData.count; i++) {
            
            
            UIImageView *imgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
            
            NSString *str = [_topData[i] objectForKey:@"banner_picture"];
            
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:str]];
            
            [mArr addObject:imgView];
        }
        
        
        
        _huView.imageViewAry = mArr;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    label.text = @"没有更多了";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkGrayColor];
    
    _tableView.tableFooterView = label;
    _tableView.tableHeaderView = _huView;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idertifre = @"dddd";
    BtnTabCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifre];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnTabCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = _data[indexPath.row];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  180;
}



#pragma mark 头部广告点击事件(播放视频)
- (void)didClickPage:(HUScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSURL *url = [NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"];
    
    MPMoviePlayerViewController *playerViewCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentViewController:playerViewCtrl animated:YES completion:nil];
    
}
#pragma mark 禁止上拉加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    
    if (y <= - 64) {
        if (_tableView.bounces == YES) {
            return;
        }
        
        _tableView.bounces = YES;
    }else{
        if (_tableView.bounces == NO) {
            return;
        }
        
        _tableView.bounces = NO;
        
    }
    
}



@end
