//
//  LoginView.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

{
    IBOutlet UIView *_btnView;

    
    IBOutlet UILabel *_loginLabel;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) UIImage *image;
@end
