//
//  HotModel.h
//  YangGuangXiaoChu
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//
/**
 hard_level	String	一般
 tags_info	Array
 play	String	29047
 image	String	http://img.szzhangchu.com/1439346665499_4516469251.jpg
 video1	String	http://video.szzhangchu.com/jiaoyanqieheB.mp4
 taste	String	咸
 dishes_id	String	273
 content	String	乍一看，会以为是一道简单粗暴的小菜，自己做才会明白其中的精细。刀工要求等级：三星…
 cooking_time	String	3分钟
 title	String	椒盐茄盒
 create_date	Integer	1037601504
 description	String	一道不简单的小菜
 video	String	http://video.szzhangchu.com/jiaoyanqieheA.mp4
 
 *  content	String	当家中来客，又没有时间弄太多复杂的菜，这道双椒炒腊肠就是不错的选择，辣椒易熟，腊肠是半成品，烹调起来简单省时，而且卖相好哦！…
 id	String	800
 title	String	双椒炒腊肠
 create_date	Integer	1052288449
 tags_info	Array
 description	String	好吃的简易小炒
 play	String	843
 image	String	http://img.szzhangchu.com/1439349250857_8881826379.jpg
 favorite	String	29
 video1	String	http://video.szzhangchu.com/shuangjiaochaolachangB.mp4
 video	String	http://video.szzhangchu.com/shuangjiaochaolachangA.mp4
 */

/**
 *	{
	episode	Integer	2
 tag	String	独家
 series_name	String	记忆中的味道
 play	Integer	2083
 image	String	http://img.szzhangchu.com/1443190866565_9771761741.jpg
 episode_sum	Integer	20
 series_id	Integer	13 */



#import "BaseModel.h"

@interface HotModel : BaseModel
//食客新增数据

@property (nonatomic, copy) NSNumber *episode;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *series_name;
@property (nonatomic, copy) NSNumber *play;
@property (nonatomic, copy) NSNumber *episode_sum;
@property (nonatomic, copy) NSNumber *series_id;





//内容
@property (nonatomic,copy) NSString *content;
//菜品ID
@property (nonatomic,copy) NSString *dishID;
//菜名
@property (nonatomic,copy) NSString *title;
//时间
@property (nonatomic,copy) NSNumber *create_date;

//制作信息
@property (nonatomic,strong) NSArray *tags_info;
//描述
@property (nonatomic,copy) NSString *dish_description;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *video1;
@property (nonatomic,copy) NSString *video;
@property (nonatomic,copy) NSString *favorite;






@property (nonatomic,copy) NSString *hard_level;
@property (nonatomic,copy) NSString *taste;
@property (nonatomic,copy) NSString *dishes_id;
@property (nonatomic,copy) NSString *cooking_time;






@end
