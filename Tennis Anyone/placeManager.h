//
//  placeManager.h
//  Tennis Anyone
//
//  Created by George Breen on 12/24/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "taPlace.h"

@interface placeManager : NSObject
{
    NSMutableArray *myArray;
}
@property (nonatomic, retain) NSMutableArray *myArray;
-(id)initWithArray:(NSArray *)placeArray;
-(NSString *) toJSON;
@end
