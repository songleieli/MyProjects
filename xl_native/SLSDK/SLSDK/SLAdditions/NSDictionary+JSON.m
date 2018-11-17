//
//  NSDictionary+JSON.m
//  VShang
//
//  Created by zs2 on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  @author liuhui

#import "NSDictionary+JSON.h"

@implementation NSDictionary(JSON)

- (id)objectForKeyIgnoreNull:(id)aKey{
    id value = [self objectForKey:aKey];
    if(!value) {
        return value; 
    }
    if([ value isEqual:[NSNull null]] || [ [value description]isEqualToString:@""] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    return value;
}
-(NSString *) stringForKey: (NSString *) key
{	
	id idObj = [self objectForKey:key];
	return (idObj && ![[idObj description] isEqualToString:@"<null>"]) ? [idObj description] :@"";

}

-(int) intForKey: (NSString *) key
{	
	return (int) [self longForKey: key];

}

-(NSArray *) arrayForKey: (NSString *) key
{	
	
	NSArray *aryReturn = [self objectForKey:key ];
    if (aryReturn && [aryReturn isKindOfClass:[NSArray class]]) {
        return aryReturn;
    }
	return nil;
}

-(BOOL) boolForKey: (NSString *)key
{	
	id idObj = [ self objectForKey:key];
	if(!idObj)
	{	
		return NO;
	}
	NSString *strReturn = [[idObj description] lowercaseString];
	return ([strReturn isEqualToString:@"1"] || [strReturn isEqualToString:@"true"] || [strReturn isEqualToString:@"yes"])?YES:NO;
}

-(long long) longForKey: (NSString *) key
{	
	NSString *strObj = [ self stringForKey:key];
	@try
	{	
		return [strObj longLongValue];
	}
	@
	catch (NSException *exception)
	{	
		return 0L;
	}

}

-(double) doubleForKey: (NSString *) key
{
	NSString *strObj = [ self stringForKey:key];
	@try
	{
		return [strObj doubleValue];
	}
	@catch (NSException *exception)
	{
		return 0;
	}
    
}

@end
