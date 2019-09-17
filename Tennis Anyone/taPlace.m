//
//  taPlace.m
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "taPlace.h"
#import "Base64.h"

@implementation taPlace

@synthesize    placeCreated,placeLastModified,placeName,emailAddr,phoneNumber,thumbNail;

-(NSString *)toJSON
{
    NSString *rets = @"{";
    NSString *comma = @" ";
    
  	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.
    if([self placeCreated]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"placeCreated\":\"%@\"", comma, [df stringFromDate:[self placeCreated]]]; comma = @",";
    }
    if([self placeLastModified]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"placeLastModified\":\"%@\"", comma, [df stringFromDate:[self placeLastModified]]]; comma = @",";
    }
    
    if([self placeName]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"placeName\":\"%@\"", comma, [self placeName]]; comma = @",";
    }
    if([self emailAddr]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"email\":\"%@\"", comma, [self emailAddr]]; comma = @",";
    }
    if([self phoneNumber]) {
        rets = [rets stringByAppendingFormat:@"%@\n\"phoneNumber\":\"%@\"", comma, [self phoneNumber]]; comma = @",";
    }
//#if 0
    if([self thumbNail]) {
        
        if(IS_OS_7_OR_LATER) {
            rets = [rets stringByAppendingFormat:@"%@\n\"thumbNail\":\"data:image/png;base64,%@\"", comma, [UIImagePNGRepresentation(self.thumbNail) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]]; comma = @",";
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
    
    self.placeCreated = [NSDate date];
    self.placeLastModified = [NSDate date];
    self.thumbNail = [UIImage imageNamed:@"unassigned"];
    self.placeName = DEFAULT_TBD_PLACE_NAME;
    
    return self;
}

-(id)initWithDictionary: (NSDictionary *)playerDict
{
    if((self = [self init]) == nil)
        return nil;
    
 	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_DATE_FORMAT];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    
    NSString *tmpDateStr =[playerDict objectForKey:@"placeCreated"];
 
    if(tmpDateStr)
        self.placeCreated = [df dateFromString:tmpDateStr];
    
    tmpDateStr =[playerDict objectForKey:@"placeLastModified"];
    
    if(tmpDateStr)
        self.placeLastModified = [df dateFromString:tmpDateStr];
    
    self.placeName = [playerDict objectForKey:@"placeName"];
    self.phoneNumber = [playerDict objectForKey:@"phoneNumber"];
    self.emailAddr = [playerDict objectForKey:@"email"];

     NSString *encodedString =[playerDict objectForKey:@"thumbNail"];
       if(encodedString) {
           NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:encodedString]];  // Create image with data
           if(imageData)
               self.thumbNail = [[UIImage alloc] initWithData:imageData];
       }
        else
            self.thumbNail = [UIImage imageNamed:@"TennisCourt"];
    return self;
}

-(BOOL)isEqual: (taPlace *)newPlace
{
    return ([self.placeName isEqualToString:newPlace.placeName]);
}
-(BOOL) isNewerThan: (taPlace *)newPlace{
    return ([newPlace.placeLastModified compare:self.placeLastModified] == NSOrderedAscending);
}

@end
