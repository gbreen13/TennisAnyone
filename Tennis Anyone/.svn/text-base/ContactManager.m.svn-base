//
//  ContactManager.m
//  Tennis Anyone
//
//  Created by George Breen on 12/22/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "ContactManager.h"

@implementation playerManager
@synthesize myArray;

-(id) initWithArray:(NSArray *)playerArray
{
    if((self = [super init]) == nil)
    return nil;
    
    myArray = [NSMutableArray array];
    for(NSDictionary *nextContact in playerArray) {
        taPlayer *nextPlayer = [[taPlayer alloc]initWithDictionary:nextContact];
        [myArray addObject:nextPlayer];
    }
    
    return self;
}

-(NSString *) toJSON
{
    NSString *rets = @"\"players\" [";
    NSString *comma = @" ";
    for (taPlayer *nextPlayer in myArray) {
        rets = [rets stringByAppendingFormat:@"\n%@\n%@", comma, [nextPlayer toJSON]];
        comma = @",";
    }

    rets = [rets stringByAppendingString:@"\n]"];
    return rets;
}

@end
