//
//  RootMMDrawerController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RootMMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LoginView.h"
@interface RootMMDrawerController ()<UMSocialUIDelegate,NSURLConnectionDataDelegate>
{
    NSString *filePath;//文件存储最终路径
    LoginView *loginView;
    
    //分享有关视图
    UIView *backView;
    UIView *shareView;

    
    //首次登录提示视图
    UIView *firstView;
    int count;
    UIImageView *firstImgView;
}
@end

@implementation RootMMDrawerController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"share" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tiaoGuo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fengMianDengLu" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareToFriend) name:@"share" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoginView) name:@"tiaoGuo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fengMianDengLu) name:@"fengMianDengLu" object:nil];
    
    //从story中拿到三个视图
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //中间视图
    self.centerViewController = [storyBoard instantiateViewControllerWithIdentifier:@"centerVC"];
    //右侧视图
    self.rightDrawerViewController = [storyBoard instantiateViewControllerWithIdentifier:@"rightVC"];
    
    //设置阴影
    self.showsShadow = YES;

    
    //设置右边视图的宽的
    self.maximumRightDrawerWidth = 290.0;
    
    //为其配置动画
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
        
        
    }];
    
    //配置动画类型
    /*
     NS_ENUM(NSInteger, MMDrawerAnimationType){
     MMDrawerAnimationTypeNone,
     MMDrawerAnimationTypeSlide,
     MMDrawerAnimationTypeSlideAndScale,
     MMDrawerAnimationTypeSwingingDoor,
     MMDrawerAnimationTypeParallax,
     
     */
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    
    
    
    //判断文件是否存在，如果不存在，再创建
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",NSHomeDirectory());
    
    
    filePath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/%@",[userDefaults objectForKey:@"fileName"]];

    [self qiDongLogo:nil];
    [self loadData];

}

- (void)fengMianDengLu{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        NSLog(@"已经登录");
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showCell" object:nil];
        
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});

    
    
    
}
- (void)saveLoginPicWith:(NSString *)urlStr{
    
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    //文件名
   NSString *fileName = [url.absoluteString lastPathComponent];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:fileName forKey:@"fileName"];
    [userDefaults synchronize];
    
    
    filePath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/%@",[userDefaults objectForKey:@"fileName"]];
    
    //构建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //发送请求
   [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
   //存储数据
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //创建文件
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];

    }
    
    
}

- (void)loadData{
    {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"HomeBanner" forKey:@"methodName"];
        
        [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
            
            
            
            NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
            
            
            
            NSURL *url = [NSURL URLWithString:arr[0]];
            //文件名
            NSString *_fileName = [url.absoluteString lastPathComponent];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString *fileName = [userDefaults objectForKey:@"fileName"];
            
            if (![fileName isEqualToString:_fileName]) {
                [self saveLoginPicWith:arr[0]];
            }

        }];
        
        
    }
}



- (void)qiDongLogo:(NSString *)pic{
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    UIImage *image = [UIImage imageWithData:[fileHandle readDataToEndOfFile]];
    if (image) {
        
        
        loginView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil] lastObject];
        loginView.frame = self.view.bounds;
        loginView.image = image;
        [self.view addSubview:loginView];
        
        [self performSelector:@selector(removeLoginView) withObject:nil afterDelay:3];
        
    }
    
    
    if (count == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"%@",[userDefaults objectForKey:@"first"]);
        
        if ([userDefaults objectForKey:@"first"] == nil) {
            //首次运行
            [self fistOpenApp];
            
        }
        
    }

    
}

- (void)removeLoginView{
    [loginView removeFromSuperview];
    
    
}
#pragma mark 分享给好友
- (void)shareToFriend{

    {
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
    
    
    NSString *str = @"http://a.app.qq.com/o/simple.jsp?pkgname=com.gold.palm.kitchen";
    NSString *shareStr = [NSString stringWithFormat:@"1000万厨娘都在用，人人都可以做美食哦！%@",str];

    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:shareStr image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showCell" object:nil];
            
            [self showLabel:nil];
            [self hiddenBackView];
            
            
            
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


#pragma mark 首次登录的应用提示信息
- (void)fistOpenApp{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"opened" forKey:@"first"];
    [userDefaults synchronize];
    
    
    firstView = [[UIView alloc] initWithFrame:self.view.bounds];
    firstView.backgroundColor = [UIColor darkGrayColor];
    firstView.alpha = 0.3;
    [self.view addSubview:firstView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [firstView addGestureRecognizer:tap];
    
    
    firstImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"firstStart_classify.png"]];

    firstImgView.frame = CGRectMake(kScreenWidth - 230, 250, 230, 250);
    [self.view addSubview:firstImgView];
    count = 1;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    switch (count) {
        case 1:
        {
            //首次点击

            firstImgView.image = [UIImage imageNamed:@"firstStart_foodClass.png"];
            
            firstImgView.frame = CGRectMake(kScreenWidth / 6, kScreenHeight - 250, 230, 250);
            
        }
            break;
        case 2:
        {
            //二次点击

            firstImgView.image = [UIImage imageNamed:@"firstStart_MyLove.png"];
            firstImgView.frame = CGRectMake(kScreenWidth / 4, kScreenHeight - 250, 230, 250);
        }
            break;
        case 3:
        {
            //三次点击
            [firstImgView removeFromSuperview];
            [firstView removeFromSuperview];
            
        }
            break;

        default:
            break;
    }
    
    
    count++;
}




@end

