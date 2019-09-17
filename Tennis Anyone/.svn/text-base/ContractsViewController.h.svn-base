//
//  ContractsViewController.h
//  Tennis Anyone
//
//  Created by George Breen on 2/14/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import "TASchedule.h"
#import "NavigationBarWithSubtitle.h"
#include "EmptyTablePromptCell.h"
#include "ContractScheduleCell.h"
#include "contractSettings.h"

@interface ContractsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, contractSettingsControllerDelegate> {
    NavigationBarWithSubtitle *topBar;
    IBOutlet UITableView *scheduleTableView;
    NSMutableArray *contractSchedules;
    contractSettings *cs;
    contractSchedule *oldCs;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *topBar;
@property (nonatomic, retain) IBOutlet UITableView *scheduleTableView;
@property (nonatomic, retain) NSMutableArray *contractSchedules;
@property (nonatomic, retain) contractSettings *cs;
@property (nonatomic, retain) contractSchedule *oldCs;
@end
