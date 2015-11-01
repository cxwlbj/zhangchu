//
//  DetailViewController.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic,copy) NSString *dishes_id;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@end
