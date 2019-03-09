
#ifndef Cavaratmall_Common_h
#define Cavaratmall_Common_h

#import "AppDelegate.h"
#import "MCLocalization.h"
#define LAST_CLOSED_TIME @"LAST_CLOSED_TIME"

#define KEY_LANGUAGE_EN @"en"
#define KEY_LANGUAGE_AR @"ar"
#define THEME_COLOR [UIColor colorWithRed:9.0f/255.0f green:118.0f/255.0f blue:221.0f/255.0f alpha:1];
#define THEME_COLOR2 [UIColor colorWithRed:54.0f/255.0f green:124.0f/255.0f blue:181.0f/255.0f alpha:1];
#define REWARDS_COLOR [UIColor colorWithRed:246.0f/255.0f green:238.0f/255.0f blue:152.0f/255.0f alpha:1];
#define HEADING_COLOR [UIColor colorWithRed:196.0f/255.0f green:157.0f/255.0f blue:88.0f/255.0f alpha:1];

#define Localized(string) [MCLocalization stringForKey:string]

#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]

#define SERVER_URL @"http://alhisba.com/api/"

#define SERVICES @"services.php"
#define REGISTERD_TRADES @"registered_trades.php"
#define WORDS @"words-json.php"
#define REGISTERD_TRADES_FILTER @"registered_trades_filter.php"
#define LOGIN @"login.php"
#define REGISTER @"member.php"
#define FORGET_PASSWORD @"forget-password.php"
#define CHANGE_PASS @"change-password.php"
#define HISTORICAl @"auctions.php"
#define TODAY @"auctions_today.php"
#define UPCOMING @"auctions_upcoming.php"
#define LOAN_CALCULATOR @"loan_calculator.php"
#define APPRAISAL_REPORT @"appraisal_report.php"
#define APPRAISAL_TYPES @"appraisal_types.php"
#define APPRAISAL_REASONS @"appraisal_reasons.php"
#define LIVE_VALUES @"ive_values.php"
#define LIVE_AREAS @"ive_areas.php"
#define LIVE_RESULT @"ive_result.php"
#define APPRAISAL_PRICE @"appraisal_getprice.php"
#define UPLOAD_IMAGE @"appraisal_report_file.php"
#define CONTACT_US @"contact-us.php"
#define SETTINGS @"settings.php"
#define MEMBERS @"members.php"
#define NEWS @"news.php"
#define FAQS @"faqs.php"
#define BLOG @"blog.php"
#define CONTACT @"contact.php"




#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#endif
