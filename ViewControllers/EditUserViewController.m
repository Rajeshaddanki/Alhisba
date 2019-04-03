//
//  EditUserViewController.m
//  Alhisba
//
//  Created by Apple on 30/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "EditUserViewController.h"
#import "SVProgressHUD.h"
#import "AddsViewController.h"
#import "ChangePasswordViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MyFaviouratesViewController.h"
#import "AccountMyAddsViewController.h"



@interface EditUserViewController (){
    
    UIButton *backBtn;
    NSMutableArray *responceArray,*editArrayResp;
}

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _emailAddressFld.delegate = self;
    _passwordFld.delegate = self;
    
    self.navigationItem.title = Localized(@"User Edit");
    
    _submitBtn.layer.cornerRadius = 10.0f;
    _submitBtn.layer.masksToBounds = true;
    
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
    

    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0f/255.0f green:69.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
        
    }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
        
    }
    
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    _emailAddressFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"First Name") attributes:@{NSForegroundColorAttributeName: color}];
    
    _passwordFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Last Name") attributes:@{NSForegroundColorAttributeName: color}];
 

    [self textFldBoarders];
    [self paddingFlds];
    
    [self showHUD:@""];
    
    [self makePostCallForPage:MEMBERS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:23];
    
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    if (requestCode == 23) {
        responceArray = result;
        
        _emailAddressFld.text = [responceArray valueForKey:@"fname"][0];
        _passwordFld.text = [responceArray valueForKey:@"lname"][0];
    }
    else if (requestCode == 120){
        editArrayResp = result;
        if ([[editArrayResp valueForKey:@"status"] isEqualToString:@"Success"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
      
       
    }
    
    [self hideHUD];
}

-(void)backBtnTapped{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)textFldBoarders{
    
    _emailAddressFld.layer.cornerRadius = 15.0f;
    _passwordFld.layer.cornerRadius = 15.0f;
}

-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _emailAddressFld.rightView = paddingView6;
        _emailAddressFld.rightViewMode = UITextFieldViewModeAlways;
        
        _passwordFld.rightView = paddingView7;
        _passwordFld.rightViewMode = UITextFieldViewModeAlways;
        
        
    }
    else{
        
       
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _emailAddressFld.leftView = paddingView6;
        _emailAddressFld.leftViewMode = UITextFieldViewModeAlways;
        
        _passwordFld.leftView = paddingView7;
        _passwordFld.leftViewMode = UITextFieldViewModeAlways;
        
    }
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (IBAction)submitBtnTapped:(id)sender {
    
    if ([self.emailAddressFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please Enter First Name")];
        
        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
    } else if ([self.passwordFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please enter last name")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }

    else {
        
        [self showHUD:@""];
        
        [self makePostCallForPage:EDIT_MEMBER withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"fname":self.emailAddressFld.text, @"lname":self.passwordFld.text} withRequestCode:120];
    }
}
@end
