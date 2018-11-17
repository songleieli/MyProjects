//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 {
 "property_name": "广兰路50弄1幢2号1层102室",
 "equipment_type": "客户电表",
 "equipment_number": "KHDB0000000003",
 "done": "未抄",
 "property_number": "A01-01-02-01-02",
 "customer_name": "汪仁伦",
 "customer_pnumber": "",
 "last_read": [
 {
 
 "last_read": 444,
 "current_read": 445
 
 }
 ],
 "flag": "new",
 "meter_reader": null,
 "meter_date": "2016-12-20 16:05:09"
 },
 */


@interface ZjLastReadModel : IObjcJsonBase

@property(nonatomic,strong) NSNumber * last_read;
@property(nonatomic,strong) NSNumber * current_read;

@end


@interface ZjGetUmeterByNodeModel : IObjcJsonBase

@property(nonatomic,copy) NSString * property_name;
@property(nonatomic,copy) NSString * equipment_type;
@property(nonatomic,copy) NSString * equipment_number;
@property(nonatomic,copy) NSString * done;
@property(nonatomic,copy) NSString * property_number;
@property(nonatomic,copy) NSString * customer_name;
@property(nonatomic,copy) NSString * customer_pnumber;
@property(nonatomic,copy) NSArray * last_read;
@property(nonatomic,copy) NSString * flag;
@property(nonatomic,copy) NSString * meter_reader;
@property(nonatomic,copy) NSString * meter_date;

@end



@interface ZjGetUmeterByNodeRespone : IObjcJsonBase

@property(nonatomic,copy) NSArray *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_get_umeter_by_node : WCServiceBase_Zjsh

//@property(nonatomic,copy) NSString *project_id;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) NSNumber *page;
@property(nonatomic,copy) NSString *node_name;

///*
// *说明，接口处理缓存的相关字段  NetWork_ZJ_pms_patrol_records 为增量更新模式数据库缓存的标准写法，其他缓存接口的数据可参考该接口的写法
// *1.cache_saveCacheModel 本地数据库缓存数据的模式
// SaveCacheModelArray 为增量更新模式，即解析接口中得所有字段按照解析的字段来存，需要指定主键
// SaveCacheModelAll   为非增量更新模式，即不解析具体接口的所有字段，将接口返回的所有Json数据存入到数据库中 不需要指定主键
// 当cache_saveCacheModel 的值为 SaveCacheModelArray 时 字段 cache_column, cache_primary_key 和 cache_array_model 必须制定对应的值
// *2. cache_column 该字段用于制定缓存数组的位置  值为 "result_result" 表示ZjPmsPatrolRecordsRespone 的result字段ZjPmsPatrolRecordsTempModel
// 的 result 数组中 ZjPmsPatrolRecordsModel 对象
// *3.cache_primary_key  缓存数据需要用到的主键  record_id 表示缓存本地数据库中表的主键为 record_id
// *4.cache_array_model  表示本地数据库中表需要解析的Model ZjPmsPatrolRecordsModel
// *5.
// */
//
//@property(nonatomic,copy) NSString *cache_column;
//@property(nonatomic,copy) NSString *cache_primary_key;
//@property(nonatomic,strong) ZjGetUmeterByNodeModel * cache_array_model;

@end
