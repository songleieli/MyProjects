//
//  MyViewTableViewCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyViewTableViewCellHeight     sizeScale(45)  //评论title的高度

@interface MyViewTableViewCellModel : NSObject

@property (nonatomic ,copy)NSString* imageStr;
@property (nonatomic ,strong)NSString* titleStr;

@property (nonatomic,assign)BOOL isShowLine;

@property (nonatomic,assign)NSInteger cellTag;

@end

@interface MyViewTableViewCell : UITableViewCell

- (void)dataBind:(MyViewTableViewCellModel*)model;

+ (NSString*) cellId;
@end
