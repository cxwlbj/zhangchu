//
//  DataService.m
//  UI-05-homework
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"

@implementation DataService


//实现该类方法
//NSMutableURLRequest方法
+ (void)requestDataWithURL: (NSString *)url WithBlock :(MyBlock)block{
    
    //方法一，可以参考下载/缓存的例子
    
    //方法二
    NSURL *url1 = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url1;

    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"%@",connectionError);
            return ;
        }
                //解析数据
                NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{

            if (connectionError) {
                return ;
            }
            
            block(dic1);
            
        });
        
    }];

    //方法三，开辟另外一个子线程
    
    
}





//AF方法
+ (void)requestURL: (NSString *)urlStr Params:(NSDictionary *)params Method:(NSString *)method Block:(MyBlock)block{
    
    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    
        [params setValue:@"4.01" forKey:@"version"];    
    if (snsAccount != nil) {

        [params setValue:@"935145" forKey:@"user_id"];
        [params  setValue:@"4C7D1B7534D8133A24FAC37EF697ACBC" forKey:@"token"];
    }
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if ([method isEqualToString:@"GET"]) {
        //GET请求
        //方法一，该方放默认结果是JSON解析
        
        //该方法返回一个operation
        [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求成功");
            block(responseObject);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];

    }else{
        //POST请求
        [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求成功");

            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
    
//    //方法一，该方放默认结果是JSON解析
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //该方法返回一个operation
//    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        block(responseObject);
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    
    
    
//    //方法二，自定义解析方式
    
//    //构造请求
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    
//    NSMutableURLRequest *request = [serializer requestWithMethod:@"GET" URLString:urlStr parameters:nil error:nil];
//    //构建操作对象
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    //设置解析方式
//    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    
//    //请求数据
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
//        block(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
    
    
    

}






@end
