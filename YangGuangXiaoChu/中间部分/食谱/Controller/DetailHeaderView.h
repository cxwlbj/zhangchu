//
//  DetailHeaderView.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderView : UIView

{
    
    IBOutlet UIView *zhe2VIew;
    
    IBOutlet UIView *zheZhaoView;
    IBOutlet UIButton *_playBtn;
    
    IBOutlet UILabel *_titleLabel;
    
    IBOutlet UILabel *_detailLabel;
    
    
    IBOutlet UILabel *_hardLabel;
    
    
    IBOutlet UILabel *_buzhouLabel;
    
    
    
    IBOutlet UILabel *_downloadLabel;
    
    IBOutlet UIImageView *_imgView;
    
}
@property (nonatomic,strong) NSDictionary *headerData;

@end
