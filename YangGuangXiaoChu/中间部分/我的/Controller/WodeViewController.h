//
//  WodeViewController.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WodeViewController : UIViewController
{
    //主
    IBOutlet UIScrollView *_mainScrollView;
    //副
    IBOutlet UIScrollView *_secondScrollView;
    
    IBOutlet UIImageView *_backImgView;
    
    IBOutlet UIButton *_leftBtn;//左边收藏
    
    IBOutlet UIButton *_rightBtn;//右边下载
    

    IBOutlet UIButton *_touxiangBtn;
    
    IBOutlet UIButton *_loginBtn;
}
@end
