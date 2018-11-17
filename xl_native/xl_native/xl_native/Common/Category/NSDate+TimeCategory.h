//
//  NSDate+TimeCategory.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TimeCategory)

/**
 *  字符串转NSDate
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return date
 */
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;



/**
 *  NSDate转字符串
 *
 *  @param date   NSDate时间
 *  @param format 转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;



/**
 *  NSDate转时间戳
 *
 *  @param date 字符串时间
 *
 *  @return 返回时间戳
 */
+ (NSInteger)cTimestampFromDate:(NSDate *)date;



/**
 *  时间戳转NSDate
 *
 *  @param timeStamp 时间戳
 *
 *  @return 字符串时间
 */
+ (NSDate *)dateFromCstampTime:(NSInteger)timeStamp;




/**
 *  字符串转时间戳
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回时间戳的字符串
 */
+ (NSInteger)cTimestampFromString:(NSString *)timeStr
                           format:(NSString *)format;


/**
 *  时间戳转字符串
 *
 *  @param timeStamp 时间戳
 *  @param format    转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;




/**
 *  获取当前年月日
 *
 *  @return 返回字符串
 */
+ (NSString *)obtainCurrentTime;


/**
 *  获取当前年月日时间戳
 *
 *  @return 返回时间戳
 */
+ (NSInteger)obtainCurrentTimestamp;


/**
 *  获取当前年月日 最后一刻的时间戳 转化格式 如yyyy-MM-dd,即2015-07-15
 *
 *  @return 返回时间戳
 */
+ (NSInteger)obtainCurrentTimestampEnd:(NSString *)endTime;


/**
 获取距离现在过了多久  一分钟前 一小时前...
 
 @param cTime 距离现在的时间
 @return 返回字符串
 */
+ (NSString *)compareCurrentTime:(NSInteger)cTime;



/**
 距离当前时间还有多久结束
 
 @param cTime 结束时间
 @return
 */
+ (NSInteger)endTime:(NSInteger)cTime;

@end

NS_ASSUME_NONNULL_END
