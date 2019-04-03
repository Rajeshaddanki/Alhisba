//
//  OfficialApraisalViewController.h
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OfficialApraisalViewController : BaseViewController


@property (strong, nonatomic)NSString *fromMenu;

// Labels Outlets...


@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertySpecificationsLbl;
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *blockNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *streetLbl;
@property (weak, nonatomic) IBOutlet UILabel *avenueLbl;
@property (weak, nonatomic) IBOutlet UILabel *plotHouseNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalDetailsLbl;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *personRequestingAppraisalLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *reasonForRequestingAppraisalLbl;
@property (weak, nonatomic) IBOutlet UILabel *remarksLbl;

@property (weak, nonatomic) IBOutlet UILabel *apraisalCostAppearLbl;

// Textfileds Outlets...

@property (weak, nonatomic) IBOutlet UITextField *slectPropetyTypeFld;
@property (weak, nonatomic) IBOutlet UITextField *selectSpecificationFld;
@property (weak, nonatomic) IBOutlet UITextField *selectAreaFld;
@property (weak, nonatomic) IBOutlet UITextField *enterBlockFld;
@property (weak, nonatomic) IBOutlet UITextField *enterStreetFld;
@property (weak, nonatomic) IBOutlet UITextField *enterAvenueFld;
@property (weak, nonatomic) IBOutlet UITextField *enterPlotHousenumberFld;
@property (weak, nonatomic) IBOutlet UITextField *additionalDetaislFld;
@property (weak, nonatomic) IBOutlet UITextField *ownerNameFld;
@property (weak, nonatomic) IBOutlet UITextField *selectPersonRequestAppraisalFld;
@property (weak, nonatomic) IBOutlet UITextField *enterPhoneFld;
@property (weak, nonatomic) IBOutlet UITextField *enterEmalFld;
@property (weak, nonatomic) IBOutlet UITextField *selectReasonFld;
@property (weak, nonatomic) IBOutlet UIButton *termsBtn;
@property (weak, nonatomic) IBOutlet UIButton *termsandConditionBtn;
@property (weak, nonatomic) IBOutlet UIButton *requestReportBtn;

@property (weak, nonatomic) IBOutlet UITextField *appraisalFld;

@property (weak, nonatomic) IBOutlet UITextField *diffTanOwnerFld;
@property (weak, nonatomic) IBOutlet UITextField *attachDocFld;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UITextField *enterRemarksFld;

// Button Actions...

- (IBAction)selectPropertyTypeBtnTapped:(id)sender;
- (IBAction)propertySpecificationsBtnTapped:(id)sender;
- (IBAction)selectAreaBtnTapped:(id)sender;
- (IBAction)personReqAprBtnTapped:(id)sender;
- (IBAction)reasonReqApraBtnTapped:(id)sender;
- (IBAction)equestForreportBtnTapped:(id)sender;
- (IBAction)termsandConditionBoxTapped:(id)sender;
- (IBAction)closeBtnTapped:(id)sender;

//.......

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UITableView *tapleViewpopUp;
@property (weak, nonatomic) IBOutlet UIView *tableContainView;

// Preview details.....
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UILabel *prepropertyType;
@property (weak, nonatomic) IBOutlet UILabel *prePropertySpeci;
@property (weak, nonatomic) IBOutlet UILabel *prePropertyAdres;
@property (weak, nonatomic) IBOutlet UILabel *prePropertyArea;
@property (weak, nonatomic) IBOutlet UILabel *preBlockNumber;
@property (weak, nonatomic) IBOutlet UILabel *preStreet;
@property (weak, nonatomic) IBOutlet UILabel *preAvenue;
@property (weak, nonatomic) IBOutlet UILabel *prePlotHouseNumber;
@property (weak, nonatomic) IBOutlet UILabel *preDetailsLbl;
@property (weak, nonatomic) IBOutlet UILabel *preAdditionalDetails;
@property (weak, nonatomic) IBOutlet UILabel *preaddition;
@property (weak, nonatomic) IBOutlet UILabel *prePersonalDetails;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *prePersonRequesting;
@property (weak, nonatomic) IBOutlet UILabel *preAppraisal;
@property (weak, nonatomic) IBOutlet UILabel *preRepresentativeName;
@property (weak, nonatomic) IBOutlet UILabel *preestimatedPrice;
@property (weak, nonatomic) IBOutlet UILabel *preEstimatePrice;
@property (weak, nonatomic) IBOutlet UILabel *precontactDetails;
@property (weak, nonatomic) IBOutlet UILabel *prePhone;
@property (weak, nonatomic) IBOutlet UILabel *preEmail;
@property (weak, nonatomic) IBOutlet UILabel *preReasonforRequesting;
@property (weak, nonatomic) IBOutlet UIButton *chooseFileBtn;
@property (weak, nonatomic) IBOutlet UILabel *nofileSlectedLbl;

- (IBAction)chooseFileBtnTapped:(id)sender;

- (IBAction)preConfirmBtnTapped:(id)sender;
- (IBAction)preCloseBtnTapped:(id)sender;


@end
