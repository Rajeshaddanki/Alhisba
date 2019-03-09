//
//  CalendarViewController.h
//  all3abb
//
//  Created by apple on 12/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "BaseViewController.h"


@interface CalendarViewController : BaseViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic)NSString *firstTimeStr;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *selectYourStartHour;
@property (weak, nonatomic) IBOutlet UIButton *confirmMyStartdateBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;

- (IBAction)cancelBtnCLicked:(id)sender;
- (IBAction)doneBtnCLicked:(id)sender;
- (IBAction)calendarNxtBtnClciked:(id)sender;
- (IBAction)calendarPreviousBtnClciked:(id)sender;

// Timer ..

- (IBAction)confirmStartDateBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *timerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *menuView;

@property (weak, nonatomic) IBOutlet UILabel *calendarYear;


@end
