//
//  weeklyContract.h
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "arrayManager.h"
#import "taconfig.h"

@class contractSchedule;
//
//  player information that is tied to this particular contract.  accretive to info in player database
//
@interface contractPlayer : NSObject
{
    NSNumber *playerIndex;                        // index into the player array.
    NSNumber *preferredNumberOfWeeks;             // preferred number of weeks to play.  slider from 1 to numAvailable weeks
    NSNumber *actualNumberOfWeeks;                // how many weeks they wind up playing.  Will be calculated.
    NSNumber *totalPlayerCost;                    // how much this player will need to pay.  calculated from contract and actual playing time.
}

@property (nonatomic, retain) NSNumber  *playerIndex, *preferredNumberOfWeeks, *actualNumberOfWeeks, *totalPlayerCost;

-(id)initWithDictionary: (NSDictionary *)playerDict;
-(NSString *)toJSON;
@end

//
//  information that describes one week of a multi-week contract
//
@interface weeklySchedule: NSObject         // this includes blocked and playable weeks.
{
    NSNumber *weekNumber;                    // which week this is
    NSDate *dateTime;                       // specifically when is this contract
    NSNumber *isBlocked;                     // courts not avaialble this week.
    NSMutableArray *scheduledPlayers;       // array of indices into contract for who is playing.
    NSMutableArray *blockedPlayers;         // who can't play this week.
    contractSchedule *myContract;           // who I came from.
}
@property (nonatomic, retain) NSNumber *weekNumber;
@property (nonatomic, retain) NSNumber *isBlocked;
@property (nonatomic, retain) NSDate *dateTime;
@property (nonatomic, retain) NSMutableArray *scheduledPlayers, *blockedPlayers;
@property (nonatomic, retain) contractSchedule *myContract;

-(id)initWithDictionary: (NSDictionary *)playerDict andParent: (contractSchedule *)cs;
-(NSString *)toJSON;
-(BOOL) isEqual:(id)object;
@end

//
//  information that describes a multi-week contract
//
@interface contractSchedule : NSObject
{
    NSDate *contractCreated;                // when contract was first created
    NSDate *contractLastModified;           // when last modified
    NSDate *contractStart;                  // day of the week schedule starts
    NSNumber *durationInMinutes;
    NSNumber *numCalendarWeeks;             // how many weeks form startdate
    NSNumber *numPlayableWeeks;             // how many weeks the courts are available (actual contract time)
    NSNumber *numPlayersNeeded;             // how may guys do we need each week (4 for doubles)
    NSNumber *placeIndex;                   // -1 = unassigned; otherwise this is an index in the place array
    NSNumber *contractFixedCourtCosts;      // fixed per contract costs
    NSNumber *contractWeeklyCourtCosts;     // varable costs of the court per week.  will be multipled by numPlayeableWeeks.  typically balls, court time.
    NSNumber *contractFixedPerPlayerCosts;  // fixed one time costs per player.  usually membership.
    NSNumber *contractWeeklyPerPlayerCosts; // costs attributed to the players that are scheduled per play.  may be zero.
    arrayManager *contractPlayers;          // array of information for each of the players that are part of this contract.
    NSMutableArray *alternatePlayers;       // subset of contacts that are considered alternates.  index into contacts
    arrayManager *weeklySchedule;           // will contain objects of type weekSchedule
}

@property (nonatomic, retain) NSNumber *durationInMinutes, *numCalendarWeeks, *numPlayableWeeks, *numPlayersNeeded, *placeIndex;
@property (nonatomic, retain) NSNumber *contractFixedCourtCosts, *contractWeeklyCourtCosts, *contractFixedPerPlayerCosts, *contractWeeklyPerPlayerCosts;
@property (nonatomic, retain) NSDate *contractCreated, *contractLastModified, *contractStart;
@property (nonatomic, retain) NSMutableArray *alternatePlayers;
@property (nonatomic, retain) arrayManager *contractPlayers, *weeklySchedule;


-(id)initWithDictionary: (NSDictionary *)playerDict;
-(id) init;
-(NSString *)toJSON;
-(BOOL) isEqual:(contractSchedule *)newSchedule;
-(BOOL) isNewerThan: (contractSchedule *)newPlace;

@end


