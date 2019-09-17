//
//  TASchedule.h
//  Tennis Anyone
//
//  Created by George Breen on 12/21/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "taconfig.h"
#import "fileManager.h"
#import "arrayManager.h"
#import "taPlace.h"
#import "taPlayer.h"
#import "weeklyContract.h"
#import "singleMatch.h"


@interface taSchedule : NSObject
{
    NSString *fileType;
    NSDate *scheduleCreate;                 // when was this scheduled created
    NSDate *scheduleLastModified;           // when last changed.
    
    int majorVer;
    int minorVer;
    taPlayer *unassigned;                   // placeholder for player with index -1 (unassigned)
    taPlace *unassignedPlace;
    arrayManager *players;                  // sorted alphabetically (last, first)
    arrayManager *places;                   // sorted alphabetically
    arrayManager *contractSchedules;        // unsorted since it is a blend of single matches and contract weeks.
    arrayManager *singleMatches;
}

@property (nonatomic, retain) NSString *fileType;
@property (nonatomic) int minorVer, majorVer;
@property (nonatomic, retain) taPlayer *unassigned;
@property (nonatomic, retain) arrayManager *contractSchedules;
@property (nonatomic, retain) arrayManager *singleMatches;
@property (nonatomic, retain) arrayManager *players;
@property (nonatomic, retain) arrayManager *places;
@property (nonatomic, retain) NSDate *scheduleCreate, *scheduleLastModified;
@property (nonatomic, retain) taPlace *unassignedPlace;

+ (NSString *)applicationDocumentsDirectory;
-(BOOL) validate: (NSURL *) url;                                                        // return TRUE is valid TA Schedule object
-(id) initWithURL:(NSURL *)url andError: (NSError **)error;                              // file if it exists, allocates if not.
-(BOOL) saveTASchedule: (taSchedule *)taSchedule withError: (NSError **) errorPtr;      // saves (overwrites) database as a JSON file
-(NSString *)toJSON;                                                                    // convert entire database to a JSON file.

//
//  Overall Schedule routines.
//

-(BOOL) mergeTASchedule: (taSchedule *)newTASchedule;                                   // merge self with new schedule
                                                                                        // entire schedule.  Will force a
                                                                                        // schedule rebuild.
-(BOOL) rebuildSchedule;

-(NSMutableArray *)getNextMatchesFromDate: (NSDate *)startDate forCount:(int)count;     // returns next set of matches.  could be single matches or a match that
                                                                                        // is part of a contract schedule.
                                                                                        // if date is nil, than from the beginning.  If count <=0 then all
-(void) addContactToSchedule: (taPlayer *) player;                                      // Add a new player
-(void) addPlacesToSchedule: (taPlace *)place;                                          // add a new place
//
//  Contract specific routines
//
-(taSchedule *) extractContract: (contractSchedule *) scheduleToExtract;                // pull out this weekly schedule and make it a stand alone schedule
-(NSMutableArray *)getContractSchedules;                                                // return the contracts
-(contractSchedule *)replaceContractSchedule:(contractSchedule *)oldMatch with:(contractSchedule *)modifiedSchedule;
-(contractSchedule *)addContractSchedule: (contractSchedule *)schedule;
-(BOOL) deleteContractSchedule: (contractSchedule *)schedule;
//
//  Match specific routines
//
-(taSchedule *) extractSingleMatch: (singleMatch *) sMatch;                             // pull out this weekly schedule.
-(singleMatch *) replaceSingleMatch: (singleMatch *)match with: (singleMatch *)newMatch;
-(singleMatch *) addSingleMatch: (singleMatch *) match;
-(BOOL) deleteSingleMatch: (singleMatch *)match;
//
//  Player specific routines
//
-(void) addPlayer: (taPlayer *)player;
- (int) getIndexOfPlayer: (taPlayer *)p;
-(taPlayer *) getPlayerFromIndex: (NSNumber *)index;
-(BOOL) canDeletePlayer: (taPlayer *) player;       // onyl if not being used
-(BOOL) deletePlayerFromSchedule: (taPlayer *) player;          // delete player.  only if not being used.

//
//  Place specific routines
//
-(taPlace *)getPlaceFromIndex: (NSNumber *)index;
- (int) getIndexOfPlace: (taPlace *)p;

@end

extern taSchedule *sharedTaSchedule;        // singleton
