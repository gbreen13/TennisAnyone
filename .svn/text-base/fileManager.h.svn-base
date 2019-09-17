//
//  fileManager.h
//  Tennis Anyone
//
//  Created by George Breen on 3/14/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "taconfig.h"

@class taSchedule;

@interface fileManager : NSObject

-(void) cleanUpTmp: (NSError **)error;
-(BOOL) loadScheduleFile: (NSError **)error;
-(BOOL) saveSharedScheduleFile:(NSError **)error;

-(NSString *) saveScheduleFileAsTmp: (taSchedule *)schedule error:(NSError **)error;

extern fileManager *sharedFileManager;

@end
