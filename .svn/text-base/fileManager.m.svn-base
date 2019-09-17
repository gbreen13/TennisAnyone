//
//  fileManager.m
//  Tennis Anyone
//
//  Created by George Breen on 3/14/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import "TASchedule.h"

fileManager *sharedFileManager;

@implementation fileManager

NSString *createTmpFile;

-(BOOL) loadScheduleFile:(NSError **)error
{

    NSString *inputPath = [self scheduleFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {
        NSURL *input = [[NSURL alloc] initFileURLWithPath:inputPath];

        sharedTaSchedule = [[taSchedule alloc] initWithURL:input andError:error];
    } else {
        sharedTaSchedule = [[taSchedule alloc] init];
    }
    return TRUE;

}

-(NSString *) getTmpDir
{
    NSString *DocDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *tempFileName = [NSString stringWithFormat:@"%@/tmp", DocDirectory];
    return tempFileName;
    
}

- (NSString *) tmpFileName {
	NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:DEFAULT_FILENAME_FORMAT];		// no seconds for now.
    NSString *tempFileName = [NSString stringWithFormat:@"%@/%@.%@", [self getTmpDir], [df stringFromDate:[NSDate date]], SCHEDULE_FILE_EXTENSION];
    NSFileManager *NSFm= [NSFileManager defaultManager];
	BOOL isDir=YES;
	
	if(![NSFm fileExistsAtPath:[self getTmpDir] isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[self getTmpDir] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return tempFileName;
}

-(NSString *) scheduleFileName
{
    NSString *docsDir;
    docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES) firstObject];
    
    return[NSString stringWithFormat:@"%@/%@", docsDir, SCHEDULE_FILE];
}

- (void)cleanUpTmp
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self getTmpDir] error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}


-(BOOL) saveSharedScheduleFile:(NSError **)error
{
//
//  Save to a tmp file first, then delete the old one and move the temp to the new one.
//
    NSError *tmperror = nil;
    NSFileManager *NSfm = [NSFileManager defaultManager];
    NSString *str = [self saveScheduleFileAsTmp:sharedTaSchedule error:error];

    if(*error == nil) {
        [NSfm removeItemAtPath:[self scheduleFileName] error:&tmperror];
        if(*error == nil)
            return [NSfm copyItemAtPath:str toPath:[self scheduleFileName] error:error];
        return NO;
    }
    return NO;
}

-(NSString *) saveScheduleFileAsTmp: (taSchedule *)schedule error:(NSError **)error
{
    NSString *ret = [self tmpFileName];
    NSString *scheduleJSON = [schedule toJSON];
    [scheduleJSON writeToFile:ret atomically:NO encoding:NSStringEncodingConversionAllowLossy error:error];
    if(*error == nil)
        return ret;
    return nil;
}


@end
