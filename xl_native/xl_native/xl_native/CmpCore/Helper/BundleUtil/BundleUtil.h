//
//  BundleUtil.h
//  NewSolution
//
//  Created by 宋磊磊 on 14-2-14.
//  Copyright (c) 2014年 com.winchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

//提取bundle 资源的工具

@interface BundleUtil : NSObject

//2018.10.30 宋磊磊 修改

+(UIImage *)getCommonBundleImageByName:(NSString *)imagename;

+(UIImage *)getCurrentBundleImageByName:(NSString *)imagename;

@end
