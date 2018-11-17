//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "request_number": "01201610170016",
 "node": "后现代城3号楼3单元",
 "contact_person": "闫凤娇",
 "contact_number": "13520591706",
 "category": "",
 "request_time": "2016-10-17 11:25:34",
 "incident_status": "DONE"
 */

@interface ZjIncidentRequestsModel : IObjcJsonBase

@property(nonatomic,copy) NSString * request_number;
@property(nonatomic,copy) NSString * node;
@property(nonatomic,copy) NSString * contact_person;
@property(nonatomic,copy) NSString * contact_number;
@property(nonatomic,copy) NSString * category;
@property(nonatomic,copy) NSString * request_time;
@property(nonatomic,copy) NSString * incident_status;


@end


@interface ZjIncidentRequestsTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray * result;


@end


@interface ZjIncidentRequestsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjIncidentRequestsTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *incident_status;
@property(nonatomic,copy) NSString *role;
@property(nonatomic,strong) NSNumber *page_num;

////缓存相关，新研究添加。字段名称必须为 1.cache_column 2.cache_primary_key 3.数据库中需要存放数据的对象，用于解析对象的属性建立相应的字段
//
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
//@property(nonatomic,strong) ZjIncidentRequestsModel * cache_array_model;

@end
