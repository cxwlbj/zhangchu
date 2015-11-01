//
//  BtnTabCell.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BtnTabCell.h"

@implementation BtnTabCell

- (void)awakeFromNib {
    // Initialization code
    
}




- (void)setModel:(HotModel *)model
{
    if (_model != model) {
        _model = model;
        [super setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.image]];
    _imgView.clipsToBounds = YES;
    
    
    if (_model.series_name) {
        //食课专题
        _label2.text = _model.series_name;
        _label1.text = [NSString stringWithFormat:@"%@人看过 %@/%@",_model.play,_model.episode,_model.episode_sum];

    }else{
        _label2.text = _model.title;
        _label1.text = _model.dish_description;
    }
    
    
    
    
    

}

- (IBAction)btnAction:(UIButton *)sender {
    
    NSString *str = _model.video
    ;
    
    if (str.length == 0) {
        
        
        NSLog(@"没有找到对应视频");
        return;
    }

    NSURL *url = [NSURL URLWithString:str];
    MPMoviePlayerViewController *playerViewCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    
    [[self viewController] presentMoviePlayerViewControllerAnimated:playerViewCtrl];
    
}


@end
