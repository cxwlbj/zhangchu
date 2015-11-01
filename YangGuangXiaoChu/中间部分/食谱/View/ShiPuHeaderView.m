//
//  ShiPuHeaderView.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ShiPuHeaderView.h"
#import "HUScrollAndPageView.h"
#import "WebBaseViewController.h"
#import "MoreViewController.h"
#import "More2ViewController.h"
#import "MeiShiBaseViewController.h"

@implementation ShiPuHeaderView
{
    NSDictionary *_data;//首页总数据
    HUScrollAndPageView *_huView;
    NSInteger *count;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (void)setData:(NSDictionary *)data{
    if (_data != data) {
        _data = data;
        
        [self _initGuangGaoView];
        [self _initEightBtn];
        [self _initPaiHangView];
        [self _initHotView];
        [self _initNewView];
        [self _initMeiShiView];
    }
}

#pragma mark 构造广告条
- (void)_initGuangGaoView{

    if (_huView == nil) {
       _huView = [[HUScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        [self addSubview:_huView];
        _huView.backgroundColor = [UIColor whiteColor];
    }
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (int i = 0; i < _data.count; i++) {
        
        
        UIImageView *imgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        
        NSString *str = [[[_data objectForKey:@"banner"] objectForKey:@"data"][i] objectForKey:@"image"];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:str]];

        [mArr addObject:imgView];
    }
    
    _huView.delegate = self;
    _huView.imageViewAry = mArr;
    [_huView shouldAutoShow:YES];

}

#pragma mark 构造首页按钮
- (void)_initEightBtn
{
    
    NSArray *array = [[_data objectForKey:@"category"] objectForKey:@"data"];

    CGFloat btnWidth = kScreenWidth / 4;
    
    if (count == 0) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth * j + (btnWidth - 50) / 2, 80 * i + 10, 50, 50)];
                
                [_btnView addSubview:btn];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btnWidth * j, 80 * i + 60, btnWidth, 25)];
                [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                label.textAlignment = NSTextAlignmentCenter;
                [_btnView addSubview:label];
                
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor darkGrayColor];
                
                if (i == 0) {
                    //第一行
                    NSURL *url = [array[j] objectForKey:@"image"];
                    
                    label.text = [array[j] objectForKey:@"text"];
                    
                    [btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
                    btn.tag = 400 + j;
                }else{
                    //第二行
                    NSURL *url = [array[j + 4] objectForKey:@"image"];
                    
                    
                    label.text = [array[j + 4] objectForKey:@"text"];
                    [btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
                    btn.tag = 400 + j + 4;
                }
                
            }
        }
        count++;
    }
    
    
}
#pragma  mark 热门推荐
- (void)_initHotView
{
    NSDictionary *dic = [_data objectForKey:@"data"][0];
    NSArray *arr = [dic objectForKey:@"data"];
    
    UIImageView *imgView1 = (UIImageView *)[_hotView viewWithTag:250];
    imgView1.clipsToBounds = YES;
    UIImageView *imgView2 = (UIImageView *)[_hotView viewWithTag:253];
    imgView2.clipsToBounds = YES;
    UILabel *label1 = (UILabel *)[_hotView viewWithTag:251];
    UILabel *label2 = (UILabel *)[_hotView viewWithTag:252];
    UILabel *label3 = (UILabel *)[_hotView viewWithTag:254];
    UILabel *label4 = (UILabel *)[_hotView viewWithTag:255];
    
    [imgView1 sd_setImageWithURL:[NSURL URLWithString:[arr[0] objectForKey:@"image"]]];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:[arr[1] objectForKey:@"image"]]];
    label1.text = [arr[0] objectForKey:@"title"];
    label2.text = [arr[0] objectForKey:@"description"];
    label3.text = [arr[1] objectForKey:@"title"];
    label4.text = [arr[0] objectForKey:@"description"];
    
}

- (void)_initNewView{
    NSDictionary *dic = [_data objectForKey:@"data"][1];
    NSArray *arr = [dic objectForKey:@"data"];

    
    
    UILabel *label1 = (UILabel *)[_newView viewWithTag:260];
    UILabel *label2 = (UILabel *)[_newView viewWithTag:261];
    UILabel *label3 = (UILabel *)[_newView viewWithTag:262];
    UILabel *label4 = (UILabel *)[_newView viewWithTag:263];
    UIImageView *imgView1 = (UIImageView *)[_newView viewWithTag:264];
    UIImageView *imgView2 = (UIImageView *)[_newView viewWithTag:265];
    
    [imgView1 sd_setImageWithURL:[NSURL URLWithString:[arr[0] objectForKey:@"image"]]];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:[arr[1] objectForKey:@"image"]]];
    imgView1.clipsToBounds = YES;
    imgView2.clipsToBounds = YES;
    
    label1.text = [arr[0] objectForKey:@"title"];
    label2.text = [arr[0] objectForKey:@"description"];
    label3.text = [arr[1] objectForKey:@"title"];
    label4.text = [arr[0] objectForKey:@"description"];
}

- (void)_initMeiShiView
{
    NSDictionary *dic = [_data objectForKey:@"data"][3];
    NSArray *arr = [dic objectForKey:@"data"];

    
    UILabel *label1 = (UILabel *)[_meiShiView viewWithTag:271];
    UILabel *label2 = (UILabel *)[_meiShiView viewWithTag:272];
    UILabel *label3 = (UILabel *)[_meiShiView viewWithTag:274];
    UILabel *label4 = (UILabel *)[_meiShiView viewWithTag:275];
    UIImageView *imgView1 = (UIImageView *)[_meiShiView viewWithTag:270];
    UIImageView *imgView2 = (UIImageView *)[_meiShiView viewWithTag:273];
    
    
    
    [imgView1 sd_setImageWithURL:[NSURL URLWithString:[arr[0] objectForKey:@"image"]]];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:[arr[1] objectForKey:@"image"]]];
    label1.text = [arr[0] objectForKey:@"title"];
    label2.text = [arr[0] objectForKey:@"description"];
    label3.text = [arr[1] objectForKey:@"title"];
    label4.text = [arr[0] objectForKey:@"description"];
}
#pragma mark 加载排行榜数据


- (void)_initPaiHangView
{
    NSArray *array = [[_data objectForKey:@"data"][2] objectForKey:@"data"];

    UIImageView *imgView1 = (UIImageView *)[_paiHangView viewWithTag:280];
    UILabel *label1_1 = (UILabel *)[_paiHangView viewWithTag:281];
    UILabel *label1_2 = (UILabel *)[_paiHangView viewWithTag:282];
    UILabel *label1_3 = (UILabel *)[_paiHangView viewWithTag:283];
    UILabel *label1_4 = (UILabel *)[_paiHangView viewWithTag:284];
    [imgView1 sd_setImageWithURL:[NSURL URLWithString:[array[0] objectForKey:@"image"]]];
    label1_1.text = [NSString stringWithFormat:@"1 %@",[array[0] objectForKey:@"title"]];
    label1_2.text = [array[0] objectForKey:@"description"];
    label1_3.text = [array[0] objectForKey:@"favorite"];
    label1_4.text = [array[0] objectForKey:@"play"];
    
    UIImageView *imgView2 = (UIImageView *)[_paiHangView viewWithTag:285];
    UILabel *label2_1 = (UILabel *)[_paiHangView viewWithTag:286];
    UILabel *label2_2 = (UILabel *)[_paiHangView viewWithTag:287];
    UILabel *label2_3 = (UILabel *)[_paiHangView viewWithTag:288];
    UILabel *label2_4 = (UILabel *)[_paiHangView viewWithTag:289];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:[array[1] objectForKey:@"image"]]];
    label2_1.text = [NSString stringWithFormat:@"2 %@",[array[1] objectForKey:@"title"]];
    label2_2.text = [array[1] objectForKey:@"description"];
    label2_3.text = [array[1] objectForKey:@"favorite"];
    label2_4.text = [array[1] objectForKey:@"play"];
    
    
    UIImageView *imgView3 = (UIImageView *)[_paiHangView viewWithTag:290];
    UILabel *label3_1 = (UILabel *)[_paiHangView viewWithTag:291];
    UILabel *label3_2 = (UILabel *)[_paiHangView viewWithTag:292];
    UILabel *label3_3 = (UILabel *)[_paiHangView viewWithTag:293];
    UILabel *label3_4 = (UILabel *)[_paiHangView viewWithTag:294];
    [imgView3 sd_setImageWithURL:[NSURL URLWithString:[array[2] objectForKey:@"image"]]];
    
    label3_1.text = [NSString stringWithFormat:@"3 %@",[array[2] objectForKey:@"title"]];
    label3_2.text = [array[2] objectForKey:@"description"];
    label3_3.text = [array[2] objectForKey:@"favorite"];
    label3_4.text = [array[2] objectForKey:@"play"];
    
    
    
    
}



#pragma mark 食谱按钮点击事件
- (void)btnAction:(UIButton *)btn
{
    
    //更多按钮
    if (btn.tag == 407) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        More2ViewController *moreVC = [storyboard instantiateViewControllerWithIdentifier:@"collectionVC"];
        moreVC.titleArr = @[@"食谱",@"食材"];
        [[self viewController].navigationController pushViewController:moreVC animated:YES];
        return;
    }
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    BtnBaseViewController *btnVC = [storyBoard instantiateViewControllerWithIdentifier:@"btnVC"];
    btnVC.params = @"HomeSerial";
    
    NSArray *array = [[_data objectForKey:@"category"] objectForKey:@"data"];
    
    btnVC.navTitle = [array[btn.tag - 400] objectForKey:@"text"];
    btnVC.btn_id = [NSString stringWithFormat:@"%ld",btn.tag - 400 + 1];

    [[self viewController].navigationController pushViewController:btnVC animated:YES];
    
    
    
}

#pragma mark 点击广告条触发的方法
- (void)didClickPage:(HUScrollAndPageView *)view atIndex:(NSInteger)index{
    
    WebBaseViewController *webVC = [[WebBaseViewController alloc] init];
    webVC.view.backgroundColor = [UIColor whiteColor];
    
    
    webVC.httpStr = [[[_data objectForKey:@"banner"]objectForKey:@"data"][index - 1] objectForKey:@"link"];
    webVC.title = [[[_data objectForKey:@"banner"]objectForKey:@"data"][index - 1] objectForKey:@"title"];
    
    [[self viewController].navigationController pushViewController:webVC animated:YES];
    
    
}

#pragma  mark 更多按钮触发事件

- (IBAction)moreBtnAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 900:
        case 901:

        {//热门热门推荐
            MoreViewController *moreBtnVC = [[MoreViewController alloc] init];
            [[self viewController].navigationController pushViewController:moreBtnVC animated:YES];
            moreBtnVC.titleArr = @[@"热门",@"新品"];
            moreBtnVC.btnTag = [NSString stringWithFormat:@"%ld",sender.tag];
        }
            break;
        case 902:
        {
            //美食专题
            MeiShiBaseViewController *moreBtnVC = [[MeiShiBaseViewController alloc] init];
            [[self viewController].navigationController pushViewController:moreBtnVC animated:YES];
            
            
        }
            break;
        case 903:
            //排行榜
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            BtnBaseViewController *btnVC = [storyBoard instantiateViewControllerWithIdentifier:@"btnVC"];
            btnVC.params = @"TopList";
            btnVC.title = @"排行榜";
            [[self viewController].navigationController pushViewController:btnVC animated:YES];
            

        }
            break;
        default:
            break;
    }
}


- (IBAction)addBtnAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1000:
        case 1001:
        {
            
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
            if (sender.tag == 1000) {
               NSString *str = [[[_data objectForKey:@"data"][0] objectForKey:@"data"][0] objectForKey:@"id"];

                detailVC.dishes_id = str;
                
            }else{
                NSString *str = [[[_data objectForKey:@"data"][0] objectForKey:@"data"][1] objectForKey:@"id"];

                detailVC.dishes_id = str;
            }
            
            
            
            [[self viewController].navigationController pushViewController:detailVC animated:YES];
            
            
        }
            break;
        case 1002:
        case 1003:
        {
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
            if (sender.tag == 1002) {
                NSString *str = [[[_data objectForKey:@"data"][1] objectForKey:@"data"][0] objectForKey:@"id"];
                
                detailVC.dishes_id = str;
                
            }else{
                NSString *str = [[[_data objectForKey:@"data"][1] objectForKey:@"data"][1] objectForKey:@"id"];
                
                detailVC.dishes_id = str;
            }
            
            
            
            [[self viewController].navigationController pushViewController:detailVC animated:YES];
            
            
        }
            break;
        case 1004:
        case 1005:
        {

            
            WebBaseViewController *webVC = [[WebBaseViewController alloc] init];
            NSString *str = nil;
            if (sender.tag == 1004) {
                str = [[[_data objectForKey:@"data"][3] objectForKey:@"data"][0] objectForKey:@"id"];
                
            }else{
                str = [[[_data objectForKey:@"data"][3] objectForKey:@"data"][1] objectForKey:@"id"];
            }
            
            //请求网络
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:@"TopicView" forKey:@"methodName"];

            
            [params setObject:str forKey:@"topic_id"];
            [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
                
                NSDictionary *dic = [data objectForKey:@"data"];
                
                webVC.httpStr = [dic objectForKey:@"share_url"];
                webVC.title = [dic objectForKey:@"title"];
                
                [[self viewController].navigationController pushViewController:webVC animated:YES];
                
            }];

        }
            break;
        case 1006:
        case 1007:
        case 1008:
        {
            
            UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DetailViewController *detailVC = [storyborad instantiateViewControllerWithIdentifier:@"detailVC"];
            if (sender.tag == 1006) {
                NSString *str = [[[_data objectForKey:@"data"][2] objectForKey:@"data"][0] objectForKey:@"id"];
                
                detailVC.dishes_id = str;
                
            }else if(sender.tag == 1007){
                NSString *str = [[[_data objectForKey:@"data"][2] objectForKey:@"data"][1] objectForKey:@"id"];
                
                detailVC.dishes_id = str;
            }else{
                NSString *str = [[[_data objectForKey:@"data"][2] objectForKey:@"data"][2] objectForKey:@"id"];
                
                detailVC.dishes_id = str;
            }
            
            
            
            [[self viewController].navigationController pushViewController:detailVC animated:YES];
            
        }
            break;
        default:
            break;
    }
    
}



@end
