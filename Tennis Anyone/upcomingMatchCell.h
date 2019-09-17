//
//  upcomingMatchCell.h
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASchedule.h"
#include "JSCustomBadge.h"

@interface upcomingMatchCell : UITableViewCell
{
    IBOutlet UIImageView *matchPlayer1;
    IBOutlet UIImageView *matchPlayer2;
    IBOutlet UIImageView *matchPlayer3;
    IBOutlet UIImageView *matchPlayer4;
    
    IBOutlet UILabel *matchPlayer1Name;
    IBOutlet UILabel *matchPlayer2Name;
    IBOutlet UILabel *matchPlayer3Name;
    IBOutlet UILabel *matchPlayer4Name;
    
    IBOutlet UILabel *matchLocation;
    IBOutlet UILabel *matchDayAndTime;         // WED 12:30P
    IBOutlet UILabel *matchDate;               // 12/13/13
    
    IBOutlet UILabel *matchDuration;           // 120 min.
    IBOutlet UILabel *matchRecurringWeek;      // week n of m
    IBOutlet UILabel *matchRecurringWeekBackground;
    IBOutlet UILabel *matchIsInThePast;
    IBOutlet UILabel *matchErrorIndicator;
    
    IBOutlet JSCustomBadge *badge;
    
    
}

@property IBOutlet UIImageView *matchPlayer1, *matchPlayer2, *matchPlayer3, *matchPlayer4;
@property IBOutlet UILabel *matchLocation, *matchDayAndTime, *matchDate, *matchDuration, *matchErrorIndicator, *matchRecurringWeek, *matchRecurringWeekBackground, *matchIsInThePast;
@property IBOutlet UILabel *matchPlayer1Name, *matchPlayer2Name, *matchPlayer3Name, *matchPlayer4Name;
@property IBOutlet JSCustomBadge *badge;

-(void) setCellWithMatches: (contractSchedule *)sc;

@end
