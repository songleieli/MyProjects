//
//  PlistHelper.m
//  WinChannelFrameWork
//
//  Created by Cai Lei on 10/19/12.
//
//

#import "WCPlistHelper.h"

@interface WCPlistHelper ()
@property (nonatomic, copy) NSString *plistName;
@property (nonatomic, copy) NSString *plistPath;
@end

@implementation WCPlistHelper
@synthesize plistName = plistName_;
@synthesize allProperties = allProperties_;
@synthesize plistPath = plistPath_;


- (id)initWithPlistNamed:(NSString *)aPlistName {
    self = [super init];
    if (self) {
        plistName_ = [aPlistName copy];
        allProperties_ = [[NSDictionary alloc] init];
    }
    return self;
}

- (NSDictionary *)allProperties {
    if (!self.plistName) {
        return nil;
    }
    

    
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
    if (!filepath) {
        return nil;
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *dbfolder = [docDir stringByAppendingPathComponent:self.plistName];
    self.plistPath = [NSString stringWithFormat:@"%@.plist",dbfolder];
    
    
    /* 注释：by songleieli
     如果不存在,将onbConfiguration.plist 拷贝到Document目录中进行操作，因为在模拟器条件下可以修改成功，而在真机条件下，修改onbConfiguration.plist 文件失败，所以要将onbConfiguration.plist放在Document目录中进行操作
     */

    NSError*error;
    NSFileManager *fm = [NSFileManager defaultManager];
    if([self isCurAppVerFirstStarUp]){ //当前版本第一次启动
        if([fm fileExistsAtPath:self.plistPath]){
            [fm removeItemAtPath:self.plistPath error:&error];
            NSLog(@"删除成功！");
        }
        [fm copyItemAtPath:filepath toPath:self.plistPath error:&error];
        BOOL isExit = [fm fileExistsAtPath:self.plistPath];
        if(isExit){
            NSLog(@"拷贝成功！");
        }
        else{
            NSLog(@"拷贝失败！");
        }
    }
    
    NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
    return properties;
}

- (void)saveplistWithPath:(NSMutableDictionary*)plistDic{
    [plistDic writeToFile:self.plistPath atomically:YES];
}

/*
 *判断应用是不是当前版本第一次启动，例如，从1.03 升级到1.1.0 第一次启动该值为YES，否则为NO，add by songleilei
 */
- (BOOL)isCurAppVerFirstStarUp{
    NSString *appVerson = [SL_Utils appVersion];
    NSString *shotVerson = [SL_Utils appShortVersion];
    
    NSString *key = [NSString stringWithFormat:@"WCPlistHelper_%@_%@",appVerson,shotVerson];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *versionInfo = [userDefault objectForKey:key];
    
    if(versionInfo == nil){
        [userDefault setObject:key forKey:key];
        [userDefault synchronize];
        return YES;
    }
    else{
        return NO;
    }
    
}

@end
