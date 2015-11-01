//
//  XiHuanViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "XiHuanViewController.h"
#import "BtnTabCell.h"

@interface XiHuanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    UIView *btnView;
}
@end

@implementation XiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = NO;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self _initFooterView];

    [self loadData];
    
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

#pragma  mark 加载数据
- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"UserLikes" forKey:@"methodName"];
    
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mArr = [NSMutableArray array];

        for (NSDictionary *dic in arr) {

            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        _data = mArr;
        
        [_tableView.header endRefreshing];
        [_tableView reloadData];
    }];
    
    
}

- (void)_initFooterView{
    
    if (btnView ==nil) {
        btnView = [[[NSBundle mainBundle] loadNibNamed:@"XiHuanBtn" owner:nil options:nil] lastObject];
        
        _tableView.tableFooterView = btnView;

    }
    
    
    
    
    UIButton *btn = (UIButton *)[btnView viewWithTag:200];
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina]) {
        //已经登录
        [btn setTitle:@"欢迎来到掌厨" forState:UIControlStateNormal];
    }else{
        //没有登录
        [btn setTitle:@"登录下，让掌厨更懂你" forState:UIControlStateNormal];
    }

    
}

- (void)btnAction:(UIButton *)btn{
    NSLog(@"点击了");
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
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 11, 50, 50)];
        imgView.image = [UIImage imageNamed:@"recommend.png"];
        [cell.contentView addSubview:imgView];
        
    }
    
    cell.model = _data[indexPath.row];
    
    
    
    
    return cell;

}

#pragma mark 点击单元格触发的事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
    HotModel *model = _data[indexPath.row];
    
    detailVC.dishes_id = model.dishes_id;
    
    [tableView reloadData];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  180;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
