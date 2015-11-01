//
//  WodeViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WodeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "DengLuViewController.h"
#import "DidLoginTableViewController.h"
#import "BtnTabCell.h"
@interface WodeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_slideView;
    NSInteger *_currentPage;//当前选中的页数
    UILabel *label;
    NSArray *_data;

}
@end

@implementation WodeViewController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginOut" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hiddenRight" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrshUI) name:@"loginOut" object:nil];
    
    //启动页登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginBtnAction:) name:@"qidong" object:nil];
    
    [self _initScrollView];
    [self _initBackImgView];

    [self _initNavBar];

    
    [self refrshUI];
    
    [self _initTabelView];
    
    [self loadData];

}

#pragma mark 加载数据

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"UserCollection" forKey:@"methodName"];

    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *mArr = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            
            HotModel *model = [[HotModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        _data = mArr;
        
        
        UITableView *tableView = (UITableView *)[_secondScrollView viewWithTag:600];
        [tableView reloadData];
        
    }];
    
    
}


#pragma mark 初始化背景imgView的UI控件
- (void)_initBackImgView{
    
    label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 2, _loginBtn.top, 100, 30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_backImgView addSubview:label];
    label.hidden = YES;
    
    _touxiangBtn.clipsToBounds = YES;
    _touxiangBtn.layer.cornerRadius = 40;
    _touxiangBtn.frame = CGRectMake((kScreenWidth - 80) / 2, 30, 80, 80);

    //处理左右按钮
    _leftBtn.bottom = _rightBtn.bottom = _backImgView .bottom;
    
    
    //构造sliderView
    _slideView = [[UIView alloc] initWithFrame:CGRectMake(_leftBtn.left, _backImgView.bottom - 3, _leftBtn.width, 3)];
    _slideView.backgroundColor = [UIColor redColor];
    [_backImgView addSubview:_slideView];

}


#pragma mark 刷新UI
- (void)refrshUI{
    
    [self loadData];
    
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    
    if (snsAccount != nil) {
        //已经微博登陆
        [_touxiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:snsAccount.iconURL] forState:UIControlStateNormal];
        
        [_loginBtn setTitle:snsAccount.userName forState:UIControlStateNormal];
        
        label.text = snsAccount.userName;
        label.hidden = NO;
        _loginBtn.hidden = YES;
        
    }else{
        label.hidden = YES;
        _loginBtn.hidden = NO;
        [_loginBtn setTitle:@"登陆下，让掌厨更懂你" forState:UIControlStateNormal];
        [_touxiangBtn setBackgroundImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
    }
    

}


#pragma mark 初始化导航栏右边的按钮
- (void)_initNavBar{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];

    
    [rightBtn addTarget:self action:@selector(settingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn setImage:[UIImage imageNamed:@"configure.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = rightItem;

}
#pragma mark 右边设置按钮触发事件
- (void)settingBtnAction:(UIButton *)btn{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}



#pragma mark 构造滑动视图
- (void)_initScrollView
{
    
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _mainScrollView.backgroundColor = [UIColor redColor];
    _mainScrollView.delegate = self;
    _secondScrollView.frame = CGRectMake(0, _backImgView.bottom, kScreenWidth, _mainScrollView.height - _backImgView.height);
    _secondScrollView.contentSize = CGSizeMake(kScreenWidth * 2,_secondScrollView.height);
    _secondScrollView.top = _backImgView.bottom;
    _secondScrollView.delegate = self;
    
    _secondScrollView.backgroundColor = [UIColor redColor];
    

    
}
#pragma mark //构造tableView

- (void)_initTabelView{
   
    for (int i = 0; i < 2; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, _secondScrollView.height)];
        [_secondScrollView addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.tag = 600 + i;
        tableView.separatorStyle = NO;
        
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        footerLabel.text = @"没有更多了";
        footerLabel.textAlignment = NSTextAlignmentCenter;
        footerLabel.font = [UIFont systemFontOfSize:14];
        footerLabel.textColor = [UIColor darkGrayColor];
        
        tableView.tableFooterView = footerLabel;
        
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 600) {
        return _data.count;

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idertifre = @"dddd";
    BtnTabCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifre];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnTabCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = _data[indexPath.row];
    return cell;
}


#pragma mark 单元格被点击的时候触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 600) {
        //收藏
        UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
        [self.navigationController pushViewController:detailVC animated:YES];
        HotModel *model = _data[indexPath.row];
        
        detailVC.dishes_id = model.dishes_id;
        
        [tableView reloadData];
    }
    
}


#pragma mark 滑动视图触发事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    
    if ([scrollView isKindOfClass:[UITableView class] ]) {

        if (y == 0) {
            scrollView.scrollEnabled = NO;
        }
    }
    
    
    //大
    if (scrollView.tag == 250) {

        if (y < 49) {
            
            for (int i = 0; i < 2; i++) {
                UITableView *tableView = (UITableView *)[_secondScrollView viewWithTag:600 + i ];
                
                tableView.scrollEnabled = NO;
            }
            
            
        }else{
            for (int i = 0; i < 2; i++) {
                UITableView *tableView = (UITableView *)[_secondScrollView viewWithTag:600 + i ];
                
                tableView.scrollEnabled = YES;
            }

        }
        
        //小
    }else if(scrollView.tag == 251){

        CGFloat x = (scrollView.contentOffset.x / kScreenWidth) * (_rightBtn.left - _leftBtn.left);
        
        _slideView.right = _leftBtn.right + x;

    }

    
    
    
}


- (IBAction)btnAction:(UIButton *)sender
{
    
    _slideView.left = sender.left;
    
    [_secondScrollView setContentOffset:CGPointMake((sender.tag - 700) * kScreenWidth, 0) animated:YES];
    
    
}








- (void)viewWillAppear:(BOOL)animated{
    //设置滑动的区域
    self.mm_drawerController. openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.navigationController.navigationBarHidden = NO;
    
    
    UITableView *tableView = (UITableView *)[_secondScrollView viewWithTag:600];
    
    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if (isOauth) {
        [tableView reloadData];
        [self loadData];

    }
}


- (void)viewDidDisappear:(BOOL)animated{
    //设置滑动的区域
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}
#pragma mark 头像登录按钮点击事件
- (IBAction)loginBtnAction:(id)sender {

    
    if (![UMSocialAccountManager isOauthWithPlatform:UMShareToSina]) {
        //没有登录
        DengLuViewController *deLuVC = [[DengLuViewController alloc] init];
        
        [self.navigationController pushViewController:deLuVC animated:YES];
    }else{
        //已经登录
        UIStoryboard *storyborad = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
        DidLoginTableViewController *didVC = [storyborad instantiateViewControllerWithIdentifier:@"didVC"];
        
        didVC.title =@"个人信息";
        [self.navigationController pushViewController:didVC animated:YES];

    }

}

@end
