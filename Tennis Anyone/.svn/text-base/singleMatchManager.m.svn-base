//
//  singleMatchManager.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "singleMatchManager.h"

@implementation singleMatchManager
@synthesize myArray;

-(id) initWithArray:(NSArray *)jarray
{
    if((self = [super init]) == nil)
        return nil;
    
    myArray = [NSMutableArray array];
    for(NSDictionary *nextSingleMatch in jarray) {
        singleMatch *nextMatch = [[singleMatch alloc]initWithDictionary:nextSingleMatch];
        [myArray addObject:nextMatch];
    }
    
    return self;
}
-(NSString *)toJSON
{
    return @"";
}

@end
