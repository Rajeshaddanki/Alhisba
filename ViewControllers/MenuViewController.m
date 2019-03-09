//
//  MenuViewController.m
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "NewViewController.h"
#import "SWRevealViewController.h"
#import "AboutUsViewController.h"
#import "AboutsUs1ViewController.h"
#import "PrivacyPolicyViewController.h"
#import "TermsofUseViewController.h"
#import "ContactUsViewController.h"
#import "FaqsViewController.h"
#import "LoginOrSignUpViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "articlesViewController.h"


@interface MenuViewController (){
    
    NSMutableArray *imagesArray,*memberArray;
    NSArray *titlesArray;
    SWRevealViewController *revealViewController;
    CAGradientLayer *gradient,*gradient1;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_loginBtn setTitle:Localized(@"Login") forState:UIControlStateNormal];
    [_signUpBtn setTitle:Localized(@"Sign Up") forState:UIControlStateNormal];
    
    _loginBtn.layer.cornerRadius = 10.0f;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.masksToBounds = YES;
    //_loginBtn.layer.borderWidth = 2.0f;

    _signUpBtn.layer.cornerRadius = 10.0f;
    _signUpBtn.clipsToBounds = YES;
    _signUpBtn.layer.masksToBounds = YES;
    _signUpBtn.layer.borderWidth = 1.0f;
    _signUpBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _afterLoginView.hidden = YES;
    _userName.hidden = YES;
    _emailId.hidden = YES;
    _logOutBtn.hidden = YES;
    _logOutIcon.hidden = YES;
    
    [self gradientLayer];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        _mainViewtailingConstraint.constant = 16;
        _imageCenterConstraint.constant = 30;
        
    }
    else{
        
        _mainViewtailingConstraint.constant = -16;
        _imageCenterConstraint.constant = -30;
        
    }
    
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    memberArray = result;
    NSLog(@"member array is %@",memberArray);
    _emailId.hidden = NO;
    
    NSUserDefaults *userName = [NSUserDefaults standardUserDefaults];
    [userName setObject:[memberArray[0] valueForKey:@"fname"] forKey:@"userName"];
    [userName synchronize];
    
    NSUserDefaults *emailId = [NSUserDefaults standardUserDefaults];
    [emailId setObject:[memberArray[0] valueForKey:@"email"] forKey:@"emailId"];
    [emailId synchronize];
    
    _emailId.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"emailId"];
    _userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    
    [self hideHUD];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self.navigationController.navigationBar setHidden:YES];

        NewViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    else if (indexPath.row == 1) {
        
        [self.navigationController.navigationBar setHidden:YES];
        
        articlesViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"articlesViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:aboutUs];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
   else if (indexPath.row == 2) {
       
       [self.navigationController.navigationBar setHidden:YES];

        AboutUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:aboutUs];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
   else if (indexPath.row == 3) {
       
       [self.navigationController.navigationBar setHidden:YES];
       
       ContactUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
       UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:aboutUs];
       [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
   }
    
   else if (indexPath.row == 4) {
       
       [self.navigationController.navigationBar setHidden:YES];
       
       PrivacyPolicyViewController *privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
       UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:privacy];
       [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
   }
   else if (indexPath.row == 5) {
       
       [self.navigationController.navigationBar setHidden:YES];
       
       FaqsViewController *privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqsViewController"];
       UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:privacy];
       [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
   }
   else if (indexPath.row == 6) {
       
       [self.navigationController.navigationBar setHidden:YES];
       
       TermsofUseViewController *privacy = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsofUseViewController"];
       UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:privacy];
       [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
   }
   else if (indexPath.row == 7) {
       
       NSURL *url = [NSURL URLWithString:@"http://alhisba.com/download/"];
       
       NSMutableArray *activityItems = [NSMutableArray arrayWithObjects: url, nil];
       
       UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
       activityViewController.excludedActivityTypes = @[
                                                        UIActivityTypePrint,
                                                        UIActivityTypeCopyToPasteboard,
                                                        UIActivityTypeAssignToContact,
                                                        UIActivityTypeSaveToCameraRoll,
                                                        UIActivityTypeAddToReadingList,
                                                        UIActivityTypeAirDrop];
       
       
       [self presentViewController:activityViewController animated:YES completion:nil];   }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    imagesArray = [[NSMutableArray alloc]initWithObjects:@"news.png",@"Articles.png",@"About us.png",@"Contact Us.png",@"Privacy Policy.png",@"FAQ.png",@"Terms and Conditions.png",@"Share Alhisba App.png", nil];
    
    titlesArray = @[Localized(@"News"),Localized(@"Articles"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Privacy Policy"),Localized(@"FAQ"),Localized(@"Terms and Conditions"),Localized(@"Share Alhisba App")];
    
    _tableviewHeight.constant = titlesArray.count * 50;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    _valid = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];

    NSLog(@"valid Details are %@",_valid);
    
    NSString *strin = _valid;
    if([strin class]==NULL){
        strin=@"";
    }
    if ([strin length]>0) {
        
        _loginBtn.hidden = YES;
        _menuTopView.hidden = YES;
        _signUpBtn.hidden = YES;
        _logOutBtn.hidden = NO;
        _logOutIcon.hidden = NO;
        _afterLoginView.hidden = NO;
        _logoImage.hidden = YES;
        _userName.hidden = NO;
        _emailId.hidden = NO;
        
       // [self showHUD:@""];
        
        NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"emailId"];
        
        if (str.length == 0) {
            
            [self makePostCallForPage:MEMBERS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:100];
        }
        else{
            _emailId.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"emailId"];
            _userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
            _emailId.hidden = NO;
            _userName.hidden = NO;
            _afterLoginView.hidden = NO;
            _userName.hidden = NO;
            _emailId.hidden = NO;
        }
        
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {

            _mainViewtailingConstraint.constant = 16;
            _imageCenterConstraint.constant = 30;

        }
        else{
            
            _mainViewtailingConstraint.constant = -16;
            _imageCenterConstraint.constant = -30;

        }
        
        

        [self gradientLayer];
        [_logOutBtn setTitle:Localized(@"Log Out") forState:UIControlStateNormal];
        
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1];
        
//        _userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
//
//        _emailId.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Email"];
        
        
        imagesArray = [[NSMutableArray alloc]initWithObjects:@"news.png",@"Articles.png",@"About us.png",@"Contact Us.png",@"Privacy Policy.png",@"FAQ.png",@"Terms and Conditions.png",@"Share Alhisba App.png", nil];
        
        titlesArray = @[Localized(@"News"),Localized(@"Articles"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Privacy Policy"),Localized(@"FAQ"),Localized(@"Terms and Conditions"),Localized(@"Share Alhisba App")];

        
    }else{
        
        _loginBtn.hidden = NO;
        _menuTopView.hidden = NO;
        _signUpBtn.hidden = NO;
        _logOutBtn.hidden = YES;
        _logOutIcon.hidden = YES;
        _afterLoginView.hidden = YES;
        _logoImage.hidden = NO;
        
        _userName.hidden = YES;
        _emailId.hidden = YES;

        [self gradientLayer];
        
        [_logOutBtn setTitle:Localized(@"Log Out") forState:UIControlStateNormal];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];
        
        imagesArray = [[NSMutableArray alloc]initWithObjects:@"news.png",@"Articles.png",@"About us.png",@"Contact Us.png",@"Privacy Policy.png",@"FAQ.png",@"Terms and Conditions.png",@"Share Alhisba App.png", nil];
        
        titlesArray = @[Localized(@"News"),Localized(@"Articles"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Privacy Policy"),Localized(@"FAQ"),Localized(@"Terms and Conditions"),Localized(@"Share Alhisba App")];

        
        //        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
    }
    
    [_menuTableView reloadData];
    
  //  [self viewDidLoad];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titlesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [_menuTableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath: indexPath];
    
    if (cell ==nil)
    {
        [_menuTableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"MenuTableViewCell"];
        
        cell = [_menuTableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    }
   
    cell.menuTitle.text = [titlesArray objectAtIndex:indexPath.row];
    cell.menuImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imagesArray objectAtIndex:indexPath.row]]];
    
    [cell.menuTitle setFont:[UIFont fontWithName:@"Cairo-SemiBold" size:18]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}


- (IBAction)loginBtnClicked:(id)sender {
  
    [self.navigationController.navigationBar setHidden:YES];

    LoginOrSignUpViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
    loginView.loginOrSign = @"login";
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
}

- (IBAction)signUpBtnClicked:(id)sender {
    
    LoginOrSignUpViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
    objViewController.loginOrSign = @"signUp";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:objViewController];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];

}

- (IBAction)logOutbtnTapped:(id)sender {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@"" forKey:@"customer_id"];
    [defaults synchronize];
    
//    _nameLbl.hidden = YES;
//    _loginBtn.hidden = NO;
//    _registerBtn.hidden = NO;
//    _emailLbl.hidden = YES;
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)twitterBtnTapped:(id)sender {
    
    NSURL *twitterURL = [NSURL URLWithString:@"https://twitter.com/alhisbakw"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/alhisbakw"]];

}

- (IBAction)whatsAppBtnTapped:(id)sender {
    
    NSURL *twitterURL = [NSURL URLWithString:@"https://bit.ly/2L5C0sk"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/ta7weelapp"]];

}

- (IBAction)instagramBtnTapped:(id)sender {
    
    NSURL *instagramURL = [NSURL URLWithString:@"https://instagram.com/alhisba?utm_source=ig_profile_share&igshid=1st4d64ofzoi2"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }

}

-(void)gradientLayer{
    
    gradient = [CAGradientLayer layer];
    gradient.frame = _menuTopView.bounds;
    gradient.startPoint = CGPointZero;
    gradient.endPoint = CGPointMake(1, 1);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0] CGColor],(id)[[UIColor colorWithRed:221.0f/255.0f green:197.0f/255.0f blue:97.0f/255.0f alpha:1.0] CGColor], nil];
    
    gradient1 = [CAGradientLayer layer];
    gradient1.frame = _afterLoginView.bounds;
    gradient1.startPoint = CGPointZero;
    gradient1.endPoint = CGPointMake(1, 1);
    gradient1.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0] CGColor],(id)[[UIColor colorWithRed:221.0f/255.0f green:197.0f/255.0f blue:97.0f/255.0f alpha:1.0] CGColor], nil];
    
    [_menuTopView.layer addSublayer:gradient];
    [_afterLoginView.layer addSublayer:gradient1];
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
