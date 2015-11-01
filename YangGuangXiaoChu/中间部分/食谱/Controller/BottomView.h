//
//  BottomView.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomModel.h"
@interface BottomView : UIView

{
    
    IBOutlet UIButton *_shouCangBtn;
    IBOutlet UILabel *_shouCangLabel;
    
    
    IBOutlet UIButton *_shareBtn;
    
    IBOutlet UIButton *_pingLunBtn;
    

    IBOutlet UILabel *_pingLunLabel;
    
}

@property (nonatomic,strong) BottomModel *model;
@end
