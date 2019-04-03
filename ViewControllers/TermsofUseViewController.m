//
//  TermsofUseViewController.m
//  Bloomego
//
//  Created by apple on 29/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "TermsofUseViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"


@interface TermsofUseViewController (){
    UIButton *backBtn;
    NSString *htmlString;
    SWRevealViewController *revealViewController;
}

@end

@implementation TermsofUseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"Terms Of Use")];
    
    revealViewController.delegate = self;
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;

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
    

    _textviewT.text=@"";
    [self showHUD:@""];
    
    [self makePostCallForPage:SETTINGS withParams:@{} withRequestCode:23];
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Terms Of Use");
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
    
    [self showInfo:Localized(@"Terms Of Use") :sender];
}

-(void)badgeInfoBtnTapped:(id)sender{
    
    [self showInfo:Localized(@"Terms Of Use") :sender];
}

-(void)parseResult:(id)result withCode:(int)reqeustCode {
    if(reqeustCode==23){
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            htmlString = [result valueForKey:@"terms_ar"];
        }
        else{
            htmlString = [result valueForKey:@"terms"];
        }
        
        
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                error: nil
                                                ];
        _textviewT.attributedText = attributedString;
        [_textviewT setFont:[UIFont systemFontOfSize:16]];
        _textviewT.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            _textviewT.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
        }
        else{
            
            _textviewT.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
        }
    }
    [self hideHUD];
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    // [self.navigationController.navigationBar setHidden:NO];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveTestNotification:)
//                                                 name:@"TestNotification"
//                                               object:nil];

}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}



- (IBAction)backBtnTapped:(id)sender {
    
  //  [self.navigationController popToRootViewControllerAnimated:NO];
      [self.revealViewController.navigationController popViewControllerAnimated:YES];

}
@end
