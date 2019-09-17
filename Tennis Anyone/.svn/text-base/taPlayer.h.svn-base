//
//  taPlayer.h
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "taconfig.h"

#define CONTACT_ICON_LARGE_WIDTH 88
#define CONTACT_ICON_SMALL_WIDTH 44

@interface taPlayer : NSObject {
    NSDate *playerCreated;                        // when contact was first created
    NSDate *playerLastModified;                       // when contact was last modified.  Any changes are merged in when schedules are shared.
    NSString *firstName;
    NSString *lastName;
    NSString *placeName;
    NSString *emailAddr;
    NSString *phoneNumber;
    UIImage *thumbNail;
}

@property (nonatomic, retain) NSDate *playerCreated, *playerLastModified;
@property (nonatomic, retain) NSString *firstName, *lastName, *emailAddr, *phoneNumber;
@property (nonatomic, retain) UIImage *thumbNail;

-(BOOL)isEqual: (taPlayer *)newPlayer;    // compare this contact with current and return TRUE is believed to be the same guy.
-(id)initWithDictionary: (NSDictionary *)playerDict;
-(id)init;
-(NSString *)toJSON;
-(BOOL) isNewerThan: (taPlayer *)newPlace;

@end

