//
//  MeiShiCell.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeiShiModel.h"
@interface MeiShiCell : UITableViewCell

{
    
    IBOutlet UIImageView *_imgView;
    
    IBOutlet UILabel *_label1;

    
    IBOutlet UILabel *_label2;
}


@property (nonatomic,strong) MeiShiModel *model;

@end
