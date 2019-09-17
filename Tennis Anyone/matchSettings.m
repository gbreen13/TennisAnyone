//
//  matchSettings.m
//  Tennis Anyone
//
//  Created by George Breen on 1/2/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import "matchSettings.h"

@implementation datePickerCell
@synthesize datePicker;
@end
@implementation singlesDoublesCell
@synthesize singlesLabel, doublesLabel, singlesDoublesSwitch;
-(void) setDoubles: (BOOL) isOn
{
    if (isOn) {
        [singlesLabel setTextColor:UI_DARK_GRAY];
        [doublesLabel setTextColor:UI_DARK_BLUE];
    }
    else {
        [singlesLabel setTextColor:UI_DARK_BLUE];
        [doublesLabel setTextColor:UI_DARK_GRAY];
        
    }
}
@end
@implementation locationCell
@synthesize where, location;
@end
@implementation dateCell
@synthesize when, dateTime;
@end

@implementation matchSettings
@synthesize sm, topBar, matchSettingsTableView;
@synthesize tmpMatch, timeShowing, sdCell, dtCell, delegate, pvc, playerHeaderLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSShadow *shadow = [NSShadow alloc];
    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowBlurRadius = 5;
	// Do any additional setup after loading the view, typically from a nib.
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSShadowAttributeName: shadow,
                                                            NSFontAttributeName: [UIFont fontWithName: DEFAULT_FONT size:24.0f]
                                                            }];
}

-(IBAction)setSDSwitch:(id)sender
{
    if([(UISwitch *)sender isOn])
        tmpMatch.numPlayersNeeded = [NSNumber numberWithInt:4];
    else
        tmpMatch.numPlayersNeeded = [NSNumber numberWithInt:2];
    [sdCell setDoubles:[(UISwitch *)sender isOn]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return (timeShowing)? 4:3;      // four includes the UIDatePicker.
    }
    if(section == 1) {
        if([tmpMatch.invitedPlayers count] > 0)
            return [tmpMatch.invitedPlayers count];
        else
            return 1;                   // will put up prompt sign
    }
    return 0;
}

-(void) viewWillAppear:(BOOL)animated
{
    //
    //  Make a copy of the singleMatch by converting to JSON and then back through the initialization.
    //
    timeShowing = FALSE;    // don't show the date picker
    if(tmpMatch != nil) return;
    if(sm != nil) {         // editing existing match
        NSError *error;
        NSString *json = [sm toJSON];
        NSDictionary *jsond = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]options:kNilOptions error:&error];
        tmpMatch = [[singleMatch alloc]initWithDictionary:jsond];
    } else              // new
        tmpMatch = [[singleMatch alloc]init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectPlayerSegue"]) {
        pvc = [segue destinationViewController];
        pvc.delegate = self;
//
//  load up pvc.alreadySelectedArray with all of the players that are already listed in this match.
//
        pvc.alreadySelectedArray = [[NSMutableArray alloc]initWithArray:tmpMatch.invitedPlayers];
        
#if 0
        if([sender isKindOfClass:[upcomingMatchCell class]]) { // if we are transitiioning from the table, use that singleMatch to edit
            NSIndexPath *indexPath = [self.scheduleTableView indexPathForSelectedRow];
            oldMatch = ms.sm = [upcomingMatches objectAtIndex:indexPath.row];
        } else  {                                               // from the "new" button
            oldMatch = ms.sm = nil;
        }
        ms.delegate = self;
#endif
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *) identifier sender:(id)sender
{
    NSIndexPath *indexPath = [self.matchSettingsTableView indexPathForSelectedRow];
    if(indexPath.section == 0 && indexPath.row == 1)
    {
        return YES;
    }
    return NO;
}

- (void) selectPlayerDidCancel: (selectPlayerViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)selectPlayerDidFinish:(selectPlayerViewController *)modifiedMatch andController: (selectPlayerViewController *) controller
{
    [[tmpMatch invitedPlayers]removeAllObjects];
    for(NSNumber *n in pvc.alreadySelectedArray) {
        [tmpMatch.invitedPlayers addObject:n];
    }
    [matchSettingsTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:         // singles/double switch
            {
                NSString *cellIdentifier = @"SinglesDoublesCell";
                singlesDoublesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil) {
                    cell = [[singlesDoublesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                sdCell = cell;
                [cell setDoubles:([[tmpMatch numPlayersNeeded] integerValue] == 4)];
                [sdCell.singlesDoublesSwitch  setOn:([[tmpMatch numPlayersNeeded] integerValue] == 4)];
                [cell.singlesLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                [cell.doublesLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                return cell;
            }
            case 1:         // location
            {
                NSString *cellIdentifier = @"LocationCell";
                locationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil) {
                    cell = [[locationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }

                taPlace *tmpp;
                
                [cell.where setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                [cell.location setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                
                if([[tmpMatch placeIndex] integerValue] >= 0) {
                    tmpp = [sharedTaSchedule getPlaceFromIndex:[tmpMatch placeIndex]];
                    cell.location.text = tmpp.placeName;
                    [cell.location setTextColor:UI_DARK_BLUE];
                } else {
                    cell.location.text = @"Select a location";
                    [cell.location setTextColor:UI_MED_GRAY];
                }
                return cell;
                
            }
            case 2:     // dateTime;
            {
                NSString *cellIdentifier = @"DateCell";
                dateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil) {
                    cell = [[dateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                dtCell = cell;
                [self setDate];
                [cell.when setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                [cell.dateTime setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
                return cell;
            }
            case 3:
            {
                NSString *cellIdentifier = @"DatePickerCell";
                datePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil) {
                    cell = [[datePickerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                [cell.datePicker setDate:tmpMatch.matchStart];
                return cell;
            }
        }
        
    } else  if([indexPath section] == 1) {
        
        if([tmpMatch.invitedPlayers count]) {
            NSString *cellIdentifier = @"PlayerDetailCell";
            playerDetail *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(cell == nil) {
                cell = [[playerDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.parentController = self;
          
            [cell setCellWithContract:[[[sharedTaSchedule players] myArray] objectAtIndex: [[tmpMatch.invitedPlayers objectAtIndex:[indexPath row]] integerValue]]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.parentController = self;
            return cell;
            
        } else {
            NSString *cellIdentifier = @"PromptCell";
            EmptyTablePromptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(cell == nil) {
                cell = [[EmptyTablePromptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell.prompt setText:@"Press to select a tennis player friend."];
            return cell;
        }

    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 1:         // select place.
            {
                [self performSegueWithIdentifier:@"SelectPlayerSegue" sender:nil];
                break;
 
            }
            case 2:
            {
                timeShowing ^= 1;
                [self.matchSettingsTableView beginUpdates];
                
                NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
                
                // check if 'indexPath' has an attached date picker below it
                if (!timeShowing)
                {
                    // found a picker below it, so remove it
                    [self.matchSettingsTableView deleteRowsAtIndexPaths:indexPaths
                                          withRowAnimation:UITableViewRowAnimationFade];
                }
                else
                {
                    // didn't find a picker below it, so we should insert it
                    [self.matchSettingsTableView insertRowsAtIndexPaths:indexPaths
                                          withRowAnimation:UITableViewRowAnimationFade];
                }
                
                [self.matchSettingsTableView endUpdates];
            }
        }
        
    }
    // if player prompt
    else if(([indexPath section] == 1) && ([tmpMatch.invitedPlayers count] == 0)) {
        [self performSegueWithIdentifier:@"SelectPlayerSegue" sender:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
     if([indexPath section] == 1)
      return YES;
     return NO;
 }

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (([indexPath section] == 1) && (editingStyle == UITableViewCellEditingStyleDelete)) {
 
        [tmpMatch.invitedPlayers removeObjectAtIndex:indexPath.row];
        [self.matchSettingsTableView reloadData];
     }
 }
-(void) setDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"ccc MMM d, h:mma"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    if(dtCell && tmpMatch) {
        dtCell.dateTime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:tmpMatch.matchStart]];
    }
}
-(IBAction)pickerChanged:(id)sender
{
    tmpMatch.matchStart = [(UIDatePicker *)sender date];
    [self setDate];

}
- (IBAction)cancel:(id)sender
{
	[delegate matchSettingsDidCancel: self];
    tmpMatch = nil;
}
- (IBAction)done:(id)sender
{
	[delegate matchSettingsDidFinish:(singleMatch *)tmpMatch andController: self];
    tmpMatch = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0) {
        if([indexPath row] == 3) return 162;
        else return 44;
    }
    if([indexPath section] == 1) {
        if([tmpMatch.invitedPlayers count] == 0)
            return PROMPT_CELL_HEIGHT;
    }
    return PLAYER_DETAIL_CELL_HEIGHT;
}

//
//  Next two are to avoid having extra table cells.

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DEFAULT_TABLE_HEADER_HEIGHT;
}
- (IBAction)addPlayers:(id)sender
{
    [self performSegueWithIdentifier:@"SelectPlayerSegue" sender:nil];
}
-(NSString *)getHeaderString {
    return [NSString stringWithFormat:@"%d INVITED PLAYERS", (int)[tmpMatch.invitedPlayers count]];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView;
    
    int hoffset = 0;
    
    sectionHeaderView = [[UIView alloc] initWithFrame:
                         CGRectMake(0, 0, tableView.bounds.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];
    
    
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:170.0/255.0 green:174.0/255.0 blue: 181.0/255.0 alpha:1.0];
    
    UILabel *headerLabel=  [[UILabel alloc] initWithFrame:
                            CGRectMake(20+hoffset, 0, sectionHeaderView.frame.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];;
    
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:18.0]];
    headerLabel.textColor = [UIColor colorWithRed:54.0/255.0f green:82.0/255.0f blue:123.0/255.0f alpha:1.0f];
    [sectionHeaderView addSubview:headerLabel];
    
    switch (section) {
        case 0:
            headerLabel.text = @"TIME AND PLACE";
            break;
        case 1:
            playerHeaderLabel = headerLabel;
            self.playerHeaderLabel.text = [self getHeaderString];
            break;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setFrame:CGRectMake(sectionHeaderView.frame.size.width-(35+hoffset), 3.0, DEFAULT_TABLE_HEADER_HEIGHT-5, DEFAULT_TABLE_HEADER_HEIGHT-5)];
    
    button.tag = section;
    button.hidden = NO;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    
    if(section == 0) {
        
        [button setImage:[UIImage imageNamed:@"uploadschedule.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"uploadschedulesel.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(showEmail:) forControlEvents:UIControlEventTouchDown];
    }
    
    else if(section == 1) {
        [button setImage:[UIImage imageNamed:@"tenniscontact.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tenniscontactsel.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(addPlayers:) forControlEvents:UIControlEventTouchDown];
    }
    
    [sectionHeaderView addSubview:button];

    return sectionHeaderView;
}

- (IBAction)showEmail:(UIButton *)sender {
    // Email Subject
    NSString *emailTitle = @"Tennis Anyone?";
    // To address
    
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    
    for(NSNumber *n in tmpMatch.invitedPlayers) {
        taPlayer *player = [sharedTaSchedule getPlayerFromIndex:n];
        [ar addObject:player.emailAddr];
    }
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];

    NSString *emailBody = [NSString stringWithFormat: @"<br> \
                           <a href=http://www.rabbithillsolutions.com/files/launchIcon58.png> <img src=http://www.rabbithillsolutions.com/files/launchIcon58.png style='margin: 5px'; align='left'>\
                           </a> <b>Tennis Anyone?<br> </b>Match Update<br><br> \
                           <div style='text-align: left;'><b><span style='font-weight: bold;'>Where:</span></b>&nbsp; \
                           %@<br>\
                           <span style='font-weight: bold;'>When:</span> Friday, 3/14/14 at 2:00 pm<br>\
                           <span style='font-weight: bold;'>Who: </span>George Breen, Ed Weimer, Paul Johns, John Paul<br></div><br><br><br><br> \
                           Sent using <a href=''>Tennis Anyone</a> for the iPhone.", [[sharedTaSchedule getPlaceFromIndex:tmpMatch.placeIndex] placeName]];
//    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:ar];
    [mc setMessageBody:emailBody isHTML:YES];
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
