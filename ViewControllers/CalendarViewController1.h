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
//#import <JTCalendar/JTCalendar.h>


@interface CalendarViewController1 : BaseViewController<JTCalendarDelegate>

//@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic)NSString *secondTimeStr;

@property (weak, nonatomic) IBOutlet UILabel *returnDate;
@property (weak, nonatomic) IBOutlet UILabel *selectYourReturnHour;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) NSDate *fromDate;


- (IBAction)cancelBtnCLicked:(id)sender;

- (IBAction)doneBtnCLicked:(id)sender;

- (IBAction)bookBtnClicked:(id)sender;

- (IBAction)calendarNxtBtnClicked:(id)sender;
- (IBAction)calendarPreviousBtnClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *timerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;

@property (weak, nonatomic) IBOutlet UILabel *calendarYear;


@end
