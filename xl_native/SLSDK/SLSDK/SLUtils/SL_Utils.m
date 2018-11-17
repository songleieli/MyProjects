//
//  SL_Utils.m
//  SLSDK
//
//  Created by 刘辉 on 16/1/4.
//  Copyright © 2016年 songlei. All rights reserved.
//

#import "SL_Utils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>

#import "SFHFKeychainUtils.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation SL_Utils


+ (NSNumber *)screenHeight
{
    return [NSNumber numberWithDouble:[UIScreen mainScreen].bounds.size.height];
}

+ (NSNumber *)screenWidth
{
    return [NSNumber numberWithDouble:[UIScreen mainScreen].bounds.size.width];
}


+ (NSString *)appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}


+ (NSString *)bundleId
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

//获取app Short 版本
+ (NSString *)appShortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

//获取app版本
+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

//获取channelID
+ (NSString *)channelID
{
    return @"appStore";
}


+ (NSString *)platformType
{
    return @"ios";
}


//获取手机版本号
+ (NSString *)appDeviceVersion
{
    return [UIDevice currentDevice].systemVersion;
}

//获取设备idfa
+(NSString *)getIDFA
{
    NSString *idfa= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

+(NSString*)getIMEI{
  return [UIDevice currentDevice].uniqueID;
}

+ (NSString *)getKeychainIDFA{
   NSString* idfa = [SFHFKeychainUtils getPasswordForUsername:@"slsdk_jrd_idfa" andServiceName:@"slsdk_jrd_idfa" error:nil];
    return idfa;
}

+ (BOOL)saveKeychainIDFA:(NSString*)idfa{
    assert(idfa != nil);
    
   BOOL result = [SFHFKeychainUtils storeUsername:@"slsdk_jrd_idfa" andPassword:idfa forServiceName:@"slsdk_jrd_idfa" updateExisting:YES error:nil];
    return result;
    
}


//获取设备类型
+ (NSInteger)getDeviceType {
    
    NSString *modelname = [[UIDevice currentDevice]model];
    
    
    NSRange rg = [[modelname lowercaseString]rangeOfString:@"iphone"];
    if(rg.location!=NSNotFound)
    {
        return Device_iPhone;
    }
    
    rg= [[modelname lowercaseString]rangeOfString:@"ipad"];
    if(rg.location!=NSNotFound){
        return Device_iPad;
        
    }
    rg= [[modelname lowercaseString]rangeOfString:@"ipod"];
    if(rg.location!=NSNotFound){
        return Device_iTouch;
    }
    
    return -1;
}

+(NSString*)getModelName{
    // 需要#import "sys/utsname.h"
//#warning 题主呕心沥血总结！！最全面！亲测！全网独此一份！！
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
    
//    作者：si1ence
//    链接：http://www.jianshu.com/p/b23016bb97af
//    來源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}



+ (NSString *)devicePhoneModel{
    NSString* phoneModel = [[UIDevice currentDevice] model];    
    return phoneModel;
}

/*手机型号*/
+ (NSString *)deviceTypeVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"deviceString:%@",deviceString);
    
    return deviceString;
}

//+ (NSString*)netWorkType
//{
//    NetworkStatus status = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
//    if( status == NotReachable)
//    {
//        return @"无网络";
//    }
//    else if(status == kReachableViaWiFi )
//    {
//        return @"wifi";
//    }
//    else if(status == kReachableViaWWAN)
//    {
//        return @"2G/3G";
//    }
//    else return @"";
//}

//获取网络类型
+(NSString *)getNetWorkType
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state =@"unkown";
    int netType = 0;
    //获取到网络返回码
    for (id child in children)
    {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                    state = @"WIFI";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

//获取运营商类型
+ (NSString *)networkOperator
{
    if ([SL_Utils getDeviceType] == Device_iPhone)
    {
//        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//        CTCarrier *carrier = info.subscriberCellularProvider;
//        return carrier.currentRadioAccessTechnology ? carrier.currentRadioAccessTechnology : @"";
        
        
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//        NSLog(@"%@", networkInfo.currentRadioAccessTechnology);
        
        return networkInfo.currentRadioAccessTechnology;
    }
    else return @"";
}


/* China - CN
 * MCC    MNC    Brand    Operator                Status        Bands (MHz)                                    References and notes
 * 460    00            China Mobile            Operational    GSM 900/GSM 1800 UMTS (TD-SCDMA) 1880/2010
 * 460    01            China Unicom            Operational    GSM 900/GSM 1800/ UMTS 2100                    CDMA network sold to China Telecom, WCDMA commercial trial started in May 2009 and in full commercial operation as of October 2009.
 * 460    02            China Mobile            Operational    GSM 900/GSM 1800/ UMTS (TD-SCDMA) 1880/2010
 * 460    03            China Telecom            Operational    CDMA 800/cdma evdo 2100
 * 460    05            China Telecom            Operational
 * 460    06            China Unicom            Operational    GSM 900/GSM 1800/UMTS 2100
 * 460    07            China Mobile            Operational    GSM 900/GSM 1800/UMTS (TD-SCDMA) 1880/2010
 * 460    20            China Tietong            Operational    GSM-R
 * NA    NA            China Telecom&China Unicom    Operational
 */

+ (NSString*)getCarrier
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString * mcc = [carrier mobileCountryCode];
    NSString * mnc = [carrier mobileNetworkCode];
    if (mnc == nil || mnc.length <1 || [mnc isEqualToString:@"SIM Not Inserted"] ) {
        return @"Unknown";
    }else {
        if ([mcc isEqualToString:@"460"]) {
            NSInteger MNC = [mnc intValue];
            switch (MNC) {
                case 00:
                case 02:
                case 07:
                    return @"China Mobile";
                    break;
                case 01:
                case 06:
                    return @"China Unicom";
                    break;
                case 03:
                case 05:
                    return @"China Telecom";
                    break;
                case 20:
                    return @"China Tietong";
                    break;
                default:
                    break;
            }
        }
    }
    
    return@"Unknown";
}



+ (float)getFreeDiskspace {
    float totalFreeSpace=0.f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        // WXLog(@"Memory Capacity of %f GB with %f GB Free memory available.", totalSpace, totalFreeSpace);
    } else {
        //WXLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return totalFreeSpace;
}

+ (float)getIOSVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


+ (NSString *)getTotalDiskspace {
    float totalSpace = 0.f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
    } else {
        //WXLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return [NSString stringWithFormat:@"%0.2f",totalSpace];
}


//判断ios系统的通知开关是否开启
+ (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if (IOS8_OR_LATER) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}

//获取供应商ID
+ (NSString*)getVendorId
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}

//在主线程发送消息
+(void)postNotificationOnMainThreadMessage:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    if( [NSThread currentThread] != [NSThread mainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
        });
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
    }
}

+ (NSString *)strWithDic:(NSDictionary *)dic
{
    NSMutableString *result = [NSMutableString string];
    
    //排序
    NSArray *sortArray = [dic.allKeys sortedArrayUsingSelector:@selector(compare:)];

        for (NSString *key in sortArray) {
        [result appendFormat:@"%@=%@&",key,dic[key]];
    }
    
    if (result.length > 0) {
        [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
    }
    
    return result;
}


+(NSString*) getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

//单独设置UA参数
+ (void) setUserAgentWithKey:(NSString*)key value:(NSString*)value
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    if([secretAgent containsString:key])
    {
        return;
    }
    NSString *newUagent = [NSString stringWithFormat:@"%@ %@(%@)",secretAgent , key, value];
    NSDictionary *dictionary = [[NSDictionary alloc]
                                initWithObjectsAndKeys:newUagent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}


+(BOOL)isNetAvilable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    return isExistenceNetwork;
    
//    BOOL bEnabled = FALSE;
//    NSString *url = @"www.baidu.com";
//    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
//    SCNetworkReachabilityFlags flags;
//    
//    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
//    
//    CFRelease(ref);
//    if (bEnabled) {
//        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
//        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
//        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
//        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
//        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
//        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
//        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
//    }
//    
//    return bEnabled;
}


@end
