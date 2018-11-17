//
//  NeighboursLabelCollectionCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NeighboursLabelCollectionCellModel : NSObject

@property (nonatomic, copy)NSString*titleStr;

@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic, copy)NSString* typeIds;

@end

@interface NeighboursLabelCollectionCell : UICollectionViewCell

- (void)dataBind:(NeighboursLabelCollectionCellModel *)model;


// 创建id

+ (NSString *)registerCellID;
@end
