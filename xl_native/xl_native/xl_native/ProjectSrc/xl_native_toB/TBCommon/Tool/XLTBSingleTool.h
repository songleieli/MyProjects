//
//  XLTBSingleTool.h
//  xl_native_toB
//
//  Created by MAC on 2018/11/1.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLTBSingleTool : NSObject

+ (instancetype)sharedInstance;

@property (assign, nonatomic) NSInteger searchType; ///< 财富计划：1：种植计划 2：养殖计划 3：创业计划 
@property (assign, nonatomic) NSInteger tabBarIndex; ///< 0：财富计划 1：乡邻订单 2：乡邻档案

@end

NS_ASSUME_NONNULL_END
