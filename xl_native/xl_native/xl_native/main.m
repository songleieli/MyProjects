
//  main.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/10.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateBase.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *startAppDelegate = [GlobalFunc sharedInstance].gWCOnbConfiguration.startAppDelegate;
        if(startAppDelegate == nil || [startAppDelegate isEqualToString:@""] == YES){
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegateBase class]));
        }
        else{
            return UIApplicationMain(argc, argv, nil, startAppDelegate);
        }
    }
}
