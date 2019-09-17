//
//  singleMatch.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "singleMatch.h"

@implementation singleMatch
@synthesize matchCreated, matchLastModified, matchStart, durationInMinutes, numPlayersNeeded, placeIndex;
@synthesize invitedPlayers, acceptedPlayers, rejectedPlayers;

-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    NSError *err;
    NSData *jsonData;
 
	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.
    if([self matchCreated]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"matchCreated\":\"%@\"", comma, [df stringFromDate:[self matchCreated]]]; comma = @",";
    }
    if([self matchLastModified]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"matchLastModified\":\"%@\"", comma, [df stringFromDate:[self matchLastModified]]]; comma = @",";
    }
    if([self matchStart]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"matchStart\":\"%@\"", comma, [df stringFromDate:[self matchStart]]]; comma = @",";
    }
    if([self durationInMinutes]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"durationInMinutes\":\"%@\"", comma, [self durationInMinutes]]; comma = @",";
    }
    if([self numPlayersNeeded]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"numPlayersNeeded\":\"%@\"", comma, [self numPlayersNeeded]]; comma = @",";
    }
    if([self placeIndex]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"placeIndex\":\"%@\"", comma, [self placeIndex]]; comma = @",";
    }
    if([self invitedPlayers]) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.invitedPlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"invitedPlayers\" : %@\n", comma, tmp]; comma = @",";
    }
    if([self acceptedPlayers]) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.acceptedPlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"acceptedPlayers\" : %@\n", comma, tmp]; comma = @",";
    }
    if([self rejectedPlayers]) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.rejectedPlayers options:NSJSONWritingPrettyPrinted error:&err];
        NSString *tmp=[[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"rejectedPlayers\" : %@\n", comma, tmp];
    }
    rets = [rets stringByAppendingString:@"\n}\n"];
   
    return rets;
}

-(id) init
{
    if((self = [super init]) == nil)
    return nil;
    
    self.matchCreated = [NSDate date];
    self.matchLastModified = [NSDate date];
    self.matchStart = [NSDate date];
    self.placeIndex = [NSNumber numberWithInteger:-1];
    self.numPlayersNeeded = [NSNumber numberWithInt:DEFAULT_NUMBER_PLAYERS];
    self.durationInMinutes = [NSNumber numberWithInt:60];
    self.invitedPlayers = [[NSMutableArray alloc]init];
    self.acceptedPlayers = [[NSMutableArray alloc]init];
    self.rejectedPlayers = [[NSMutableArray alloc]init];
    
    return self;
}

-(id)initWithDictionary: (NSDictionary *)smDict
{
    if((self = [self init]) == nil)
        return nil;
    
    self.durationInMinutes = [smDict objectForKey:@"durationInMinutes"];
    self.numPlayersNeeded = [smDict objectForKey:@"numPlayersNeeded"];
    self.placeIndex = [smDict objectForKey:@"placeIndex"];
    NSString *tmpDateStr;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.
    tmpDateStr =[smDict objectForKey:@"matchCreated"];
    if(tmpDateStr)
        self.matchCreated = [df dateFromString:tmpDateStr];
    tmpDateStr =[smDict objectForKey:@"matchLastModified"];
    if(tmpDateStr)
        self.matchLastModified = [df dateFromString:tmpDateStr];
    tmpDateStr =[smDict objectForKey:@"matchStart"];
    if(tmpDateStr)
        self.matchStart = [df dateFromString:tmpDateStr];

    self.invitedPlayers = [[NSMutableArray alloc] initWithArray:[smDict objectForKey:@"invitedPlayers"]];
    self.acceptedPlayers = [[NSMutableArray alloc] initWithArray:[smDict objectForKey:@"acceptedPlayers"]];
    self.rejectedPlayers = [[NSMutableArray alloc] initWithArray:[smDict objectForKey:@"rejectedPlayers"]];
   
    return self;
}
-(BOOL) isEqual:(singleMatch *)newSchedule
{
    return ([self.matchCreated isEqualToDate:newSchedule.matchCreated]);      // TBD need to compare more.  maybe magic number
}

-(BOOL) isNewerThan: (singleMatch *)newMatch
{
   return ([newMatch.matchLastModified compare:self.matchLastModified] == NSOrderedAscending);
}

@end
