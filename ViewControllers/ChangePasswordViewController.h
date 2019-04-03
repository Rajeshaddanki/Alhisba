//
//  ChangePasswordViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "Country.h"
#import "CountryArea.h"

@interface ChangePasswordViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *restId;
@property (nonatomic, copy) void (^completionBlock)();

@property (weak, nonatomic) IBOutlet UITextField *oldPas;

@property (weak, nonatomic) IBOutlet UITextField *ProvidePasswo;

@property (weak, nonatomic) IBOutlet UITextField *confirmPaswo;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UILabel *changePaswordLbl;


- (IBAction)submitBtnClicked:(id)sender;

@end
