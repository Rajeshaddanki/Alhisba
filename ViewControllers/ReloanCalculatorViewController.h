//
//  ReloanCalculatorViewController.h
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ReloanCalculatorViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *reloanCalculatorLbl;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UILabel *propertyValueKdLbl;
@property (weak, nonatomic) IBOutlet UITextField *enterPropertyValue;
@property (weak, nonatomic) IBOutlet UILabel *downPaymentLbl;
@property (weak, nonatomic) IBOutlet UIButton *downPaymentBtn;
@property (weak, nonatomic) IBOutlet UITextField *downPaymentFld;
@property (weak, nonatomic) IBOutlet UILabel *downPaymentPercentLbl;
@property (weak, nonatomic) IBOutlet UIButton *downPaymentPerentageBtn;
@property (weak, nonatomic) IBOutlet UITextField *downpaymentPercentageFld;
@property (weak, nonatomic) IBOutlet UILabel *loanAmountLbl;
@property (weak, nonatomic) IBOutlet UITextField *loanAmountFld;
@property (weak, nonatomic) IBOutlet UILabel *gracePeriodLbl;
@property (weak, nonatomic) IBOutlet UITextField *graceYearsFld;
@property (weak, nonatomic) IBOutlet UITextField *graceMonthsFld;
@property (weak, nonatomic) IBOutlet UILabel *repaymentLbl;
@property (weak, nonatomic) IBOutlet UITextField *repaymentYearsFld;
@property (weak, nonatomic) IBOutlet UITextField *repaymentMonthsFld;
@property (weak, nonatomic) IBOutlet UILabel *anualRateLbl;
@property (weak, nonatomic) IBOutlet UITextField *anualRateFld;
@property (weak, nonatomic) IBOutlet UILabel *installmentTypeLbl;
@property (weak, nonatomic) IBOutlet UITextField *slectPaymentModeFld;
@property (weak, nonatomic) IBOutlet UILabel *noOfpaymentsLbl;
@property (weak, nonatomic) IBOutlet UITextField *noOfpaymentsFld;
@property (strong, nonatomic)NSString *fromMenu;

@property (weak, nonatomic) IBOutlet UITableView *popUpTabelView;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIView *resultPopUpView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultPopUpViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultpopUpTop;
@property (weak, nonatomic) IBOutlet UILabel *totalPurchasePriceLl;
@property (weak, nonatomic) IBOutlet UILabel *totalPurchasePrice;
@property (weak, nonatomic) IBOutlet UILabel *bankProfitLbl;
@property (weak, nonatomic) IBOutlet UILabel *bankProfitPrice;
@property (weak, nonatomic) IBOutlet UILabel *installAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *installAmountPrice;
@property (weak, nonatomic) IBOutlet UILabel *loanDurationLbl;
@property (weak, nonatomic) IBOutlet UILabel *loanDurationValue;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;

@property (weak, nonatomic) IBOutlet UIView *tableBackView;

- (IBAction)closeBtnTapped:(id)sender;
- (IBAction)refreshBtnTapped:(id)sender;
- (IBAction)downPaymentBtntapped:(id)sender;
- (IBAction)downPaymentPerentageBtnTapped:(id)sender;
- (IBAction)gracePeriodYearsBtnTapped:(id)sender;
- (IBAction)gracePeriodMonthsBtnTapped:(id)sender;
- (IBAction)repaymentYearsBtnTapped:(id)sender;
- (IBAction)repaymentMonthsBtnTapped:(id)sender;
- (IBAction)annualdownBtnTapped:(id)sender;
- (IBAction)annualUpBtnTapped:(id)sender;
- (IBAction)calculateBtnTapped:(id)sender;
- (IBAction)installmentTypeBtnTapped:(id)sender;


// for newDesign
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;

- (IBAction)propertyValueInfoBtnAction:(id)sender;
- (IBAction)downPaymentperBtnAction:(id)sender;
- (IBAction)gracePeriodInfoBtnAction:(id)sender;
- (IBAction)anuualProfitRateInfoBtnAction:(id)sender;
- (IBAction)downPaymentKdBtn:(id)sender;
- (IBAction)loanAmountBtnTapped:(id)sender;
- (IBAction)repaymentBtnTapped:(id)sender;


@end
