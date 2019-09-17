//
//  singleMatch.h
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "taconfig.h"

@interface singleMatch : NSObject <NSCopying>
{
    NSDate *matchCreated;                    // when contract was first created
    NSDate *matchLastModified;               // when last modified
    NSDate *matchStart;                      // day of the week schedule starts
    NSNumber *durationInMinutes;
    NSNumber *numPlayersNeeded;
    NSNumber *placeIndex;                    // -1 = unassigned;
    NSMutableArray *invitedPlayers;          // who's invited
    NSMutableArray *acceptedPlayers;         // who's invited
    NSMutableArray *rejectedPlayers;         // who can't play
}

@property (nonatomic, retain) NSDate *matchCreated, *matchLastModified, *matchStart;
@property (nonatomic, retain) NSNumber *durationInMinutes, *numPlayersNeeded, *placeIndex;
@property (nonatomic, retain) NSMutableArray *invitedPlayers, *acceptedPlayers, *rejectedPlayers;

-(id)initWithDictionary: (NSDictionary *)playerDict;
-(id)init;
-(BOOL) isEqual:(singleMatch *)newMatch;
-(BOOL) isNewerThan: (singleMatch *)newMatch;
-(NSString *)toJSON;

@end
