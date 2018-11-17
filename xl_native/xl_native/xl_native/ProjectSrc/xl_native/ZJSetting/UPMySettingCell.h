//
//  ActiviteyCell.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface UPMySettingModel : IObjcJsonBase

//新添加
@property(nonatomic,copy) NSString * image;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * des;

@end



#define UPMySettingCellHeight 50.0f

@interface UPMySettingCell : BaseTableViewCell

- (void)fillDataWithModel:(UPMySettingModel *)listModel;

@property(nonatomic,strong) UPMySettingModel * listModel;

@property(nonatomic,strong) UIButton * viewBg;
@property(nonatomic,strong) UIImageView * imageVeiwIcon;

@property(nonatomic,strong) UILabel * labelName;
@property(nonatomic,strong) UILabel * labelDetail;
@property(nonatomic,strong) UILabel * labelTime;


@end
