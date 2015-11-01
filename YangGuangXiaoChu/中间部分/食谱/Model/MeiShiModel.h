//
//  MeiShiModel.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//
/**
 
 
 
 *  id	String	60
 headphoto	String	http://img.szzhangchu.com/1439361047868_1114556934.jpg
 title	String	产后瘦身，健康饮食最靠谱
 nickname	String	清新小妹子
 description	String	产后新妈妈们专属健康瘦身餐
 create_time	Integer	1443110400
 image	String	http://img.szzhangchu.com/1442015301377_1817959890.jpg
 visit	String	1
 favorite	String	1
 */
#import "BaseModel.h"

@interface MeiShiModel : BaseModel


@property (nonatomic ,copy) NSString *meiShiID;
@property (nonatomic ,copy) NSString *headphoto;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *nickname;
@property (nonatomic ,copy) NSString *meiShi_description;
@property (nonatomic ,copy) NSNumber *create_time;
@property (nonatomic ,copy) NSString *image;
@property (nonatomic ,copy) NSString *visit;
@property (nonatomic ,copy) NSString *favorite;


@end
