//
//  ContractsViewController.m
//  Tennis Anyone
//
//  Created by George Breen on 2/14/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import "ContractsViewController.h"

@interface ContractsViewController ()

@end

@implementation ContractsViewController

@synthesize topBar,scheduleTableView, cs, oldCs, contractSchedules;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            UITextAttributeTextColor: [UIColor whiteColor],
                                                            UITextAttributeTextShadowColor: [UIColor clearColor],
                                                            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                            UITextAttributeFont: [UIFont fontWithName: DEFAULT_FONT size:24.0f]
                                                            }];
    scheduleTableView.layer.cornerRadius=5;
    scheduleTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self reloadFromSharedTaSchedule];
}
//
//  Adjust height of the table.  this sets properly whether ipad, iphone or 4" iphone
//


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreate.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *) identifier sender:(id)sender
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    cs = [segue destinationViewController];
    NSIndexPath *indexPath = [self.scheduleTableView indexPathForSelectedRow];
    if([sender isKindOfClass:[ContractScheduleCell class]]) { // if we are transitiioning from the table, use that singleMatch to edit
        oldCs = cs.cs = [contractSchedules objectAtIndex:indexPath.row];
    } else  {                                               // from the "new" button
        oldCs = cs.cs = nil;
    }
}


-(IBAction) newContractSelected:(id)sender
{
    [self performSegueWithIdentifier:@"ContractSettingsSegue" sender:sender];
}

#pragma mark - contractSettings delegate
- (void)contractSettingsDidCancel: (contractSettings *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)contractSettingsDidFinish:(contractSchedule *)modifiedSchedule andController: (contractSchedule *) controller
{
    if(oldCs != nil)
        [sharedTaSchedule replaceContractSchedule:oldCs with:modifiedSchedule];
    else
        [sharedTaSchedule addContractSchedule:modifiedSchedule];
    
    [self reloadFromSharedTaSchedule];
    [scheduleTableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

-(void) reloadFromSharedTaSchedule
{
    contractSchedules = [sharedTaSchedule getContractSchedules];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.scheduleTableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ContractSettingsSegue" sender:cell];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([contractSchedules count] > 0)
        return [contractSchedules count];
    return 1;   // help 
}

//
//  We can only delete upcoming matches that are sinigle matches from the first section.
//
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    //  We can delete any contract we want.
    //
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [sharedTaSchedule deleteContractSchedule:(contractSchedule *)[contractSchedules objectAtIndex:indexPath.row]];
        [self reloadFromSharedTaSchedule];
        [self.scheduleTableView reloadData];
    }
    return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([contractSchedules count]) {
        NSString *cellIdentifier = @"ContractCell";
        ContractScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[ContractScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setCellWithContract:[contractSchedules objectAtIndex:[indexPath row]]];
        return cell;
        
    } else {
        NSString *cellIdentifier = @"PromptCell";
        EmptyTablePromptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[EmptyTablePromptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell.prompt setText:@"Press to set up a a new Contract"];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([contractSchedules count] > 0)
        return MATCH_CELL_HEIGHT;
    else
        return PROMPT_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DEFAULT_TABLE_HEADER_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView;
    
    
    sectionHeaderView = [[UIView alloc] initWithFrame:
                         CGRectMake(0, 0, tableView.bounds.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];
    
    
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:170.0/255.0 green:174.0/255.0 blue: 181.0/255.0 alpha:1.0];
    
    UILabel *headerLabel=  [[UILabel alloc] initWithFrame:
                            CGRectMake(20, 0, sectionHeaderView.frame.size.width, DEFAULT_TABLE_HEADER_HEIGHT)];;
    
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;

    [headerLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:18.0]];
    headerLabel.textColor = [UIColor colorWithRed:54.0/255.0f green:82.0/255.0f blue:123.0/255.0f alpha:1.0f];
    [sectionHeaderView addSubview:headerLabel];
    
    headerLabel.text = @"CONTRACTS";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setFrame:CGRectMake(sectionHeaderView.frame.size.width-(DEFAULT_TABLE_HEADER_HEIGHT+5), 3.0, DEFAULT_TABLE_HEADER_HEIGHT-5, DEFAULT_TABLE_HEADER_HEIGHT-5)];
    button.tag = section;
    button.hidden = NO;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    //    [button addTarget:self action:@selector(insertParameter:) forControlEvents:UIControlEventTouchDown];
    [sectionHeaderView addSubview:button];
    
    [button addTarget:self action:@selector(newContractSelected:) forControlEvents:UIControlEventTouchUpInside];
    return sectionHeaderView;
}

@end
