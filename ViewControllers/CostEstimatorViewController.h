//
//  CostEstimatorViewController.h
//  Alhisba
//
//  Created by apple on 25/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CostEstimatorViewController : BaseViewController
@property (weak, nonatomic)  UIWebView *webView2;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *navTltle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewBottom;
@property (strong, nonatomic)NSString *fromMenu;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
