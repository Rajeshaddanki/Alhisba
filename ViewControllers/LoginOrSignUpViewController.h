//
//  LoginOrSignUpViewController.h
//  Alhisba
//
//  Created by apple on 19/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIFloatLabelTextField.h"

@interface LoginOrSignUpViewController : BaseViewController

// LoginView Buttons And outFlds...

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;
@property (weak, nonatomic) IBOutlet UIButton *mainLoginBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLoginCenterContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginCenterConstraint;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordFld;

@property (strong, nonatomic)NSString *fromPostAdd;


@property (strong, nonatomic)NSString *fromOfficial;

- (IBAction)loginBtnTapped:(id)sender;
- (IBAction)signUpBtnTapped:(id)sender;
- (IBAction)forgotBtnTapped:(id)sender;
- (IBAction)mainLoginBtnTapped:(id)sender;

// SignUpView Buttons And outFlds...

@property (weak, nonatomic) IBOutlet UIButton *signUpLogin;
@property (weak, nonatomic) IBOutlet UIButton *signUpSignUp;
@property (weak, nonatomic) IBOutlet UIButton *signUpMainBtn;


@property (weak, nonatomic) IBOutlet UITextField *firstNameFld;
@property (weak, nonatomic) IBOutlet UITextField *lastNameFld;
@property (weak, nonatomic) IBOutlet UITextField *phoneFld;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmailFld;
@property (weak, nonatomic) IBOutlet UITextField *signUppasswordFld;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordFld;





@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UILabel *firstNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emialLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *paswwordLbl;
@property (weak, nonatomic) IBOutlet UILabel *confirmPswdLbl;
@property (weak, nonatomic) IBOutlet UIImageView *signUpLogo;
@property (weak, nonatomic) IBOutlet UIView *signUpView;
@property (weak, nonatomic) IBOutlet UIImageView *signUpBackground;

@property (strong, nonatomic)NSString *loginOrSign;

- (IBAction)signUpSignUpBtnClicked:(id)sender;
- (IBAction)signUploginBtnClicked:(id)sender;
- (IBAction)signUpMainBtnClicked:(id)sender;

@end
