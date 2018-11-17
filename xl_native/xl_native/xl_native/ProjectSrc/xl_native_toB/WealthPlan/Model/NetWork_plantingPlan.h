//
//  NetWork_plantingPlan.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlantingPlanCostModel : IObjcJsonBase

@property (assign, nonatomic) NSInteger bakeCost;
@property (assign, nonatomic) NSInteger fertilizerCost;
@property (assign, nonatomic) NSInteger landCost;
@property (assign, nonatomic) NSInteger machineCost;
@property (assign, nonatomic) NSInteger pesticideCost;
@property (assign, nonatomic) NSInteger seedlingsCost;

@end
@interface PlantingPlanCplanModel : IObjcJsonBase

@property (copy, nonatomic) NSString *cost;
@property (copy, nonatomic) NSString *netincome;
@property (copy, nonatomic) NSString *totalincome;

@end
@interface PlantingPlanMapchartsModel : IObjcJsonBase

@property (strong, nonatomic) NSArray *assets;
@property (strong, nonatomic) NSArray *deposits;
@property (assign, nonatomic) NSInteger times;
@property (strong, nonatomic) NSArray *totalincomes;
@property (strong, nonatomic) NSArray *years;

@end
@interface PlantingPlanMplanModel : IObjcJsonBase

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *item;
@property (copy, nonatomic) NSString *muarea;

@end
@interface PlantingPlanPropertyModel : IObjcJsonBase

@property (assign, nonatomic) NSInteger buildYear;
@property (copy, nonatomic) NSString *depositAmount;
@property (copy, nonatomic) NSString *depositBank;
@property (copy, nonatomic) NSString *houseArea;
@property (copy, nonatomic) NSString *isLoan;
@property (copy, nonatomic) NSString *landArea;
@property (copy, nonatomic) NSString *mainCrop;

@end



@interface PlantingPlanModel : IObjcJsonBase

@property (strong, nonatomic) PlantingPlanCostModel *cost;
@property (strong, nonatomic) PlantingPlanCplanModel *cplan;
@property (strong, nonatomic) PlantingPlanMapchartsModel *mapcharts;
@property (strong, nonatomic) PlantingPlanMplanModel *mplan;
@property (strong, nonatomic) PlantingPlanPropertyModel *property;


@property (copy, nonatomic) NSString *familyInfo;
@property (copy, nonatomic) NSString *image;
@property (assign, nonatomic) NSInteger mobile;

@end

@interface PlantingPlanRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) PlantingPlanModel *data;
@property (assign, nonatomic) NSInteger totall;

@end

@interface NetWork_plantingPlan : WCServiceBase

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *id;
@property (assign, nonatomic) NSInteger type; ///< 1:种植 2:养殖 3:创业


@end

NS_ASSUME_NONNULL_END
