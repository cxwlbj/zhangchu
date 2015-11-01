//
//  ShiPuViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ShiPuViewController.h"
#import "ShiPuHeaderView.h"
#import "MBProgressHUD.h"
@interface ShiPuViewController ()
{
    ShiPuHeaderView *headerView;
    MBProgressHUD *_hud;
    
}
@end

@implementation ShiPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //添加下拉刷新控件
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       //回调事件
        [self loadData];
    }];
    
    //自定义单元格头部视图
    [self _initHeaderView];
    [self _initNavBar];
    [self loadData];
    [self _initHud];
}

- (void)_initHud{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.removeFromSuperViewOnHide = YES;
    
    _hud.labelText = @"正在加载...";
    
    _hud.square = YES;
}

- (void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"HomeIndex" forKey:@"methodName"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        headerView.data = [data objectForKey:@"data"];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
         [_hud hide:YES];
        

            MBProgressHUD *hudC = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudC.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark@2x副本"]];
            hudC.square = YES;
            hudC.mode = MBProgressHUDModeCustomView;
            hudC.labelText =@"加载完成   ";
            hudC.removeFromSuperViewOnHide = YES;
            [hudC hide:YES afterDelay:1.5];

       

        
        
    }];
    
    
}

#pragma mark 自定义导航栏
- (void)_initNavBar{
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftBtn addTarget:self action:@selector(navBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -48, 0, 0);
    leftBtn.tag = 2000;
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    

    UIView *midView = [[[NSBundle mainBundle] loadNibNamed:@"navMidBtn" owner:nil options:nil] lastObject];
    midView.frame = CGRectMake(0, 0, kScreenWidth - 10, 30);

    midView.layer.cornerRadius = 4;
    
    UIButton *midBtn = (UIButton *)[midView viewWithTag:2001];
    
    [midBtn addTarget:self action:@selector(navBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = midView;
    

    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightBtn addTarget:self action:@selector(navBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn setImage:[UIImage imageNamed:@"消息默认.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"消 息" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 8, 0, 0);

    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 28.5, 0, 0);

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightItem.width = 30;
    self.navigationItem.rightBarButtonItem = rightItem;
    rightBtn.tag = 2002;
    
    
}

#pragma mark 导航栏按钮触发时间
- (void)navBtnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 2000:
            //扫一扫
            
        {

        }
            break;
        case 2001:
            //搜索
        {
            UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           UIViewController *searchVC = [storyBorad instantiateViewControllerWithIdentifier:@"searchVC"];
            
            
            [self presentViewController:searchVC animated:YES completion:nil];
            
            
        }
            break;
        case 2002:
            //消息
        {
            
            
            NSLog(@"消息");
            
            
        }
            break;


            
        default:
            break;
    }
}






#pragma mark 自定义单元格头部视图
- (void)_initHeaderView
{

    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"ShiPuHeaderView" owner:nil options:nil] lastObject];

    self.tableView.tableHeaderView = headerView;
}


//定义组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shipuCell" forIndexPath:indexPath];
    
    
    return cell;
    
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}
@end
