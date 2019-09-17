//
//  placeManager.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "placeManager.h"

@implementation placeManager

@synthesize myArray;

-(id) initWithArray:(NSArray *)placeArray
{
    if((self = [super init]) == nil)
        return nil;
    
    myArray = [NSMutableArray array];
    for(NSDictionary *nextContact in placeArray) {
        taPlace *nextPlace = [[taPlace alloc]initWithDictionary:nextContact];
        [myArray addObject:nextPlace];
    }
    
    return self;
}

-(NSString *) toJSON
{
    NSString *rets = @"[\n";
    for(int i =0; i< [myArray count]; ) {
        
        rets = [rets stringByAppendingString:[[myArray objectAtIndex:i++] toJSON]];   //
        if(i < [myArray count])
            rets = [rets stringByAppendingString:@",\n"];
    }
    
    rets = [rets stringByAppendingString:@"]\n"];
    return rets;
}
@end
