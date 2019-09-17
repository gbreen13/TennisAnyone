//
//  taconfig.h
//  Tennis Anyone
//
//  Created by George Breen on 12/26/13.
//  Copyright (c) 2013 George Breen. All rights reserved.
//

#ifndef Tennis_Anyone_taconfig_h
#define Tennis_Anyone_taconfig_h


#define VERSION_MAJOR 1
#define VERSION_MINOR 0

#define INBOX_FOLDER @"Inbox"
#define SCHEDULE_FILE_EXTENSION @"tas"
#define SCHEDULE_FILE @"taschedule.tas"
#define TMP_FOLDER @"Tmp"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define UI_DARK_GRAY [UIColor colorWithRed:170.0/255.0f green:174.0/255.0f blue:181.0/255.0f alpha:1.0f]
#define UI_MED_GRAY [UIColor colorWithRed:209.0/255.0f green:214.0/255.0f blue:221.0/255.0f alpha:1.0f]
#define UI_LIGHT_GRAY [UIColor colorWithRed:237.0/255.0f green:239.0/255.0f blue:240.0/255.0f alpha:1.0f]
#define UI_DARK_BLUE [UIColor colorWithRed:54.0/255.0f green:82.0/255.0f blue:123.0/255.0f alpha:1.0f]
#define UI_LIGHT_BLUE [UIColor colorWithRed:95.0/255.0f green:153.0/255.0f blue:206.0/255.0f alpha:1.0f]
#define UI_RED [UIColor colorWithRed:202.0/255.0f green:102.0/255.0f blue:83.0/255.0f alpha:1.0f]
#define UI_TENNIS_YELLOW [UIColor colorWithRed:205.0/255.0f green:192.0/255.0f blue:112.0/255.0f alpha:1.0f]

#define DEFAULT_NUMBER_PLAYERS 4        // doubles
#define DEFAULT_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define DEFAULT_FILENAME_FORMAT @"yyyyMMddHHmmss"

#define DEFAULT_FONT @"Seravek"
#define DEFAULT_TBD_PLAYER_NAME @"TBD"
#define DEFAULT_TBD_PLACE_NAME @"TBD"
#define MAX_PLAYERS 1000
#define MAX_PLACES 256
#define DEFAULT_TABLE_HEADER_HEIGHT 35
#define PROMPT_CELL_HEIGHT 70

#define PLAYER_DETAIL_CELL_HEIGHT 75
#define MATCH_CELL_HEIGHT 95
#define MATCH_SETTINGS_TP_HEIGHT 300



#endif
