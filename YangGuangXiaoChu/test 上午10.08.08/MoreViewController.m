//
//  MoreViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreViewController.h"
#import "BtnTabCell.h"
@interface MoreViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_slideView;//滑动的view
    UIScrollView *_scrollView;
    UIView *testView;
    
    NSArray *_hotData;
    NSArray *_newData;
    
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化中间标题视图
    [self _initTitleView];
    [self _initScrollView];
    [self _initTabelView];
    [self loadHotData];
    [self loadNewData];
}

- (void)_initTitleView
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 60)];
    [leftBtn addTarget:self action:@selector(fanHuiItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
        testView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:nil options:nil] lastObject];
    
    self.navigationItem.titleView = testView;

    UIButton *btn1 = (UIButton *)[testView viewWithTag:200];
    UIButton *btn2 = (UIButton *)[testView viewWithTag:201];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    _slideView = (UIView *)[testView viewWithTag:202];
    
    
    if (self.titleArr) {
        [btn1 setTitle:self.titleArr[0] forState:UIControlStateNormal];
        [btn2 setTitle:self.titleArr[1] forState:UIControlStateNormal];
    }
    
}

- (void)btnAction:(UIButton *)btn
{
    [_scrollView setContentOffset:CGPointMake((btn.tag - 200) * kScreenWidth, 0) animated:YES];
    
}


#pragma mark 构造UIScrollView
- (void)_initScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, _scrollView.height);
    
    
#pragma 进来的时候的定位
    if ([self.btnTag isEqualToString:@"901"]) {
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:nil];
    }

    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    
    UIButton *btn1 = (UIButton *)[testView viewWithTag:200];
    UIButton *btn2 = (UIButton *)[testView viewWithTag:201];

    CGFloat x = (scrollView.contentOffset.x / kScreenWidth) * (btn2.left - btn1.left);
    
    _slideView.right = btn1.right + x;
    

    
    
    
}




#pragma mark 构造UITableView
- (void)_initTabelView
{
    for (int i = 0; i < 2; i ++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, _scrollView.height)];
        tableView.delegate = self;
        tableView.dataSource = self;

        tableView.separatorStyle = NO;
        tableView.tag = 300 + i;
        [_scrollView addSubview:tableView];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag ==300) {
        return _hotData.count;
    }else if (tableView.tag == 301){
        return _newData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idertifre = @"dddd";
    BtnTabCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifre];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnTabCell" owner:nil options:nil] lastObject];
    }
    
    if (tableView.tag == 300) {
        cell.model = _hotData[indexPath.row];
    }else{
        cell.model = _newData[indexPath.row];

    }
    
    return cell;
}

#pragma mark 单元格被点击时触发的时间
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
    if (_scrollView.contentOffset.x == kScreenWidth) {
        //新品
        HotModel *model = _newData[indexPath.row];
        

        detailVC.dishes_id = model.dishID;

        
    }else{
        //热门
        HotModel *model = _hotData[indexPath.row];
        detailVC.dishes_id = model.dishID;
    }
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    UITableView *tableView1 = (UITableView *)[_scrollView viewWithTag:300];
    
    [tableView1 reloadData];
    UITableView *tableView2 = (UITableView *)[_scrollView viewWithTag:301];
    
    [tableView2 reloadData];

}







#pragma mark 加载热门数据
- (void)loadHotData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"HomeMore" forKey:@"methodName"];
    [params setObject:@1 forKey:@"type"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        _hotData = mArr;
//        [self _initHotView];
        UITableView *tableView = (UITableView *)[_scrollView viewWithTag:300];
        [tableView reloadData];
        
    }];
    
    
}



#pragma mark 加载新品数据
- (void)loadNewData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"HomeMore" forKey:@"methodName"];
    [params setObject:@2 forKey:@"type"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        _newData = mArr;
//        [self _initNewView];
        UITableView *tableView = (UITableView *)[_scrollView viewWithTag:301];
        [_scrollView reloadInputViews];
        [tableView reloadData];

        
    }];
    
}

- (void)fanHuiItemAction:(UIBarButtonItem *)item
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
