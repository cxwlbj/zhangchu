//
//  MeiShiCell.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MeiShiCell.h"

@implementation MeiShiCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setModel:(MeiShiModel *)model
{
    if (_model != model) {
        _model = model;
        [super setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.contentMode = UIViewContentModeCenter;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.image]];
    _imgView.contentMode = UIViewContentModeScaleToFill;
    _label1.text = _model.title;
    _label2.text = _model.meiShi_description;
    
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
