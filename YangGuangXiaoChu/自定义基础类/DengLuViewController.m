//
//  DengLuViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DengLuViewController.h"

@interface DengLuViewController ()

@end

@implementation DengLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackgroundImage.png"]];
    [_selectedBtn setImage:[UIImage imageNamed:@"termSelected.png"] forState:UIControlStateSelected];
    [_selectedBtn setImage:[UIImage imageNamed:@"termUnselected.png"] forState:UIControlStateNormal];
    _selectedBtn.selected = YES;
    [_textView becomeFirstResponder];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(UIButton *)sender {

    switch (sender.tag) {
        case 200:
        {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 201:
        {
            //确定按钮
            if (_selectedBtn.selected == NO) {
                
                [self showLabel:sender];
                return;
            }
            
        }
            break;
            
        case 202:
        case 203:
        {
            _selectedBtn.selected = !_selectedBtn.selected;
        }
            break;
        case 204:
        {

            
            UIViewController *VC = [[UIViewController alloc] init];
            
            VC.title = @"服务协议";
            VC.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:VC animated:YES];
            self.navigationController.navigationBarHidden = NO;
        }
            break;
        case 205:
        {
            //微信
            if (_selectedBtn.selected == NO) {
                
                [self showLabel:sender];
                return;
            }
            
            
        }
            break;
        case 206:
        {
            //qq
            if (_selectedBtn.selected == NO) {
                
                [self showLabel:sender];
                return;
            }
        }
            break;
        case 207:
        {
            //新浪
            if (_selectedBtn.selected == NO) {
                
                [self showLabel:sender];
                return;
            }
            [self sinaLogin];
        }
            break;
        default:
            break;
    }
    
    
    
}

- (void)showLabel:(UIButton *)btn{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2, kScreenHeight, 200, 40)];
    label.text = @"请先阅读并同意服务协议";
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


- (void)sinaLogin{
    
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        NSLog(@"已经登录");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showCell" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
