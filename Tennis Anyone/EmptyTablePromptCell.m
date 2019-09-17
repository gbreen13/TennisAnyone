//
//  EmptyTablePromptCell.m
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "EmptyTablePromptCell.h"

@implementation EmptyTablePromptCell
@synthesize plusIcon,  prompt;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [prompt setFont:[UIFont fontWithName:@"Seravek" size:24.0f]];       // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
