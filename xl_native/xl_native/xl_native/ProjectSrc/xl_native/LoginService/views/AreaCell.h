//
//  MyViewTableViewCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_getSonElement.h"

#define AreaCellHeight     sizeScale(50)  //评论title的高度

@interface AreaCell : UITableViewCell

- (void)dataBind:(SonElementModel*)model;

+ (NSString*) cellId;

@end
