//
//  ContactManager.h
//  Tennis Anyone
//
//  Created by George Breen on 12/22/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "taPlayer.h"

@interface playerManager : NSObject
{
    NSMutableArray *myArray;
}
@property (nonatomic, retain) NSMutableArray *myArray;

-(id)initWithArray:(NSArray *)playerArray;
-(NSString *) toJSON;
@end

