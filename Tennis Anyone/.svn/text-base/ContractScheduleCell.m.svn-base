//
//  ContractScheduleCell.m
//  Tennis Anyone
//
//  Created by George Breen on 12/30/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#import "ContractScheduleCell.h"

@implementation ContractScheduleCell
@synthesize dayAndTime, weekInfo, placeName, lastChanged, placeImage;

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

-(void) setCellWithContract: (contractSchedule *)cs
{
    taPlace *tmpp;
    [dayAndTime setFont:[UIFont fontWithName:DEFAULT_FONT size:14.0f]];
    [placeName setFont:[UIFont fontWithName:DEFAULT_FONT size:12.0f]];
    [weekInfo setFont:[UIFont fontWithName:DEFAULT_FONT size:12.0f]];
    [lastChanged setFont:[UIFont fontWithName:DEFAULT_FONT size:12.0f]];
   NSDateFormatter *df = [[NSDateFormatter alloc]init];
	[df setDateFormat:@"cccc"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    [df2 setDateFormat:@"hh:mma"];
    
    tmpp = [sharedTaSchedule getPlaceFromIndex:[cs placeIndex]];
 
    placeName.text = tmpp.placeName;
    placeImage.image = tmpp.thumbNail;
    dayAndTime.text = [NSString stringWithFormat:@"%@s %@, %dh%dm", [df stringFromDate:cs.contractStart], [df2 stringFromDate:cs.contractStart],[cs.durationInMinutes integerValue] / 60, [cs.durationInMinutes integerValue]%60];
	[df setDateFormat:@"M/d/yy"];		// no seconds for now.[df setDateFormat:@"MM-dd-yyyy-HH-mm"];		// no seconds for now.
    weekInfo.text = [NSString stringWithFormat:@"start:%@, %@ weeks", [df stringFromDate:cs.contractStart], cs.numPlayableWeeks];
    lastChanged.text = [NSString stringWithFormat:@"last changed: %@", [df stringFromDate:cs.contractLastModified]];
}

@end
