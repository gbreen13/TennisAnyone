//
//  arrayManager.h
//  Tennis Anyone
//
//  Created by George Breen on 12/25/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface arrayManager : NSObject
{
    NSMutableArray *myArray;
}
@property (nonatomic, retain) NSMutableArray *myArray;

-(id)initWithArray:(NSArray *)playerArray andClass: (Class)objClass;
-(id)initWithArray:(NSArray *)playerArray andClass: (Class)objClass andParent: (id)parent;
-(id)init;
-(NSString *) toJSON;
@end

