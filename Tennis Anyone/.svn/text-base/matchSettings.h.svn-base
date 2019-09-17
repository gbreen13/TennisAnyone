//
//  matchSettings.h
//  Tennis Anyone
//
//  Created by George Breen on 1/2/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASchedule.h"
#import "NavigationBarWithSubtitle.h"
#import "playerDetail.h"
#import "EmptyTablePromptCell.h"
#import "selectPlayerViewController.h"


@class matchSettings;

@interface datePickerCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@end
@interface singlesDoublesCell : UITableViewCell
{
    IBOutlet UISwitch *singlesDoublesSwitch;
}
@property (nonatomic, retain) IBOutlet UILabel *singlesLabel, *doublesLabel;
@property (nonatomic, retain) IBOutlet UISwitch *singlesDoublesSwitch;
-(void) setDoubles: (BOOL) isOn;
@end
@interface locationCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *where, *location;
@end
@interface dateCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *when, *dateTime;
@end

@protocol matchSettingsControllerDelegate <NSObject>
- (void)matchSettingsDidCancel: (matchSettings *)controller;
- (void)matchSettingsDidFinish:(singleMatch *)modifiedMatch andController: (matchSettings *) controller;
@end

@interface matchSettings : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate, SelectPlayerControllerDelegate>
{
    IBOutlet NavigationBarWithSubtitle *topBar;
    IBOutlet UITableView *matchSettingsTableView;
    BOOL timeShowing;
    singleMatch *sm;            // the source single Match;
    singleMatch *tmpMatch;      // what we'll modify
    singlesDoublesCell *sdCell;
    dateCell *dtCell;
    id <matchSettingsControllerDelegate> delegate;
    selectPlayerViewController *pvc;
    UILabel *playerHeaderLabel;
}
-(IBAction)setSDSwitch: (id)sender;

@property (nonatomic, retain) singleMatch *sm, *tmpMatch;
@property (nonatomic, retain) singlesDoublesCell *sdCell;
@property (nonatomic, retain) dateCell *dtCell;
@property (nonatomic, retain) IBOutlet NavigationBarWithSubtitle *topBar;
@property (nonatomic, retain) IBOutlet UITableView *matchSettingsTableView;
@property (nonatomic, retain) id <matchSettingsControllerDelegate> delegate;
@property (nonatomic) BOOL timeShowing;
@property (nonatomic, retain) selectPlayerViewController *pvc;
@property (nonatomic, retain) UILabel *playerHeaderLabel;
-(IBAction)pickerChanged:(id)sender;
@end
