//
//  instantValueEstimator1ViewController.h
//  Alhisba
//
//  Created by apple on 10/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface instantValueEstimator1ViewController : BaseViewController



// pop Up details and Outlets VALUES....

@property (weak, nonatomic) IBOutlet UILabel *areaTitle;
@property (weak, nonatomic) IBOutlet UILabel *landSizeTitle;
@property (weak, nonatomic) IBOutlet UILabel *streetTitle;
@property (weak, nonatomic) IBOutlet UILabel *locationTitle;
@property (weak, nonatomic) IBOutlet UILabel *buildingAgeTitle;
@property (weak, nonatomic) IBOutlet UILabel *finishingQualityTitle;
@property (weak, nonatomic) IBOutlet UILabel *basementTitle;
@property (weak, nonatomic) IBOutlet UILabel *noOffloorsTitle;
@property (weak, nonatomic) IBOutlet UILabel *seaFrontTitle;
@property (weak, nonatomic) IBOutlet UILabel *backStreetTitle;
@property (weak, nonatomic) IBOutlet UILabel *directionTitle;
@property (weak, nonatomic) IBOutlet UILabel *curbTitle;
@property (weak, nonatomic) IBOutlet UILabel *estimatedPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *landValue;
@property (weak, nonatomic) IBOutlet UILabel *buildingValue;
@property (weak, nonatomic) IBOutlet UITextView *landSpecsTitle;
@property (weak, nonatomic) IBOutlet UITextView *plotSpecsTitles;
@property (weak, nonatomic) IBOutlet UITextView *facingSpecsTitles;
@property (weak, nonatomic) IBOutlet UILabel *estimatedPriceLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alspecTopHeight;

@property (weak, nonatomic) IBOutlet UILabel *preViewArea;

@property (weak, nonatomic) IBOutlet UILabel *totalProperty;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;


@property (weak, nonatomic) IBOutlet UICollectionView *relatedCollectionView;


// Nsstring values ...

@property (strong, nonatomic) NSString *areaTitle1;
@property (strong, nonatomic) NSString *landSizeTitle1;
@property (strong, nonatomic) NSString *streetTitle1;
@property (strong, nonatomic) NSString *locationTitle1;
@property (strong, nonatomic) NSString *buildingAgeTitle1;
@property (strong, nonatomic) NSString *finishingQualityTitle1;
@property (strong, nonatomic) NSString *basementTitle1;
@property (strong, nonatomic) NSString *noOffloorsTitle1;
@property (strong, nonatomic) NSString *seaFrontTitle1;
@property (strong, nonatomic) NSString *backStreetTitle1;
@property (strong, nonatomic) NSString *directionTitle1;
@property (strong, nonatomic) NSString *curbTitle1;
@property (strong, nonatomic) NSString *estimatedPriceValue1;
@property (strong, nonatomic) NSString *landValue1;
@property (strong, nonatomic) NSString *buildingValue1;
@property (strong, nonatomic) NSString *landSpecsTitle1;
@property (strong, nonatomic) NSString *plotSpecsTitles1;
@property (strong, nonatomic) NSString *facingSpecsTitles1;
@property (strong, nonatomic) NSString *estimatedPriceLbl1;
@property (strong, nonatomic) NSString *date;
@property (weak, nonatomic) IBOutlet UIScrollView *scollView;


// pop Up details and Outlets Labels....

@property (weak, nonatomic) IBOutlet UILabel *previewAreaLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewLandSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewstreetLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewLocationLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewbuildingAgeLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewfinishingQuali;
@property (weak, nonatomic) IBOutlet UILabel *previewbasementLlb;
@property (weak, nonatomic) IBOutlet UILabel *previewnoOfFloors;
@property (weak, nonatomic) IBOutlet UILabel *previewSeaFrontLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewbackStreetLenght;
@property (weak, nonatomic) IBOutlet UILabel *previewDirectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *previewCurbFld;
@property (weak, nonatomic) IBOutlet UILabel *previewDetailsLbl;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *previewPop;

@property (weak, nonatomic) IBOutlet UILabel *lastUpdateonLbl;

@property (weak, nonatomic) IBOutlet UILabel *landValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *buildingValueLbl;

@property (weak, nonatomic) IBOutlet UILabel *propertySpecificationLbl;

@property (weak, nonatomic) IBOutlet UILabel *locationSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *plotSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *facingSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *shareResultLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UITextView *descTxtView;

@property (weak, nonatomic) IBOutlet UIView *sharedView;
@property (weak, nonatomic) IBOutlet UILabel *estimateValue;


@property (weak, nonatomic) IBOutlet UIView *landValueView;
@property (weak, nonatomic) IBOutlet UIView *propertyValueView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@property (weak, nonatomic) IBOutlet UIButton *clickHereOfficialBtn;

- (IBAction)clickhereOfficialBtnTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
