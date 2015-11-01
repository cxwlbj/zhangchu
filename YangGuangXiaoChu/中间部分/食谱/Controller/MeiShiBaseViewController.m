//
//  MeiShiBaseViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MeiShiBaseViewController.h"
#import "MeiShiModel.h"
#import "MeiShiCell.h"
@interface MeiShiBaseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_data;
}
@end

@implementation MeiShiBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"美食专题";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 60)];
    [leftBtn addTarget:self action:@selector(fanHuiItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self loadData];
}


#pragma  mark 加载数据
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"TopicList" forKey:@"methodName"];
    
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
             MeiShiModel *model = [[MeiShiModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        _data = mArr;
        [_tableView reloadData];
        
    }];
    
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idertifre = @"dddd";
    MeiShiCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifre];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeiShiCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = _data[indexPath.row];
    
    return cell;
}

#pragma  mark 单元格被点击时触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  methodName	TopicView
     version	1.0
     user_id	0
     topic_id	58
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"TopicView" forKey:@"methodName"];
    MeiShiModel *model = _data[indexPath.row];
    
    [params setObject:model.meiShiID forKey:@"topic_id"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSDictionary *dic = [data objectForKey:@"data"];
        
        
        WebBaseViewController *webVC = [[WebBaseViewController alloc] init];
        webVC.httpStr = [dic objectForKey:@"share_url"];
        webVC.title = [dic objectForKey:@"title"];
        [self.navigationController pushViewController:webVC animated:YES ];
        
        
    }];
    [tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (void)fanHuiItemAction:(UIBarButtonItem *)item
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
