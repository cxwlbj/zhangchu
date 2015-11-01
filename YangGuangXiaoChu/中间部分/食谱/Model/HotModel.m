//
//  HotModel.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel
-(id)initContentWithDic:(NSDictionary *)jsonDic{
    
    self = [super initContentWithDic:jsonDic];
    if (self) {
        
        
        self.dishID = [jsonDic objectForKey:@"id"];
        self.dish_description = [jsonDic objectForKey:@"description"];
    }
    
    return self;
    
}
@end
