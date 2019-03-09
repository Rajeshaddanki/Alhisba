//
//  ReloanShareViewController.h
//  Alhisba
//
//  Created by apple on 27/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReloanShareViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *totalPurchasePriceLl;
@property (weak, nonatomic) IBOutlet UILabel *totalPurchasePrice;
@property (weak, nonatomic) IBOutlet UILabel *bankProfitLbl;
@property (weak, nonatomic) IBOutlet UILabel *bankProfitPrice;
@property (weak, nonatomic) IBOutlet UILabel *installAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *installAmountPrice;
@property (weak, nonatomic) IBOutlet UILabel *loanDurationLbl;
@property (weak, nonatomic) IBOutlet UILabel *loanDurationValue;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property(strong,nonatomic) NSDictionary *dict;
@end

NS_ASSUME_NONNULL_END
