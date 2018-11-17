//
//  BundleUtil.m
//  NewSolution
//
//  Created by songlielei on 14-2-14.
//  Copyright (c) 2014年 com.winchannel. All rights reserved.
//

#import "BundleUtil.h"
#import "UIDevice+Hardware.h"

#define BUNDLE_COMPOSE_FORMAT @"%@/%@/%@.%@"
#define IMAGE_EXTEND_DOUBLE_X @"@2x"
#define IMAGE_EXTEND_PNG @"png"
#define FILE_EXTEND_HTML @"html"

#define BUNDLE_COMPOSE_FORMAT_NOTYPE @"%@/%@/%@"

@implementation BundleUtil

#pragma - mark 2018.10.30 宋磊磊 修改

/*
 获取主要Bundle
 1.如果传入的有bundlename，则返回 Bundle
 2.如果没有传入bundlename 则返回common.bundle
 */
+(NSBundle *)getBundleByName:(NSString *)bundlename
{
    NSString *bundlePath = nil;
    if (bundlename != nil)
        bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:bundlename];
    else
        bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"common.bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

//获取公共根目录下图片路径 使用默认png类型
+(UIImage *)getCommonBundleImageByName:(NSString *)imagename{
    
    imagename = [NSString stringWithFormat:@"img/%@",imagename];

    NSBundle  *bundle=[BundleUtil getBundleByName:nil];
    NSString *path = [bundle pathForResource:imagename ofType:IMAGE_EXTEND_PNG];
    
    return [UIImage imageWithContentsOfFile:path];

    
}

//获取当前target.bundle 下image的图像
+(UIImage *)getCurrentBundleImageByName:(NSString *)imagename{
    
    imagename = [NSString stringWithFormat:@"/img/%@",imagename];
    NSString *bundlename= [GlobalFunc sharedInstance].gWCOnbConfiguration.resourceBundleName;
    NSBundle  *bundle=[BundleUtil getBundleByName:bundlename];
    NSString *path = [bundle pathForResource:imagename ofType:IMAGE_EXTEND_PNG];
    return [UIImage imageWithContentsOfFile:path];
}











@end
