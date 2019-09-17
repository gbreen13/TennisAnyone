//
//  EmptyTablePromptCell.h
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyTablePromptCell : UITableViewCell
{
    IBOutlet UIImageView *plusIcon;
    IBOutlet UILabel *prompt;
}
@property (nonatomic, retain) IBOutlet UIImageView *plusIcon;
@property (nonatomic, retain) IBOutlet  UILabel *prompt;

@end
