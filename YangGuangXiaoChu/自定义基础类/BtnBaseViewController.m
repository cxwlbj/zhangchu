//
//  BtnBaseViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BtnBaseViewController.h"
#import "BtnTabCell.h"
@interface BtnBaseViewController ()

@end

@implementation BtnBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.separatorStyle = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [params setObject:self.params forKey:@"methodName"];
    [params setObject:@"4.01" forKey:@"version"];
    
    if (self.btn_id) {
        [params setObject:self.btn_id forKey:@"serial_id"];
    }
    if (self.cat_id) {
        [params setObject:self.cat_id forKey:@"cat_id"];
        [params setObject:@1 forKey:@"type"];
    }
    
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {

        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        _data = mArr;
        [_tableView reloadData];
        
       
        if (_navTitle) {
             NSString *title = [NSString stringWithFormat:@"%@(%@)",_navTitle,[[data objectForKey:@"data"] objectForKey:@"total"]];
            self.title = title;

        }
        
    }];

    
    
    
}


//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

//定义单元格
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


- (void)setNavTitle:(NSString *)navTitle{
    if (_navTitle != navTitle) {
        _navTitle = navTitle;
        self.title = _navTitle;
    }
}

#pragma mark 点击单元格触发的事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
    
    HotModel *model = _data[indexPath.row];
    
    
    if (model.dishID.length != 0) {
        detailVC.dishes_id = model.dishID;
    }else{
        detailVC.dishes_id = model.dishes_id;
    }

    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    [tableView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
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
