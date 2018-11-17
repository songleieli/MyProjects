//
//  TopicHeader.m
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "TopicHeader.h"

@implementation TopicHeader

+ (instancetype)shareView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TopicHeader" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
}

@end
