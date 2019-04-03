//
//  MenuViewController.h
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *menuTopView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (nonatomic, strong) NSString *valid;

@property (weak, nonatomic) IBOutlet UIView *afterLoginView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *emailId;
@property (weak, nonatomic) IBOutlet UIImageView *logOutIcon;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewtailingConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageCenterConstraint;
@property (weak, nonatomic) IBOutlet UILabel *ourSocialMediaLbl;
@property (weak, nonatomic) IBOutlet UIImageView *dollarIcon;



- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)signUpBtnClicked:(id)sender;
- (IBAction)logOutbtnTapped:(id)sender;
- (IBAction)twitterBtnTapped:(id)sender;
- (IBAction)whatsAppBtnTapped:(id)sender;
- (IBAction)instagramBtnTapped:(id)sender;


@end

NS_ASSUME_NONNULL_END
