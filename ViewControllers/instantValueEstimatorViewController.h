//
//  instantValueEstimatorViewController.h
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface instantValueEstimatorViewController : BaseViewController

@property (strong , nonatomic)NSString *fromMenu;

@property (weak, nonatomic) IBOutlet UICollectionView 
*locationcollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *locationSpecCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *plotSpecCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *facingCollectinView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plotSpecHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facingHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationCheckHeight;
@property (weak, nonatomic) IBOutlet UIButton *landBtn;
@property (weak, nonatomic) IBOutlet UIButton *buildingBtn;
@property (weak, nonatomic) IBOutlet UIView *previewPopUp;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;
@property (weak, nonatomic) IBOutlet UIView *sabahCityView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sabahCityheight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sabahCityTopHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareBtnTop;

// Label Outlests......

@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *landSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *streetLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UILabel *buildingAgeLbl;
@property (weak, nonatomic) IBOutlet UILabel *finishingQualityLbl;
@property (weak, nonatomic) IBOutlet UILabel *basementLbl;
@property (weak, nonatomic) IBOutlet UILabel *noofFloorsLbl;

// Textfileds Outlets...

@property (weak, nonatomic) IBOutlet UITextField *selectAreaFld;
@property (weak, nonatomic) IBOutlet UITextField *selectLandSize;
@property (weak, nonatomic) IBOutlet UITextField *selectStreet;
@property (weak, nonatomic) IBOutlet UITextField *selectLocationFld;
@property (weak, nonatomic) IBOutlet UITextField *buildingAgeFl;
@property (weak, nonatomic) IBOutlet UITextField *finishingQualityFld;
@property (weak, nonatomic) IBOutlet UITextField *basementFld;
@property (weak, nonatomic) IBOutlet UITextField *noOfFloorsFld;
@property (weak, nonatomic) IBOutlet UITextField *selectdirectionFld;
@property (weak, nonatomic) IBOutlet UITextField *selectCurbFLd;
@property (weak, nonatomic) IBOutlet UITextField *advancedSpeFld;

@property (weak, nonatomic) IBOutlet UITextField *seaFrontLengthsFld;
@property (weak, nonatomic) IBOutlet UITextField *backStreetFld;

@property (weak, nonatomic) IBOutlet UILabel *advancedSpeLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationSpecWidth;

@property (weak, nonatomic) IBOutlet UILabel *propertyStatusLbl;


// Button Actions ...

- (IBAction)selectAreabtnTapped:(id)sender;
- (IBAction)selectLandSizeBtnTapped:(id)sender;
- (IBAction)selectStreetBtnTapped:(id)sender;
- (IBAction)buildingAgeBtnTapped:(id)sender;
- (IBAction)finishingQualityBtnTapped:(id)sender;
- (IBAction)basementBtnTapped:(id)sender;
- (IBAction)advancedSpecBtnTapped:(id)sender;
- (IBAction)directionBtnTapped:(id)sender;
- (IBAction)curbBtnTapped:(id)sender;
- (IBAction)locationBtnTapped:(id)sender;
- (IBAction)floorsBtnTapped:(id)sender;
- (IBAction)popUpcancelBtnTapped:(id)sender;
- (IBAction)calculateBtnTapped:(id)sender;
- (IBAction)sharingBtnTapped:(id)sender;

- (IBAction)buildingTapped:(id)sender;
- (IBAction)landTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *advancedBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allspecTopHeight;


// Hiding Flds, labels and collections........

@property (weak, nonatomic) IBOutlet UILabel *buildingBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *buildingLineLbl;
@property (weak, nonatomic) IBOutlet UILabel *finishingBackgroundLbl;
@property (weak, nonatomic) IBOutlet UILabel *finishingLineLbl;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFloorsBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *nooffloorsLineLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *plotSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *facingSpecLbl;
@property (weak, nonatomic) IBOutlet UILabel *directionBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *curbBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *basementUdeLbl;
@property (weak, nonatomic) IBOutlet UILabel *floorsUnderLineLbl;

@property (weak, nonatomic) IBOutlet UILabel *locationSpecUnderloneLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plotSpecUnderloneLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facingUnderloneLbl;
@property (weak, nonatomic) IBOutlet UILabel *directionUnderloneLbl;
@property (weak, nonatomic) IBOutlet UILabel *curbUnderloneLbl;
@property (weak, nonatomic) IBOutlet UIImageView *curbDownImage;
@property (weak, nonatomic) IBOutlet UIImageView *directionDownImage;
@property (weak, nonatomic) IBOutlet UIImageView *buildingDownImage;
@property (weak, nonatomic) IBOutlet UIImageView *finishingDownImage;
@property (weak, nonatomic) IBOutlet UILabel *basementBackLbl;
@property (weak, nonatomic) IBOutlet UIImageView *basementDownImage;
@property (weak, nonatomic) IBOutlet UILabel *plotsUnderLbl;
@property (weak, nonatomic) IBOutlet UILabel *facingUnderLbl;
@property (weak, nonatomic) IBOutlet UILabel *directioNLbl;
@property (weak, nonatomic) IBOutlet UILabel *curbLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *additionFldTop;
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UITableView *tablePopUpView;
@property (weak, nonatomic) IBOutlet UIView *tableBackView;
@property (weak, nonatomic) IBOutlet UILabel *estimatedPriceLbl;


@property (weak, nonatomic) IBOutlet UIImageView *advancedSpecImage;
@property (weak, nonatomic) IBOutlet UIImageView *floorsImage;

// BuildingSpecView....

@property (weak, nonatomic) IBOutlet UIView *buildingSpecView;
@property (weak, nonatomic) IBOutlet UIView *allSpecsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buildingSpecHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allspecHeight;
@property (weak, nonatomic) IBOutlet UIButton *sharingBtn;
@property (weak, nonatomic) IBOutlet UILabel *sharingLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sharingBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SpecHeight;



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
@property (weak, nonatomic) IBOutlet UILabel *landSpecsTitle;
@property (weak, nonatomic) IBOutlet UILabel *plotSpecsTitles;
@property (weak, nonatomic) IBOutlet UILabel *facingSpecsTitles;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alspecTopHeight;


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

@property (weak, nonatomic) IBOutlet UILabel *buildingLbl;
@property (weak, nonatomic) IBOutlet UILabel *landLbl;


- (IBAction)faceBookBtnTapped:(id)sender;
- (IBAction)whatsappBtnTapped:(id)sender;
- (IBAction)twitterBtnTapped:(id)sender;
- (IBAction)instagramBtnTapped:(id)sender;
- (IBAction)previewCloseBtnTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *curbTextLbl;


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
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *seaFrontLbl;
@property (weak, nonatomic) IBOutlet UILabel *seabackLbl;

@property (weak, nonatomic) IBOutlet UICollectionView *sharedCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sharedCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *instaTitle;
- (IBAction)areaInfoBtnAction:(id)sender;
- (IBAction)landsizeBtnAction:(id)sender;
- (IBAction)locationInfobtnAction:(id)sender;
- (IBAction)streetInfobtnAction:(id)sender;
- (IBAction)buildingAgeInfobtnAction:(id)sender;
- (IBAction)finishingQualityInfobtnAction:(id)sender;
- (IBAction)basementInfobtnAction:(id)sender;
- (IBAction)numberofFloorInfobtnAction:(id)sender;
- (IBAction)locationSpecInfobtnAction:(id)sender;
- (IBAction)plotSpecInfobtnAction:(id)sender;
- (IBAction)facingInfobtnAction:(id)sender;
- (IBAction)directionInfobtnAction:(id)sender;
- (IBAction)crubInfobtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *advancedBtnbackgroundView;

@end
