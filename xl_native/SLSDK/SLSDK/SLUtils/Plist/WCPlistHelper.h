//
//  PlistHelper.h
//  WinChannelFrameWork
//
//  Created by songle Lei on 10/19/12.
//
//




#import <Foundation/Foundation.h>

@interface WCPlistHelper : NSObject
@property (nonatomic, retain, readonly) NSDictionary *allProperties;

- (id)initWithPlistNamed:(NSString *)aPlistName;

- (void)saveplistWithPath:(NSMutableDictionary*)plistDic;

@end
