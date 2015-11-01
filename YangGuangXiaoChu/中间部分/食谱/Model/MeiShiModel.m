//
//  MeiShiModel.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MeiShiModel.h"

@implementation MeiShiModel
-(id)initContentWithDic:(NSDictionary *)jsonDic{
    
    self = [super initContentWithDic:jsonDic];
    if (self) {
        
        
        self.meiShiID = [jsonDic objectForKey:@"id"];
        self.meiShi_description = [jsonDic objectForKey:@"description"];
    }
    
    return self;
    
}

@end
