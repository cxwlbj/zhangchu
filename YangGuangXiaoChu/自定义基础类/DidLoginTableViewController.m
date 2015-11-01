//
//  DidLoginTableViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DidLoginTableViewController.h"

@interface DidLoginTableViewController ()

@end

@implementation DidLoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initLayOut];
}

- (void)_initLayOut{
    _touXiangBtn.right = kScreenWidth - 30;
    _biaoQianLabel.right = _nameBtn.right;_yearLabel.right = _touXiangBtn.right;
    _rightBtn.right = _touXiangBtn.right;
    _leftBtn.right = _rightBtn.left - 10;
    
    
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    [_touXiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:snsAccount.iconURL] forState:UIControlStateNormal];
    [_nameBtn setTitle:snsAccount.userName forState:UIControlStateNormal];
    
}

@end
