//
//  playerDetail.h
//  Tennis Anyone
//
//  Created by George Breen on 1/2/14.
//  Copyright (c) 2014 George Breen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "taPlayer.h"


@interface playerDetail : UITableViewCell <UINavigationControllerDelegate, UIActionSheetDelegate,
    MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    IBOutlet UIImageView *player;
    IBOutlet UILabel *playerName;
    IBOutlet UIButton *phoneOrTextButton;
    IBOutlet UIButton *emailButton;
    UIViewController *parentController;
}
-(IBAction)phoneCall;
- (IBAction)sendSMS;
- (IBAction)showEmail:(UIButton *)sender;
-(IBAction)phoneOrTextCall:(UIButton *)sender;
@property (nonatomic, retain) IBOutlet UIImageView *player;
@property (nonatomic, retain) IBOutlet UILabel *playerName;
@property (nonatomic, retain) IBOutlet UIButton *phoneOrTextButton,  *emailButton;
@property (nonatomic, retain) UIViewController *parentController;
-(void) setCellWithContract: (taPlayer *) pl;

@end
