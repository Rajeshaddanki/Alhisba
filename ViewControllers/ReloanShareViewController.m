//
//  ReloanShareViewController.m
//  Alhisba
//
//  Created by apple on 27/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ReloanShareViewController.h"

@interface ReloanShareViewController ()
{
    UIButton *menuBtn,*backBtn;
}

@end

@implementation ReloanShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *prof = [NSString stringWithFormat:@"%@",[_dict valueForKey:@"bank_profit"]];
    NSString *emi =  [NSString stringWithFormat:@"%@",[_dict valueForKey:@"emi"]];
    NSString *total =  [NSString stringWithFormat:@"%@",[_dict valueForKey:@"tot_purchase"]];
    
    //    _totalPurchasePrice.text = [NSString stringWithFormat:@"%ld",(long)total.integerValue];
    //    _bankProfitPrice.text = [NSString stringWithFormat:@"%ld",(long)prof.integerValue];
    //    _installAmountPrice.text = [NSString stringWithFormat:@"%ld",(long)emi.integerValue];
    //    _loanDurationValue.text = [result valueForKey:@"term"];
    _totalPurchasePrice.text = total;
    _bankProfitPrice.text = prof;
    _installAmountPrice.text = emi;
    _loanDurationValue.text = [_dict valueForKey:@"term"];
    
    _popUpView.layer.cornerRadius = 5;
    _popUpView.clipsToBounds = YES;
    
    self.navigationItem.title = Localized(@"Re Loan calculator");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"shareWhite.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
    [menuBtn addTarget:self action:@selector(shareBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    
    
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

}
-(void)shareBtnTapped{
    
    UIImage *imageToShare = [self captureView:_popUpView inSize:_popUpView.frame.size];
    
    
    NSMutableArray *activityItems = [NSMutableArray arrayWithObjects: imageToShare, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[
                                                     UIActivityTypePrint,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypeSaveToCameraRoll,
                                                     UIActivityTypeAddToReadingList,
                                                     UIActivityTypeAirDrop];
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)backBtnTapped{
    
    [self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
