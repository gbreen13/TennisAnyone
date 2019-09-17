//
//  FirstViewController.h
//  Tennis Anyone
//
//  Created by George Breen on 12/14/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASchedule.h"
#import "NavigationBarWithSubtitle.h"
#include "EmptyTablePromptCell.h"
#include "upcomingMatchCell.h"
#include "ContractScheduleCell.h"
#include "matchSettings.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, matchSettingsControllerDelegate> {
    NavigationBarWithSubtitle *topBar;
    IBOutlet UITableView *scheduleTableView;
    NSMutableArray *upcomingMatches;
    matchSettings *ms;
    singleMatch *oldMatch;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *topBar;
@property (nonatomic, retain) IBOutlet UITableView *scheduleTableView;
@property (nonatomic, retain) NSMutableArray *upcomingMatches;
@property (nonatomic, retain) matchSettings *ms;
@property (nonatomic, retain) singleMatch *oldMatch;

@end
