//
//  ForgotPasswordViewController.h
//  Bloomego
//
//  Created by apple on 08/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIFloatLabelTextField.h"


@interface ForgotPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *emailFld;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitBtnclicked:(id)sender;

@end
