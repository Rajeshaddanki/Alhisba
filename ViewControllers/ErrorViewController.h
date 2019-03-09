//
//  ErrorViewController.h
//  Alhisba
//
//  Created by apple on 28/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ErrorViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *tryagainBtn;
- (IBAction)tryAgainBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
