//
//  contractSettings.h
//  Tennis Anyone
//
//  Created by George Breen on 1/2/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TASchedule.h"
#import "NavigationBarWithSubtitle.h"


@class contractSettings;

@protocol contractSettingsControllerDelegate <NSObject>
- (void)contractSettingsDidCancel: (contractSettings *)controller;
- (void)contractSettingsDidFinish: (contractSettings *)modifiedMatch andController: (contractSettings *) controller;
@end

@interface contractSettings : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet NavigationBarWithSubtitle *topBar;
    IBOutlet UITableView *contractSettingsTableView;
    contractSchedule   *cs;             // the source single Match;
    contractSchedule *nSchedule;      // what we'll modify
    id <contractSettingsControllerDelegate> delegate;
}


@property (nonatomic, retain) contractSchedule *cs, *nSchedule;
@property (nonatomic, retain) IBOutlet NavigationBarWithSubtitle *topBar;
@property (nonatomic, retain) IBOutlet UITableView *contractSettingsTableView;
@property (nonatomic, assign) id <contractSettingsControllerDelegate> delegate;
@end


