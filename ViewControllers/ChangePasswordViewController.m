//
//  ChangePasswordViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "AppTableViewCell.h"
#import "HomeViewController.h"
#import "Country.h"
#import "CountryArea.h"
#import "UIViewController+MJPopupViewController.h"
#import "SVProgressHUD.h"
//#import <IQKeyboardManager.h>

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)


@interface ChangePasswordViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    
    NSMutableArray *mostProductsList;
    NSArray *array;
    UIButton *buttonUser;
    NSMutableArray *serviceArray;
    BOOL isFilltered;
    NSMutableArray *Arrdata;
    NSMutableArray *cellText1;
    Country *country;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonItem;
@property (nonatomic) NSMutableArray *areas;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectServiceLbl;

@end

@implementation ChangePasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _oldPas.delegate = self;
    _ProvidePasswo.delegate = self;
    _confirmPaswo.delegate = self;
    
   // [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];
    
    self.navigationItem.title = Localized(@"Change Password");
    _changePaswordLbl.text = Localized(@"Change Password");
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    UIColor *color = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    _oldPas.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Old Password") attributes:@{NSForegroundColorAttributeName: color }];
    _ProvidePasswo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"New Password") attributes:@{NSForegroundColorAttributeName: color}];
    _confirmPaswo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Confirm Password") attributes:@{NSForegroundColorAttributeName: color}];
   
   // _submitBtn.titleLabel.text = Localized(@"SUBMIT");
    
    self.submitBtn.layer.cornerRadius=self.submitBtn.frame.size.height/2;
    self.submitBtn.layer.borderColor = [UIColor colorWithRed:(238/255.f) green:(54/255.f) blue:(36/255.f) alpha:1.0f].CGColor;
   
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [_oldPas setTextAlignment:NSTextAlignmentLeft];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentLeft];
    }
    else{
        [_oldPas setTextAlignment:NSTextAlignmentRight];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentRight];
    }
    
    [self textFldBoarders];
    [self paddingFlds];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Hacen Tunisia" size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans" size:20.0],NSFontAttributeName,nil];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0f/255.0f green:97.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    // self.navigationItem.title = @"Change Password";
    
    [self shadow:_oldPas];
    [self shadow:_ProvidePasswo];
    [self shadow:_confirmPaswo];
    
   
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.navigationController.navigationBar.bounds;
    
    CGRect gradientFrame = self.navigationController.navigationBar.bounds;
    gradientFrame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
    gradientLayer.frame = gradientFrame;
    
    gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1].CGColor,
                              (__bridge id)[UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:147.0f/255.0f alpha:1].CGColor ];
    //    gradientLayer.startPoint = CGPointMake(1.0, 0);
    //    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:gradientImage1 forBarMetrics:UIBarMetricsDefault];
    
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [_oldPas setTextAlignment:NSTextAlignmentRight];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentRight];
    }
    else{
        [_oldPas setTextAlignment:NSTextAlignmentLeft];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentLeft];
    }
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)submitBtnClicked:(id)sender {
    
    if(_oldPas.text.length==0)
    {
        [self showErrorAlertWithMessage:Localized(@"Please enter your old password.")];
    }
    else if(_ProvidePasswo.text.length==0)
    {
        [self showErrorAlertWithMessage:Localized(@"Please enter your new password.")];
    }
    
    else if(_confirmPaswo.text.length==0)
    {
         [self showErrorAlertWithMessage:Localized(@"Please confirm your password.")];
    }
    else
    {
        if([_ProvidePasswo.text isEqualToString:_confirmPaswo.text]){
            
            [self changePasswordAiCalling];
        }
        
        else{
            
             [self showErrorAlertWithMessage:Localized(@"The new passwords entered do not match.")];
        }
    }
}

-(void)changePasswordAiCalling{
    
    NSString *totalString = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
    
    if (totalString.length==0) {
        
         [self showErrorAlertWithMessage:Localized(@"Please login to change password")];
    }
    else{
        
        [self makePostCallForPage:CHANGE_PASS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"opassword":self.oldPas.text,@"password":self.ProvidePasswo.text,@"cpassword":self.confirmPaswo.text,} withRequestCode:1];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
      if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
          
          NSString *str = @"Your password has been changed successfully.";
          UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
          NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:str];
          [hogan addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"DroidSans-Bold" size:17]
                        range:NSMakeRange(0, str.length)];
          [alertVC setValue:hogan forKey:@"attributedTitle"];
          UIAlertAction *button = [UIAlertAction actionWithTitle:Localized(@"OK")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             self.completionBlock();
                                                             [self.delegate cancelButtonClicked:self];
                                                         }];
          [alertVC addAction:button];
          [self presentViewController:alertVC animated:YES completion:nil];

      }else{
          [self showErrorAlertWithMessage:[result valueForKey:@"message"]];
      }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)textFldBoarders{
    
    _oldPas.layer.cornerRadius= 15.0f;
  //  _oldPas.layer.masksToBounds=YES;
    _oldPas.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _oldPas.layer.borderWidth = 2.0f;

//    _oldPas.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _oldPas.layer.borderWidth= 1.0f;
    
    _confirmPaswo.layer.cornerRadius= 15.0f;
 //   _confirmPaswo.layer.masksToBounds=YES;
    _confirmPaswo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _confirmPaswo.layer.borderWidth = 2.0f;

    _ProvidePasswo.layer.cornerRadius= 15.0f;
 //   _ProvidePasswo.layer.masksToBounds=YES;
    _ProvidePasswo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _ProvidePasswo.layer.borderWidth = 2.0f;

//    _ProvidePasswo.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _ProvidePasswo.layer.borderWidth= 1.0f;
    
}

-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _oldPas.rightView = paddingView;
        _oldPas.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _ProvidePasswo.rightView = paddingView1;
        _ProvidePasswo.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _confirmPaswo.rightView = paddingView2;
        _confirmPaswo.rightViewMode = UITextFieldViewModeAlways;
        
    }
    else{
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _oldPas.leftView = paddingView;
        _oldPas.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _ProvidePasswo.leftView = paddingView1;
        _ProvidePasswo.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _confirmPaswo.leftView = paddingView2;
        _confirmPaswo.leftViewMode = UITextFieldViewModeAlways;

    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
 //   [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];
}

- (IBAction)cancelBtnClciked:(id)sender {
    
    [self.delegate cancelButtonClicked:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)shadow:(UITextField*)txtFld{
    
    txtFld.layer.cornerRadius = txtFld.frame.size.height/2-15;
    txtFld.clipsToBounds = false;
    txtFld.layer.shadowOpacity=0.2;
    txtFld.layer.shadowColor = [[UIColor blackColor] CGColor];
    txtFld.layer.shadowOffset =CGSizeMake(0, 2);
}

@end
