//
//  taPlayer.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "taPlayer.h"
#import "Base64.h"
//
//  add the base64 encoding extensions
//

@implementation taPlayer
@synthesize playerCreated, playerLastModified, firstName, lastName, emailAddr, phoneNumber, thumbNail;

-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    
 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    if([self playerCreated]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"playerCreated\":\"%@\"", comma, [df stringFromDate:[self playerCreated]]]; comma = @",";
    }
    if([self playerLastModified]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"playerLastModified\":\"%@\"", comma, [df stringFromDate:[self playerLastModified]]]; comma = @",";
    }
    
    if([self lastName]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"lastName\":\"%@\"", comma, [self lastName]]; comma = @",";
    }
    if([self firstName]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"firstName\":\"%@\"", comma, [self firstName]]; comma = @",";
    }
    if([self emailAddr]) {
        NSData *data = [[self emailAddr] dataUsingEncoding:NSUTF8StringEncoding];
        rets = [rets stringByAppendingFormat:@"%@\n\"email\":\"%@\"", comma, [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]; comma = @",";
    }
    if([self phoneNumber]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"phoneNumber\":\"%@\"", comma, [self phoneNumber]]; comma = @",";
    }
//#if 0
    if([self thumbNail]) {
        
        if(IS_OS_7_OR_LATER) {
            rets = [rets stringByAppendingFormat:@"%@\n\"thumbNail\":\"data:image/png;base64,%@\"", comma, [UIImagePNGRepresentation(self.thumbNail) base64EncodedStringWithOptions:0]]; comma = @",";
        } else {
            NSData* data = UIImagePNGRepresentation(self.thumbNail);
            [Base64 initialize];
            NSString *strEncoded = [Base64 encode:data];
            rets = [rets stringByAppendingFormat:@"%@\n\"thumbNail\":\"data:image/png;base64,%@\"", comma, strEncoded];
        }
    }
//#endif
    rets = [rets stringByAppendingString:@"\n}\n"];
    return rets;
}

-(id) init
{
    if((self = [super init]) == nil)
        return nil;
    
    self.playerCreated = [NSDate date];
    self.playerLastModified = [NSDate date];
    self.thumbNail = [UIImage imageNamed:@"unassigned"];
    self.lastName = self.firstName = @"TBD";
    return self;
}

-(id)initWithDictionary: (NSDictionary *)playerDict
{
    if((self = [self init]) == nil)
        return nil;
    
 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.

    NSString *tmpDateStr =[playerDict objectForKey:@"playerCreated"];
    
    if(tmpDateStr)
        self.playerCreated = [df dateFromString:tmpDateStr];
   
    tmpDateStr =[playerDict objectForKey:@"playerLastModified"];
    
    if(tmpDateStr)
        self.playerLastModified = [df dateFromString:tmpDateStr];
    
    self.firstName = [playerDict objectForKey:@"firstName"];
    self.lastName = [playerDict objectForKey:@"lastName"];
    self.phoneNumber = [playerDict objectForKey:@"phoneNumber"];
    self.thumbNail = [UIImage imageNamed:@"TennisPlayer"];
    self.emailAddr = [playerDict objectForKey:@"email"];
    NSString *encodedString =[playerDict objectForKey:@"thumbNail"];
    if(encodedString){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:encodedString]];
        // Create image with data
        if(imageData)
            self.thumbNail = [[UIImage alloc] initWithData:imageData];
    }
    
    if ((self.thumbNail == nil) || (self.thumbNail == [UIImage imageNamed:@"unassigned"]))
        self.thumbNail = [UIImage imageNamed:@"TennisPlayer"];
    
    return self;
}

-(BOOL)isEqual: (taPlayer *)newPlayer
{
    return ([self.firstName isEqualToString:newPlayer.firstName] &&[self.lastName isEqualToString:newPlayer.lastName]);
}

-(BOOL) isNewerThan: (taPlayer *)newPlayer
{
    return ([newPlayer.playerLastModified compare:self.playerLastModified] == NSOrderedAscending);
}


@end
