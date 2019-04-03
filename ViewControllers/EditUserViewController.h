//
//  EditUserViewController.h
//  Alhisba
//
//  Created by Apple on 30/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface EditUserViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *emailAddressFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordFld;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitBtnTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
