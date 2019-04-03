//
//  AccountViewController.m
//  Alhisba
//
//  Created by Apple on 29/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AccountViewController.h"
#import "SVProgressHUD.h"
#import "AddsViewController.h"
#import "ChangePasswordViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MyFaviouratesViewController.h"
#import "AccountMyAddsViewController.h"
#import "EditUserViewController.h"

@interface AccountViewController ()<PopViewControllerDelegate>{
    
    UIButton *backBtn;
    NSMutableArray *responceArray;
}

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    
    _editBtn.layer.cornerRadius = 10.0f;
    _editBtn.layer.masksToBounds = true;
    
    _myAdsBtn.layer.cornerRadius = 10.0f;
    _myAdsBtn.layer.masksToBounds = true;
    
    _myfavBtn.layer.cornerRadius = 10.0f;
    _myfavBtn.layer.masksToBounds = true;
    
    _changePasBtn.layer.cornerRadius = 10.0f;
    _changePasBtn.layer.masksToBounds = true;
    
    [_myfavBtn setTitle:Localized(@"My Favorites") forState:UIControlStateNormal];
    [_myAdsBtn setTitle:Localized(@"My Ads") forState:UIControlStateNormal];
    [_changePasBtn setTitle:Localized(@"Change Password") forState:UIControlStateNormal];
    [_editBtn setTitle:Localized(@"Edit") forState:UIControlStateNormal];


    _mobileNOLbl.text = Localized(@"Mobile Number");
    _emailAdresLbl.text = Localized(@"Email Address");
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Profile");
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];
    
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
    
    
    [self showHUD:@""];
    
    [self makePostCallForPage:MEMBERS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:23];

}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{

    responceArray = result;
    
    _userNameLbl.text = [NSString stringWithFormat:@"%@ %@",[responceArray valueForKey:@"fname"][0],[responceArray valueForKey:@"lname"][0]];
    _mobileNoFld.text = [responceArray valueForKey:@"phone"][0];
    _emailFld.text = [responceArray valueForKey:@"email"][0];
    
     [_emailFld setFont:[UIFont fontWithName:@"Cairo-Bold" size:18]];
    [_mobileNoFld setFont:[UIFont fontWithName:@"Cairo-Bold" size:18]];
    
    [self hideHUD];
}


-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Profile") :sender];
}

- (IBAction)editBtnTapped:(id)sender {
    
    EditUserViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"EditUserViewController"];
    [self.navigationController pushViewController:obj animated:YES];

}

- (IBAction)myAddsBtnTapped:(id)sender {
    
    AccountMyAddsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountMyAddsViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)myFavBtnTapped:(id)sender {
    
    MyFaviouratesViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyFaviouratesViewController"];
    [self.navigationController pushViewController:obj animated:YES];

}

- (IBAction)changePasBtnTapped:(id)sender {
    
    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    vc.delegate = self;
    vc.completionBlock = ^ {
        
    };
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self showHUD:@""];
    
    [self makePostCallForPage:MEMBERS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:23];
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
