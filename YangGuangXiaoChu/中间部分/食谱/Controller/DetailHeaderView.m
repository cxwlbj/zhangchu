//
//  DetailHeaderView.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _imgView.clipsToBounds = YES;
    _imgView.width = kScreenWidth;
    _playBtn.center = _imgView.center;
    
    _detailLabel.width = kScreenWidth - 56;
    
    zheZhaoView.width = kScreenWidth;
    zhe2VIew.width = kScreenWidth;
    
    
}


-(void)setHeaderData:(NSDictionary *)headerData{
    if (_headerData !=headerData) {
        _headerData = headerData;
        [self _initViews];
    }
}


- (void)_initViews{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[_headerData objectForKey:@"image"]]];
    _titleLabel.text = [_headerData objectForKey:@"dashes_name"];
    _detailLabel.text = [_headerData objectForKey:@"material_desc"];
    [_detailLabel sizeToFit];
    _hardLabel.text = [NSString stringWithFormat:@"难度：%@",    [_headerData objectForKey:@"hard_level"]];
    
    _buzhouLabel.text = [NSString stringWithFormat:@"时间：%@",    [_headerData objectForKey:@"cooke_time"]];
    _downloadLabel.text = [NSString stringWithFormat:@"口味：%@",    [_headerData objectForKey:@"taste"]];

    

}

- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 200:
        case 201:
        case 202:
        {
            NSString *str = [_headerData objectForKey:@"material_video"];
            NSURL *url = [NSURL URLWithString:str];
            
            MPMoviePlayerViewController *playerViewCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
            
            [[self viewController] presentMoviePlayerViewControllerAnimated:playerViewCtrl];
        
        }
            break;
        case 203:
        {
            //下载
        }
            break;
    
        default:
            break;
    }
}





@end
