//
//  NSObject+JSON.m
//  
//
//  Created by liuhui on 15/8/6.
//
//

#import "NSObject+JSON.h"
#import "JSONKit.h"

@implementation NSObject (JSON)

- (NSString *)JSONRepresentation {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    NSLog(@"Not valid type for JSON");
    return nil;
}

@end

@implementation NSString (JSON)

//- (id)JSONValue
//{
//    NSData* jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *resultDict = [jsonData objectFromJSONData];
//    return resultDict;
//}

- (id)JSONValue {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"	"withString:@"    "];
    string = [string stringByReplacingOccurrencesOfString:@"	\t"withString:@"    "];
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [jsonData JSONValue];
    if(json == nil)
    {
        NSString *trimmedString = [[string componentsSeparatedByCharactersInSet: [NSCharacterSet controlCharacterSet]]componentsJoinedByString: @""];
        NSData *jsonData = [trimmedString dataUsingEncoding:NSUTF8StringEncoding];
        json = [jsonData JSONValue];
    }
    return json;
}


@end

@implementation NSData (JSON)

- (id)JSONValue {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self options: NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    else {
        return json;
    }
}

@end
