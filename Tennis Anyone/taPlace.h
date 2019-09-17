//
//  taPlace.h
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "taconfig.h"

@interface taPlace : NSObject {
    NSDate *placeCreated;                        // when contact was first created
    NSDate *placeLastModified;                       // when contact was last modified.  Any changes are merged in when schedules are shared.
    NSString *placeName;
    NSString *emaileAddr;
    NSString *phoneNumber;
    UIImage *thumbNail;
}

@property (nonatomic, retain) NSDate *placeCreated, *placeLastModified;
@property (nonatomic, retain) NSString *placeName, *emailAddr, *phoneNumber;
@property (nonatomic, retain) UIImage *thumbNail;

-(BOOL)isEqual: (taPlace *)newPlace;    // compare this contact with current and return TRUE is believed to be the same guy.
-(BOOL) isNewerThan: (taPlace *)newPlace;
-(id)initWithDictionary: (NSDictionary *)playerDict;
-(id)init;
-(NSString *)toJSON;
@end
