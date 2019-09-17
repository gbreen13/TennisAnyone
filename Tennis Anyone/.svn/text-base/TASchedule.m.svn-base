//
//  TASchedule.m
//  Tennis Anyone
//
//  Created by George Breen on 12/21/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "TASchedule.h"

taSchedule *sharedTaSchedule;        // singleton

@implementation taSchedule

@synthesize fileType, majorVer, minorVer, places, contractSchedules, singleMatches, players, scheduleCreate, scheduleLastModified, unassigned, unassignedPlace;

+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(id) initWithURL:(NSURL *)url andError: (NSError **)error;
{
    if((self = [super init]) == nil)
        return nil;

    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    
    if(!json) {
        NSLog(@"ERROR:invalid schedule file");
        return nil;
    }
    
    self.unassigned = [[taPlayer alloc] init];
    self.unassignedPlace = [[taPlace alloc] init];
    self.players =  [[arrayManager alloc]initWithArray:[json objectForKey:@"players"] andClass:[taPlayer class]];
    self.places =  [[arrayManager alloc]initWithArray:[json objectForKey:@"places"] andClass:[taPlace class]];
    self.contractSchedules = [[arrayManager alloc]initWithArray:[json objectForKey:@"contractSchedules"] andClass:[contractSchedule class]];
    self.singleMatches = [[arrayManager alloc]initWithArray:[json objectForKey:@"singleMatches"] andClass:[singleMatch class]];
    return self;
}

-(id) init
{
    if((self = [super init]) == nil)
        return nil;
    scheduleCreate = [NSDate date];
    scheduleLastModified = [NSDate date];
    self.places = [[arrayManager alloc]init];
    self.players = [[arrayManager alloc] init];
    self.contractSchedules = [[arrayManager alloc] init];
    self.singleMatches = [[arrayManager alloc] init];
    self.unassigned = [[taPlayer alloc] init];
    self.unassignedPlace = [[taPlace alloc] init];
    
    return self;
}

-(BOOL) validate:(NSURL *)url
{
    return TRUE;    // for now..
}

-(NSString *)toJSON
{
    NSString *rets = @"\n{\n";
    NSString *comma = @"";
    rets = [rets stringByAppendingFormat:@"%@\n\"fileType\":\"%@\"", comma, @"TennisAnyoneSchedule"]; comma = @",";
    rets = [rets stringByAppendingFormat:@"%@\n\"versionMajor\":\"%d\"", comma, VERSION_MAJOR]; comma = @",";
    rets = [rets stringByAppendingFormat:@"%@\n\"versionMinor\":\"%d\"", comma, VERSION_MINOR]; comma = @",";
    if(players && [players.myArray count]) {rets = [rets stringByAppendingFormat:@"%@%@ ", comma, [players toJSON]]; comma = @",";}
    if(places && [places.myArray count]) {rets = [rets stringByAppendingFormat:@"%@%@\n ", comma, [places toJSON]];comma = @",";}
    if(contractSchedules && [contractSchedules.myArray count]) {rets = [rets stringByAppendingFormat:@"%@%@\n ", comma, [contractSchedules toJSON]];comma = @",";}
    if(singleMatches && [singleMatches.myArray count]) {rets = [rets stringByAppendingFormat:@"%@%@", comma, [singleMatches toJSON]];}
    rets = [rets stringByAppendingString:@"\n}"];
    return rets;
}

//
//  Create a new schedule that only contains this contract schedule.
//
//  players - only players referenced by this contract (players and alternates) are saved.
//  place = only the place this contract is played is saved.
//  contractSchedules = only this one contract is saved (player indexes adjusted to match new player list)
//  single Matchs - none.
//

-(taSchedule *) extractContract: (contractSchedule *) scheduleToExtract
{
 
    if(![[contractSchedules myArray] containsObject:scheduleToExtract])
        return nil;
    
    taSchedule *newSchedule = [[taSchedule alloc]init];     // create a new overall schedule
    contractSchedule *newContract = [[contractSchedule alloc]init];
    
//
//  Build an array of only the players that matter (thos referenced by this contract).
//
    NSMutableArray *contractPlayers = [[scheduleToExtract contractPlayers]myArray];

    // get the list of contract players and save the play info
    
    for(contractPlayer *cp in contractPlayers) {                // add contract players (once)
        NSNumber *i = [cp playerIndex];
        if(![[[newSchedule players]myArray] containsObject:[[players myArray] objectAtIndex:[i integerValue]]]) {
            [[[newSchedule players]myArray] addObject:[[players myArray] objectAtIndex:[i integerValue]]];
        }
    }
 
    for(NSNumber *i in [scheduleToExtract alternatePlayers]) {   // add alternate players (once)
        if(![[[newSchedule players]myArray] containsObject:[[players myArray] objectAtIndex:[i integerValue]]]) {
            [[[newSchedule players]myArray] addObject:[[players myArray] objectAtIndex:[i integerValue]]];
        }
    }
    
    NSMutableArray *newPlace = [[NSMutableArray alloc]initWithObjects:[[places myArray] objectAtIndex:[scheduleToExtract.placeIndex integerValue]], nil];

    newSchedule.places = [[arrayManager alloc]init];
    newSchedule.places.myArray = newPlace;
//
//  Build the new contract.  creation and last mod date are now and already filled in by constructor
//
    newContract.contractStart = scheduleToExtract.contractStart;
    newContract.durationInMinutes = scheduleToExtract.durationInMinutes;
    newContract.numCalendarWeeks = scheduleToExtract.numCalendarWeeks;
    newContract.numPlayableWeeks = scheduleToExtract.numPlayableWeeks;
    newContract.numPlayersNeeded = scheduleToExtract.numPlayersNeeded;
    newContract.placeIndex = [NSNumber numberWithInt:0];
    newContract.contractFixedCourtCosts = scheduleToExtract.contractFixedCourtCosts;
    newContract.contractWeeklyCourtCosts = scheduleToExtract.contractWeeklyCourtCosts;
    newContract.contractFixedPerPlayerCosts = scheduleToExtract.contractFixedPerPlayerCosts;
    newContract.contractWeeklyPerPlayerCosts = scheduleToExtract.contractWeeklyPerPlayerCosts;
    newContract.contractPlayers = [[arrayManager alloc]init];
    
    for(contractPlayer *cp in contractPlayers) {
        contractPlayer *newContractPlayer = [[contractPlayer alloc]init];
        newContractPlayer.preferredNumberOfWeeks = cp.preferredNumberOfWeeks;
        newContractPlayer.actualNumberOfWeeks = cp.actualNumberOfWeeks;
        newContractPlayer.totalPlayerCost = cp.totalPlayerCost;
        newContractPlayer.playerIndex = [NSNumber numberWithInteger:[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[cp.playerIndex integerValue]]]];
        [[newContract.contractPlayers myArray] addObject:newContractPlayer];
    }
    
    newContract.alternatePlayers = [[NSMutableArray alloc]init];
    for(NSNumber *oldIndex in [scheduleToExtract alternatePlayers]) {   // add alternate players (once)
        int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[oldIndex integerValue]]];
        [[newContract alternatePlayers] addObject:[NSNumber numberWithInteger:newindex]];
    }

    newContract.weeklySchedule = scheduleToExtract.weeklySchedule;          // same schedule
    
    for(weeklySchedule *ws in [[scheduleToExtract weeklySchedule]myArray]) {
        NSMutableArray *newScheduledPlayers = [[NSMutableArray alloc]init];
        for (NSNumber *pl in [ws scheduledPlayers]) {
            int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[pl integerValue]]];
            [newScheduledPlayers addObject:[NSNumber numberWithInteger:newindex]];
        }
        ws.scheduledPlayers = newScheduledPlayers;
        NSMutableArray *newBlockedPlayers = [[NSMutableArray alloc]init];
        for (NSNumber *pl in [ws blockedPlayers]) {
            int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[pl integerValue]]];
            [newBlockedPlayers addObject:[NSNumber numberWithInteger:newindex]];
        }
        ws.BlockedPlayers = newBlockedPlayers;
    }
    newSchedule.contractSchedules = [[arrayManager alloc]init];
    [[newSchedule.contractSchedules myArray] addObject:newContract];
    
    newSchedule.singleMatches = nil;
    
    return newSchedule;
}

//
//  Extract a single match from the schedule and return a fully formed schedule with just this match.
//  we ensure that only the referenced players are put into the schedule.
//
-(taSchedule *) extractSingleMatch: (singleMatch *) sMatch
{
    if(![[singleMatches myArray] containsObject:sMatch])
        return nil;
    
    taSchedule *newSchedule = [[taSchedule alloc]init];     // create a new overall schedule
    singleMatch *newMatch = [[singleMatch alloc]init];
    
//
//  Only keep track of the players that matter in this match and only the place that it is being played.
//
//
    for(NSNumber *i in sMatch.invitedPlayers) {                // add contract players (once)
        if(![[[newSchedule players]myArray] containsObject:[[players myArray] objectAtIndex:[i integerValue]]]) {
            [[[newSchedule players]myArray] addObject:[[players myArray] objectAtIndex:[i integerValue]]];
        }
    }
    for(NSNumber *i in sMatch.acceptedPlayers) {                // add contract players (once)
        if(![[[newSchedule players]myArray] containsObject:[[players myArray] objectAtIndex:[i integerValue]]]) {
            [[[newSchedule players]myArray] addObject:[[players myArray] objectAtIndex:[i integerValue]]];
        }
    }
    for(NSNumber *i in sMatch.rejectedPlayers) {                // add contract players (once)
        if(![[[newSchedule players]myArray] containsObject:[[players myArray] objectAtIndex:[i integerValue]]]) {
            [[[newSchedule players]myArray] addObject:[[players myArray] objectAtIndex:[i integerValue]]];
        }
    }
    
    newMatch.matchCreated = sMatch.matchCreated;
    newMatch.matchLastModified = sMatch.matchLastModified;
    newMatch.matchStart = sMatch.matchStart;
    newMatch.durationInMinutes = sMatch.durationInMinutes;
    newMatch.numPlayersNeeded = sMatch.numPlayersNeeded;
    newMatch.placeIndex = [NSNumber numberWithInt:0];
    
    NSMutableArray *newPlace = [[NSMutableArray alloc]initWithObjects:[[places myArray] objectAtIndex:[sMatch.placeIndex integerValue]], nil];

    newSchedule.places = [[arrayManager alloc]init];
    newSchedule.places.myArray = newPlace;
    
    newMatch.invitedPlayers = [[NSMutableArray alloc]init];
    newMatch.rejectedPlayers = [[NSMutableArray alloc]init];
    newMatch.acceptedPlayers = [[NSMutableArray alloc]init];

    for (NSNumber *pl in [sMatch invitedPlayers]) {
        int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[pl integerValue]]];
        [newMatch.invitedPlayers addObject:[NSNumber numberWithInteger:newindex]];
    }
    for (NSNumber *pl in [sMatch acceptedPlayers]) {
        int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[pl integerValue]]];
        [newMatch.acceptedPlayers addObject:[NSNumber numberWithInteger:newindex]];
    }
    for (NSNumber *pl in [sMatch rejectedPlayers]) {
        int newindex = (int)[[[newSchedule players]myArray] indexOfObject:[[players myArray] objectAtIndex:[pl integerValue]]];
        [newMatch.rejectedPlayers addObject:[NSNumber numberWithInteger:newindex]];
    }
    newSchedule.singleMatches = [[arrayManager alloc]init];
    [[newSchedule.singleMatches myArray] addObject:newMatch];
    
    newSchedule.contractSchedules = nil;
    
    return newSchedule;
}

//
//  Complicated merged.
//  1. players.  If player in new schedule does not exist, need to add the player to the end of the player array.  All subsequent references
//      to players in the contract schedules and single matches need to be realigned with the new player arry indices.  If player does exist then use latest version.
//
//  2. single matches.  If the match is the same but the modification dates are different, merge invited players and use the last known accepted and rejected players ?
//
//  3. places.  if place does'nt exist then add to the end and readjust placeIndex in matches.  If it does exist, the use latest version.
//
//  4. contract matches.  If contact is same, use latest version.
//
- (int) getIndexOfPlace: (taPlace *)p
{
    int i = -1;
    
    for(taPlace *tp in [places myArray]) {
        
        if([tp isEqual:p])
            return ++i;
        else
            ++i;
    }
    return -1;
}

- (int) getIndexOfPlayer: (taPlayer *)p
{
    int i = -1;
    
    for(taPlayer *tp in [players myArray]) {
        
        if([tp isEqual:p])
            return ++i;
        else
            ++i;
    }
    return -1;
}

- (int) getIndexOfSingleMatch: (singleMatch *)sm
{
    int i = -1;
    
    for(singleMatch *s in [singleMatches myArray]) {
        
        if([s isEqual:sm])
            return ++i;
        else
            ++i;
    }
    return -1;
}

- (int) getIndexOfContractSchedule: (contractSchedule *)sm
{
    int i = -1;
    
    for(contractSchedule *s in [self.contractSchedules myArray]) {
        
        if([s isEqual:sm])
            return ++i;
        else
            ++i;
    }
    return -1;
}

-(BOOL) mergeTASchedule: (taSchedule *)newTASchedule                                   // merge self with new schedule
{
    int newPlaceIndex[MAX_PLACES];
    int newPlayerIndex[MAX_PLAYERS];
//
//  Start by merging the places into one long array;  If we find the place in the original list then we replace if the new one is newer, otherwise use it.
//  if it's not in the original list, tack on to the end.   Keep track of where we put the place in the new list so we can later change references in the
//  merged schedules.
    
    for(int i=0; i< MAX_PLACES; i++) newPlaceIndex[i] = -1;
    
    int i = 0;
    
    for(taPlace *tp in [[newTASchedule places] myArray]) {
        int newind;
        if((newind = [self getIndexOfPlace:tp]) != -1) {
            newPlaceIndex[i] = newind;
            if([tp isNewerThan:[[places myArray] objectAtIndex:newind]]) {
                [[places myArray] replaceObjectAtIndex:newind withObject:tp];
            }
        } else {
            newPlaceIndex[i] = (int)[[places myArray] count];
            [[places myArray] addObject:tp];
        }
        i++;
    }
//
//  Now, merge the players into one long array;  Uses the same logic as above.
//
    
    for(int i=0; i< MAX_PLAYERS; i++) newPlayerIndex[i] = -1;
    
    i = 0;
    
    for(taPlayer *tp in [[newTASchedule players] myArray]) {
        int newind;
        if((newind = [self getIndexOfPlayer:tp]) != -1) {
            newPlayerIndex[i] = newind;
            if([tp isNewerThan:[[players myArray] objectAtIndex:newind]]) {
                [[players myArray] replaceObjectAtIndex:newind withObject:tp];
            }
        } else {
            newPlayerIndex[i] = (int)[[players myArray] count];
            [[players myArray] addObject:tp];
        }
        i++;
    }
//
//  Now, any place or player in the newTAschedule has a reference in the original schedule and the mappig
//  is in newPlaceIndex or newPlayerIndex;
//
    NSArray *newSingleMatches;
    
    if ([newTASchedule singleMatches] && ((newSingleMatches = [[newTASchedule singleMatches] myArray]) != nil))
    {
//
//  only replace single MAtches that are newer.
//
        for(singleMatch *nextsm in newSingleMatches) {

            int j = newPlaceIndex[[[nextsm placeIndex] integerValue]];      // update place index to point to merged group.
            nextsm.placeIndex = [NSNumber numberWithInt:j];
            
            // map indices to new array.
            
            for(i =0; i< [[nextsm invitedPlayers] count]; i++ ) {
                NSNumber *nextPlayer = [[nextsm invitedPlayers] objectAtIndex: i];
                [nextsm.invitedPlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
            }
            
            for(i =0; i< [[nextsm acceptedPlayers] count]; i++ ) {
                NSNumber *nextPlayer = [[nextsm acceptedPlayers] objectAtIndex: i];
                [nextsm.acceptedPlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
            }
            
            for(i =0; i< [[nextsm rejectedPlayers] count]; i++ ) {
                NSNumber *nextPlayer = [[nextsm rejectedPlayers] objectAtIndex: i];
                [nextsm.rejectedPlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
            }
            
            int newind;
            if((newind = [self getIndexOfSingleMatch:nextsm]) != -1) {
                if([nextsm isNewerThan:[[singleMatches myArray] objectAtIndex:newind]]) {
                    //
                    //  update the players indecies
                    //
                    
                    [[[self singleMatches] myArray] replaceObjectAtIndex:newind withObject:nextsm];
                }
            } else {
                [[[newTASchedule singleMatches] myArray] addObject:nextsm];
            }
        
        }
    }
    
    NSArray *newContractSchedules;
    
    if ([newTASchedule contractSchedules] && ((newContractSchedules = [[newTASchedule contractSchedules] myArray]) != nil))
    {
        for(contractSchedule *nextcs in newContractSchedules) {
            
        //
        //  only merge in new contracts or update if the one to merge in is newer.
        //
            int newind;
            newind = [self getIndexOfContractSchedule:nextcs];
            
            if((newind != -1) && (([nextcs isNewerThan:[[contractSchedules myArray] objectAtIndex:newind]])))
                continue;           // we already have this contract and it is the newest.  Skip merging this one.
        
            int j = newPlaceIndex[[[nextcs placeIndex] integerValue]];      // update place index to point to merged group.
            nextcs.placeIndex = [NSNumber numberWithInt:j];
        //
        //  update the player references in the contractPlayers section to point to the new indices
        //
            for(contractPlayer *cp in [nextcs.contractPlayers myArray]) {
                NSNumber *pi = cp.playerIndex;
                cp.playerIndex = [NSNumber numberWithInt:newPlayerIndex[[pi integerValue]]];
            }
        //
        //  now alternate players.
        //
            
            for(i =0; i< [[nextcs alternatePlayers] count]; i++ ) {
                NSNumber *nextPlayer = [[nextcs alternatePlayers] objectAtIndex: i];
                [nextcs.alternatePlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
            }
        //
        //  finally, walk through the weeks for thi schedule and update the scheduled and blocked player arrays.
        //
            NSArray *newWeeklySchedules;
            if ((nextcs.weeklySchedule) && ((newWeeklySchedules = [nextcs.weeklySchedule myArray]) != nil))
            {
                //
                //  only replace single MAtches that are newer.
                //
                for(weeklySchedule *nextcs in newWeeklySchedules) {
                    for(i =0; i< [[nextcs scheduledPlayers] count]; i++ ) {
                        NSNumber *nextPlayer = [[nextcs scheduledPlayers] objectAtIndex: i];
                        [nextcs.scheduledPlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
                    }
                    
                    for(i =0; i< [[nextcs blockedPlayers] count]; i++ ) {
                        NSNumber *nextPlayer = [[nextcs blockedPlayers] objectAtIndex: i];
                        [nextcs.blockedPlayers replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:newPlayerIndex[[nextPlayer integerValue]]]];
                    }
                }
            }
    
    //
    //  update the players indecies
    //
            if(newind != -1)
                [[[self contractSchedules] myArray] replaceObjectAtIndex:newind withObject:nextcs];
            else
                [[[newTASchedule singleMatches] myArray] addObject:nextcs];
        }
    }
    NSError *error = nil;
    [sharedFileManager saveSharedScheduleFile:&error];
    return TRUE;
}


//
//  returns the next item in the schedule that is after the current date.  will return either either
//  a single match or a weekly schedule part of a contract.  The date of the item is returned in retDate.
//  if there isn't one, return is NULL and retDate contents are unpredictable.
//
-(id) findNextThingAfter: (NSDate *)lastDate returnDate: (NSDate **)retDate;
{
    id currentWinner = nil;
    NSDate *nextBest;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:10];
    [comps setMonth:10];
    [comps setYear:3010];       // far future;
 
    nextBest = [[NSCalendar currentCalendar] dateFromComponents:comps];
 
    for(contractSchedule *nextcs in [contractSchedules myArray]) {
        for (weeklySchedule *ws in [[nextcs weeklySchedule] myArray]) {
            if(([(ws.dateTime) compare :lastDate] == NSOrderedDescending) &&
               !([ws.dateTime compare:nextBest] == NSOrderedDescending)) {  // if this is later than start date but younger than last
                nextBest = ws.dateTime;
                currentWinner = ws;
            }
        }
    }
    
    for(singleMatch *nextsm in [singleMatches myArray]) {
        if(([(nextsm.matchStart) compare :lastDate] == NSOrderedDescending) &&    // later than date passed in
           !([nextsm.matchStart compare:nextBest] == NSOrderedDescending)) {  // earlier than last we tracked.
            nextBest = nextsm.matchStart;
            currentWinner = nextsm;
        }
    }
    
    *retDate = nextBest;
    return currentWinner;
}
//
//  Get a batch of the next matches.  They have to be after the passed in startdate and up to count.
//  a match could be a single match or a contract match from a weekly contract.
//
//  return an array that contains single matches or weekly schedules.
//
-(NSMutableArray *)getNextMatchesFromDate: (NSDate *)startDate forCount:(int)count
{
    NSMutableArray *reta = [NSMutableArray array];
    NSDate *retDate = startDate;
    
    
    while (count--) {
        id retval= [self findNextThingAfter: startDate returnDate: &retDate];
        if(retval) {
            startDate = retDate;
            [reta addObject:retval];
        }
        else
            break;
    }
    return reta;
}
//
//  Get a batch of the next matches.  They have to be after the passed in startdate and up to count.
//  a match could be a single match or a contract match from a weekly contract.
//
//  return an array that contains single matches or weekly schedules.
//
-(NSMutableArray *)getContractSchedules
{
    NSMutableArray *reta = [NSMutableArray array];
    
    for(contractSchedule *cs in [contractSchedules myArray]) {
        [reta addObject:cs];
    }
    return reta;
}

-(taPlayer *)getPlayerFromIndex: (NSNumber *)index
{
    int i = (int)[index integerValue];
    if((i == -1) || (i >= [[players myArray]count]))
        return unassigned;
    
    return ([[players myArray] objectAtIndex:i]);
}
-(taPlace *)getPlaceFromIndex: (NSNumber *)index
{
    int i = (int)[index integerValue];
    if((i == -1) || (i >= [[places myArray]count]))
        return unassignedPlace;
    
    return ([[places myArray] objectAtIndex:i]);
}

-(void) addPlayer: (taPlayer *)player
{
    [[players myArray] addObject:player];
}

-(singleMatch *) replaceSingleMatch: (singleMatch *)match with: (singleMatch *)newMatch
{
    int i= 0;
    for(singleMatch *next in [singleMatches myArray]) {
        if([next isEqual:match]) {
            newMatch.matchLastModified = [NSDate date];
            [[singleMatches myArray]replaceObjectAtIndex:i withObject:newMatch];
            return newMatch;
        }
        i++;
    }
    return nil;
}

-(singleMatch *) addSingleMatch: (singleMatch *) newMatch
{
    newMatch.matchLastModified = [NSDate date];
    [[singleMatches myArray] addObject:newMatch];
    return newMatch;
}

-(BOOL) deleteSingleMatch: (singleMatch *)match
{
    int i = 0;
    for(singleMatch *next in [singleMatches myArray]) {
        if([next isEqual:match]) {
            [[singleMatches myArray]removeObjectAtIndex:i];
            return YES;
        }
        i++;
    }
    return NO;
}

@end
