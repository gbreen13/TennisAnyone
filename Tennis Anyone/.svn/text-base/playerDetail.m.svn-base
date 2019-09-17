 //
//  playerDetail.m
//  Tennis Anyone
//
//  Created by George Breen on 1/2/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//

#import "playerDetail.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@interface UIView (SuperView)

- (UIView *)findSuperViewWithClass:(Class)superViewClass;

@end


@implementation UIView (SuperView)

- (UIView *)findSuperViewWithClass:(Class)superViewClass {
    
    UIView *superView = self.superview;
    UIView *foundSuperView = nil;
    
    while (nil != superView && nil == foundSuperView) {
        if ([superView isKindOfClass:superViewClass]) {
            foundSuperView = superView;
        } else {
            superView = superView.superview;
        }
    }
    return foundSuperView;
}
@end

@implementation playerDetail
@synthesize player, playerName, phoneOrTextButton, emailButton, parentController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setCellWithContract: (taPlayer *)pl
{
    [playerName setFont:[UIFont fontWithName:DEFAULT_FONT size:17.0f]];
    [phoneOrTextButton.titleLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:14.0f]];
    [emailButton.titleLabel setFont:[UIFont fontWithName:DEFAULT_FONT size:14.0f]];
    
    playerName.text = [NSString stringWithFormat:@"%@ %@", pl.firstName, pl.lastName];
    if(pl.emailAddr != nil) {
        [emailButton setTitle:pl.emailAddr forState:UIControlStateNormal];
    }
    else {
        [emailButton setTitle:@"" forState:UIControlStateNormal];
        emailButton.titleLabel.text = nil;
    }
    
    if(pl.phoneNumber != nil) {
        [phoneOrTextButton setTitle:pl.phoneNumber forState:UIControlStateNormal];
    }
    else {
        [phoneOrTextButton setTitle:@"" forState:UIControlStateNormal];
        phoneOrTextButton.titleLabel.text = nil;
    }
    
    player.image = pl.thumbNail;
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    [parentController dismissModalViewControllerAnimated:YES];
    
}
-(bool)canDevicePlaceAPhoneCall {
    /*
     
     Returns YES if the device can place a phone call
     
     */
    
    // Check if the device can place a phone call
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        // Device supports phone calls, lets confirm it can place one right now
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        NSString *mnc = [carrier mobileNetworkCode];
        if (([mnc length] == 0) || ([mnc isEqualToString:@"65535"])) {
            // Device cannot place a call at this time.  SIM might be removed.
            return NO;
        } else {
            // Device can place a phone call
            return YES;
        }
    } else {
        // Device does not support phone calls
        return  NO;
    }
}

#pragma Mark - Phone, email and text.

-(NSString *)trim: (NSString *)str
{
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *resultString = [[str componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    return resultString;
}

- (IBAction)showEmail:(UIButton *)sender {
    // Email Subject
    NSString *emailTitle = @"Tennis";
    // Email Content
    NSString *messageBody = @"";
    // To address
    playerDetail *pd = (playerDetail *)[sender findSuperViewWithClass:[playerDetail class]];
    NSArray *toRecipents = [NSArray arrayWithObject:pd.emailButton.titleLabel.text];
   
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [parentController presentViewController:mc animated:YES completion:NULL];
    
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
    [parentController dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)phoneOrTextCall:(UIButton *)sender
{
    if([phoneOrTextButton.titleLabel.text length] == 0)
        return;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Contact %@", phoneOrTextButton.titleLabel.text] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [popup addButtonWithTitle:@"Call"];
    [popup addButtonWithTitle:@"Text"];
    [popup addButtonWithTitle:@"Cancel"];
    popup.tag = 1;  // signal to ActionSheet this is for phone #
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {       // phone index
            switch( buttonIndex) {
                case 0:
                    [self phoneCall];
                    break;
                case 1:
                    [self sendSMS];
                    break;
            }
        }
    }
}

-(IBAction) phoneCall
{
    
    if(![self canDevicePlaceAPhoneCall]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device can't make  phone calls!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    NSString *phoneURLString = [NSString stringWithFormat:@"telprompt://%@", [self trim:phoneOrTextButton.titleLabel.text]];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (IBAction)sendSMS
{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSString *number = phoneOrTextButton.titleLabel.text;
    NSArray *recipents = [NSArray arrayWithObject:number];
    NSString *message = @"Tennis Anyone Alert:";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [parentController presentViewController:messageController animated:YES completion:nil];
}



@end
