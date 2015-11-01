//
//  WebBaseViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WebBaseViewController.h"

@interface WebBaseViewController ()<UIWebViewDelegate>
{

    UIWebView *baseWebView;
}
@end

@implementation WebBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNavBar];
    
}
#pragma mark 自定义webView
- (void)initWebView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    baseWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 49)];
    //网页自适应
    baseWebView.delegate = self;
    baseWebView.scalesPageToFit = YES;
    baseWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:baseWebView];
    
    
    NSURL *url = [NSURL URLWithString:_httpStr];
    //创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    
    [baseWebView loadRequest:request];//加载
}


#pragma mark  自定义导航栏
- (void)initNavBar{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 60)];
    [leftBtn addTarget:self action:@selector(fanHuiItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)setHttpStr:(NSString *)httpStr{
    if (_httpStr != httpStr) {
        _httpStr = httpStr;
        [self initWebView];
    }
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
