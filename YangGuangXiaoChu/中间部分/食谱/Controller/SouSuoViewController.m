//
//  SouSuoViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SouSuoViewController.h"

@interface SouSuoViewController ()

@end

@implementation SouSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_textView becomeFirstResponder];
    
}
- (IBAction)cacleBtnAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:self completion:nil];
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
