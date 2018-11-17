//
//  VUILable.h
//  JrLoanMobile
//
//  Created by song leilei on 15/12/9.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VUILable : UILabel{
    @private
        VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;

@end
