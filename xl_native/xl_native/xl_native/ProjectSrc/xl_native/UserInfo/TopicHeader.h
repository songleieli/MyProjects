//
//  TopicHeader.h
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopicHeader : UIView

+ (instancetype)shareView ;

@property (weak, nonatomic) IBOutlet UILabel *topic;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *num;

@end

NS_ASSUME_NONNULL_END
