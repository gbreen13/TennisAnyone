//
//  arrayManager.m
//  Tennis Anyone
//
//  Created by George Breen on 12/25/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "arrayManager.h"
#import "taPlayer.h"
#import "taPlace.h"
#import "weeklyContract.h"
#import "singleMatch.h"

@implementation arrayManager
@synthesize myArray;

-(id) initWithArray:(NSArray *)playerArray andClass: (Class)objClass
{
    if((self = [super init]) == nil)
        return nil;
    
    myArray = [NSMutableArray array];
    for(NSDictionary *nextContact in playerArray) {
        id nextPlayer = [[[objClass class] alloc] initWithDictionary:nextContact];
        [myArray addObject:nextPlayer];
    }
    
    return self;
}

-(id)initWithArray:(NSArray *)playerArray andClass: (Class)objClass andParent: (id)parent;
{
    if((self = [super init]) == nil)
        return nil;
    
    myArray = [NSMutableArray array];
    for(NSDictionary *nextContact in playerArray) {
        id nextPlayer = [[[objClass class] alloc] initWithDictionary:nextContact andParent:parent];
        [myArray addObject:nextPlayer];
    }
    
    return self;
}

-(id) init{
    if((self = [super init]) == nil)
        return nil;
    
    myArray = [NSMutableArray array];
    return self;
}

-(NSString *) toJSON
{
    if([myArray count] <= 0) return @"";
    id arrType = [myArray objectAtIndex:0];
    if (arrType == nil) return @"";
    NSString *rets;
    
    if([arrType isKindOfClass:[taPlayer class]])
        rets = @"\"players\"";
    else if([arrType isKindOfClass:[taPlace class]])
        rets = @"\"places\"";
    else if([arrType isKindOfClass:[contractSchedule class]])
        rets = @"\"contractSchedules\"";
    else if([arrType isKindOfClass:[singleMatch class]])
        rets = @"\"singleMatches\"";
    else if([arrType isKindOfClass:[contractPlayer class]])
        rets = @"\"contractPlayers\"";
    else if([arrType isKindOfClass:[weeklySchedule class]])
        rets = @"\"weeklySchedule\"";
    else return @"";
    
    rets = [rets stringByAppendingString:@" : ["];
    NSString *comma = @" ";
    for (id nextPlayer in myArray) {
        rets = [rets stringByAppendingFormat:@"\n%@\n%@", comma, [nextPlayer toJSON]];
        comma = @",";
    }
    
    rets = [rets stringByAppendingString:@"\n]"];
    return rets;
}

@end
