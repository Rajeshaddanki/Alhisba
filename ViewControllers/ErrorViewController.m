//
//  ErrorViewController.m
//  Alhisba
//
//  Created by apple on 28/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@end

@implementation ErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _label1.text = Localized(@"We will return back soon");
    _label2.text = Localized(@"ThankQ for using ALHISBA application");
    [_tryagainBtn setTitle:Localized(@"Please Try Again") forState:UIControlStateNormal];
    _tryagainBtn.layer.cornerRadius = 5;
    _tryagainBtn.clipsToBounds=YES;
    [_label2 setTextAlignment:NSTextAlignmentCenter];
    [_label1 setTextAlignment:NSTextAlignmentCenter];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tryAgainBtnAction:(id)sender {
    
   // [APP_DELEGATE downloadSettings];
}

 
@end
