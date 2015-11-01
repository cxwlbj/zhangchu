//
//  BottomModel.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"
/**
 *  "agreement_amount" = 260;
 "comment_count" = 3;
 "cooke_time" = "20\U5206\U949f";
 "dashes_id" = 14442;
 "dashes_name" = "\U77f3\U677f\U7f8a\U8089";
 "hard_level" = "\U8f83\U96be";
 image = "http://img.szzhangchu.com/1442398237781_1755782966.JPG";
 like = 0;
 "share_amount" = 0;
 "share_url" = "http://h5.izhangchu.com/web/dishes_view/index.html?&dishes_id=14442";

 */
@interface BottomModel : BaseModel


@property (nonatomic,copy) NSString *agreement_amount;
@property (nonatomic,copy) NSString *comment_count;
@property (nonatomic,copy) NSString *share_url;
@property (nonatomic,copy) NSString *like;
@property (nonatomic,copy) NSString *dashes_id;
@property (nonatomic,copy) NSString *dashes_name;
@property (nonatomic,copy) NSString *image;



@end
