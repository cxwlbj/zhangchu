//
//  RightTableViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RightTableViewController.h"
#import "XWAlterview.h"
@interface RightTableViewController ()

@end

@implementation RightTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showCell" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.bounces = NO;
    
    _loginCell.hidden = NO;
    _loginCell.textLabel.text = @"退出登录";
    _loginCell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenCell) name:@"showCell" object:nil];
    
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    if (snsAccount == nil) {
        //未登录
        _loginCell.hidden = YES;
    }else{
        //已经登录
        _loginCell.hidden = NO;
    }

}



- (void)jiSuanHuanCun{
    
    
    NSInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cacheSize = size / pow(1024, 2);
    
    _hunCunLabel.text = [NSString stringWithFormat:@"%.1fM",cacheSize];

}

#pragma mark 清除缓存
- (void)clearCache{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self jiSuanHuanCun];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
          //推送开关
            _switch.on = !_switch.on;
            
        }
            break;
        case 1:
        {
            //分享给好友
            [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:nil];
            
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                //关于我们
            }else{
                //给我打分
            }
            
            
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                //意见反馈
            }else if (indexPath.row == 1){
                //清除缓存
                [self clearHuanCun];
            }else{
                //版本更新
            }
            
        }
            break;
        case 4:
        {
            //退出登录
            
            
            XWAlterview *xwAlert = [[XWAlterview alloc] initWithTitle:@"确定退出？" contentText:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [xwAlert show];
            
            xwAlert.leftBlock = ^(){
            };
            xwAlert.rightBlock = ^(){

                
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                    
                    NSLog(@"退出登录");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenRight" object:nil];
                    
                    _loginCell.hidden = YES;
                }];

            };

            
            
            
            

            
        }
      default:
            break;
    }
    
    [_tableView reloadData];
}


- (void)hiddenCell{
    _loginCell.hidden = NO;
}

#pragma mark 清除缓存触动方法
- (void)clearHuanCun{
    
    XWAlterview *xwAlert = [[XWAlterview alloc] initWithTitle:@"确定清除缓存？" contentText:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [xwAlert show];
    
    xwAlert.leftBlock = ^(){
        NSLog(@"点击了左边的按钮");
    };
    xwAlert.rightBlock = ^(){
        [self clearCache];
        
    };

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self jiSuanHuanCun];

}






- (IBAction)switchAction:(id)sender {
    NSLog(@"开关打开");
}

@end
