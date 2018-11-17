//
//  NSObject+JSON.h
//  
//
//  Created by liuhui on 15/8/6.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

- (NSString *)JSONRepresentation;

@end

@interface NSString (JSON)

- (id)JSONValue;

@end

@interface NSData (JSON)

- (id)JSONValue;

@end