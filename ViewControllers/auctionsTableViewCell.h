//
//  auctionsTableViewCell.h
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface auctionsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *boarderLbl;
@property (weak, nonatomic) IBOutlet UILabel *textViewheadLbl;
@property (weak, nonatomic) IBOutlet UILabel *textViewLbl;
@property (weak, nonatomic) IBOutlet UIButton *auctionSummaryBtnTap;
@property (weak, nonatomic) IBOutlet UIButton *propertiesListTapBtn;

@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIButton *wishListBtn;

@end
