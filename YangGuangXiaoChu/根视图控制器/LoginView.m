//
//  LoginView.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LoginView.h"
#import "DengLuViewController.h"
@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initViews];
}

- (void)_initViews{
    
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    if (snsAccount) {
        //已经登录
        _btnView.hidden = YES;
        _loginLabel.hidden = YES;
        
    }
    
}

- (void)setImage:(UIImage *)image{
    if (_image !=image) {
        _image = image;
        _imgView.image = image;
    }
}
- (IBAction)btnAction:(UIButton *)sender {

        
        switch (sender.tag) {
        case 300:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaoGuo" object:nil];
            
        }
            break;
        case 301:
        case 302:
        case 303:

        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fengMianDengLu" object:nil];
            
            
            
            
            
        }
            break;
        default:
            break;
    }
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
