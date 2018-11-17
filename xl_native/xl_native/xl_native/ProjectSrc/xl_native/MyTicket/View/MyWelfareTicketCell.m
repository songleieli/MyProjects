//
//  MyWelfareTicketCell.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "MyWelfareTicketCell.h"

static NSString* const ViewTableViewCellId=@"MyWelfareTicketCellCellId";


@implementation MyWelfareTicketCell






- (void)setModel:(MyWelfareTicketModel *)model
{
    _model = model;
    
    self.count.text = model.count;
    self.cycleDesc.text = model.cycleDesc;
    self.title.text = model.title;
    self.usePlat.text = [NSString stringWithFormat:@"适用平台：%@",model.usePlat];
    self.time.text = [NSString stringWithFormat:@"有效期至：%@",model.limitDate] ;
    
    // 0使用过，1未使用过，2过期
    if ([model.isused isEqualToString:@"0"]) {
        self.titleImg.image = [UIImage imageNamed:@"组 326"];
        self.usedImg.image = [UIImage imageNamed:@"组 327"];
        self.lineImg.image = [UIImage imageNamed:@""];
        self.lab.text = @"";
        self.lab.numberOfLines = [self.lab.text length];
        
    } else if ([model.isused isEqualToString:@"1"]) {
        self.titleImg.image = [UIImage imageNamed:@"组 324"];
        self.usedImg.image = [UIImage imageNamed:@""];
        self.lineImg.image = [UIImage imageNamed:@"组 325"];
        self.lab.text = @"立\n即\n使\n用";
        self.lab.numberOfLines = [self.lab.text length];
        
    } else if ([model.isused isEqualToString:@"2"]) {
        self.titleImg.image = [UIImage imageNamed:@"组 326"];
        self.usedImg.image = [UIImage imageNamed:@""];
        self.lineImg.image = [UIImage imageNamed:@""];
        self.lab.text = @"";
        self.lab.numberOfLines = [self.lab.text length];
        
    }
    
    
}
- (IBAction)btnClick:(id)sender {
    if ([self.model.isused isEqualToString:@"1"]) {
        if (self.btnClickBlock) {
            self.btnClickBlock();
        }
        XLLog(@"点击");
    } else {
        XLLog(@"不能点击");
    }
}

#pragma mark - 类方法
+ (NSString*) cellId{
    return ViewTableViewCellId;
}

@end
