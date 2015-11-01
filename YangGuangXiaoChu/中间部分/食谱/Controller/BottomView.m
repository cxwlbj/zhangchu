//
//  BottomView.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BottomView.h"
#import "DengLuViewController.h"
#import "UMSocialControllerServiceComment.h"
@implementation BottomView



- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initViews];
}

- (void)_initViews{
     [_shouCangBtn setImage:[UIImage imageNamed:@"收藏_p.png"] forState:UIControlStateHighlighted];
     [_shouCangBtn setImage:[UIImage imageNamed:@"收藏_p.png"] forState:UIControlStateSelected];
    
    [_shareBtn setImage:[UIImage imageNamed:@"分享 _p.png"] forState:UIControlStateHighlighted];
    [_pingLunBtn setImage:[UIImage imageNamed:@"评论_p.png"] forState:UIControlStateHighlighted];
    
    
    
}




- (void)setModel:(BottomModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];

}

}
- (void)layoutSubviews{
    [super layoutSubviews];
    _shouCangLabel.text = _model.agreement_amount;
    
    _pingLunLabel.text = _model.comment_count;
    
    
    if ([_model.like isEqual:@"1"]) {
        _shouCangBtn.selected = YES;
    }else{
        _shouCangBtn.selected = NO;

    }
  
    
    
}
- (IBAction)btnAction:(UIButton *)sender {

    
    if (![UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouCangDengLu" object:nil];
        
        return;
    }
    
    switch (sender.tag) {
        case 720:
        {
            //收藏
            [self shouCang];
        }
            break;
        case 721:
        {
            //分享
            [self fengXiang];
        }
            break;
        case 722:
        {
            //评论
            [self pingLun];
        }
            break;
        default:
            break;
    }
    

    
}
#pragma mark  收藏,分享，评论事件
- (void)fengXiang{
    
[[NSNotificationCenter defaultCenter] postNotificationName:@"comment" object:@2];
}
- (void)pingLun{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"comment" object:@1];

}



- (void)shouCang{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    

    
    if ([_model.like isEqual:@"1"]) {
        //取消收藏
        NSString *str = [NSString stringWithFormat:@"%d",0];
        [params setObject:str forKey:@"type"];
    }else{
        //收藏
        NSString *str = [NSString stringWithFormat:@"%d",1];
        [params setObject:str forKey:@"type"];
    }
    
    
    
    [params setObject:@"UserUpdatelikes" forKey:@"methodName"];
    [params setObject:_model.dashes_id forKey:@"ids"];
    
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"like" object:nil];
        
        
    }];
    
    
    
    
}



@end
