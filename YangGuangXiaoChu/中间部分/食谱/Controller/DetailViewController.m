//
//  DetailViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailHeaderView.h"
#import "BottomView.h"
#import "BottomModel.h"
#include "DengLuViewController.h"
@interface DetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    NSDictionary *_data;
    DetailHeaderView *headerView;
    UIView *sliderView;
    UIView *heheView;
    UIScrollView *litterScrView;
    BottomView *bottomView;
    
    
    
    UIView *backView;
    UIView *shareView;
}
@end

@implementation DetailViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shouCangDengLu" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"like" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"comment" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"like" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"shouCangDengLu" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareAndComment:) name:@"comment" object:nil];
    
    

    
    [self _initNavBar];
    [self loadData];
    [self _initHeaderView];
    [self _initScrollView];
    [self _initLitterScrollView];
    [self _initTabelView];
    
}

- (void)login{
    
    DengLuViewController *dengLuVC =[[DengLuViewController alloc] init];
    [self.navigationController pushViewController:dengLuVC animated:YES];
}

- (void)shareAndComment:(NSNotification *)noti{
    if ([noti.object  isEqual: @1]) {
        //评论
        UINavigationController *commentList = [[UMSocialControllerServiceComment defaultControllerService] getSocialCommentListController];
        
        [self presentViewController:commentList animated:YES completion:nil];
        
    }else{
        //分享
        backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor darkGrayColor];
        backView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackView)];
        [backView addGestureRecognizer:tap];
        
        [self.view addSubview:backView];
        
        
        shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 120)];
        shareView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:shareView];
        
        [UIView animateWithDuration:0.3 animations:^{
            shareView.bottom = kScreenHeight;
        }];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
        [btn setImage:[UIImage imageNamed:@"icon_sina"] forState:UIControlStateNormal];

        [btn setTitle:@"新浪微博" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(70, -50, 0, 0);
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [shareView addSubview:btn];
        
        [btn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *canceBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 2, 80, 100, 30)];
        [shareView addSubview:canceBtn];
        [canceBtn addTarget:self action:@selector(hiddenBackView) forControlEvents:UIControlEventTouchUpInside];
        [canceBtn setTitle:@"取消分享" forState:UIControlStateNormal];
        [canceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        canceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }

    
    
    
}
- (void)hiddenBackView{
    [backView removeFromSuperview];
    [shareView removeFromSuperview];
}



- (void)shareBtnAction:(UIButton *)btn{
    
    [self hiddenBackView];
    
    BottomModel *model = [[BottomModel alloc] initContentWithDic:_data];
    NSString *shareStr = [NSString stringWithFormat:@"超好吃！我用掌厨学会了%@的做法，1000万厨娘都在用，人人都可以做美食哦！%@",model.dashes_name, model.share_url];
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:model.image];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:shareStr image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");

            [self showLabel:btn];
        }
    }];
    
    
}



- (void)showLabel:(UIButton *)btn{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2, kScreenHeight, 200, 40)];
    label.text = @"分享成功";
    label.backgroundColor = [UIColor darkGrayColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    //为其添加特殊阴影
    label.layer.shadowOffset =  CGSizeMake(0, 12);
    label.layer.shadowOpacity = 1;
    label.layer.shadowRadius = 8;
    label.layer.shadowColor =  [UIColor blackColor].CGColor;
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.userInteractionEnabled = NO;
        label.top = kScreenHeight - 120;
        
    } completion:^(BOOL finished) {
        sleep(1);
        [label removeFromSuperview];
        btn.userInteractionEnabled = YES;
    }];
    
    
}




#pragma mark 构造tableView
- (void)_initTabelView{
    for (int i = 0; i < 4;  i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth  * i, 0, kScreenWidth, kScreenHeight - 104 - 40)];
        tableView.showsVerticalScrollIndicator =NO;
        tableView.bounces = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        [litterScrView addSubview:tableView];
        tableView.tag = 600 + i;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    return cell;
}

#pragma mark构造滑动视图

- (void)_initLitterScrollView{
    
    litterScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 464, kScreenWidth, kScreenHeight - 104)];
    litterScrView.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:litterScrView];
    litterScrView.showsVerticalScrollIndicator = NO;
    
    litterScrView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight - 104);
    litterScrView.bounces = NO;
    
    litterScrView.pagingEnabled = YES;
    litterScrView.delegate = self;
    litterScrView.tag = 300;
    for (int i = 0; i < 4; i ++) {
        UIView *test = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 100, 100, 100)];
        test.backgroundColor = [UIColor redColor];
        [litterScrView addSubview:test];
    }
    
}



- (void)_initScrollView{

    _scrollView.contentSize = CGSizeMake(kScreenWidth,  424 + kScreenHeight - 64);
    _scrollView.bounces = NO;
    
    sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 424, kScreenWidth, 40)];
    sliderView.backgroundColor = [UIColor whiteColor];
    
    [_scrollView addSubview:sliderView];
    
    NSArray *arr = @[@"做法",@"食材",@"相关知识",@"相宜相克"];
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 4 * i, 0, kScreenWidth / 4, 40)];
            [sliderView addSubview:btn];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            btn.tag = 500 + i;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    
    heheView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth / 4, 5)];
    heheView.backgroundColor = [UIColor orangeColor];
    [sliderView addSubview:heheView];
    
    
        

}


#pragma mark 按钮触发事件
- (void)btnAction:(UIButton *)btn{

    heheView.left = (btn.tag - 500) * kScreenWidth / 4;
    [litterScrView setContentOffset:CGPointMake((btn.tag - 500) * kScreenWidth, 0) animated:YES];
}

#pragma mark 滑动视图代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    
    if ([scrollView isKindOfClass:[UITableView class] ]) {

        if (y == 0) {
            scrollView.scrollEnabled = NO;
        }
    }
    
    
    
    //小滑动视图
    if (scrollView.tag == 300) {
        
        if ([scrollView isKindOfClass:[UITableView class]]) {
            return;
        }
        CGFloat x = scrollView.contentOffset.x / kScreenWidth;

        
        heheView.left = x * kScreenWidth /4;
    }
    
    //大滑动视图
    if (scrollView.tag == 400) {

        
        if (y < 424 - 64) {
            self.navigationController.navigationBarHidden = YES;
            for (int i = 0; i < 4; i++) {
                UITableView *tableView = (UITableView *)[litterScrView viewWithTag:600 + i ];
                
                tableView.scrollEnabled = NO;
            }

        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.navigationController.navigationBarHidden = NO;
            }];
            
            
            for (int i = 0; i < 4; i++) {
                UITableView *tableView = (UITableView *)[litterScrView viewWithTag:600 + i ];
                
                tableView.scrollEnabled = YES;
            }

        }

    }
}

#pragma  mark 加载数据
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"DishesView" forKey:@"methodName"];
    [params setObject:self.dishes_id forKey:@"dishes_id"];
    [params setObject:@"4.01" forKey:@"version"];
 
    
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        _data = [data objectForKey:@"data"];
        
        [_tableView reloadData];
        headerView.headerData = _data;
        self.title = [_data objectForKey:@"dashes_name"];

        BottomModel *model = [[BottomModel alloc] initContentWithDic:_data];

        
        bottomView.model = model;
        
    }];

    
}


#pragma mark 构造头部视图
- (void)_initHeaderView{

    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:nil options:nil] lastObject];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:headerView];

    
    bottomView = [[[NSBundle mainBundle] loadNibNamed:@"bottomView" owner:nil options:nil] lastObject];
    bottomView.bottom = kScreenHeight;
    bottomView.width = kScreenWidth;

    [self.view addSubview:bottomView];
    
    
    
    
}





#pragma mark 自定义导航栏
- (void)_initNavBar {
    
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
    [leftBtn addTarget:self action:@selector(fanHuiItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

}


- (void)fanHuiItemAction:(UIBarButtonItem *)item
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
