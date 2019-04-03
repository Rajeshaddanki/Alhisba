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

@property (weak, nonatomic) IBOutlet UITextField *roomsTextFld;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roomFldHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roomFldTop;

@property (weak, nonatomic) IBOutlet UIButton *saveDraftBtn;
@property (weak, nonatomic) IBOutlet UIButton *proceedbtn;


- (IBAction)selectBtnTapped:(id)sender;
- (IBAction)saveDraftBtnTapped:(id)sender;
- (IBAction)proceedBtnTapped:(id)sender;
- (IBAction)segmentTouchIns:(id)sender;


// Constraints Out lets...


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forRentTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *forSaleLbl;
@property (weak, nonatomic) IBOutlet UIButton *forSaleBtn;

@property (weak, nonatomic) IBOutlet UIView *forSaleView;

- (IBAction)forSaleBtnTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *forRentLbl;
@property (weak, nonatomic) IBOutlet UIButton *forrentBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forRentViewHeigthConstarint;
@property (weak, nonatomic) IBOutlet UIView *forRentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adduptoXConstraint;

- (IBAction)forrentBtnTapped:(id)sender;


// Outlets ...

@property (weak, nonatomic) IBOutlet UITextField *titleFld;

@property (weak, nonatomic) IBOutlet UITextField *propertyTypeFld;

@property (weak, nonatomic) IBOutlet UITextField *areaFld;

@property (weak, nonatomic) IBOutlet UITextField *mobileNoFld;

@property (weak, nonatomic) IBOutlet UITextField *AlternativeMobileFld;

@property (weak, nonatomic) IBOutlet UITextField *landSizefld;

@property (weak, nonatomic) IBOutlet UITextField *priceFld;

@property (weak, nonatomic) IBOutlet UITextField *price2Fld;

@property (weak, nonatomic) IBOutlet UITextField *priceTypeFld;

@property (weak, nonatomic) IBOutlet UITextField *priceType2Fld;
@property (weak, nonatomic) IBOutlet UITextField *locationFld;

@property (weak, nonatomic) IBOutlet UICollectionView *locationCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationCollectionviewHeight;


@property (weak, nonatomic) IBOutlet UITextField *curbFld;
@property (weak, nonatomic) IBOutlet UICollectionView *curbCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *curbCollectionviewHeight;

@property (weak, nonatomic) IBOutlet UITextField *streetFld;
@property (weak, nonatomic) IBOutlet UITextField *facingFld;
@property (weak, nonatomic) IBOutlet UITextField *directionFld;
@property (weak, nonatomic) IBOutlet UITextField *generalFld;

@property (weak, nonatomic) IBOutlet UITextField *ageFld;

@property (weak, nonatomic) IBOutlet UITextField *buildUpAreaFld;

@property (weak, nonatomic) IBOutlet UILabel *facadeLbl;

@property (weak, nonatomic) IBOutlet UICollectionView *facadeCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facadeCollectionViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *finishingLbl;

@property (weak, nonatomic) IBOutlet UICollectionView *finishingCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishingCollectionViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *conditionsLbl;

@property (weak, nonatomic) IBOutlet UICollectionView *conditionsCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conditioncollectionviewHeight;

@property (weak, nonatomic) IBOutlet UILabel *addonsLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *addonsCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addonsCollectionviewHeight;

@property (weak, nonatomic) IBOutlet UITextField *charletsFld;
@property (weak, nonatomic) IBOutlet UITextField *rentalFld;

@property (weak, nonatomic) IBOutlet UITextField *entranceFld;
@property (weak, nonatomic) IBOutlet UITextField *seaFrontFld;
@property (weak, nonatomic) IBOutlet UITextField *backSideFrontFld;
@property (weak, nonatomic) IBOutlet UITextField *monthlyRentFld;

@property (weak, nonatomic) IBOutlet UITextField *noofFlatsFld;
@property (weak, nonatomic) IBOutlet UITextField *flatSizeFld;
@property (weak, nonatomic) IBOutlet UITextField *noofBedroomsFld;
@property (weak, nonatomic) IBOutlet UITextField *noofBathroomsFld;

@property (weak, nonatomic) IBOutlet UITextView *additionInfoArabic;

@property (weak, nonatomic) IBOutlet UITextField *expiryDateFld;


// Actions ...

- (IBAction)propertyTypeBtnTapped:(id)sender;
- (IBAction)areaBtnTapped:(id)sender;
- (IBAction)priceTypeBtnTapped:(id)sender;
- (IBAction)priceType2BtnTapped:(id)sender;
- (IBAction)locationBtnTapped:(id)sender;
- (IBAction)curbBtnTapped:(id)sender;
- (IBAction)streetBtnTapped:(id)sender;
- (IBAction)facingBtnTapped:(id)sender;
- (IBAction)directionBtnTapped:(id)sender;
- (IBAction)generalBtnTapped:(id)sender;
- (IBAction)ageBtnTapped:(id)sender;
- (IBAction)charletsBtnTapped:(id)sender;
- (IBAction)rentalBtnTapped:(id)sender;

- (IBAction)appupto9Photoestapped:(id)sender;


@property (weak, nonatomic) IBOutlet UICollectionView *photoesCollectionView;


@end

NS_ASSUME_NONNULL_END
