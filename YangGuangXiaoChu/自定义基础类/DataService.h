//
//  DataService.h
//  UI-05-homework
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyBlock)(id data);


@interface DataService : NSObject


//构建一个类方法，含有一个字符串和一个block

+ (void)requestDataWithURL: (NSString *)url WithBlock :(MyBlock)block;



//AF方法
+ (void)requestURL: (NSString *)urlStr Params:(NSDictionary *)params Method:(NSString *)method Block:(MyBlock)block;


@end
