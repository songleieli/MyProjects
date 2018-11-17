//
//  AddIntegralTool.h
//  xl_native
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddIntegralTool : NSObject

+ (instancetype)sharedInstance;

- (void)addIntegral:(BaseViewController *)vc code:(NSString *)code;

@end
