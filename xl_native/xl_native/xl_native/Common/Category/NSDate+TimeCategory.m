//
//  NSDate+TimeCategory.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NSDate+TimeCategory.h"

static NSDateFormatter *dateFormatter;

@implementation NSDate (TimeCategory)

+ (NSDateFormatter *)defaultFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}



+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}


+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [NSDate defaultFormatter];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}




+ (NSInteger)cTimestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}


+ (NSDate *)dateFromCstampTime:(NSInteger)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}



+ (NSInteger)cTimestampFromString:(NSString *)timeStr
                           format:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}



+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}



+ (NSString *)obtainCurrentTime
{
    NSDate *date = [NSDate date];
    int _year,_month,_day;
    NSDateFormatter *dateFormat = [NSDate defaultFormatter];
    dateFormat.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [dateFormat setDateFormat:@"yyyy"];
    _year = [[dateFormat stringFromDate:date] intValue];
    [dateFormat setDateFormat:@"MM"];
    _month = [[dateFormat stringFromDate:date] intValue];
    [dateFormat setDateFormat:@"dd"];
    _day = [[dateFormat stringFromDate:date] intValue];
    
    return HMSTR(@"%d-%02d-%02d",_year,_month,_day);
}


+ (NSInteger)obtainCurrentTimestamp
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
    return [NSDate cTimestampFromString:string format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSInteger)obtainCurrentTimestampEnd:(NSString *)endTime
{
    NSString *time_end = [NSString stringWithFormat:@"%@ 23:59:59",endTime];
    return [NSDate cTimestampFromString:time_end format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)compareCurrentTime:(NSInteger )cTime
{
    
    //把字符串转为NSdate
    
    NSDate *timeDate = [NSDate dateFromCstampTime:cTime];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return  result;
    
}

+ (NSInteger )endTime:(NSInteger)cTime
{
    NSInteger dd = [NSDate cTimestampFromDate:[NSDate date]];
    NSInteger time = (cTime - dd);
    return time;
}

@end
