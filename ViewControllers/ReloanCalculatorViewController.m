//
//  ReloanCalculatorViewController.m
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ReloanCalculatorViewController.h"
#import "SearchTableViewCell.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "ActionSheetStringPicker.h"
#import "Reloan1ViewController.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
@interface ReloanCalculatorViewController ()<UITextFieldDelegate>{
    UIButton *menuBtn,*backBtn;
    NSInteger *propertyValue,*downPaymentValue;
    NSString *valueStr;
    NSMutableArray *listArray,*resultArray;
    NSInteger subs1;
    NSString *installmentStr,*amountStr;
    int labelValue;
    SWRevealViewController *revealViewController;
}

@end

@implementation ReloanCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _enterPropertyValue.delegate = self;
    _downPaymentFld.delegate = self;
    _downpaymentPercentageFld.delegate = self;
    _loanAmountFld.delegate = self;
    _graceYearsFld.delegate = self;
    _graceMonthsFld.delegate = self;
    _repaymentYearsFld.delegate = self;
    _repaymentMonthsFld.delegate = self;
    _anualRateFld.delegate = self;
    _slectPaymentModeFld.delegate = self;
    
//    [self shadow:_enterPropertyValue];
    [self shadow:_downPaymentFld];
    [self shadow:_downpaymentPercentageFld];
    [self shadow:_loanAmountFld];
    [self shadow:_graceYearsFld];
    [self shadow:_graceMonthsFld];
    [self shadow:_anualRateFld];
    [self shadow:_slectPaymentModeFld];
    
    _popUpView.hidden = YES;
    _popUpTabelView.hidden = YES;
    _tableBackView.hidden = YES;
    _resultPopUpViewHeight.constant = 0;
    _resultpopUpTop.constant = -30;
    _resultLbl.hidden = YES;
    _resultPopUpView.hidden = YES;
    _graceYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Years")];
    _graceMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
    _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"5"),Localized(@"Years")];
    _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
    
    
//    NSInteger totalSubs = 5 * 12;
//    subs1 = totalSubs ;
//    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
    labelValue = 5;
    self.anualRateFld.text = [NSString stringWithFormat:@"%@",@"5"];
    
    self.tableBackView.layer.borderColor = [UIColor blackColor].CGColor;
    _tableBackView.layer.cornerRadius = 15.0f;
     [_tableBackView.layer setBorderColor:[UIColor colorWithRed:73.0f/255.0f green:82.0f/255.0f blue:125.0f/255.0f alpha:1.0].CGColor];
    [_tableBackView.layer setBorderWidth:2.0f];
    [_tableBackView.layer setMasksToBounds:YES];
    //[_tableBackView.layer setCornerRadius:5.0f];
    
    _calculateBtn.layer.cornerRadius = 15.0f;
    _resultPopUpView.layer.cornerRadius = 15.0f;
    
    _reloanCalculatorLbl.text = Localized(@"Re Loan calculator");
    _propertyValueKdLbl.text = Localized(@"Property Value (KD)");
    _downPaymentLbl.text = Localized(@"Down Payment (KD)");
    _downPaymentPercentLbl.text = Localized(@"Down Payment (%)");
    _loanAmountLbl.text = Localized(@"Loan Amount");
    _gracePeriodLbl.text = Localized(@"Grace Period");
    _repaymentLbl.text = Localized(@"Repayment Period");
    _anualRateLbl.text = Localized(@"Annual Profit Rate (%)");
    _installmentTypeLbl.text = Localized(@"Installment Type");
    _noOfpaymentsLbl.text = Localized(@"No Of Payments");
    _resultLbl.text = Localized(@"Result");
    
    _totalPurchasePriceLl.text = Localized(@"Total Purchase Price (KD)");
    _bankProfitLbl.text = Localized(@"Bank Profit (KD)");
    _installAmountLbl.text = Localized(@"Installment Amount (KD)");
    _loanDurationLbl.text = Localized(@"Loan Duration");
    
    [_calculateBtn setTitle:Localized(@"Calculate") forState:UIControlStateNormal];

    _noOfpaymentsFld.text = Localized(@"Number of payments");
    NSInteger totalSubs = 5 * 12;
    subs1 = totalSubs ;
    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
    
    [_totalPurchasePriceLl  setTextAlignment:NSTextAlignmentCenter];
    [_bankProfitLbl setTextAlignment:NSTextAlignmentCenter];
    [_installAmountLbl setTextAlignment:NSTextAlignmentCenter];
    [_loanDurationLbl setTextAlignment:NSTextAlignmentCenter];
    
    self.navigationItem.title = Localized(@"Re Loan calculator");
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
    
//    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView sizeToFit];
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                   style:UIBarButtonItemStyleBordered target:self
//                                                                  action:@selector(doneClicked:)];
//    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
//    _enterPropertyValue.inputAccessoryView = keyboardDoneButtonView;
//    
//    
//    UIToolbar *keyboardDoneButtonView1 = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView1 sizeToFit];
//    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                    style:UIBarButtonItemStyleBordered target:self
//                                                                   action:@selector(doneClicked:)];
//    [keyboardDoneButtonView1 setItems:[NSArray arrayWithObjects:doneButton1, nil]];
//    _downPaymentFld.inputAccessoryView = keyboardDoneButtonView1;
//    
//    UIToolbar *keyboardDoneButtonView3 = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView3 sizeToFit];
//    UIBarButtonItem *doneButton3 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                    style:UIBarButtonItemStyleBordered target:self
//                                                                   action:@selector(doneClicked:)];
//    [keyboardDoneButtonView3 setItems:[NSArray arrayWithObjects:doneButton3, nil]];
//    _downpaymentPercentageFld.inputAccessoryView = keyboardDoneButtonView3;
//
//    
//    UIToolbar *keyboardDoneButtonView2 = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView2 sizeToFit];
//    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                    style:UIBarButtonItemStyleBordered target:self
//                                                                   action:@selector(doneClicked:)];
//    [keyboardDoneButtonView2 setItems:[NSArray arrayWithObjects:doneButton2, nil]];
//    _loanAmountFld.inputAccessoryView = keyboardDoneButtonView2;
//    
//    
//    
//    UIToolbar *keyboardDoneButtonView4 = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView4 sizeToFit];
//    UIBarButtonItem *doneButton4 = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                   style:UIBarButtonItemStyleBordered target:self
//                                                                  action:@selector(doneClicked:)];
//    [keyboardDoneButtonView4 setItems:[NSArray arrayWithObjects:doneButton4, nil]];
//    _anualRateFld.inputAccessoryView = keyboardDoneButtonView4;

    _slectPaymentModeFld.text =Localized(@"Monthly");
    installmentStr = @"1";
    
     _downPaymentFld.userInteractionEnabled = YES;
     _downpaymentPercentageFld.userInteractionEnabled = NO;
    
    amountStr = @"amount";
    [_downPaymentBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];

    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
     [menuBtn addTarget:self action:@selector(reloanBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
    }
    else{
        
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
    }
    
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    
    _enterPropertyValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Property Value in KD") attributes:@{NSForegroundColorAttributeName: color}];
    _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
    _downpaymentPercentageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (%)") attributes:@{NSForegroundColorAttributeName: color}];
    _loanAmountFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Loan Amount") attributes:@{NSForegroundColorAttributeName: color}];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;

    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Re Loan calculator");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel.backgroundColor = [UIColor clearColor];
    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel sizeToFit];
    UIImage *image = [UIImage imageNamed: @"badge.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame] ;
    [newView addSubview:imageView];
    [newView addSubview:tmpTitleLabel];
    tmpTitleLabel.center=newView.center;
    imageView.frame = CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20)];
    [btn addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:btn];
    self.navigationItem.titleView = newView;
    
    
    
   // [self customSetup];
    
    [self textFldBoarders];
    [self paddingFlds];
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Re Loan calculator") :sender];
}


-(void)viewWillAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"RELOANCALCULATOR RESULT SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;

}
- (void)customSetup
{
    [menuBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            //            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            //            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-120;
            
            [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        // self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        printf("unknown");
                }
            }
            
        }else{
            
            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        //  self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        printf("unknown");
                }
            }
            
        }
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    //resultArray = result;
            Reloan1ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"Reloan1ViewController"];
        obj.dict = result;
    
   

    //our values
    
    obj.areaTitle1 = [NSString stringWithFormat:@"%@ %@",[self strToCurrencyFormatter:_enterPropertyValue.text],Localized(@"KD")];
    //obj.streetTitle1 = [NSString stringWithFormat:@"%@ %@",_downPaymentFld.text,Localized(@"KD")];
    obj.streetTitle1 = [NSString stringWithFormat:@"%@ %@",[self strToCurrencyFormatter:_downPaymentFld.text],Localized(@"KD")];

    obj.locationTitle1 = [NSString stringWithFormat:@"%@",_downpaymentPercentageFld.text];
    obj.buildingAgeTitle1 = [NSString stringWithFormat:@"%@ %@",[self strToCurrencyFormatter:_loanAmountFld.text],Localized(@"KD")];
    obj.finishingQualityTitle1 = [NSString stringWithFormat:@"%@",_anualRateFld.text];
    obj.basementTitle1 = [NSString stringWithFormat:@"%@ %@",_graceYearsFld.text,_graceMonthsFld.text];
    obj.noOffloorsTitle1 = [NSString stringWithFormat:@"%@ %@",_repaymentYearsFld.text,_repaymentMonthsFld.text];

    obj.seaFrontTitle1 = [NSString stringWithFormat:@"%@",_slectPaymentModeFld.text];
    obj.backStreetTitle1 = [NSString stringWithFormat:@"%@",_noOfpaymentsFld.text];

    
    
    
    
    
    
    
    
    
    
    
    
            [self.navigationController pushViewController:obj animated:YES];
//    NSString *prof = [NSString stringWithFormat:@"%@",[result valueForKey:@"bank_profit"]];
//    NSString *emi =  [NSString stringWithFormat:@"%@",[result valueForKey:@"emi"]];
//    NSString *total =  [NSString stringWithFormat:@"%@",[result valueForKey:@"tot_purchase"]];
//
////    _totalPurchasePrice.text = [NSString stringWithFormat:@"%ld",(long)total.integerValue];
////    _bankProfitPrice.text = [NSString stringWithFormat:@"%ld",(long)prof.integerValue];
////    _installAmountPrice.text = [NSString stringWithFormat:@"%ld",(long)emi.integerValue];
////    _loanDurationValue.text = [result valueForKey:@"term"];
//    _totalPurchasePrice.text = total;
//        _bankProfitPrice.text = prof;
//        _installAmountPrice.text = emi;
//        _loanDurationValue.text = [result valueForKey:@"term"];
    [self hideHUD];
}

#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"SearchTableViewCell";
        
        SearchTableViewCell *cell = [_popUpTabelView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    cell.titleLbl.text = [listArray objectAtIndex:indexPath.row];

    [cell.radioButton setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
        
        cell.radioButton.tag = indexPath.row;
        cell.titleBtn.tag = indexPath.row;
    
        [cell.radioButton addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.titleBtn addTarget:self action:@selector(checkBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
}


-(void)checkBtnClicked1:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_popUpTabelView];
    
    NSIndexPath *indexPath = [_popUpTabelView indexPathForRowAtPoint:buttonFrame.origin];
    
//    [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    if ([valueStr isEqualToString:@"graceYear"]) {
        
        _graceYearsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],@"Years"];
    }
    else  if ([valueStr isEqualToString:@"graceMonth"]) {
        
        _graceMonthsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],@"Months"];
    }
    else if ([valueStr isEqualToString:@"repaymentYear"]){
        
        _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],@"Years"];
        
        NSString *str = _repaymentYearsFld.text;
        NSString *str1 = _repaymentMonthsFld.text;
        
        NSUInteger value1 =str.intValue;
        NSUInteger value2 = str1.intValue;
        NSInteger subs = value1 + value2;
        
        //        NSString *repayYea = [NSString stringWithFormat:@"%@",_repaymentYearsFld.text];
        //        NSUInteger repay = repayYea.intValue;
        NSUInteger yearV = 12;
        NSInteger totalSubs = subs * yearV;
        NSInteger totalSubPlus = totalSubs + value2;
        
        if ([_slectPaymentModeFld.text isEqualToString:@"Monthly"]) {
            
            NSString *str = @"1";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        
        else if ([_slectPaymentModeFld.text isEqualToString:@"Quartely"]){
            
            NSString *str = @"3";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Semi-Annual"]){
            
            NSString *str = @"6";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Annual"]){
            
            NSString *str = @"12";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else{
            
        }
    }
    else if ([valueStr isEqualToString:@"repaymentMonth"]){
        
        _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],@"Months"] ;
        
        NSString *str = _repaymentYearsFld.text;
        NSString *str1 = _repaymentMonthsFld.text;
        
        NSUInteger value1 =str.intValue;
        NSUInteger value2 = str1.intValue;
        //        NSInteger subs = value1 + value2;
        
        NSUInteger yearV = 12;
        
        NSInteger totalSubs = value1 * yearV;
        NSInteger totalSubPlus = totalSubs + value2;
        
        
        if ([_slectPaymentModeFld.text isEqualToString:@"Monthly"]) {
            
            NSString *str = @"1";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Quartely"]){
            
            NSString *str = @"3";
            subs1 = totalSubPlus / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Semi-Annual"]){
            
            NSString *str = @"6";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Annual"]){
            
            NSString *str = @"12";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else{
            
        }
    }
    else if ([valueStr isEqualToString:@"installMent"]){
        
        _slectPaymentModeFld.text = [listArray objectAtIndex:indexPath.row];
        
        if ([_slectPaymentModeFld.text isEqualToString:@"Monthly"]) {
            
            NSString *str = @"1";
            installmentStr = @"1";
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Quartely"]){
            
            NSString *str = @"3";
            installmentStr = @"3";
            NSUInteger subsVal = subs1 / 3;
            
            NSString *value = [NSString stringWithFormat:@"%ld",subs1 % 3];
            
           // int nu = value.integerValue;
            
            if ([value isEqualToString:str]) {
                
                _noOfpaymentsFld.text = [NSString stringWithFormat:@"%lu",subsVal+1];
            }
            else if (value > str){
                
                _noOfpaymentsFld.text = [NSString stringWithFormat:@"%lu",subsVal+1];
            }
            else{
                
                _noOfpaymentsFld.text = [NSString stringWithFormat:@"%lu",(unsigned long)subsVal];
            }
            
//            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Semi-Annual"]){
            
            NSString *str = @"6";
            installmentStr = @"6";
            
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:@"Annual"]){
            
            NSString *str = @"12";
            installmentStr = @"12";
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else{
            
            
        }
    }
    else{
        
    }
    
    _popUpView.hidden = YES;
    _popUpTabelView.hidden = YES;
    _tableBackView.hidden = YES;
    
}

-(void)checkBtnClicked:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_popUpTabelView];
    
    NSIndexPath *indexPath = [_popUpTabelView indexPathForRowAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    if ([valueStr isEqualToString:@"graceYear"]) {
        
        _graceYearsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],Localized(@"Years")];
    }
  else  if ([valueStr isEqualToString:@"graceMonth"]) {
      
      _graceMonthsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],Localized(@"Months")];
    }
    else if ([valueStr isEqualToString:@"repaymentYear"]){
        
        _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],Localized(@"Years")];
        
        NSString *str = _repaymentYearsFld.text;
        NSString *str1 = _repaymentMonthsFld.text;
        
        NSUInteger value1 =str.intValue;
        NSUInteger value2 = str1.intValue;
        NSInteger subs = value1 + value2;
        
//        NSString *repayYea = [NSString stringWithFormat:@"%@",_repaymentYearsFld.text];
//        NSUInteger repay = repayYea.intValue;
        NSUInteger yearV = 12;
        NSInteger totalSubs = subs * yearV;
        NSInteger totalSubPlus = totalSubs + value2;

        if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Monthly")]) {
            
            NSString *str = @"1";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Quartely")]){
            
            NSString *str = @"3";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Semi-Annual")]){
            
            NSString *str = @"6";
             subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];

        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Annual")]){
            
            NSString *str = @"12";
             subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else{
            
        }
    }
    else if ([valueStr isEqualToString:@"repaymentMonth"]){
        
        _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:indexPath.row],@"Months"] ;
        
        NSString *str = _repaymentYearsFld.text;
        NSString *str1 = _repaymentMonthsFld.text;
        
        NSUInteger value1 =str.intValue;
        NSUInteger value2 = str1.intValue;
//        NSInteger subs = value1 + value2;
        
        NSUInteger yearV = 12;
        
        NSInteger totalSubs = value1 * yearV;
        NSInteger totalSubPlus = totalSubs + value2;
        
        
        if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Monthly")]) {
            
            NSString *str = @"1";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Quartely")]){
            
            NSString *str = @"3";
            subs1 = totalSubPlus / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Semi-Annual")]){
            
            NSString *str = @"6";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Annual")]){
            
            NSString *str = @"12";
            subs1 = totalSubPlus / str.intValue;
            
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else{
            
        }
    }
    else if ([valueStr isEqualToString:@"installMent"]){
        
        _slectPaymentModeFld.text = [listArray objectAtIndex:indexPath.row];
        
        if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Monthly")]) {
            
            NSString *str = @"1";
            installmentStr = @"1";
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Quartely")]){
            
            NSString *str = @"3";
            installmentStr = @"3";
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Semi-Annual")]){
            
            NSString *str = @"6";
            installmentStr = @"6";
            
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Annual")]){
            
            NSString *str = @"12";
            installmentStr = @"12";
            NSUInteger subsVal = subs1 / str.intValue;
            _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
        }
        else{
            
            
        }
    }
    else{
        
    }

    _popUpView.hidden = YES;
    _popUpTabelView.hidden = YES;
    _tableBackView.hidden = YES;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 60;
}

-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)propertyValueTap{

    _loanAmountFld.text = _enterPropertyValue.text;
}


//-(void) textFieldDidChange {
//
//    NSNumberFormatter *formatter = [NSNumberFormatter new];
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
//
//    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:2000000]];
//    NSLog(@"the Formatted String is  %@",formatted);
//
//    textField.text = formatted;
//}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _enterPropertyValue) {
        NSLog(@"fknjkfnkjef");

        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
                if (isBackSpace == -8) {
            NSLog(@"Backspace was pressed");
                    
                    if ([_loanAmountFld.text length] > 0) {
                        NSString *downP = [_enterPropertyValue.text substringToIndex:[_enterPropertyValue.text length] - 1];
                        
                        NSString *str1 = [NSString stringWithFormat:@"%@",downP];
                        NSString *str12 = [NSString stringWithFormat:@"%@",_downPaymentFld.text];
                        
                        NSUInteger value12 =str1.intValue;
                        NSUInteger value2 = str12.intValue;
                        NSInteger subs = value12 - value2;
                        
                        if ([str1 isEqualToString:@"0"]) {
                            
                            UIColor *color = [UIColor whiteColor];
                            _downPaymentFld.text = @"";
                            _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
                        }
                        else{
                            //    NSInteger subs1 = value12 / value2;
                            //  _downPaymentFld.text = [NSString stringWithFormat:@"%ld",(long)value2];
                        }
                        
                        NSLog(@"subs 1 is %ld",(long)subs1);
                        _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs];
                        _loanAmountFld.text = [_loanAmountFld.text substringToIndex:[_loanAmountFld.text length] - 1];
                        
                        NSString *str = _loanAmountFld.text;
                        
                        if ([str isEqualToString:@""]) {
                            
                            UIColor *color = [UIColor whiteColor];
                            
                            _downPaymentFld.text = @"";
                            _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];

                            _downpaymentPercentageFld.text = @"";
                            _downpaymentPercentageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (%)") attributes:@{NSForegroundColorAttributeName: color}];
                        }
                        else{
                            
                        }

            // NSString *str = _loanAmountFld.text;
           // NSString *str1 = _enterPropertyValue.text;
//            NSNumberFormatter *formatter = [NSNumberFormatter new];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
//        NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:str.intValue]];
//        NSLog(@"the Formatted String is  %@",formatted);
//                _loanAmountFld.text = formatted;
                        
//                        NSNumberFormatter *formatter1 = [NSNumberFormatter new];
//                        [formatter1 setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
//                        NSString *formatted1 = [formatter stringFromNumber:[NSNumber numberWithInteger:str1.intValue]];
//                        NSLog(@"the Formatted String is  %@",formatted1);
//                        _enterPropertyValue.text = formatted;

                        //_loanAmountFld.text = [NSString stringWithFormat:@"%@",string];
                        
                    } else {
                        //no characters to delete... attempting to do so will result in a crash
                    }
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%@",_downPaymentFld.text];
            NSString *str1 = [NSString stringWithFormat:@"%@%@",_enterPropertyValue.text,string];
            
            NSUInteger value1 =str1.intValue;
            NSUInteger value2 = str.intValue;
            NSInteger subs = value1 - value2;
           // NSInteger subs1 = value1 / value2;
            
            NSLog(@"subs 1 is %ld",(long)subs1);
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs];
           // _loanAmountFld.text = [NSString stringWithFormat:@"%@%@",_enterPropertyValue.text,string];
           // NSString *str = _loanAmountFld.text;
            
        
            
         //   NSString *str1 = _enterPropertyValue.text;
            
//            NSNumberFormatter *formatter = [NSNumberFormatter new];
//            [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
//            NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:str.intValue]];
//            NSLog(@"the Formatted String is  %@",formatted);
//            _loanAmountFld.text = formatted;
            
//            NSNumberFormatter *formatter1 = [NSNumberFormatter new];
//            [formatter1 setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
//            NSString *formatted1 = [formatter stringFromNumber:[NSNumber numberWithInteger:str1.intValue]];
//            NSLog(@"the Formatted String is  %@",formatted1);
//            _enterPropertyValue.text = formatted;
        }
        
       // [self propertyValueTap];
    }
    else if (textField == _downPaymentFld){
        
        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
        if (isBackSpace == -8) {
            NSLog(@"Backspace was pressed");
            NSString *str = [NSString stringWithFormat:@"%@",_enterPropertyValue.text];
            NSUInteger value1 =str.intValue;
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)value1];

            UIColor *color = [UIColor whiteColor];
            _downpaymentPercentageFld.text = @"";
            _downpaymentPercentageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (%)") attributes:@{NSForegroundColorAttributeName: color}];
            
            // Added for when deleting the data at downpaymnet....
            
          //  _downPaymentFld.text = [_downPaymentFld.text substringToIndex:[_downPaymentFld.text length] - 1];
            
            
            
            NSString *downP = [_downPaymentFld.text substringToIndex:[_downPaymentFld.text length] - 1];
            
            NSString *str12 = [NSString stringWithFormat:@"%@",_enterPropertyValue.text];
            NSString *str1 = [NSString stringWithFormat:@"%@",downP];
            
            NSUInteger value12 =str12.intValue;
            NSUInteger value2 = str1.intValue;
            NSInteger subs = value12 - value2;
            
            if ([str1 isEqualToString:@"0"]) {
                
                UIColor *color = [UIColor whiteColor];
                _downPaymentFld.text = @"";
                _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
            }
            else{
            //    NSInteger subs1 = value12 / value2;
              //  _downPaymentFld.text = [NSString stringWithFormat:@"%ld",(long)value2];
            }
            
            NSLog(@"subs 1 is %ld",(long)subs1);
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs];

         //   NSUInteger value3 = 100;
            NSInteger subs5 = value1/100;
            NSUInteger subs6 = value2 / subs5;

            //  NSUInteger subs6 = subs5/value3;
            //NSLog(@"subs 6 is %ld",(long)subs6);

            _downpaymentPercentageFld.text = [NSString stringWithFormat:@"%ld",(long)subs6];
//            NSLog(@"_downpaymentPercentageFld text is %@",_downpaymentPercentageFld.text);
            NSLog(@"_downpaymentpayementFld text is %@",_downPaymentFld.text);
            NSLog(@"_downpaymentpayementFld text is %@",_downPaymentFld.text);
            NSLog(@"_downpaymentpayementFld text is %@",_downPaymentFld.text);
            NSLog(@"_downpaymentpayementFld text is %@",_downPaymentFld.text);


    }
        else{
           
            NSString *str = [NSString stringWithFormat:@"%@",_enterPropertyValue.text];
            NSString *str1 = [NSString stringWithFormat:@"%@%@",_downPaymentFld.text,string];
            NSUInteger value1 =str.intValue;
            NSUInteger value2 = str1.intValue;
            if(value2>value1-1)
            {
                [self showErrorAlertWithMessage:Localized(@"DownPayment ShouldBe LessThan ProperValue")];
                return NO;
            }
            NSInteger subs = value1 - value2;
           // NSInteger subs1 = value1 / value2;
            
            NSLog(@"subs 1 is %ld",(long)subs1);
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs];
            
//            NSUInteger value3 = 100;
            NSInteger subs5 = value1/100;
            
            NSUInteger subs6;
            
            if (subs5 == 0) {
                
                subs6 = value2/value1;
            }
            else{
                subs6 = value2 / subs5;
            }
            
            
          //  NSUInteger subs6 = subs5/value3;
          //NSLog(@"subs 6 is %ld",(long)subs6);
            
            _downpaymentPercentageFld.text = [NSString stringWithFormat:@"%ld",(long)subs6];
            NSLog(@"_downpaymentPercentageFld text is %@",_downpaymentPercentageFld.text);
        
        }
    }
    
    else if (textField == _downpaymentPercentageFld){
        
        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
        if (isBackSpace == -8) {
            
            NSString *downPayPerc = [_downpaymentPercentageFld.text substringToIndex:[_downpaymentPercentageFld.text length] - 1];

            NSString *str = [NSString stringWithFormat:@"%@",_enterPropertyValue.text];
            NSString *str1 = [NSString stringWithFormat:@"%@",downPayPerc];
            
            NSUInteger value1 =str.intValue;
            NSUInteger value2 = str1.intValue;
            
            NSInteger subs = value1*value2/100;
            
            _downPaymentFld.text = [NSString stringWithFormat:@"%ld",(long)subs];
            
            NSString *str2 = [NSString stringWithFormat:@"%@",_downPaymentFld.text];
            NSInteger subs1 = str.intValue - str2.intValue;
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%@",_enterPropertyValue.text];
            NSString *str1 = [NSString stringWithFormat:@"%@%@",_downpaymentPercentageFld.text,string];
            
            NSUInteger value1 =str.intValue;
            NSUInteger value2 = str1.intValue;
            if(value2>99)
            {
                [self showErrorAlertWithMessage:Localized(@"DownPayment ShouldBe LessThan ProperValue")];
                return NO;
            }
            NSInteger subs = value1*value2/100;
            
            _downPaymentFld.text = [NSString stringWithFormat:@"%ld",(long)subs];
            
            NSString *str2 = [NSString stringWithFormat:@"%@",_downPaymentFld.text];
            NSInteger subs1 = str.intValue - str2.intValue;
            _loanAmountFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
            
            if ([str1 isEqualToString:@""]) {
                
                UIColor *color = [UIColor whiteColor];
                _downPaymentFld.text = @"";
                _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
            }
            else{
                
            }
        }
    }
    else{
        
    }

    return YES;
}

-(void)downPaYbtnTap{


}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)closeBtnTapped:(id)sender {
    _popUpView.hidden = YES;
    _popUpTabelView.hidden = YES;
    _tableBackView.hidden = YES;
}

-(void)reloanBtnTapped{
    
    UIColor *color = [UIColor whiteColor];
    _enterPropertyValue.text = @"";
    _downPaymentFld.text = @"";
    _downpaymentPercentageFld.text = @"";
    _loanAmountFld.text = @"";
    _graceYearsFld.text = @"0 Years";
    _graceMonthsFld.text = @"0 Months";
    _repaymentYearsFld.text = @"0 Years";
    _repaymentMonthsFld.text = @"0 Months";
    _graceYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Years")];
    _graceMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
    _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"5"),Localized(@"Years")];
    _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
    //    NSInteger totalSubs = 5 * 12;
    //    subs1 = totalSubs ;
    //    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
    _resultPopUpViewHeight.constant = 0;
    _resultPopUpView.hidden = YES;
    _resultpopUpTop.constant = 0;
    _resultLbl.hidden = YES;
    
    _enterPropertyValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Property Value in KD") attributes:@{NSForegroundColorAttributeName: color}];
    _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
    _downpaymentPercentageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (%)") attributes:@{NSForegroundColorAttributeName: color}];
    _loanAmountFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Loan Amount") attributes:@{NSForegroundColorAttributeName: color}];
    
    //    _noOfpaymentsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Number of payments") attributes:@{NSForegroundColorAttributeName: color}];
    
    _noOfpaymentsFld.text = Localized(@"Number of payments");
    NSInteger totalSubs = 5 * 12;
    subs1 = totalSubs ;
    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
}

- (IBAction)refreshBtnTapped:(id)sender {
    
    UIColor *color = [UIColor whiteColor];
    _enterPropertyValue.text = @"";
    _downPaymentFld.text = @"";
    _downpaymentPercentageFld.text = @"";
    _loanAmountFld.text = @"";
    _graceYearsFld.text = @"0 Years";
    _graceMonthsFld.text = @"0 Months";
    _repaymentYearsFld.text = @"0 Years";
    _repaymentMonthsFld.text = @"0 Months";
    _graceYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Years")];
    _graceMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
    _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"5"),Localized(@"Years")];
    _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",Localized(@"0"),Localized(@"Months")];
//    NSInteger totalSubs = 5 * 12;
//    subs1 = totalSubs ;
//    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
    _resultPopUpViewHeight.constant = 0;
    _resultPopUpView.hidden = YES;
    _resultpopUpTop.constant = 0;
    _resultLbl.hidden = YES;
    
    _enterPropertyValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Property Value in KD") attributes:@{NSForegroundColorAttributeName: color}];
    _downPaymentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (KD)") attributes:@{NSForegroundColorAttributeName: color}];
    _downpaymentPercentageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Down Payment (%)") attributes:@{NSForegroundColorAttributeName: color}];
    _loanAmountFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Loan Amount") attributes:@{NSForegroundColorAttributeName: color}];

//    _noOfpaymentsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Number of payments") attributes:@{NSForegroundColorAttributeName: color}];
    
    _noOfpaymentsFld.text = Localized(@"Number of payments");
    NSInteger totalSubs = 5 * 12;
    subs1 = totalSubs ;
    _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
}

- (IBAction)downPaymentBtntapped:(id)sender {
    NSLog(@"comming");
    _downPaymentPerentageBtn.selected = NO;
    
    if (_downPaymentBtn.selected == YES)
    {
         amountStr = @"";
        _downPaymentFld.userInteractionEnabled = NO;
        _downpaymentPercentageFld.userInteractionEnabled = YES;
        [_downPaymentBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
        _downPaymentBtn.selected = NO;
    }
    else
    {
        amountStr = @"amount";
        _downPaymentFld.userInteractionEnabled = YES;
        _downpaymentPercentageFld.userInteractionEnabled = NO;
        [_downPaymentBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
        [_downPaymentPerentageBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
        _downPaymentBtn.selected = YES;

    }
}

- (IBAction)downPaymentPerentageBtnTapped:(id)sender {
    
    _downPaymentBtn.selected = NO;
    if (_downPaymentPerentageBtn.selected == YES)
    {
        amountStr = @"";
        [_downPaymentPerentageBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
        NSLog(@"NO NO");
        _downpaymentPercentageFld.userInteractionEnabled = NO;
          _downPaymentFld.userInteractionEnabled = YES;
        _downPaymentPerentageBtn.selected = NO;
    }
    else
    {
         amountStr = @"percent";
        NSLog(@"YES YES");
        [_downPaymentPerentageBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
        [_downPaymentBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
           _downpaymentPercentageFld.userInteractionEnabled = YES;
        _downPaymentFld.userInteractionEnabled = NO;
        _downPaymentPerentageBtn.selected = YES;
    }
}

- (IBAction)gracePeriodYearsBtnTapped:(id)sender {
    
    valueStr = @"graceYear";
    
    listArray = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Grace Year")
                                            rows:listArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           _graceYearsFld.text=[NSString stringWithFormat:@"%@",[listArray objectAtIndex:selectedIndex]];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
//    _popUpView.hidden = NO;
//    _popUpTabelView.hidden = NO;
//    _tableBackView.hidden = NO;
//    [_popUpTabelView reloadData];
    
    [_enterPropertyValue resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];

}

- (IBAction)gracePeriodMonthsBtnTapped:(id)sender {
   
    valueStr = @"graceMonth";
    listArray = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Grace Month")
                                            rows:listArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           _graceMonthsFld.text=[NSString stringWithFormat:@"%@",[listArray objectAtIndex:selectedIndex]];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];

//    _popUpView.hidden = NO;
//    _popUpTabelView.hidden = NO;
//    _tableBackView.hidden = NO;
//    [_popUpTabelView reloadData];
    
    [_enterPropertyValue resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];

}

- (IBAction)repaymentYearsBtnTapped:(id)sender {
    
    valueStr = @"repaymentYear";
    
    listArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    
    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Repayment Year")
                                            rows:listArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
//                                           _repaymentYearsFld.text=[NSString stringWithFormat:@"%@",[listArray objectAtIndex:selectedIndex]];
                                           
                                           _repaymentYearsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:selectedIndex],Localized(@"Years")];
                                           
                                           NSString *str = _repaymentYearsFld.text;
                                           NSString *str1 = _repaymentMonthsFld.text;
                                           
                                           NSUInteger value1 =str.intValue;
                                           NSUInteger value2 = str1.intValue;
                                           NSInteger subs = value1 + value2;
                                           
                                           //        NSString *repayYea = [NSString stringWithFormat:@"%@",_repaymentYearsFld.text];
                                           //        NSUInteger repay = repayYea.intValue;
                                           NSUInteger yearV = 12;
                                           NSInteger totalSubs = subs * yearV;
                                           NSInteger totalSubPlus = totalSubs + value2;
                                           
                                           if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Monthly")]) {
                                               
                                               NSString *str = @"1";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                           }
                                           
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Quartely")]){
                                               
                                               NSString *str = @"3";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Semi-Annual")]){
                                               
                                               NSString *str = @"6";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                               
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Annual")]){
                                               
                                               NSString *str = @"12";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                           }
                                           else{
                                               
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
//    _popUpView.hidden = NO;
//    _popUpTabelView.hidden = NO;
//    _tableBackView.hidden = NO;
//    [_popUpTabelView reloadData];
    
    [_enterPropertyValue resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];

}

- (IBAction)repaymentMonthsBtnTapped:(id)sender {
    
    valueStr = @"repaymentMonth";

    listArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Repayment Month")
                                            rows:listArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           _repaymentMonthsFld.text=[NSString stringWithFormat:@"%@",[listArray objectAtIndex:selectedIndex]];
                                           
                                           _repaymentMonthsFld.text = [NSString stringWithFormat:@"%@ %@",[listArray objectAtIndex:selectedIndex],@"Months"] ;
                                           
                                           NSString *str = _repaymentYearsFld.text;
                                           NSString *str1 = _repaymentMonthsFld.text;
                                           
                                           NSUInteger value1 =str.intValue;
                                           NSUInteger value2 = str1.intValue;
                                           //        NSInteger subs = value1 + value2;
                                           
                                           NSUInteger yearV = 12;
                                           
                                           NSInteger totalSubs = value1 * yearV;
                                           NSInteger totalSubPlus = totalSubs + value2;
                                           
                                           
                                           if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Monthly")]) {
                                               
                                               NSString *str = @"1";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Quartely")]){
                                               
                                               NSString *str = @"3";
                                               subs1 = totalSubPlus / str.intValue;
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Semi-Annual")]){
                                               
                                               NSString *str = @"6";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                               
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:Localized(@"Annual")]){
                                               
                                               NSString *str = @"12";
                                               subs1 = totalSubPlus / str.intValue;
                                               
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subs1];
                                               
                                           }
                                           else{
                                               
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];

//    _popUpView.hidden = NO;
//    _popUpTabelView.hidden = NO;
//    _tableBackView.hidden = NO;
//    [_popUpTabelView reloadData];
    
    [_enterPropertyValue resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];
}

- (IBAction)annualdownBtnTapped:(id)sender {
    
    labelValue--;
    if (labelValue < 5) {
        
        self.anualRateFld.text = [NSString stringWithFormat:@"%@",@"5"];
        labelValue = 5;
    }
    else{
        self.anualRateFld.text = [NSString stringWithFormat:@"%d",labelValue];
    }
}

- (IBAction)annualUpBtnTapped:(id)sender{
   
    labelValue++;
    if (labelValue == 0) {
        self.anualRateFld.text = [NSString stringWithFormat:@"%@",@"0"];
    }
    else
    {
        self.anualRateFld.text = [NSString stringWithFormat:@"%d",labelValue];
    }
}

- (IBAction)calculateBtnTapped:(id)sender {
    [self resignFirstResponder];
    if([_enterPropertyValue.text  isEqual: @""]){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Property Value")];
    }else if([_downPaymentFld.text  isEqual: @""]){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Down 0000Payment")];
    }
    
    
    else{
    [self showHUD:@""];
        NSLog(@"%@",[self convertToEnglishNumber:_enterPropertyValue.text]);
    [self makePostCallForPage:LOAN_CALCULATOR withParams:@{@"property":[self convertToEnglishNumber:_enterPropertyValue.text],@"amt":@"",@"downamount":[self convertToEnglishNumber:_downPaymentFld.text],@"loan":[self convertToEnglishNumber:_loanAmountFld.text],@"grace_period_year":[self convertToEnglishNumber:_graceYearsFld.text],@"grace_period_month":[self convertToEnglishNumber:_graceMonthsFld.text],@"repayment_period_year":[self convertToEnglishNumber:_repaymentYearsFld.text],@"repayment_period_month":[self convertToEnglishNumber:_repaymentMonthsFld.text],@"profit":[self convertToEnglishNumber:_anualRateFld.text],@"installment":[self convertToEnglishNumber:installmentStr],@"payments":[self convertToEnglishNumber:_noOfpaymentsFld.text]} withRequestCode:1];
    }
    
//    _resultPopUpViewHeight.constant = 470;
//    _resultPopUpView.hidden = NO;
//    _resultpopUpTop.constant = 16;
//    _resultLbl.hidden = NO;
}

- (IBAction)installmentTypeBtnTapped:(id)sender {
    
     valueStr = @"installMent";
    
  
    listArray = [[NSMutableArray alloc]initWithObjects:Localized(@"Monthly"),Localized(@"Quarterly"),Localized(@"Semi-Annually"),Localized(@"Annually"), nil];

    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select installMent type")
                                            rows:listArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
//                                           _slectPaymentModeFld.text=[NSString stringWithFormat:@"%@",[listArray objectAtIndex:selectedIndex]];
                                       
                                           _slectPaymentModeFld.text = [listArray objectAtIndex:selectedIndex];
                                           
                                           if ([_slectPaymentModeFld.text isEqualToString:listArray[0]]) {
                                               
                                               NSString *str = @"1";
                                               installmentStr = @"1";
                                               NSUInteger subsVal = subs1 / str.intValue;
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:listArray[1]]){
                                               
                                               NSString *str = @"3";
                                               installmentStr = @"3";
                                               NSUInteger subsVal = subs1 / str.intValue;
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:listArray[2]]){
                                               
                                               NSString *str = @"6";
                                               installmentStr = @"6";
                                               
                                               NSUInteger subsVal = subs1 / str.intValue;
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
                                           }
                                           else if ([_slectPaymentModeFld.text isEqualToString:listArray[3]]){
                                               
                                               NSString *str = @"12";
                                               installmentStr = @"12";
                                               NSUInteger subsVal = subs1 / str.intValue;
                                               _noOfpaymentsFld.text = [NSString stringWithFormat:@"%ld",(long)subsVal];
                                           }
                                           else{
                                               
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
//    _popUpView.hidden = NO;
//    _popUpTabelView.hidden = NO;
//    _tableBackView.hidden = NO;
//    [_popUpTabelView reloadData];
    
    [_enterPropertyValue resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];

}


#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    // [self.view endEditing:NO];
    [_enterPropertyValue resignFirstResponder];
    [_downPaymentFld resignFirstResponder];
    [_downpaymentPercentageFld resignFirstResponder];
    [_loanAmountFld resignFirstResponder];
    [_anualRateFld resignFirstResponder];
}


-(void)textFldBoarders{
    
    _enterPropertyValue.layer.borderColor = [UIColor whiteColor].CGColor;
    _enterPropertyValue.layer.borderWidth = 2.0f;
    _enterPropertyValue.layer.cornerRadius = 15.0f;

    _downPaymentFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _downPaymentFld.layer.borderWidth = 2.0f;
    _downPaymentFld.layer.cornerRadius = 15.0f;

    _downpaymentPercentageFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _downpaymentPercentageFld.layer.borderWidth = 2.0f;
    _downpaymentPercentageFld.layer.cornerRadius = 15.0f;

    _loanAmountFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _loanAmountFld.layer.borderWidth = 2.0f;
    _loanAmountFld.layer.cornerRadius = 15.0f;

    _graceYearsFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _graceYearsFld.layer.borderWidth = 2.0f;
    _graceYearsFld.layer.cornerRadius = 15.0f;

    _graceMonthsFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _graceMonthsFld.layer.borderWidth = 2.0f;
    _graceMonthsFld.layer.cornerRadius = 15.0f;

    _repaymentYearsFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _repaymentYearsFld.layer.borderWidth = 2.0f;
    _repaymentYearsFld.layer.cornerRadius = 15.0f;

    _repaymentMonthsFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _repaymentMonthsFld.layer.borderWidth = 2.0f;
    _repaymentMonthsFld.layer.cornerRadius = 15.0f;

    _anualRateFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _anualRateFld.layer.borderWidth = 2.0f;
    _anualRateFld.layer.cornerRadius = 15.0f;

    _slectPaymentModeFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _slectPaymentModeFld.layer.borderWidth = 2.0f;
    _slectPaymentModeFld.layer.cornerRadius = 15.0f;

    _noOfpaymentsFld.layer.borderColor = [UIColor whiteColor].CGColor;
    _noOfpaymentsFld.layer.borderWidth = 2.0f;
    _noOfpaymentsFld.layer.cornerRadius = 15.0f;
    
    _label1.layer.cornerRadius = 15;_label1.clipsToBounds = YES;
//    _label2.layer.cornerRadius = 10;_label2.clipsToBounds = YES;
//    _label3.layer.cornerRadius = 10;_label3.clipsToBounds = YES;
//    _label4.layer.cornerRadius = 10;_label4.clipsToBounds = YES;
//    _label5.layer.cornerRadius = 10;_label5.clipsToBounds = YES;
//    _label6.layer.cornerRadius = 10;_label6.clipsToBounds = YES;
//    _label7.layer.cornerRadius = 10;_label7.clipsToBounds = YES;
//    _label8.layer.cornerRadius = 10;_label8.clipsToBounds = YES;
//    _label9.layer.cornerRadius = 10;_label9.clipsToBounds = YES;
//    _label10.layer.cornerRadius = 10;_label10.clipsToBounds = YES;
//    _label11.layer.cornerRadius = 10;_label11.clipsToBounds = YES;
    

}

-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _enterPropertyValue.rightView = paddingView;
        _enterPropertyValue.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _downPaymentFld.rightView = paddingView1;
        _downPaymentFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _downpaymentPercentageFld.rightView = paddingView2;
        _downpaymentPercentageFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _loanAmountFld.rightView = paddingView3;
        _loanAmountFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];

        
        _graceYearsFld.rightView = paddingView4;
        _graceYearsFld.rightViewMode = UITextFieldViewModeAlways;
        
        _graceMonthsFld.rightView = paddingView5;
        _graceMonthsFld.rightViewMode = UITextFieldViewModeAlways;
        
        _repaymentYearsFld.rightView = paddingView6;
        _repaymentYearsFld.rightViewMode = UITextFieldViewModeAlways;
        
        _repaymentMonthsFld.rightView = paddingView7;
        _repaymentMonthsFld.rightViewMode = UITextFieldViewModeAlways;
        
        _anualRateFld.rightView = paddingView8;
        _anualRateFld.rightViewMode = UITextFieldViewModeAlways;
        
        _slectPaymentModeFld.rightView = paddingView9;
        _slectPaymentModeFld.rightViewMode = UITextFieldViewModeAlways;
        
        _noOfpaymentsFld.rightView = paddingView10;
        _noOfpaymentsFld.rightViewMode = UITextFieldViewModeAlways;
        
    }
    else{
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _enterPropertyValue.leftView = paddingView;
        _enterPropertyValue.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _downPaymentFld.leftView = paddingView1;
        _downPaymentFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _downpaymentPercentageFld.leftView = paddingView2;
        _downpaymentPercentageFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _loanAmountFld.leftView = paddingView3;
        _loanAmountFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];

        
        _graceYearsFld.leftView = paddingView4;
        _graceYearsFld.leftViewMode = UITextFieldViewModeAlways;
        
        _graceMonthsFld.leftView = paddingView5;
        _graceMonthsFld.leftViewMode = UITextFieldViewModeAlways;
        
        _repaymentYearsFld.leftView = paddingView6;
        _repaymentYearsFld.leftViewMode = UITextFieldViewModeAlways;
        
        _repaymentMonthsFld.leftView = paddingView7;
        _repaymentMonthsFld.leftViewMode = UITextFieldViewModeAlways;
        
        _anualRateFld.leftView = paddingView8;
        _anualRateFld.leftViewMode = UITextFieldViewModeAlways;
        
        _slectPaymentModeFld.leftView = paddingView9;
        _slectPaymentModeFld.leftViewMode = UITextFieldViewModeAlways;
        
        _noOfpaymentsFld.leftView = paddingView10;
        _noOfpaymentsFld.leftViewMode = UITextFieldViewModeAlways;

        
    }
}





- (IBAction)propertyValueInfoBtnAction:(id)sender {
    [self showInfo:Localized(@"info_property_value") :sender];
}

- (IBAction)downPaymentperBtnAction:(id)sender {
    [self showInfo:Localized(@"info_downpayment_percentage") :sender];

}

- (IBAction)gracePeriodInfoBtnAction:(id)sender {
    [self showInfo:Localized(@"info_grace_period") :sender];

}

- (IBAction)anuualProfitRateInfoBtnAction:(id)sender {
    [self showInfo:Localized(@"info_annual_profit_rate") :sender];
}

- (IBAction)downPaymentKdBtn:(id)sender {
    
    [self showInfo:Localized(@"info_downpayment_KD") :sender];
}

- (IBAction)loanAmountBtnTapped:(id)sender {
    
    [self showInfo:Localized(@"info_loan_amount") :sender];
}

- (IBAction)repaymentBtnTapped:(id)sender {
    
     [self showInfo:Localized(@"info_repayment_period") :sender];
}

-(void)shadow:(UITextField*)txtFld{
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:txtFld.bounds];
    txtFld.layer.masksToBounds = YES;
    txtFld.layer.shadowColor = [UIColor redColor].CGColor;
    txtFld.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    txtFld.layer.shadowOpacity = 0.5f;
    txtFld.layer.shadowPath = shadowPath.CGPath;

}

@end
