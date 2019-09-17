//
//  weeklyContract.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "weeklyContract.h"


@implementation contractPlayer
@synthesize playerIndex, preferredNumberOfWeeks, actualNumberOfWeeks, totalPlayerCost;

-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    if([self playerIndex]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"playerIndex\":\"%@\"", comma, [self playerIndex]]; comma = @",";
    }
    if([self preferredNumberOfWeeks]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"preferredNumberOfWeeks\":\"%@\"", comma, [self preferredNumberOfWeeks]]; comma = @",";
    }
    if([self actualNumberOfWeeks]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"actualNumberOfWeeks\":\"%@\"", comma, [self actualNumberOfWeeks]]; comma = @",";
    }
    if([self totalPlayerCost]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"totalPlayerCost\":\"%@\"", comma, [self totalPlayerCost]];
    }
    rets = [rets stringByAppendingString:@"\n}\n"];
    return rets;
}

-(id)initWithDictionary: (NSDictionary *)contractPlayerDict
{
    if((self = [super init]) == nil)
        return nil;
    self.playerIndex = [contractPlayerDict objectForKey:@"playerIndex"];
    self.preferredNumberOfWeeks = [contractPlayerDict objectForKey:@"preferredNumberOfWeeks"];
    self.actualNumberOfWeeks = [contractPlayerDict objectForKey:@"actualNumberOfWeeks"];
    self.totalPlayerCost = [contractPlayerDict objectForKey:@"totalPlayerCost"];
    return self;
}

@end

@implementation weeklySchedule

@synthesize weekNumber, scheduledPlayers, blockedPlayers, dateTime , isBlocked, myContract;
-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    NSError *err;
    
    if([self weekNumber]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"weekNumber\":\"%@\"", comma, [self weekNumber]]; comma = @",";
    }
    if([self dateTime]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"matchStart\":\"%@\"", comma, [self dateTime]]; comma = @",";
    }
    if([self isBlocked]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"isBlocked\":\"%@\"", comma, (isBlocked.boolValue)?@"true":@"false"]; comma = @",";
    }
    if([self scheduledPlayers]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.scheduledPlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"scheduledPlayers\" : %@\n", comma, tmp]; comma = @",";
    }
    if([self blockedPlayers]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.blockedPlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"blockedPlayers\" : %@\n", comma, tmp];
    }
    rets = [rets stringByAppendingString:@"\n}\n"];
    
    return rets;

}

-(id)initWithDictionary: (NSDictionary *)weeklyContractDict andParent:(contractSchedule *)cs
{
    if((self = [super init]) == nil)
        return nil;
    self.weekNumber = [weeklyContractDict objectForKey:@"weekNumber"];

 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];
    NSString *tmpDateStr =[weeklyContractDict objectForKey:@"matchStart"];
    
    if(tmpDateStr)
        self.dateTime = [df dateFromString:tmpDateStr];
    else {
        self.dateTime = [cs.contractStart dateByAddingTimeInterval:60*60*24*7*[self.weekNumber integerValue]];
    }
    self.isBlocked = [weeklyContractDict objectForKey:@"isBlocked"];
    self.scheduledPlayers = [[NSMutableArray alloc]initWithArray:[weeklyContractDict objectForKey:@"scheduledPlayers"]];
    self.blockedPlayers = [[NSMutableArray alloc] initWithArray:[weeklyContractDict objectForKey:@"blockedPlayers"]];
    self.myContract = cs;
    
    return self;
}


@end


@implementation contractSchedule
@synthesize durationInMinutes, numCalendarWeeks, numPlayableWeeks, numPlayersNeeded, placeIndex;
@synthesize contractFixedCourtCosts, contractWeeklyCourtCosts, contractFixedPerPlayerCosts, contractWeeklyPerPlayerCosts;
@synthesize contractCreated, contractLastModified, contractStart;
@synthesize alternatePlayers, contractPlayers, weeklySchedule;

-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    NSError *err;
    NSData *jsonData;
    
 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    if([self contractCreated]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractCreated\":\"%@\"", comma, [df stringFromDate:[self contractCreated]]]; comma = @",";
    }
    if([self contractLastModified]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractLastModified\":\"%@\"", comma, [df stringFromDate:[self contractLastModified]]]; comma = @",";
    }
    if([self contractStart]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractStart\":\"%@\"", comma, [df stringFromDate:[self contractStart]]]; comma = @",";
    }
    if([self durationInMinutes]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"durationInMinutes\":\"%@\"", comma, [self durationInMinutes]]; comma = @",";
    }
    if([self numCalendarWeeks]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"numCalendarWeeks\":\"%@\"", comma, [self numCalendarWeeks]]; comma = @",";
    }
    if([self numPlayableWeeks]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"numPlayableWeeks\":\"%@\"", comma, [self numPlayableWeeks]]; comma = @",";
    }
    if([self numPlayersNeeded]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"numPlayersNeeded\":\"%@\"", comma, [self numPlayersNeeded]]; comma = @",";
    }
    if([self placeIndex]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"placeIndex\":\"%@\"", comma, [self placeIndex]]; comma = @",";
    }
    if([self contractFixedCourtCosts]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractFixedCourtCosts\":\"%@\"", comma, [self contractFixedCourtCosts]]; comma = @",";
    }
    if([self contractWeeklyCourtCosts]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractWeeklyCourtCosts\":\"%@\"", comma, [self contractWeeklyCourtCosts]]; comma = @",";
    }
    if([self contractFixedPerPlayerCosts]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"contractFixedPerPlayerCosts\":\"%@\"", comma, [self contractFixedPerPlayerCosts]]; comma = @",";
    }
    if([self contractPlayers]) {
        rets = [rets stringByAppendingFormat:@"%@\n%@", comma, [self.contractPlayers toJSON]]; comma = @",";
    }
    if([self weeklySchedule]) {
        rets = [rets stringByAppendingFormat:@"%@\n%@", comma, [self.weeklySchedule toJSON]]; comma = @",";
    }
    if([self alternatePlayers]) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.alternatePlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"alternatePlayers\" : %@\n", comma, tmp];
    }
    rets = [rets stringByAppendingString:@"\n}\n"];
   
    return rets;
}

-(id) init
{
    if((self = [super init]) == nil)
    return nil;
    
    self.contractCreated = [NSDate date];
    self.contractLastModified = [NSDate date];
    
    return self;
}

-(id)initWithDictionary: (NSDictionary *)contractScheduleDict
{
    if((self = [self init]) == nil)
        return nil;
    
 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    
    NSString *tmpDateStr =[contractScheduleDict objectForKey:@"contractCreated"];
    
    if(tmpDateStr)
        self.contractCreated = [df dateFromString:tmpDateStr];
    
    tmpDateStr =[contractScheduleDict objectForKey:@"contractLastModified"];
    
    if(tmpDateStr)
        self.contractLastModified = [df dateFromString:tmpDateStr];
    
    tmpDateStr =[contractScheduleDict objectForKey:@"contractStart"];
    if(tmpDateStr)
        self.contractStart = [df dateFromString:tmpDateStr];
    
    self.durationInMinutes = [contractScheduleDict objectForKey:@"durationInMinutes"];
    self.numCalendarWeeks = [contractScheduleDict objectForKey:@"numCalendarWeeks"];
    self.numPlayableWeeks = [contractScheduleDict objectForKey:@"numPlayableWeeks"];
    self.numPlayersNeeded = [contractScheduleDict objectForKey:@"numPlayersNeeded"];
    self.placeIndex = [contractScheduleDict objectForKey:@"placeIndex"];
    self.contractFixedCourtCosts = [contractScheduleDict objectForKey:@"contractFixedCourtCosts"];
    self.contractWeeklyCourtCosts = [contractScheduleDict objectForKey:@"contractWeeklyCourtCosts"];
    self.contractFixedPerPlayerCosts = [contractScheduleDict objectForKey:@"contractFixedPerPlayerCosts"];
    self.contractWeeklyPerPlayerCosts = [contractScheduleDict objectForKey:@"contractWeeklyPerPlayerCosts"];
    self.contractPlayers =  [[arrayManager alloc]initWithArray:[contractScheduleDict objectForKey:@"contractPlayers"] andClass:[contractPlayer class]];
    self.weeklySchedule =  [[arrayManager alloc]initWithArray:[contractScheduleDict objectForKey:@"weeklySchedule"] andClass:[weeklySchedule class] andParent:self];
    self.alternatePlayers = [[NSMutableArray alloc] initWithArray:[contractScheduleDict objectForKey:@"alternatePlayers"]];

 
    return self;
}

-(BOOL) isEqual:(contractSchedule *)newSchedule
{
    return ([self.contractCreated isEqualToDate:newSchedule.contractCreated]);      // TBD need to compare more.  maybe magic number
}

-(BOOL) isNewerThan: (contractSchedule *)newCs{
    return ([newCs.contractLastModified compare:self.contractLastModified] == NSOrderedAscending);
}


@end

