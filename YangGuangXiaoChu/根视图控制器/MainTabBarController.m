//
//  MainTabBarController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainTabBarController.h"
@interface MainTabBarController ()
{
    UIButton *_lastBtn;//上一个按钮
    UILabel *_lastLabel;//上一个label
    UIImageView *tarBarImgView;
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"coll" object:nil];
    [self _initTarbarItem];
    
}

- (void)test{
    tarBarImgView.hidden = NO;
}

#pragma mark 自定义标签栏
- (void)_initTarbarItem{
    //隐藏系统标签栏
    self.tabBar.hidden = YES;
    //自定义标签栏
    tarBarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    tarBarImgView.backgroundColor = [UIColor whiteColor];
    tarBarImgView.userInteractionEnabled = YES;
    [self.view addSubview:tarBarImgView];
    
    tarBarImgView.tag = 1234;
    UIImageView *tarImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    tarImgView.backgroundColor = [UIColor lightGrayColor];
    [tarBarImgView addSubview:tarImgView];
    
    
    //构造底部按钮
    NSArray *norArray = @[@"食谱A.png",@"喜欢A.png",@"食课A.png",@"我的A.png"];
    NSArray *selArray = @[@"食谱B.png",@"喜欢B.png",@"食课B.png",@"我的B.png"];
    NSArray *textName = @[@"食谱",@"喜欢",@"食课",@"我的"];

    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0 + i * kScreenWidth / 4, 0, kScreenWidth / 4, 49)];
        NSString *norStr = norArray[i];
        UIImage *norImage = [UIImage imageNamed:norStr];
        NSString *selStr = selArray[i];
        UIImage *selImage = [UIImage imageNamed:selStr];
        
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setImage:selImage forState:UIControlStateSelected];
        
        [btn setImage:norImage forState:UIControlStateNormal];
        
        [tarBarImgView addSubview:btn];
        
        //按钮下面的标题
        
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth / 4, 19)];

        label.textAlignment = NSTextAlignmentCenter;
        label.text = textName[i];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        [btn addSubview:label];
        label.tag = 300 + i;
        
        if (i == 0) {
            btn.selected = YES;
            _lastBtn = btn;
            _lastLabel = label;
            label.textColor = [UIColor orangeColor];

        }
        
    }

}


- (void)btnAction:(UIButton *)btn
{
    //拿到对应的label
    UILabel *label = (UILabel *)[btn viewWithTag:btn.tag + 100];
    
    self.selectedIndex = btn.tag - 200;
    
    if (btn.selected == YES) {
        //点击的时同一个按钮
        btn.selected = YES;
        label.textColor = [UIColor orangeColor];

    }else{
        //点击别的按钮
        btn.selected = !btn.selected;
        label.textColor = [UIColor orangeColor];
        

            _lastBtn.selected = NO;
            _lastLabel.textColor = [UIColor darkGrayColor];
 
    }
    
    
    _lastBtn = btn;
    _lastLabel = label;
    
}



@end
