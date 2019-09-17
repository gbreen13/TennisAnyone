//
//  AppDelegate.m
//  Tennis Anyone
//
//  Created by George Breen on 12/14/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    // Override point for customization after application launch.
    NSURL *inputFile;

#ifdef DEBUG
//    NSString *testPath = [[NSBundle mainBundle] pathForResource:@"tt" ofType:@"json"];
//    inputFile = [[NSURL alloc] initFileURLWithPath:testPath];
//    NSString *testPath2 = [[NSBundle mainBundle] pathForResource:@"tt2" ofType:@"json"];
//    NSURL *inputFile2 = [[NSURL alloc] initFileURLWithPath:testPath2];
//    taSchedule *new4merge = [[taSchedule alloc] initWithURL:inputFile2];
//    [sharedTaSchedule mergeTASchedule:new4merge];
#endif
    sharedFileManager = [[fileManager alloc]init];
    [sharedFileManager loadScheduleFile:&error];
    [sharedFileManager saveSharedScheduleFile:&error];

	NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];     // open with file.
	
	if ([url isFileURL])
	{
        taSchedule *loadedSchedule = [[taSchedule alloc] initWithURL:(NSURL *)url andError:&error];
        if(loadedSchedule != nil) {
            [sharedTaSchedule mergeTASchedule:(taSchedule *)loadedSchedule];
        }
	}
    

    NSLog(@"%@", [sharedTaSchedule toJSON]);
#if 0    
    contractSchedule *test = [[[sharedTaSchedule contractSchedules] myArray] objectAtIndex:0];
    taSchedule *newSchedule = [sharedTaSchedule extractContract:test];
    NSLog(@"%@",[newSchedule toJSON]);
    
    singleMatch *sm = [[[sharedTaSchedule singleMatches] myArray] objectAtIndex:0];
    newSchedule = [sharedTaSchedule extractSingleMatch:sm];
    NSLog(@"%@",[newSchedule toJSON]);
    
    NSMutableArray *next = [ sharedTaSchedule getNextMatchesFromDate: [NSDate date] forCount:4];
    NSLog(@"%@", next);
#endif
   return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
 	NSLog(@"openURL");
    NSError *error = nil;
    if ([url isFileURL])
	{
        taSchedule *loadedSchedule = [[taSchedule alloc] initWithURL:(NSURL *)url andError:&error];
        if(loadedSchedule != nil) {
            [sharedTaSchedule mergeTASchedule:(taSchedule *)loadedSchedule];
        } else {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File does not appear to be  a valid Tennis Anyone schedule." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
        }
	}
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
