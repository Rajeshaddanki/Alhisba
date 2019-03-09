//
//  PostAddViewController.h
//  Alhisba
//
//  Created by Apple on 05/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostAddViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *chooseCateLbl;

@property (weak, nonatomic) IBOutlet UILabel *selectLbl;
@property (weak, nonatomic) IBOutlet UIImageView *selectIcon;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIView *addUptoView;
@property (weak, nonatomic) IBOutlet UILabel *addUptoLbl;

// FOr Sale..

@property (weak, nonatomic) IBOutlet UITextField *saleCityFld;
@property (weak, nonatomic) IBOutlet UITextField *salePropertyTypeFld;
@property (weak, nonatomic) IBOutlet UITextField *saleAreaSizeFld;
@property (weak, nonatomic) IBOutlet UITextView *saleDes;
@property (weak, nonatomic) IBOutlet UITextField *saleNameFld;
@property (weak, nonatomic) IBOutlet UITextField *saleMobileFld;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

// For rent...

@property (weak, nonatomic) IBOutlet UITextField *rentCityFdl;
@property (weak, nonatomic) IBOutlet UITextField *rentPriceFld;
@property (weak, nonatomic) IBOutlet UITextField *rentPropertyTypeFld;
@property (weak, nonatomic) IBOutlet UITextField *rentNoofroomsFld;
@property (weak, nonatomic) IBOutlet UITextField *rentAreaSizeFld;
@property (weak, nonatomic) IBOutlet UITextView *rentDes;
@property (weak, nonatomic) IBOutlet UITextField *rentNameFld;
@property (weak, nonatomic) IBOutlet UITextField *rentMobileNoFls;


@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *proceedbtn;


- (IBAction)selectBtnTapped:(id)sender;
- (IBAction)saveDraftBtnTapped:(id)sender;
- (IBAction)proceedBtnTapped:(id)sender;
- (IBAction)segmentTouchIns:(id)sender;


@end

NS_ASSUME_NONNULL_END
