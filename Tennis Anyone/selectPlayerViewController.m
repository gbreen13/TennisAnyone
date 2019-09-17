//
//  selectPlayerViewController.m
//  Tennis Anyone
//
//  Created by George Breen on 1/12/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import "selectPlayerViewController.h"
#import "Base64.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Resize.h"


@interface selectPlayerViewController ()

@end

@implementation selectPlayerViewController
@synthesize selectPlayerTableView, topBar, delegate, thisList, alreadySelectedArray, selectPeople, nextPlayer, phoneArray, emailArray, headerLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisList =[[NSMutableArray alloc]initWithArray:[[sharedTaSchedule players] myArray]];
    selectPeople = [[NSMutableArray alloc]init];
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ([[[sharedTaSchedule players] myArray] count] > 0)? [[[sharedTaSchedule players]myArray]count] : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return PLAYER_DETAIL_CELL_HEIGHT;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    for (NSNumber *n in alreadySelectedArray) {
        if([n integerValue] == [indexPath row]) {
            return UITableViewCellAccessoryCheckmark;
        }
    }
    return UITableViewCellAccessoryNone;
}

-(NSString *)getHeaderString {
    return [NSString stringWithFormat:@"%d SELECTED PLAYERS", (int)[alreadySelectedArray count]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    
    newCell.accessoryType = newCell.accessoryType == UITableViewCellAccessoryNone ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    if(newCell.accessoryType == UITableViewCellAccessoryNone) { // remove frmo list
        newCell.accessoryView = [[ UIImageView alloc ]
                                initWithImage:[UIImage imageNamed:@"uncheckmark" ]];
        for(NSNumber *n in alreadySelectedArray) {
            if([n integerValue] == [indexPath row]) {
                [alreadySelectedArray removeObject:n];
                break;
            }
        }
    }
    else {
        newCell.accessoryView = [[ UIImageView alloc ]
                                initWithImage:[UIImage imageNamed:@"checkmark" ]];
        [alreadySelectedArray addObject:[NSNumber numberWithInt:[indexPath row]]];
    }
    headerLabel.text = [self getHeaderString];

    [selectPlayerTableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[sharedTaSchedule players] myArray] count]) {
        NSString *cellIdentifier = @"PlayerDetailCell";
        playerDetail *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[playerDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.parentController = self;
  
        [cell setCellWithContract:[[[sharedTaSchedule players] myArray] objectAtIndex: [indexPath row]]];
    
        for (NSNumber *n in alreadySelectedArray) {
            if([n integerValue] == [indexPath row]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.accessoryView = [[ UIImageView alloc ]
                                         initWithImage:[UIImage imageNamed:@"checkmark" ]];                [cell setBackgroundColor:UI_LIGHT_GRAY];
                return cell;
            }
        }
        cell.accessoryView = [[ UIImageView alloc ]
             initWithImage:[UIImage imageNamed:@"uncheckmark" ]];                [cell setBackgroundColor:UI_LIGHT_GRAY];
        cell.accessoryType = UITableViewCellAccessoryNone;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DEFAULT_TABLE_HEADER_HEIGHT;
}

#pragma mark - Contact Picker Routines.

- (void) pickContactFromAddressBook:(id)sender {
    CNContactPickerViewController *peoplePicker = [[CNContactPickerViewController alloc] init];
    peoplePicker.delegate = self;
/*
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
    peoplePicker.navigationBar.topItem.title = @"Select Players";
    peoplePicker.navigationBar.tintColor = UI_DARK_BLUE;
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            UITextAttributeTextColor: [UIColor whiteColor],
                                                            UITextAttributeTextShadowColor: [UIColor clearColor],
                                                            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                            UITextAttributeFont: [UIFont fontWithName: DEFAULT_FONT size:24.0f]
                                                            }];
    peoplePicker.displayedProperties = displayedItems;
    peoplePicker.delegate = self;
 */
    [selectPeople removeAllObjects];
    [self presentViewController:peoplePicker animated:YES completion:nil];
}

// replace button now that controller is initialized
- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([navigationController isKindOfClass:[ABPeoplePickerNavigationController class]]) {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(peoplePickerNavigationControllerDidDone:)];
        navigationController.topViewController.navigationItem.rightBarButtonItem = bbi;
       UIBarButtonItem *bbl = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(peoplePickerNavigationControllerDidCancel:)];
        navigationController.topViewController.navigationItem.leftBarButtonItem = bbl;
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)peoplePickerNavigationControllerDidDone:(ABPeoplePickerNavigationController *)peoplePicker {
    for(NSMutableDictionary *np in selectPeople) {
        taPlayer *newPlayer = [[taPlayer alloc] initWithDictionary:np];
        if([sharedTaSchedule getIndexOfPlayer:newPlayer] == -1) {
            [sharedTaSchedule addPlayer:newPlayer];
        }
        else [[[sharedTaSchedule players] myArray] replaceObjectAtIndex:[sharedTaSchedule getIndexOfPlayer:newPlayer] withObject:newPlayer];
            
            
    }
    NSError *error = nil;
    [sharedFileManager saveSharedScheduleFile:&error];
    [selectPlayerTableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    UIView *view = peoplePicker.topViewController.view;
    UITableView *tableView = nil;
    for(UIView *uv in view.subviews)
    {
        if([uv isKindOfClass:[UITableView class]])
        {
            tableView = (UITableView*)uv;
            break;
        }
    }
    
    if(tableView != nil)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
        
        cell.accessoryType = cell.accessoryType == UITableViewCellAccessoryNone ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        [cell setSelected:NO animated:YES];
        
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {       // add to the list.
//          cell.accessoryView = [[ UIImageView alloc ]
//                                  initWithImage:[UIImage imageNamed:@"checkmark" ]];
            nextPlayer = [NSMutableDictionary new];
            CFStringRef lastNameString;
            lastNameString = ABRecordCopyValue(person, kABPersonLastNameProperty);
            NSString *lastName = (__bridge NSString *)lastNameString;
            CFStringRef name;
            name = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            NSString *nameString = (__bridge NSString *)name;
            [nextPlayer setValue:lastName forKey:@"lastName"];
            [nextPlayer setValue:nameString forKey:@"firstName"];
            [nextPlayer setValue:[tableView indexPathForSelectedRow] forKey:@"indexPath"];       // so we know when to delete it.
            // phoneNumber, email, thumbNail
            ABMultiValueRef property = ABRecordCopyValue(person, kABPersonPhoneProperty );
            phoneArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(property);
            
            if([phoneArray count] == 1) {
                [nextPlayer setValue:[phoneArray objectAtIndex:0] forKey:@"phoneNumber"];
            }
            
            else if([phoneArray count] > 1)  {
                
                UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select phone #:" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                for(int i=0; i< [phoneArray count]; i++) {
                    [popup addButtonWithTitle:[phoneArray objectAtIndex:i]];
                }
                popup.tag = 1;  // signal to ActionSheet this is for phone #
                [popup showInView:[UIApplication sharedApplication].keyWindow];
            }
                
            property = ABRecordCopyValue(person, kABPersonEmailProperty);
                
            emailArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(property);
            if([emailArray count] == 1) {
                [nextPlayer setValue:[emailArray objectAtIndex:0] forKey:@"email"];
            }
                
            else if([emailArray count] > 1)  {
                    
                UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select email:" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                
                for(int i=0; i< [emailArray count]; i++) {
                        [popup addButtonWithTitle:[emailArray objectAtIndex:i]];
                }
                popup.tag = 2;      // signal to action sheet this is email
                [popup showInView:[UIApplication sharedApplication].keyWindow];
            }
            
            NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(person);
            
            if(imgData != nil) {
                
                UIImage *image = [UIImage imageWithData:imgData];
                image = [image resizedImage:CGSizeMake(44, 44) interpolationQuality:kCGInterpolationHigh ];
                image = [image roundedCornerImage:22 borderSize:1];
                NSString *rets;
/*
 *  This should work for IOS7 but it doesn't seem to.  Fails in taPlayer when creating from dictionary.  Going old school.  
 
                if(IS_OS_7_OR_LATER) {
                    rets = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                } else { 
 */
                    NSData* data = UIImagePNGRepresentation(image);
                    [Base64 initialize];
                    rets = [Base64 encode:data];
//                }
                NSString *thumbnailStr = [NSString stringWithFormat:@"data:image/png;base64,%@", rets];
               [nextPlayer setValue:thumbnailStr forKey:@"thumbNail"];
            }
            
            [selectPeople addObject:nextPlayer];
            
            NSLog(@"new player: %@", nextPlayer);
       }
        else {
 //           cell.accessoryView = nil;
            for(NSMutableDictionary *dc in selectPeople) {  // remove from the list.
                NSIndexPath *ip = [dc valueForKey:@"indexPath"];
                if(([ip section] == [[tableView indexPathForSelectedRow] section]) && ([ip row] == [[tableView indexPathForSelectedRow] row])) {
                    [selectPeople removeObject:dc];
                }
            }
        }
    }
    
    
    return NO;
}
    
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
     
     switch (popup.tag) {
        case 1: {       // phone index
            [nextPlayer setValue:[phoneArray objectAtIndex:buttonIndex] forKey:@"phoneNumber"];
            break;
        }
             
        case 2: {       // email addr
            [nextPlayer setValue:[emailArray objectAtIndex:buttonIndex] forKey:@"email"];
            break;
        }
    }
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier {
    
    if (property == kABPersonEmailProperty) {
        ABMultiValueRef values = ABRecordCopyValue(person, kABPersonEmailProperty);
        NSString *value = (__bridge NSString *)ABMultiValueCopyValueAtIndex(values, identifier);
        NSLog(@"[AddressBook] value selected: %@", value);
        [self dismissModalViewControllerAnimated:YES];
    }
    
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView;
    
    int hoffset = 0;
    
    sectionHeaderView = [[UIView alloc] initWithFrame:
                         CGRectMake(0, 0, tableView.bounds.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];
    
    
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:170.0/255.0 green:174.0/255.0 blue: 181.0/255.0 alpha:1.0];
    
    self.headerLabel=  [[UILabel alloc] initWithFrame:
                            CGRectMake(20+hoffset, 0, sectionHeaderView.frame.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];
    
    
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.textAlignment = NSTextAlignmentLeft;
    [self.headerLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:18.0]];
    self.headerLabel.textColor = [UIColor colorWithRed:54.0/255.0f green:82.0/255.0f blue:123.0/255.0f alpha:1.0f];
    [sectionHeaderView addSubview:headerLabel];
    
    headerLabel.text = [self getHeaderString];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setFrame:CGRectMake(sectionHeaderView.frame.size.width-(DEFAULT_TABLE_HEADER_HEIGHT+5), 3.0, DEFAULT_TABLE_HEADER_HEIGHT-5, DEFAULT_TABLE_HEADER_HEIGHT-5)];
    button.tag = section;
    button.hidden = NO;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    [button setImage:[UIImage imageNamed:@"addcontact.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"addcontactsel.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector( pickContactFromAddressBook:) forControlEvents:UIControlEventTouchDown];
    [sectionHeaderView addSubview:button];
    return sectionHeaderView;
}


- (IBAction)cancel:(id)sender
{
	[delegate selectPlayerDidCancel: self];
}
- (IBAction)done:(id)sender
{
	[delegate selectPlayerDidFinish:(NSMutableArray *)nil andController: self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
