//
//  MainNavigationController.m
//  YangGuangXiaoChu
//
//  Created by keyzhang on 15/11/1.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBarTintColor:[UIColor orangeColor]];
    //自定义导航栏字体
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.delegate = self;
}


//push隐藏标签栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger count = self.viewControllers.count;
    
    UIImageView *imgView = (UIImageView *)[self.tabBarController.view viewWithTag:1234];
    
    if (count == 1) {
        
        imgView.hidden = NO;
        
    }else if(count == 2){
        imgView.hidden = YES;
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
