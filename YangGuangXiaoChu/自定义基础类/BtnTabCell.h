//
//  BtnTabCell.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnTabCell : UITableViewCell

{
    IBOutlet UIImageView *_imgView;
    
    IBOutlet UILabel *_label1;
    
    IBOutlet UILabel *_label2;
    
    
}
@property (nonatomic,strong) HotModel *model;
@end
