//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjPmsPatrolRecordsModel : IObjcJsonBase

@property(nonatomic,copy) NSString * record_id;                 //巡检记录id
@property(nonatomic,copy) NSString * patrol_point_equipment;    //巡检设备名
@property(nonatomic,copy) NSString * equipment_num;             //巡检设备名
@property(nonatomic,copy) NSString * patrol_type;               //巡检类型
@property(nonatomic,copy) NSString * patrol_point;              //巡检点
@property(nonatomic,copy) NSString * start_time;                //巡检时间(巡检计划开始时间)
@property(nonatomic,copy) NSString * no_man_flag;               //是否房间无人，（装修巡检时用来确认是否勾选房间无人）
@property(nonatomic,copy) NSString * patrol_status;             //巡检状态
@property(nonatomic,copy) NSString * patrol_person;             //巡检人
@property(nonatomic,copy) NSString * patrol_location;           //巡检点
@property(nonatomic,copy) NSString * patrol_class;              //# 巡检类别，currency:通用 / standard:标准
@property(nonatomic,copy) NSString * patrol_time;                //巡检时间（已检与未检时指巡检时间，待检时指上次巡检时间）
@property(nonatomic,copy) NSString * start_time_temp;           //派工日期(计划起始日期)
@property(nonatomic,copy) NSString * end_time;                  //计划终止日期
@property(nonatomic,copy) NSString * complete_time;             //完成日期
@property(nonatomic,copy) NSString * cycle_num;                 //暂无
@property(nonatomic,copy) NSString * property_number;                 //房间编号
@property(nonatomic,copy) NSString * equipment_name;                 //设备巡检-设备名称

@property(nonatomic,copy) NSString * patrol_location_id;              //?什么参数
@property(nonatomic,copy) NSString * equipment_id;                 //设备Id
@property(nonatomic,copy) NSString * type_code;                    //巡检类型code
@property(nonatomic,copy) NSString * status_code;                  //？  ONGOING
@property(nonatomic,copy) NSString * if_plan;                      //# 是否计划内，Y:计划内/N:计划外
@property(nonatomic,copy) NSString * order_id;                     // 计划id
@property(nonatomic,copy) NSString * order_desc;                //巡检说明，根据order_id 从orders_list 中取出

@property(nonatomic,copy) NSString * point_name;                   //# 巡检(事件)名称
@property(nonatomic,copy) NSString * order_name;                   //# 巡检计划单名称

//add by songlei 计算cell 高度
@property(nonatomic,assign) CGFloat cellHeight;                   //预先计划Cell的高度
@property(nonatomic,assign) BOOL is_old_data;                     //是否物管老数据，如果是老数据没有计划名称和巡检名称





//缓存过滤使用
@property(nonatomic,copy) NSString *cache_patrol_type;
@property(nonatomic,copy) NSString *cache_record_status;
@property(nonatomic,copy) NSString *cache_page_num;

@end


@interface ZjPmsPatrolOrderListModel : IObjcJsonBase

//缓存过滤使用
@property(nonatomic,copy) NSString *order_id;
@property(nonatomic,copy) NSString *order_desc; //描述

@end


@interface ZjPmsPatrolRecordsTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray * patrol_records;
@property(nonatomic,strong) NSArray * orders_list;

@end

@interface ZjPmsPatrolRecordsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjPmsPatrolRecordsTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_pms_patrol_records : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString * patrol_type;
@property(nonatomic,copy) NSString * record_status;
@property(nonatomic,copy) NSNumber *page_num;


@end
