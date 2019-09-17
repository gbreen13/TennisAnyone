//
//  selectPlayerViewController.h
//  Tennis Anyone
//
//  Created by George Breen on 1/12/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASchedule.h"
#import "fileManager.h"
#import "NavigationBarWithSubtitle.h"
#import "EmptyTablePromptCell.h"
#import "playerDetail.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>

@class selectPlayerViewController;

@protocol SelectPlayerControllerDelegate <NSObject>
- (void)selectPlayerDidCancel: (selectPlayerViewController *)controller;
- (void)selectPlayerDidFinish: (NSMutableArray *) returnPlayers andController: (selectPlayerViewController *)controller;
@end

@interface selectPlayerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,
                                                         UINavigationControllerDelegate, CNContactPickerDelegate>
{
    IBOutlet NavigationBarWithSubtitle *topBar;
    IBOutlet UITableView *selectPlayerTableView;
    id <SelectPlayerControllerDelegate> delegate;
    NSMutableArray *alreadySelectedArray, *thisList;       // List of already selected players
    BOOL allowMultipleSelection;                // Can add select more than one.
    NSMutableArray *selectPeople;                  // new players to add to tennis players
    NSMutableDictionary *nextPlayer;
    NSArray *phoneArray, *emailArray;
    UILabel *headerLabel;                   // will list how many are selected currently

}
@property (nonatomic, retain) IBOutlet UITableView *selectPlayerTableView;
@property (nonatomic, retain) IBOutlet NavigationBarWithSubtitle *topBar;
@property (nonatomic, retain) id <SelectPlayerControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *alreadySelectedArray, *thisList, *selectPeople;
@property (nonatomic, retain) NSMutableDictionary *nextPlayer;
@property (nonatomic, retain) NSArray *phoneArray, *emailArray;
@property (nonatomic, retain) UILabel *headerLabel;


@end
