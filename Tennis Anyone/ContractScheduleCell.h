//
//  ContractScheduleCell.h
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "TASchedule.h"

@interface ContractScheduleCell : UITableViewCell
{
    IBOutlet UIImageView *placeImage;
    IBOutlet UILabel *dayAndTime;
    IBOutlet UILabel *weekInfo;
    IBOutlet UILabel *placeName;
    IBOutlet UILabel *lastChanged;
}
@property (nonatomic, retain) IBOutlet UIImageView *placeImage;
@property (nonatomic, retain) UILabel *dayAndTime, *weekInfo, *placeName, *lastChanged;

-(void) setCellWithContract: (contractSchedule *)cs;

@end
