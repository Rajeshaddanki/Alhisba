//
//  CostEstimatorViewController.m
//  Alhisba
//
//  Created by apple on 25/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CostEstimatorViewController.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>

@interface CostEstimatorViewController ()<UIWebViewDelegate>{
    UIButton *menuBtn,*backBtn;
    NSString *finalUrl;
    SWRevealViewController *revealViewController;
    NSString *dType;
}

@end

@implementation CostEstimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 1136:
                printf("iPhone 5 or 5S or 5C");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                dType=@"iPhone5";
                break;
            case 1334:
                printf("iPhone 6/6S/7/8");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                 dType=@"iPhone6";
                break;
            case 1920:
                printf("iPhone 6+/6S+/7+/8+");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                 dType=@"iPhone6+";
                break;
            case 2436:
                printf("iPhone X, Xs");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                break;
            case 2688:
                printf("iPhone Xs Max");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                 break;
            case 1792:
                printf("iPhone Xr");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                 break;
            default:
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                printf("unknown");
        }
    }
self.navigationItem.title = Localized(@"Cost Estimator");
self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];

//    menuBtn = [[UIButton alloc] init];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//// [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = backBarButtonItem;

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
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Construction Cost Estimator");
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

//    [[[self.webView subviews] lastObject] setScrollingEnabled:NO];
    
    [self showHUD:@"Loading"];

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
     //   finalUrl = [NSString stringWithFormat:@"http://alhisba.com/cost_estimator.php?lang=ar&dtype=%@",dType];
        
        finalUrl = [NSString stringWithFormat:@"http://mamacgroup.com/new-alhisba/appAlhisba/construction-cost-estimator.html"];
    }
    else{
        finalUrl = [NSString stringWithFormat:@"http://mamacgroup.com/new-alhisba/appAlhisba/construction-cost-estimator.html"];
    }
    [self customSetup];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]]];
    [self hideHUD];

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

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Construction Cost Estimator") :sender];
}

-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"CONSTRUCTION COSTESTIMATOR SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
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


-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHUD:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _backGroundImage.hidden=YES;
    _colorView.hidden=YES;
    _activityIndicator.hidden=YES;

    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    
}
@end
