//
//  MyViewTableViewCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_queryFollower.h"

#define MyFansCellHeight     sizeScale(50)  //评论title的高度

@interface MyFansCell : UITableViewCell

- (void)dataBind:(QueryFollowedModel*)model;

+ (NSString*) cellId;

@end
