//
//  ShiPuHeaderView.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUScrollAndPageView.h"
@interface ShiPuHeaderView : UIView<HUcrollViewViewDelegate>
{
    
    
    
    IBOutlet UIView *_btnView;
    
    
    IBOutlet UIView *_hotView;
    
    
    IBOutlet UIView *_newView;
    
    
    IBOutlet UIView *_meiShiView;
    
    
    
    IBOutlet UIView *_paiHangView;
}
@property (nonatomic,strong) NSDictionary *data;
@end
