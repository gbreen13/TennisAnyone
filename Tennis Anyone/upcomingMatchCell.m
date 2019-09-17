//
//  upcomingMatchCell.m
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reservedn.
//

#import "upcomingMatchCell.h"

@implementation upcomingMatchCell

@synthesize matchPlayer1, matchPlayer2, matchPlayer3, matchPlayer4, matchRecurringWeek;
@synthesize matchLocation, matchDayAndTime, matchDate, matchDuration, matchErrorIndicator, matchRecurringWeekBackground, matchIsInThePast, badge;

@synthesize matchPlayer1Name, matchPlayer2Name, matchPlayer3Name, matchPlayer4Name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//
//  Populate the cell with this schedule information.   could be weekly schedule or single match
//
-(void) setCellWithMatches: (id)cell
{
    BOOL hasError = FALSE;
    NSMutableArray *players;
    taPlayer *tmpp;
    NSDate *thisTime;

    [matchLocation setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
    [matchRecurringWeek setFont:[UIFont fontWithName:DEFAULT_FONT size:13.0f]];
    [matchDate setFont:[UIFont fontWithName:DEFAULT_FONT size:13.0f]];
    [matchDayAndTime setFont:[UIFont fontWithName:DEFAULT_FONT size:13.0f]];
    [matchDuration setFont:[UIFont fontWithName:DEFAULT_FONT size:13.0f]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:@"ccc h:mma"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    [matchLocation setTextColor:UI_DARK_BLUE];
    
    if([cell isKindOfClass:[weeklySchedule class]]) {
        contractSchedule *cs = [(weeklySchedule *)cell myContract];
        taPlace *pl = [sharedTaSchedule getPlaceFromIndex:[cs placeIndex]];
        matchLocation.text = [pl placeName];
//        [matchLocation setTextColor:UI_TENNIS_YELLOW];
        players = [[NSMutableArray alloc]initWithArray:[(weeklySchedule *)cell scheduledPlayers]];
        matchDayAndTime.text = [df stringFromDate:[(weeklySchedule *)cell dateTime]];
        matchRecurringWeek.text = [NSString stringWithFormat:@"%@/%@", [(weeklySchedule *)cell weekNumber], [cs numPlayableWeeks]];
        [matchRecurringWeek setHidden:false];
        [df setDateFormat:@"MM/dd/yy"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
        matchDate.text = [df stringFromDate:[(weeklySchedule *)cell dateTime]];
        matchDuration.text = [NSString stringWithFormat:@"%@ min", [cs durationInMinutes]];
        self.accessoryType = UITableViewCellAccessoryNone;
        [matchRecurringWeekBackground setHidden:FALSE];
        thisTime = [cell dateTime];
    }
    else {
        singleMatch *sm = (singleMatch *)cell;
        thisTime = [sm matchStart];
        
        taPlace *pl = [sharedTaSchedule getPlaceFromIndex:[sm placeIndex]];
        matchLocation.text = [pl placeName];
        if([matchLocation.text isEqualToString:DEFAULT_TBD_PLACE_NAME])
            [matchLocation setTextColor:UI_RED];
        players = [[NSMutableArray alloc] initWithArray:[sm invitedPlayers]];
        matchDayAndTime.text = [df stringFromDate:[sm matchStart]];
        [matchRecurringWeek setHidden:false];
        [df setDateFormat:@"MM/dd/yy"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
        [matchRecurringWeek setHidden:true];
        matchDate.text = [df stringFromDate:[sm matchStart]];
        matchDuration.text = [NSString stringWithFormat:@"%@ min", [sm durationInMinutes]];
        [matchRecurringWeekBackground setHidden:TRUE];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//
//  If in the past, grey out.
//
    if([thisTime compare: [NSDate date]] == NSOrderedDescending)
        [matchIsInThePast setHidden:TRUE];
    else
        [matchIsInThePast setHidden:FALSE];
    
    [matchPlayer1Name setTextColor:UI_DARK_BLUE];
    [matchPlayer2Name setTextColor:UI_DARK_BLUE];
    [matchPlayer3Name setTextColor:UI_DARK_BLUE];
    [matchPlayer4Name setTextColor:UI_DARK_BLUE];
    
    for(int i = (int)[players count]; i < 4; i++) {
        [players addObject:[NSNumber numberWithInt:-1]];
        switch(i) {
            case 0: [matchPlayer1Name setTextColor:UI_RED]; break;
            case 1: [matchPlayer2Name setTextColor:UI_RED]; break;
            case 2: [matchPlayer3Name setTextColor:UI_RED]; break;
            case 3: [matchPlayer4Name setTextColor:UI_RED]; break;
        }
        hasError = TRUE;
    }
    
    if([players count] > 4) {
        [badge setBadgeText:[NSString stringWithFormat:@"+%d", (int)[players count]-4]];
        [badge setHidden:NO];
    } else {
      [badge setHidden:YES];
    }
    tmpp = [sharedTaSchedule getPlayerFromIndex:[players objectAtIndex:0]];
    matchPlayer1.image = tmpp.thumbNail;
    matchPlayer1Name.text = [NSString stringWithFormat:@"%@", tmpp.firstName];
    tmpp = [sharedTaSchedule getPlayerFromIndex:[players objectAtIndex:1]];
    matchPlayer2.image = tmpp.thumbNail;
    matchPlayer2Name.text = [NSString stringWithFormat:@"%@", tmpp.firstName];
    tmpp = [sharedTaSchedule getPlayerFromIndex:[players objectAtIndex:2]];
    matchPlayer3.image = tmpp.thumbNail;
    matchPlayer3Name.text = [NSString stringWithFormat:@"%@", tmpp.firstName];
    tmpp = [sharedTaSchedule getPlayerFromIndex:[players objectAtIndex:3]];
    matchPlayer4.image = tmpp.thumbNail;
    matchPlayer4Name.text = [NSString stringWithFormat:@"%@", tmpp.firstName];
    [matchPlayer1Name setFont:[UIFont fontWithName:DEFAULT_FONT size:11.0f]];
    [matchPlayer2Name setFont:[UIFont fontWithName:DEFAULT_FONT size:11.0f]];
    [matchPlayer3Name setFont:[UIFont fontWithName:DEFAULT_FONT size:11.0f]];
    [matchPlayer4Name setFont:[UIFont fontWithName:DEFAULT_FONT size:11.0f]];
    [matchErrorIndicator setHidden:!hasError];
}

@end