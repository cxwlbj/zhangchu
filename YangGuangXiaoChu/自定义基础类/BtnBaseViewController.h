//
//  BtnBaseViewController.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnBaseViewController : UIViewController<UITableViewDelegate ,UITableViewDataSource>

{
    
    IBOutlet UITableView *_tableView;
}

@property (nonatomic,copy) NSString *navTitle;

@property (nonatomic,copy) NSArray *data;

@property (nonatomic,copy) NSString *btn_id;
@property (nonatomic ,copy) NSString *params;//参数
@property (nonatomic,copy) NSString *cat_id;

@end
