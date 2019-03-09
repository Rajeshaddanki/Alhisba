//
//  CalendarViewController.m
//  all3abb
//
//  Created by apple on 12/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "CalendarViewController1.h"
#import "HomeViewController.h"
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"

@interface CalendarViewController1 (){
    
    NSMutableDictionary *_eventsByDate;
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    NSDate *_dateSelected;
    NSString *dateString;
    NSArray *weekOfs;
    NSArray *dateString1;
    NSString *weekof1;
    NSString *weekof2;
    NSString *reqDateString;
    NSString *haveDAte;
    UIBarButtonItem *customBarRightBtn;
    NSString *currentTime,*strat1,*difftime1;
    UIButton *backBtn;
    int startTime;
    int endTime;
}

@end

@implementation CalendarViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
//    weekof1=@"5";
//    weekof2=@"6";
    
    dateString1 = [[NSMutableArray alloc]init];
    haveDAte=@"first";
    
    _infoLbl.hidden = NO;
    [_infoLbl setTextAlignment:NSTextAlignmentCenter];
    
    _timerView.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [imageView setImage:image];
    [imageView.widthAnchor constraintEqualToConstant:120].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:120].active = YES;
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imageView;

    _returnDate.text = Localized(@"Select return date");
    _selectYourReturnHour.text = Localized(@"Select your start hour");
    [_bookBtn setTitle:Localized(@"Book") forState:UIControlStateNormal];


    [_returnDate setTextAlignment:NSTextAlignmentCenter];
    
    self.navigationItem.title = Localized(@"CALENDAR");
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"secondTime" forKey:@"DateFirstSecond"];
    [standardUserDefaults synchronize];

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi" size:20.0],NSFontAttributeName,nil];
        
    }   else
    {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Roboto-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        backBtn = [[UIButton alloc] init];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(0, 0, 30, 30);
//        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
//    }
//    else{
//        
//        backBtn = [[UIButton alloc] init];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(0, 0, 30, 30);
//        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
//    }
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
        [_previousBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        
    }
    else{
        
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
        [_nextBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        [_previousBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
    }
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.doneBtn.layer.cornerRadius = self.doneBtn.frame.size.height/2;
    self.doneBtn.clipsToBounds=YES;

    self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.size.height/2;
    self.cancelBtn.clipsToBounds=YES;

    self.navigationItem.hidesBackButton=YES;

//    [self makePostCallForPage:CALENDAR withParams:@{} withRequestCode:1];

    _doneBtn.userInteractionEnabled = NO;

    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    NSString *myString = [NSString stringWithFormat:@"%@",[_calendarManager date]];
    NSArray *stringComponents = [myString componentsSeparatedByString:@"-"];
    NSString *myFinalString = [stringComponents objectAtIndex:0];
    NSLog(@"Previous page loaded %@",myFinalString);
    
    _calendarYear.text = [NSString stringWithFormat:@"%@",myFinalString];
    
    [_calendarYear setTextAlignment:NSTextAlignmentCenter];

}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
   // NSLog(@"result is%@",result);
    
    if (requestCode == 1) {
        
        NSArray *dateArray = [result valueForKey:@"holidays"];
        NSArray *timeSlots = [result valueForKey:@"time_slots"];
        
        NSLog(@"time slots %@",timeSlots);
        
//        weekOfs = [result valueForKey:@"week_offs"];
//            weekof1 = [weekOfs objectAtIndex:0];
//            weekof2 = [weekOfs objectAtIndex:1];
        
        if([dateArray isKindOfClass:[NSNull class]]) {
            dateString1 = [[NSArray alloc] initWithObjects:@"2017-09-10",@"2017-09-14",@"2017-09-19",@"",@"2017-09-20", nil];
        }
        else{
            dateString1 = [dateArray valueForKey:@"date"];
        }
        [_calendarManager reload];
        
//        [self makePostCallForPage:CALENDAR2 withParams:@{} withRequestCode:120];
    }
    
    else{
        
        weekOfs = [result valueForKey:@"week_offs"];
        NSLog(@"week ofs%@",weekOfs);
    }

}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    NSString *str3=[[NSUserDefaults standardUserDefaults] valueForKey:@"dateString"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dateString"]);
    NSString *strD=[[self dateFormatter] stringFromDate:dayView.date];

    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor clearColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor clearColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor clearColor];
        //dayView.textLabel.textColor = [UIColor blackColor];
        dayView.textLabel.textColor = [UIColor whiteColor];

    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor clearColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    //haveDAte=@"first";
    
    //    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"dayviewDate"];
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    dateFormat.dateFormat = @"yyyy-MM-dd";
    //    NSDate *date = [dateFormat dateFromString:str];
    //    dayView.date = date;
    
    _dateSelected = dayView.date;
    
    //   NSDate *now = [NSDate date];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    NSArray *daysOfWeek = @[@"",@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    [nowDateFormatter setDateFormat:@"e"];
    NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:dayView.date] integerValue];
    NSLog(@"Day of Week: %@",[daysOfWeek objectAtIndex:weekdayNumber]);
    
    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
    [memberId setObject:[daysOfWeek objectAtIndex:weekdayNumber] forKey:@"weekString"];
    [memberId synchronize];
    
    reqDateString = [[self dateFormatter] stringFromDate:_dateSelected];
    
    const int secsInHour = 60*60;
    const int secsInDay = 24*secsInHour;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *dc = [cal components:units fromDate:_dateSelected];
    
    if (dc.weekday == weekof1.integerValue || dc.weekday == weekof2.integerValue) {
        
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor clearColor];
        dayView.dotView.backgroundColor = [UIColor clearColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
        _doneBtn.userInteractionEnabled = NO;
        
    } else {
        
        if([[[self dateFormatter] stringFromDate:_dateSelected] compare:[[NSUserDefaults standardUserDefaults] valueForKey:@"dayviewDate"]] == NSOrderedAscending)
        {
            NSString *today=[NSString stringWithFormat:@"%@",[NSDate date]];
            NSString *chooseday=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dayviewDate"]];
            NSArray *date1=[today componentsSeparatedByString:@" "];
            NSArray *date2=[chooseday componentsSeparatedByString:@" "];
            
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor clearColor];
            dayView.dotView.backgroundColor = [UIColor clearColor];
            dayView.textLabel.textColor = [UIColor lightGrayColor];
            
            if([[date1 objectAtIndex:0] isEqualToString:[date2 objectAtIndex:0]])
            {
                NSLog(@"Today date clicked");
                
                NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                [memberId1 setObject:@"DateField" forKey:@"DateText"];
                [memberId1 synchronize];
                
                NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                [memberId setObject:reqDateString forKey:@"dateString1"];
                [memberId synchronize];
                
          [self.navigationController popViewControllerAnimated:NO];
                
            }
            else
            {
                if ([_dateSelected isEqualToDate:[NSDate date]]) {
                    
                    NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                    [memberId1 setObject:@"DateField" forKey:@"DateText"];
                    [memberId1 synchronize];
                    
                    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                    [memberId setObject:reqDateString forKey:@"dateString1"];
                    [memberId synchronize];
                    
                    
           [self.navigationController popViewControllerAnimated:NO];
                    
                }

                NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                [memberId1 setObject:@"DateField" forKey:@"DateText"];
                [memberId1 synchronize];
                
                NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                [memberId setObject:reqDateString forKey:@"dateString1"];
                [memberId synchronize];
                
                
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
        
        else {
            
            for (NSString *str in dateString1) {
                
                if ([reqDateString isEqualToString:str]) {
                    
                    _doneBtn.userInteractionEnabled = NO;
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [UIColor clearColor];
                    dayView.dotView.backgroundColor = [UIColor clearColor];
                    dayView.textLabel.textColor = [UIColor blackColor];
                    
                    NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                    [memberId1 setObject:@"DateField" forKey:@"DateText"];
                    [memberId1 synchronize];
                    
                    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                    [memberId setObject:reqDateString forKey:@"dateString1"];
                    [memberId synchronize];
                    
                    
                    [self.navigationController popViewControllerAnimated:NO];
                }
                
            }
            if([haveDAte isEqual:@"first"]){
                
                if ([[[self dateFormatter] stringFromDate:_dateSelected] compare:[[self dateFormatter] stringFromDate:[[NSUserDefaults standardUserDefaults] valueForKey:@"dayviewDate"]]] == NSOrderedAscending) {
                   
                    NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                    [memberId1 setObject:@"DateField" forKey:@"DateText"];
                    [memberId1 synchronize];
                    
                    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                    [memberId setObject:reqDateString forKey:@"dateString1"];
                    [memberId synchronize];
                    
                    
                    [self.navigationController popViewControllerAnimated:NO];

//                    _timerView.hidden = YES;
                }
                else{
                    
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [UIColor whiteColor];
                    dayView.dotView.backgroundColor = [UIColor whiteColor];
                    dayView.textLabel.textColor = [UIColor blackColor];       // For holidays.
                    
                    NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                    [memberId1 setObject:@"DateField" forKey:@"DateText"];
                    [memberId1 synchronize];
                    
                    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                    [memberId setObject:reqDateString forKey:@"dateString1"];
                    [memberId synchronize];
                    
                                    [self.navigationController popViewControllerAnimated:NO];
                    
//                    _timerView.hidden = NO;
//                    _infoLbl.hidden = YES;
//
//                    _returnDate.text = [NSString stringWithFormat:@"%@",reqDateString];
//
//                    [_timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
                    
                }
            }
            
        }
    }
    //    [[self dateFormatter] setDateFormat:@"MMMM,dd"];
    [[self dateFormatter] setDateFormat:@"yyyy-MM-dd"];
    
    // dateString = [[self dateFormatter] stringFromDate:_dateSelected];
    
    // Animation for the circleView
    
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

- (void)dateChanged:(id)sender
{

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm:ss a"];
        currentTime = [dateFormatter stringFromDate:self.timePicker.date];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"hh:mm a"];
    difftime1 = [dateFormatter stringFromDate:self.timePicker.date];
    
    if ([currentTime length] == 0) {
        
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        dateFormatter1.dateFormat = @"hh:mm:ss a";
        [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter1 stringFromDate:now]);
        currentTime = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:now]];
    }
    else{
        currentTime = [dateFormatter stringFromDate:self.timePicker.date];
    }
        
//        NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
//        [memberId setObject:[NSString stringWithFormat:@"%@,%@",reqDateString,currentTime] forKey:@"dateString1"];
//        [memberId synchronize];
    
    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
    [memberId setObject:[NSString stringWithFormat:@"%@",reqDateString] forKey:@"dateString1"];
    [memberId synchronize];

        
        NSString* combinedString = [reqDateString stringByAppendingString:[NSString stringWithFormat:@" %@",currentTime]];
        NSLog(@"combined String %@",combinedString);
        
        NSUserDefaults *combinedStr = [NSUserDefaults standardUserDefaults];
        [combinedStr setObject:combinedString forKey:@"combinedStr1"];
        [combinedStr synchronize];
        
        NSUserDefaults *standa = [NSUserDefaults standardUserDefaults];
        [standa setObject:currentTime forKey:@"timeString1"];
        [standa synchronize];
    
    NSUserDefaults *standa1 = [NSUserDefaults standardUserDefaults];
    [standa1 setObject:difftime1 forKey:@"difftime1"];
    [standa1 synchronize];

        
        NSUserDefaults *endDate = [NSUserDefaults standardUserDefaults];
        [endDate setObject:[NSString stringWithFormat:@"%@",reqDateString] forKey:@"endDate"];
        [endDate synchronize];
        
        _returnDate.text = [NSString stringWithFormat:@"%@,%@",reqDateString,currentTime];
        NSLog(@"%@", currentTime);
}


#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
    
    NSString *myString = [NSString stringWithFormat:@"%@",[_calendarManager date]];
    NSArray *stringComponents = [myString componentsSeparatedByString:@"-"];
    NSString *myFinalString = [stringComponents objectAtIndex:0];
    NSLog(@"Previous page loaded %@",myFinalString);
    
    _calendarYear.text = [NSString stringWithFormat:@"%@",myFinalString];
    
    [_calendarYear setTextAlignment:NSTextAlignmentCenter];

}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
    
    NSString *myString = [NSString stringWithFormat:@"%@",[_calendarManager date]];
    NSArray *stringComponents = [myString componentsSeparatedByString:@"-"];
    NSString *myFinalString = [stringComponents objectAtIndex:0];
    NSLog(@"Previous page loaded %@",myFinalString);
    
    _calendarYear.text = [NSString stringWithFormat:@"%@",myFinalString];
    
    [_calendarYear setTextAlignment:NSTextAlignmentCenter];

}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-50];
    //_minDate = _fromDate;
    // Max date will be 100 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:100];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
//        [dateFormatter setDateFormat:@"MMMM,dd"];

        NSDate *now = [NSDate date];
        NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
        NSArray *daysOfWeek = @[@"",@"Su",@"M",@"T",@"W",@"Th",@"F",@"S"];
        [nowDateFormatter setDateFormat:@"e"];
        NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:now] integerValue];
        NSLog(@"Day of Week: %@",[daysOfWeek objectAtIndex:weekdayNumber]);
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelBtnCLicked:(id)sender {
    
//    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:obj animated:NO];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)doneBtnCLicked:(id)sender {
//    CheckOutViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckOutViewController"];
//    obj.dateField = reqDateString;
//    [self.navigationController pushViewController:obj animated:NO];

}

- (IBAction)bookBtnClicked:(id)sender {
    
    [self showHUD:@"Loading"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    currentTime = [dateFormatter stringFromDate:self.timePicker.date];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"hh:mm a"];
    difftime1 = [dateFormatter1 stringFromDate:self.timePicker.date];
    
    if ([currentTime length] == 0) {
        
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        dateFormatter1.dateFormat = @"hh:mm:ss a";
        [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter1 stringFromDate:now]);
        currentTime = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:now]];
    }
    else{
        currentTime = [dateFormatter stringFromDate:self.timePicker.date];
    }
    
    NSString* combinedString = [reqDateString stringByAppendingString:[NSString stringWithFormat:@" %@",currentTime]];
    NSLog(@"combined String %@",combinedString);
    
    NSUserDefaults *combinedStr = [NSUserDefaults standardUserDefaults];
    [combinedStr setObject:combinedString forKey:@"combinedStr1"];
    [combinedStr synchronize];
    
    
    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
    [memberId setObject:[NSString stringWithFormat:@"%@",reqDateString] forKey:@"dateString1"];
    [memberId synchronize];

    
    NSUserDefaults *endDate = [NSUserDefaults standardUserDefaults];
    [endDate setObject:[NSString stringWithFormat:@"%@",reqDateString] forKey:@"endDate"];
    [endDate synchronize];

    NSUserDefaults *standa = [NSUserDefaults standardUserDefaults];
    [standa setObject:currentTime forKey:@"timeString1"];
    [standa synchronize];
    
    NSUserDefaults *standa1 = [NSUserDefaults standardUserDefaults];
    [standa1 setObject:difftime1 forKey:@"difftime1"];
    [standa1 synchronize];

    _returnDate.text = [NSString stringWithFormat:@"%@,%@",reqDateString,currentTime];
    NSLog(@"%@", currentTime);

//    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    obj.carsList = @"carsList";
//    [self.navigationController pushViewController:obj animated:NO];
    
    NSUserDefaults *standa2 = [NSUserDefaults standardUserDefaults];
    [standa2 setObject:@"carsList" forKey:@"cart"];
    [standa2 synchronize];
    [self hideHUD];
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)calendarNxtBtnClicked:(id)sender {
    
    [_calendarManager.contentView loadNextPageWithAnimation];
}

- (IBAction)calendarPreviousBtnClicked:(id)sender {
    
    [_calendarManager.contentView loadPreviousPageWithAnimation];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self createMinAndMaxDate];
}

@end
