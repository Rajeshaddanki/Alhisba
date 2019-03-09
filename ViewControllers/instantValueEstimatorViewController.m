//
//  instantValueEstimatorViewController.m
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "instantValueEstimatorViewController.h"
#import "locationcheckCollectionViewCell.h"
#import "LocationSpecCollectionViewCell.h"
#import "PlotSpecCollectionViewCell.h"
#import "FacingCollectionViewCell.h"
#import "SVProgressHUD.h"
#import "SearchTableViewCell.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import "instantValueEstimator1ViewController.h"
#import "ActionSheetStringPicker.h"
#import "SharedCollectionViewCell.h"
#import "SelectAreaViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "PopViewControllerDelegate.h"

@interface instantValueEstimatorViewController ()<UIDocumentInteractionControllerDelegate,PopViewControllerDelegate>{
    
    UIButton *menuBtn,*backBtn;
    NSMutableArray *locationArray,*locationSpecArray,*plotSpecArray,*facingArray,*resultArray,*crubCheckingArray,*seafacingArray;
    NSMutableArray *locationArrayMulti,*locationSpecArrayMulti,*plotSpecArrayMulti,*facingArrayMulti,*crubCheckArrayMulti;
    NSString *fldType,*areaId;
    NSUInteger count;
    NSMutableArray *landSizeArray,*streetArray,*location1Array,*buildingArray,*finishingArray,*basementArray,*noOfFloorsArray,*directionArray,*curbArray,*resultArray1,*filedLocationArray;
    NSMutableArray *sizeIdarray,*streetIdarray,*buildingIdarray,*FinishIdarray,*basementIdarray,*directionIdarray,*curbIdarray,*filedLocationIdArray,*noOfFloorsIdArray;
    NSString *landSizeId,*streetId,*buildingId,*finidhingId,*basementId,*directiontId,*curbtId,*filedLocationId,*noOfFloorsId;
    NSMutableArray *table,*locationSpecsArray1,*plotSpesArray1,*facingSpecArray1,*crackArray1;
    NSMutableArray *filterContainStringad,*locationSpecsContained,*plotSpesContained,*facingSpecContained,*buildingSpecsContained,*curbContainedStr;
    NSMutableString  *locationStr,*locationSpecStr,*plotSpecStr,*facingSpecStr,*buildingSpecStr,*crubCheckStr;
    NSString *buildingSpec1,*buildingSpec2,*buildingSpec3,*buildingSpec4;
    NSString *status;
    
    NSMutableArray *streetMulti,*buildingMulti,*qaulityMulti,*basementMulti,*directionMulti,*curbMulti,*locationMulti,*floorMulti;
    NSString *streetMultiFactor,*buldingMultiFactor,*qualityMultiFactor,*basementMultiFactor,*directionMultiFactor,*curbMultiFactor,*locationMultiFactor,*floorMultiFactor;
    NSString *advancSpeString;
    NSMutableArray *locationSpecTitleContained,*plotSpecTitleContained,*facingSpecTitleContained,*curbCheckArray;
    NSMutableString *locationSpectitleStr,*plotSpecTitleStr,*facinfSpecTitleStr;
    NSString *sharedCheck;
    NSMutableArray *titleArray;
    SWRevealViewController *revealViewController;
    NSString *parseRe;
    
    
    
}

@property (retain) UIDocumentInteractionController * documentInteractionController;

@end

@implementation instantValueEstimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _seaFrontLengthsFld.delegate=self;
    _backStreetFld.delegate=self;
    parseRe = @"parseRe";
//    _selectAreaFld.textColor = [UIColor whiteColor];
//    _selectCurbFLd.textColor = [UIColor clearColor];
    _selectAreaFld.delegate = self;
    _selectLandSize.delegate = self;
    _selectStreet.delegate = self;
    _selectLocationFld.delegate = self;
    _buildingAgeFl.delegate = self;
    _finishingQualityFld.delegate = self;
    _basementFld.delegate = self;
    _noOfFloorsFld.delegate = self;
    
    _popUpView.hidden = YES;
    _tablePopUpView.hidden = YES;
    _tableBackView.hidden = YES;
    _previewPopUp.hidden = YES;
    _sabahCityView.hidden = YES;
    _sabahCityheight.constant = 0;
    _sabahCityTopHeight.constant = 0;
     _shareBtnTop.constant = -30;
    
    buildingSpecStr = [[NSMutableString alloc]init];

//    _advancedBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _advancedBtn.layer.borderWidth=1.0;
//    _advancedBtn.layer.cornerRadius=5;
//    _advancedBtn.clipsToBounds=YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;


    _advancedBtnbackgroundView.layer.cornerRadius=15;
    _advancedBtnbackgroundView.clipsToBounds=YES;

    [_estimatedPriceLbl setTextAlignment:NSTextAlignmentCenter];
    _propertyStatusLbl.text = Localized(@"Property Status");
    _sharingLbl.text = Localized(@"Shared");
    _advancedSpeLbl.text = Localized(@"Advanced Specification");
    
    _locationSpecLbl.text = Localized(@"Location Spec");
    _plotSpecLbl.text = Localized(@"Plot Spec");
    _facingSpecLbl.text = Localized(@"Facing Spec");
    [_calculateBtn setTitle:Localized(@"Calculate") forState:UIControlStateNormal];
    _directioNLbl.text = Localized(@"Direction");
    _curbLbl.text = Localized(@"Curb");
    
    table = [NSMutableArray array];
    filterContainStringad = [NSMutableArray array];
    
    locationSpecsArray1 = [NSMutableArray array];
    locationSpecsContained = [NSMutableArray array];
    locationSpecTitleContained = [NSMutableArray array];
    crackArray1=[NSMutableArray array];
    
    crubCheckArrayMulti = [NSMutableArray array];
    crubCheckingArray = [NSMutableArray array];
    
    plotSpesArray1 = [NSMutableArray array];
    plotSpesContained = [NSMutableArray array];
    plotSpecTitleContained = [NSMutableArray array];
    
    facingSpecArray1 = [NSMutableArray array];
    facingSpecContained = [NSMutableArray array];
    facingSpecTitleContained = [NSMutableArray array];
    
    buildingArray = [NSMutableArray array];
    buildingSpecsContained = [NSMutableArray array];
    
    curbContainedStr = [NSMutableArray array];
    
    [_landBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    status = @"1";
    [_buildingBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
    _landBtn.selected = YES;
    
    self.tableBackView.layer.borderColor = [UIColor blackColor].CGColor;
    [_tableBackView.layer setBorderColor:[UIColor colorWithRed:73.0f/255.0f green:82.0f/255.0f blue:125.0f/255.0f alpha:1.0].CGColor];
    _tableBackView.layer.cornerRadius = 15.0f;
    [_tableBackView.layer setBorderWidth:2.0f];
    [_tableBackView.layer setMasksToBounds:YES];
//    [_tableBackView.layer setCornerRadius:5.0f];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _advancedSpeFld.rightView = paddingView;
        _advancedSpeFld.rightViewMode = UITextFieldViewModeAlways;
    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _advancedSpeFld.leftView = paddingView;
        _advancedSpeFld.leftViewMode = UITextFieldViewModeAlways;
    }
    
    // [self fieldsHidden];
    
    _allspecHeight.constant = 0;
    _buildingSpecHeight.constant = 0;
    _buildingSpecView.hidden = YES;
    _allSpecsView.hidden = YES;
    _locationCheckHeight.constant = 0;
    _sharingBtnHeight.constant = 0;
    
    status = @"1";
    
    _areaLbl.text = Localized(@"Area");
    _landSizeLbl.text = Localized(@"Land Size(Sqms)");
    _streetLbl.text = Localized(@"Street");
    _locationLbl.text = Localized(@"Location");
    _buildingAgeLbl.text = Localized(@"Building Age");
    _finishingQualityLbl.text = Localized(@"Finishing Quality");
    _basementLbl.text = Localized(@"Basement");
    _noofFloorsLbl.text = Localized(@"Select No Of Floors");
    
    
    UIColor *color = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    _selectAreaFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please select Area") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectLandSize.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Land Size") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectStreet.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Street") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectLocationFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Location") attributes:@{NSForegroundColorAttributeName: color}];
    
    _buildingAgeFl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Building Age") attributes:@{NSForegroundColorAttributeName: color}];
    
    _finishingQualityFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Finishing Quality") attributes:@{NSForegroundColorAttributeName: color}];
    
    _basementFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Basement") attributes:@{NSForegroundColorAttributeName: color}];
    
    _noOfFloorsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Number Of Floors") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectdirectionFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Direction") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectCurbFLd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Curb") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectdirectionFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Direction") attributes:@{NSForegroundColorAttributeName: color}];
    
    
    [_previewPopUp.layer setBorderWidth:2.0f];
    [_previewPopUp.layer setCornerRadius:5.0f];
    [_previewPopUp.layer setBorderColor:[UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0f].CGColor];
    [_previewPopUp.layer setMasksToBounds:YES];
    
    [self textFldBoarders];
    [self paddingFlds];
    
//    if ([_fromMenu isEqualToString:@"fromMenu"]) {
//
//        UINavigationBar *navigationBar = self.navigationController.navigationBar;
//        UIImage *image = [UIImage imageNamed: @"NavImage.png"];
//        [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
//    }
//    else{
//
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                      forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
//        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//        self.navigationController.navigationBar.translucent = YES;
//        self.navigationController.view.backgroundColor = [UIColor clearColor];
//    }
    
    self.navigationItem.title = Localized(@"Instant Value Estimator");
    _instaTitle.text = Localized(@"Instant Value Estimator");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
//    menuBtn = [[UIButton alloc] init];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//    // [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    _calculateBtn.layer.cornerRadius = 15.0f;
    _advancedSpeFld.layer.cornerRadius = 15.0f;
//    _advancedSpeFld.text = @"Advanced Specification";
//    _advancedSpeFld.textColor = [UIColor whiteColor];
    
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
    
    [_advancedSpeLbl setTextAlignment:NSTextAlignmentCenter];
    
    [self customSetup];
    
    
    _buildingLbl.text = Localized(@"Building");
    _landLbl.text = Localized(@"Land");
    
    _allspecTopHeight.constant = 0;
    buildingSpec1=buildingSpec2=buildingSpec3=buildingSpec4=locationStr=locationSpecStr=plotSpecStr=facingSpecStr=directiontId=curbtId=areaId=landSizeId=streetId=filedLocationId=@"";
    
    _selectAreaFld.text = @"";
    
    _selectLandSize.text = @"";
    
    _selectStreet.text = @"";
    
    _selectLocationFld.text = @"";
    
    _buildingAgeFl.text = @"";
    
    _finishingQualityFld.text = @"";
    
    _basementFld.text = @"";
    
    _noOfFloorsFld.text = @"";
    
    _selectdirectionFld.text = @"";
    
    _selectCurbFLd.text = @"";
    
    _selectdirectionFld.text = @"";
    
    
    // label
//    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
//    tmpTitleLabel.text = Localized(@"Instant Value Estimator");
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
//    }else{
//        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
//    }
//    tmpTitleLabel.backgroundColor = [UIColor clearColor];
//    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
//    [tmpTitleLabel sizeToFit];
//    UIImage *image = [UIImage imageNamed: @"badge.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
//
//    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
//    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame] ;
//    [newView addSubview:imageView];
//    [newView addSubview:tmpTitleLabel];
//    tmpTitleLabel.center=newView.center;
//    imageView.frame = CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20);
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20)];
//    [btn addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
//    [newView addSubview:btn];
//    self.navigationItem.titleView = newView;
    
}
-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Instant Value Estimator") :sender];
}

- (void)customSetup
{
    [menuBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            //            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            //            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-120;
            
            [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        // self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        printf("unknown");
                }
            }
            
        }else{
            
            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        //  self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        printf("unknown");
                }
            }
            
        }
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
}
-(void)clearToStartForArea{
   
    _advancedBtn.selected = NO;
status = @"1";
    _buildingBtn.selected = NO;
    _landBtn.selected = YES;
   
    [_buildingBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
    [_landBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    _selectLandSize.text = @"";
    
    _selectStreet.text = @"";
    
    _selectLocationFld.text = @"";
    
    _buildingAgeFl.text = @"";
    
    _finishingQualityFld.text = @"";
    
    _basementFld.text = @"";
    
    _noOfFloorsFld.text = @"";
    
    _selectdirectionFld.text = @"";
    
    _selectCurbFLd.text = @"";
    
    _selectdirectionFld.text = @"";
    locationSpectitleStr = [[NSMutableString alloc]init];
    plotSpecTitleStr= [[NSMutableString alloc]init];
     facinfSpecTitleStr= [[NSMutableString alloc]init];
    crackArray1 = [[NSMutableArray alloc] init];
    curbContainedStr= [[NSMutableArray alloc] init];
    [self advancedSpecBtnTapped:nil];
}
-(void)clearToStart{
    _advancedSpecImage.image = [UIImage imageNamed:@"add.png"];
    _advancedBtn.selected = NO;
    status = @"1";
    _allSpecsView.hidden = YES;
    _allspecHeight.constant = 0;
    _sharingBtnHeight.constant = 0;
    _shareBtnTop.constant = 0;
    _allspecTopHeight.constant = 0;

   // [self advancedSpecClear];
    _selectLandSize.text = @"";
    
    _selectStreet.text = @"";
    
    _selectLocationFld.text = @"";
    
    _buildingAgeFl.text = @"";
    
    _finishingQualityFld.text = @"";
    
    _basementFld.text = @"";
    
    _noOfFloorsFld.text = @"";
    
    _selectdirectionFld.text = @"";
    
    _selectCurbFLd.text = @"";
    
    _selectdirectionFld.text = @"";
    
    crackArray1 = [[NSMutableArray alloc] init];
    curbContainedStr= [[NSMutableArray alloc] init];
    
}
#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    if (reqeustCode == 1) {
        
        resultArray = result;
//        _popUpView.hidden = NO;
//        _tablePopUpView.hidden = NO;
//        _tableBackView.hidden = NO;
//        [_tablePopUpView reloadData];
        
        
        _popUpView.hidden = YES;
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            titleArray = [resultArray valueForKey:@"value_arabic"];
        }
        else{
          titleArray = [resultArray valueForKey:@"value_english"];
        }
        
        NSMutableArray *idArray = [resultArray valueForKey:@"id"];
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                rows:titleArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               _selectAreaFld.text=[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:selectedIndex]];
                                               
                                        NSString *timeStr = [NSString stringWithFormat:@"%@",[idArray objectAtIndex:selectedIndex]];
                                               
                                               areaId = [NSString stringWithFormat:@"%@",[idArray objectAtIndex:selectedIndex]];
                                               
                                               _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
//
//                            if ([[[resultArray valueForKey:@"value_english"] objectAtIndex:selectedIndex] isEqualToString:@"Sabah Sea City - 4"]) {
//                                                   _sabahCityView.hidden = NO;
//                                                   _sabahCityheight.constant = 170;
//                                                   _sabahCityTopHeight.constant = 0;
//                                               }
//                                               else{
//                                                   _sabahCityView.hidden = YES;
//                                                   _sabahCityheight.constant = 0;
//                                                   _sabahCityTopHeight.constant = 20;
//                                               }
//
                                               parseRe = @"parseRe";
                [self makePostCallForPage:LIVE_VALUES withParams:@{@"area_id":timeStr} withRequestCode:100];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
        
        
        
    }
    else if (reqeustCode == 100){
        
        resultArray1 = result;
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            locationArray = [[result valueForKey:@"location_check"] valueForKey:@"value_arabic"];
            
            locationSpecArray =  [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"value_arabic"];
            
            plotSpecArray =  [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"value_arabic"];
            
            facingArray =   [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"value_arabic"];
            
            crubCheckingArray =   [[result valueForKey:@"crub_check"]  valueForKey:@"value_arabic"];
            
            seafacingArray = [[result valueForKey:@"sea_facing"]  valueForKey:@"value_arabic"];

           

            if (seafacingArray.count == 0) {
                
                _sabahCityView.hidden = YES;
                _sabahCityheight.constant = 0;
                _sabahCityTopHeight.constant = 10;
            }
            else{
                _seaFrontLbl.text = [seafacingArray  objectAtIndex:0];
                _seabackLbl.text = [seafacingArray  objectAtIndex:1];
                _sabahCityView.hidden = NO;
                _sabahCityheight.constant = 220;
                _sabahCityTopHeight.constant = 10;

            }
            
        }
        else{
            
            locationArray = [[result valueForKey:@"location_check"] valueForKey:@"value_english"];
            
            locationSpecArray =  [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"value_english"];
            
            plotSpecArray =  [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"value_english"];
            facingArray =   [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"value_english"];
            
            crubCheckingArray =   [[result valueForKey:@"crub_check"]  valueForKey:@"value_english"];
            
            seafacingArray = [[result valueForKey:@"sea_facing"]  valueForKey:@"value_english"];

            if (seafacingArray.count == 0) {
                
                _sabahCityView.hidden = YES;
                _sabahCityheight.constant = 0;
                _sabahCityTopHeight.constant = 10;
            }
            else{
                _seaFrontLbl.text = [seafacingArray  objectAtIndex:0];
                _seabackLbl.text = [seafacingArray  objectAtIndex:1];
                _sabahCityView.hidden = NO;
                _sabahCityheight.constant = 220;
                _sabahCityTopHeight.constant = 10;

            }
        }
        
        locationArrayMulti = [[result valueForKey:@"location_check"] valueForKey:@"multiplication_factor"];
        
        locationSpecArrayMulti = [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"multiplication_factor"];
        
        plotSpecArrayMulti = [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"multiplication_factor"];
        
        facingArrayMulti = [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"multiplication_factor"];
        
        curbCheckArray = [[result valueForKey:@"crub_check"] valueForKey:@"multiplication_factor"];
        
        if ([parseRe isEqualToString:@"parseRe"]) {
            
            _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
            _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
            _specCollectionViewHeight.constant = (locationSpecArray.count/2 *50)+(locationSpecArray.count%2 *50);
            _facingHeight.constant = (facingArray.count/2 *50)+(facingArray.count%2 *50);
            _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *50)+(curbCheckArray.count%2 *50);
            parseRe = @"parse";
        }
        else{
            
            _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
            _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
            _specCollectionViewHeight.constant = (locationSpecArray.count/2 *50)+(locationSpecArray.count%2 *50);
            _facingHeight.constant = (facingArray.count/2 *50)+(facingArray.count%2 *50);
            _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *50)+(curbCheckArray.count%2 *50);

            //_shareBtnTop.constant = _plotSpecHeight.constant+_facingHeight.constant+_specCollectionViewHeight.constant-80+310;
            
        }
    
        
//        _allspecHeight.constant = plotSpecArray.count*25+facingArray.count *25+locationSpecArray.count *25+200;
//
//        _shareBtnTop.constant = plotSpecArray.count*25+facingArray.count *25+locationSpecArray.count *25+250+320;
        
        [_locationcollectionView reloadData];
        [_locationSpecCollectionView reloadData];
        [_plotSpecCollectionView reloadData];
        [_facingCollectinView reloadData];
        [_sharedCollectionView reloadData];
        [self clearToStartForArea];

    }
    else if (reqeustCode == 10){
        
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            locationArray = [[result valueForKey:@"location_check"] valueForKey:@"value_arabic"];
            
            locationSpecArray =  [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"value_arabic"];
            
            plotSpecArray =  [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"value_arabic"];
            
            facingArray =   [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"value_arabic"];

        }
        else{
         
            locationArray = [[result valueForKey:@"location_check"] valueForKey:@"value_english"];
        
            locationSpecArray =  [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"value_english"];
            
            plotSpecArray =  [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"value_english"];
            facingArray =   [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"value_english"];
        }
        

        locationArrayMulti = [[result valueForKey:@"location_check"] valueForKey:@"multiplication_factor"];
        
        locationSpecArrayMulti = [[[result valueForKey:@"location_spec"] valueForKey:@"location_spec_values"] valueForKey:@"multiplication_factor"];
        
        plotSpecArrayMulti = [[[result valueForKey:@"plot_spec"] valueForKey:@"plot_spec_values"] valueForKey:@"multiplication_factor"];
        
        facingArrayMulti = [[[result valueForKey:@"facing"] valueForKey:@"facing_values"] valueForKey:@"multiplication_factor"];
        
        
//        _locationCheckHeight.constant = locationArray.count * 25;
//        _specCollectionViewHeight.constant = locationSpecArray.count *25;
//        _plotSpecHeight.constant = plotSpecArray.count *25;
//        _facingHeight.constant = facingArray.count *25;
        
       
        _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
        _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
        _specCollectionViewHeight.constant = (locationSpecArray.count/2 *50)+(locationSpecArray.count%2 *50);
        _facingHeight.constant = (facingArray.count/2 *50)+(facingArray.count%2 *50);
        _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *50)+(curbCheckArray.count%2 *50);

//        _allspecHeight.constant = plotSpecArray.count*28+facingArray.count *28+locationSpecArray.count *28+200;
//        //            _shareBtnTop.constant = _allspecHeight.constant-850;
//
//        _shareBtnTop.constant = plotSpecArray.count*28+facingArray.count *28+locationSpecArray.count *28+250+320;
        
        [_locationcollectionView reloadData];
        [_locationSpecCollectionView reloadData];
        [_plotSpecCollectionView reloadData];
        [_facingCollectinView reloadData];
        [_sharedCollectionView reloadData];

    }
    
    else if (reqeustCode == 30){
        if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {

        NSLog(@"Result is %@",result);
        if([[result valueForKey:@"building_value"] intValue]<0){
            [self showErrorAlertWithMessage:Localized(@"Something Went Wrong Please Try Again")];
        }
        else if([[result valueForKey:@"land_value"] intValue]<0){
            [self showErrorAlertWithMessage:Localized(@"Something Went Wrong Please Try Again")];
        }else if([[result valueForKey:@"total"] intValue]<0){
            [self showErrorAlertWithMessage:Localized(@"Something Went Wrong Please Try Again")];
        }else{
//        [_estimatedPriceValue.layer setBorderColor:[UIColor whiteColor].CGColor];
//        [_estimatedPriceValue.layer setMasksToBounds:YES];
//        [_estimatedPriceValue.layer setBorderWidth:2.0f];
        
        instantValueEstimator1ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimator1ViewController"];
        obj.areaTitle1 = _selectAreaFld.text;
        obj.landSizeTitle1 = _selectLandSize.text;
        obj.streetTitle1 = _selectStreet.text;
        obj.locationTitle1 = _selectLocationFld.text;
        obj.buildingAgeTitle1 = _buildingAgeFl.text;
        obj.finishingQualityTitle1 = _finishingQualityFld.text;
        obj.basementTitle1 = _basementFld.text;
        obj.noOffloorsTitle1 = _noOfFloorsFld.text;
        obj.seaFrontTitle1 = @"NA";
        obj.backStreetTitle1 = @"NA";
        obj.directionTitle1 = _selectdirectionFld.text;
        obj.curbTitle1 = _selectCurbFLd.text;
        obj.estimatedPriceValue1 = [NSString stringWithFormat:@"%@ %@",Localized(@"KD"),[result valueForKey:@"total"]];
        obj.landValue1 = [NSString stringWithFormat:@"%@ %@",Localized(@"KD"),[result valueForKey:@"land_value"]];
        obj.buildingValue1 = [NSString stringWithFormat:@"%@ %@",Localized(@"KD"),[result valueForKey:@"building_value"]];
        obj.date = [NSString stringWithFormat:@"%@ %@",Localized([result valueForKey:@"datem"]),Localized([result valueForKey:@"datey"])];
        
        obj.landSpecsTitle1 = locationSpectitleStr;
        obj.plotSpecsTitles1 = plotSpecTitleStr;
        obj.facingSpecsTitles1 = facinfSpecTitleStr;
        
        [self.navigationController pushViewController:obj animated:NO];

//        _areaTitle.text = _selectAreaFld.text;
//        _landSizeTitle.text = _selectLandSize.text;
//        _streetTitle.text = _selectStreet.text;
//        _locationTitle.text = _selectLocationFld.text;
//        _buildingAgeTitle.text = _buildingAgeFl.text;
//        _finishingQualityTitle.text = _finishingQualityFld.text;
//        _basementTitle.text = _basementFld.text;
//        _noOffloorsTitle.text = _noOfFloorsFld.text;
//        _seaFrontTitle.text = @"NA";
//        _backStreetTitle.text = @"NA";
//        _directionTitle.text = _selectdirectionFld.text;
//        _curbTitle.text = _selectCurbFLd.text;
//        _estimatedPriceValue.text = [NSString stringWithFormat:@"%@ KD",[result valueForKey:@"total"]];
//        _landValue.text = [NSString stringWithFormat:@"%@ KD",[result valueForKey:@"land_value"]];
//        _buildingValue.text = [NSString stringWithFormat:@"%@ KD",[result valueForKey:@"building_value"]];
//        
//        _landSpecsTitle.text = locationSpectitleStr;
//        _plotSpecsTitles.text = plotSpecTitleStr;
//        _facingSpecsTitles.text = facinfSpecTitleStr;
        
//        [self settextAlignment:_estimatedPriceValue];
//        [self settextAlignment:_areaTitle];
//        [self settextAlignment:_landSizeTitle];
//        [self settextAlignment:_streetTitle];
//        [self settextAlignment:_locationTitle];
//        [self settextAlignment:_buildingAgeTitle];
//        [self settextAlignment:_finishingQualityTitle];
//        [self settextAlignment:_basementTitle];
//        [self settextAlignment:_noOffloorsTitle];
//        [self settextAlignment:_seaFrontTitle];
//        [self settextAlignment:_backStreetTitle];
//        [self settextAlignment:_directionTitle];
//        [self settextAlignment:_curbTitle];
//
//        [self settextAlignment:_previewAreaLbl];
//        [self settextAlignment:_previewLandSizeLbl];
//        [self settextAlignment:_previewstreetLbl];
//        [self settextAlignment:_previewLocationLbl];
//        [self settextAlignment:_previewbuildingAgeLbl];
//        [self settextAlignment:_previewfinishingQuali];
//        [self settextAlignment:_previewbasementLlb];
//        [self settextAlignment:_previewnoOfFloors];
//        [self settextAlignment:_previewSeaFrontLbl];
//        [self settextAlignment:_previewbackStreetLenght];
//        [self settextAlignment:_previewDirectionLbl];
//        [self settextAlignment:_previewCurbFld];
//        [self settextAlignment:_previewDetailsLbl];
        
//        _popUpView.hidden = NO;
//        _previewPopUp.hidden = NO;
    }
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[result valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertController dismissViewControllerAnimated:YES completion:^{
                    // Do something
                    
                }];
                
            });
        }
    }
    else{
        
    }
    
    [self hideHUD];
}

-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }}

#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _locationcollectionView) {
        return locationArray.count;
    }
    else if (collectionView == _locationSpecCollectionView){
        return locationSpecArray.count;
    }
    else if (collectionView == _plotSpecCollectionView){
        return plotSpecArray.count;
    }
    else if (collectionView == _facingCollectinView){
        return facingArray.count;
    } else if (collectionView == _sharedCollectionView){
        return crubCheckingArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _locationcollectionView) {
        
        locationcheckCollectionViewCell *cell = [self.locationcollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];
        
        cell.titleLlb.text = [locationArray objectAtIndex:indexPath.row];
        
      //  [cell.titleLlb setTextAlignment:NSTextAlignmentCenter];

        [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
        
        if ([table containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
        {
            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkon.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
        }
        
//        cell.checkBoxBtn.tag = indexPath.row;
//
//        [cell.checkBoxBtn addTarget:self action:@selector(locationCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedBtn = ^{

            
            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkon.png"] forState:UIControlStateNormal];
            
            cell.titleLlb.textColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            
            if ([table containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                //[table removeObject:[locationArray objectAtIndex:indexPath.row]];
                
                [table removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [filterContainStringad removeObject:[locationArrayMulti objectAtIndex:indexPath.row]];
                
                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
                
                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];

                
                NSLog(@"filter contains string is %@",filterContainStringad);
                
                locationStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < filterContainStringad.count ; i++){
                    
                    if(i<filterContainStringad.count-1)
                    {
                        [locationStr appendString:[NSString stringWithFormat:@"%@%@",[filterContainStringad objectAtIndex:i],appendStrig2]];
                        
                    }
                    else
                    {
                        [locationStr appendString:[NSString stringWithFormat:@"%@",[filterContainStringad objectAtIndex:i]]];
                    }
                }
                
                NSLog(@"location Str is %@",locationStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];
                
                [filterContainStringad addObject:[locationArrayMulti objectAtIndex:indexPath.row]];
                
                NSLog(@"filter contains string is %@",filterContainStringad);
                
                locationStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < filterContainStringad.count ; i++){
                    
                    if(i<filterContainStringad.count-1){
                        
                        [locationStr appendString:[NSString stringWithFormat:@"%@%@",[filterContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [locationStr appendString:[NSString stringWithFormat:@"%@",[filterContainStringad objectAtIndex:i]]];
                    }
                }
                
                NSLog(@"location Str is %@",locationStr);
            }
        };
        return cell;
    }else if (collectionView == _sharedCollectionView){
        
        SharedCollectionViewCell *cell = [self.sharedCollectionView dequeueReusableCellWithReuseIdentifier:@"SharedCollectionViewCell" forIndexPath:indexPath];
        
        cell.titleLbl.text = [crubCheckingArray objectAtIndex:indexPath.row];
        
        [cell.checkBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
        
        cell.titleLbl.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];

        if ([crackArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
        {
            [cell.checkBtn setImage:[UIImage imageNamed:@"checkon.png"] forState:UIControlStateNormal];

        }
        else
        {
            [cell.checkBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
        }
        
        //        cell.checkBoxBtn.tag = indexPath.row;
        //
        //        [cell.checkBoxBtn addTarget:self action:@selector(locationCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedBtn = ^{
            
            
            [cell.checkBtn setImage:[UIImage imageNamed:@"checkon.png"] forState:UIControlStateNormal];

            cell.titleLbl.textColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];

            if ([crackArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                //[table removeObject:[locationArray objectAtIndex:indexPath.row]];
                
                [crackArray1 removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [curbContainedStr removeObject:[curbCheckArray objectAtIndex:indexPath.row]];
                
                [cell.checkBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];
                
                cell.titleLbl.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];

                
                NSLog(@"filter contains string is %@",curbContainedStr);
                
               // curbContainedStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < curbCheckArray.count ; i++){
                    
                    if(i<curbCheckArray.count-1)
                    {
                        [crubCheckStr appendString:[NSString stringWithFormat:@"%@%@",[curbCheckArray objectAtIndex:i],appendStrig2]];
                        
                    }
                    else
                    {
                        [crubCheckStr appendString:[NSString stringWithFormat:@"%@",[curbCheckArray objectAtIndex:i]]];
                    }
                }
                
                NSLog(@"curb contained Str is %@",crubCheckStr);
            }
            else
            {
                [crackArray1 addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];
                
                [curbContainedStr addObject:[curbCheckArray objectAtIndex:indexPath.row]];
                
                NSLog(@"filter contains string is %@",curbContainedStr);
                
                crubCheckStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < curbCheckArray.count ; i++){
                    
                    if(i<curbCheckArray.count-1){
                        
                        [crubCheckStr appendString:[NSString stringWithFormat:@"%@%@",[curbCheckArray objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [crubCheckStr appendString:[NSString stringWithFormat:@"%@",[curbCheckArray objectAtIndex:i]]];
                    }
                }
                
                NSLog(@"curb contained Str is %@",curbContainedStr);
            }
        };
        return cell;
    }
    else if (collectionView == _locationSpecCollectionView){
        
        LocationSpecCollectionViewCell *cell1 = [self.locationSpecCollectionView dequeueReusableCellWithReuseIdentifier:@"LocationSpecCollectionViewCell" forIndexPath:indexPath];
        
        cell1.titleLlb.text = [locationSpecArray objectAtIndex:indexPath.row];
        
        [cell1.titleLlb setTextAlignment:NSTextAlignmentCenter];
        
//        [cell1.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        cell1.checkBoxBtn.layer.borderWidth = 1.0f;
        cell1.checkBoxBtn.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:222.0f/255.0f blue:226.0f/255.0f alpha:1.0].CGColor;
        cell1.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cell1.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
        cell1.checkBoxBtn.layer.cornerRadius =15.0f;
        [self cellButonShadowClear:cell1.checkBoxBtn];
        
 //       cell1.checkBoxBtn.layer.masksToBounds = YES;

//        cell1.layer.borderWidth = 2.0f;
//        cell1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        cell1.layer.cornerRadius =15.0f;
//        cell1.layer.masksToBounds = YES;

        
        if ([locationSpecsArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
        {
//            [cell1.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
          //  cell1.checkBoxBtn.layer.borderWidth = 2.0f;
           // cell1.checkBoxBtn.layer.borderColor = [UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0].CGColor;
            //cell1.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0].CGColor;
            cell1.checkBoxBtn.layer.borderWidth = 0.0f;
cell1.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;

            [self cellButonShadow:cell1.checkBoxBtn];
            

            cell1.titleLlb.textColor = [UIColor whiteColor];
            cell1.checkBoxBtn.layer.cornerRadius =15.0f;
  //          cell1.checkBoxBtn.layer.masksToBounds = YES;
            //            cell1.layer.borderWidth = 2.0f;
//            cell1.layer.borderColor = [UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0].CGColor;
//            cell1.layer.cornerRadius =15.0f;
//            cell1.layer.masksToBounds = YES;

        }
        else
        {
//            [cell1.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
            
            cell1.checkBoxBtn.layer.borderWidth = 1.0f;
            cell1.checkBoxBtn.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:222.0f/255.0f blue:226.0f/255.0f alpha:1.0].CGColor;
            cell1.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            cell1.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
            cell1.checkBoxBtn.layer.cornerRadius =15.0f;
            
            [self cellButonShadowClear:cell1.checkBoxBtn];

            //               cell1.checkBoxBtn.layer.masksToBounds = YES;

//            cell1.layer.borderWidth = 2.0f;
//            cell1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            cell1.layer.cornerRadius =15.0f;
//            cell1.layer.masksToBounds = YES;

        }
        
        //cell1.checkBoxBtn.tag = indexPath.row;
        
        //[cell1.checkBoxBtn addTarget:self action:@selector(locationSpecCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell1.selectedBtn =  ^{
            
            if ([locationSpecsArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                [locationSpecsArray1 removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [locationSpecTitleContained removeObject:[locationSpecArray objectAtIndex:indexPath.row]];
                
                [locationSpecsContained removeObject:[locationSpecArrayMulti objectAtIndex:indexPath.row]];
                
//                [cell1.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
                
                cell1.checkBoxBtn.layer.borderWidth = 1.0f;
                cell1.checkBoxBtn.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:222.0f/255.0f blue:226.0f/255.0f alpha:1.0].CGColor;
                cell1.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
                cell1.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
                cell1.checkBoxBtn.layer.cornerRadius =15.0f;
                
                [self cellButonShadowClear:cell1.checkBoxBtn];

 //               cell1.checkBoxBtn.layer.masksToBounds = YES;
                
//                cell1.layer.borderWidth = 2.0f;
//                cell1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//                cell1.layer.cornerRadius =15.0f;
//                cell1.layer.masksToBounds = YES;


                
                NSLog(@"filter contains string is %@",locationSpecsContained);
                
                locationSpecStr = [[NSMutableString alloc]init];
                locationSpectitleStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < locationSpecsContained.count ; i++){
                    
                    if(i<locationSpecsContained.count-1)
                    {
                        [locationSpecStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecsContained objectAtIndex:i],appendStrig2]];
                        
                        [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecTitleContained objectAtIndex:i],appendStrig2]];
                        
                    }
                    else
                    {
                        [locationSpecStr appendString:[NSString stringWithFormat:@"%@",[locationSpecsContained objectAtIndex:i]]];
                        
                        [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@",[locationSpecTitleContained objectAtIndex:i]]];
                    }
                }
            }
            else
            {
//                [cell1.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
                
          //      cell1.checkBoxBtn.layer.borderWidth = 2.0f;
                // cell1.checkBoxBtn.layer.borderColor = [UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0].CGColor;
                cell1.checkBoxBtn.layer.borderWidth = 0.0f;
                cell1.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
                cell1.titleLlb.textColor = [UIColor whiteColor];
                cell1.checkBoxBtn.layer.cornerRadius =15.0f;
                
                [self cellButonShadow:cell1.checkBoxBtn];

                //          cell1.checkBoxBtn.layer.masksToBounds = YES;
//                cell1.layer.borderWidth = 2.0f;
//                cell1.layer.borderColor = [UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0].CGColor;
//                cell1.layer.cornerRadius =15.0f;
//                cell1.layer.masksToBounds = YES;

                [locationSpecsArray1 addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [locationSpecTitleContained addObject:[locationSpecArray objectAtIndex:indexPath.row]];
                
                [locationSpecsContained addObject:[locationSpecArrayMulti objectAtIndex:indexPath.row]];
                
                NSLog(@"filter contains string is %@",locationSpecsContained);
                
                locationSpecStr = [[NSMutableString alloc]init];
                
                locationSpectitleStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < locationSpecsContained.count ; i++){
                    
                    if(i<locationSpecsContained.count-1){
                        
                        [locationSpecStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecsContained objectAtIndex:i],appendStrig2]];
                        
                        [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecTitleContained objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [locationSpecStr appendString:[NSString stringWithFormat:@"%@",[locationSpecsContained objectAtIndex:i]]];
                        
                        [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@",[locationSpecTitleContained objectAtIndex:i]]];
                    }
                }
                
            }
        };
        return cell1;
    }
    else if (collectionView == _plotSpecCollectionView){
        
        PlotSpecCollectionViewCell *cell = [self.plotSpecCollectionView dequeueReusableCellWithReuseIdentifier:@"PlotSpecCollectionViewCell" forIndexPath:indexPath];
        
        cell.titleLlb.text = [plotSpecArray objectAtIndex:indexPath.row];
        
        [cell.titleLlb setTextAlignment:NSTextAlignmentCenter];
//        [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.checkBoxBtn.layer.borderWidth = 1.0f;
        cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
        cell.checkBoxBtn.layer.cornerRadius =15.0f;
        cell.checkBoxBtn.layer.masksToBounds = YES;

        [self cellButonShadowClear:cell.checkBoxBtn];

        
        if ([plotSpesArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
        {
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
            
            cell.checkBoxBtn.layer.borderWidth = 0.0f;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
            cell.titleLlb.textColor = [UIColor whiteColor];
//            cell.titleLlb.textColor = [UIColor whiteColor];
            [self cellButonShadow:cell.checkBoxBtn];

            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;

        }
        else
        {
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
            
            cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.checkBoxBtn.layer.borderWidth = 1.0f;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
            [self cellButonShadowClear:cell.checkBoxBtn];

            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;

        }
        
//        cell.checkBoxBtn.tag = indexPath.row;
//
//        [cell.checkBoxBtn addTarget:self action:@selector(plotSpecBtntapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedBtn = ^{
            
           
            
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
            cell.checkBoxBtn.layer.borderWidth = 0.0f;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
            cell.titleLlb.textColor = [UIColor whiteColor];
           // cell.titleLlb.textColor = [UIColor whiteColor];
            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;

            [self cellButonShadow:cell.checkBoxBtn];

            
            if ([plotSpesArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                [plotSpesArray1 removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [plotSpecTitleContained removeObject:[plotSpecArray objectAtIndex:indexPath.row]];
                
                [plotSpesContained removeObject:[plotSpecArrayMulti objectAtIndex:indexPath.row]];
                
//                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
                
                cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                cell.checkBoxBtn.layer.borderWidth = 1.0f;
                cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
                
                [self cellButonShadowClear:cell.checkBoxBtn];

                cell.checkBoxBtn.layer.cornerRadius =15.0f;
                cell.checkBoxBtn.layer.masksToBounds = YES;

                NSLog(@"filter contains string is %@",plotSpesContained);
                
                plotSpecStr = [[NSMutableString alloc]init];
                plotSpecTitleStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < plotSpesContained.count ; i++){
                    
                    if(i<plotSpesContained.count-1)
                    {
                        [plotSpecStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpesContained objectAtIndex:i],appendStrig2]];
                        
                        [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpecTitleContained objectAtIndex:i],appendStrig2]];
                        
                        
                    }
                    else
                    {
                        [plotSpecStr appendString:[NSString stringWithFormat:@"%@",[plotSpesContained objectAtIndex:i]]];
                        
                        [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[plotSpecTitleContained objectAtIndex:i]]];
                    }
                }
            }
            else
            {
                [plotSpesArray1 addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [plotSpecTitleContained addObject:[plotSpecArray objectAtIndex:indexPath.row]];
                
                [plotSpesContained addObject:[plotSpecArrayMulti objectAtIndex:indexPath.row]];
                
                NSLog(@"filter contains string is %@",plotSpesContained);
                
                plotSpecStr = [[NSMutableString alloc]init];
                plotSpecTitleStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < plotSpesContained.count ; i++){
                    
                    if(i<plotSpesContained.count-1){
                        
                        [plotSpecStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpesContained objectAtIndex:i],appendStrig2]];
                        
                        [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpecTitleContained objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [plotSpecStr appendString:[NSString stringWithFormat:@"%@",[plotSpesContained objectAtIndex:i]]];
                        
                        [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[plotSpecTitleContained objectAtIndex:i]]];
                    }
                }
                
                NSLog(@"plot Spec string is %@",plotSpecTitleStr);
                
            }
        };
        return cell;
    }
    else if (collectionView == _facingCollectinView){
        
        FacingCollectionViewCell *cell = [self.facingCollectinView dequeueReusableCellWithReuseIdentifier:@"FacingCollectionViewCell" forIndexPath:indexPath];
        
        cell.titleLlb.text = [facingArray objectAtIndex:indexPath.row];
        
        [cell.titleLlb setTextAlignment:NSTextAlignmentCenter];
        
//        [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        cell.checkBoxBtn.layer.borderWidth = 1.0f;
        cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
        cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cell.checkBoxBtn.layer.cornerRadius =15.0f;
        cell.checkBoxBtn.layer.masksToBounds = YES;
        [self cellButonShadowClear:cell.checkBoxBtn];

        
        if ([plotSpesArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
        {
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
            
            cell.checkBoxBtn.layer.borderWidth = 0.0f;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
            cell.titleLlb.textColor = [UIColor whiteColor];
//            cell.titleLlb.textColor = [UIColor whiteColor];
            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;
            [self cellButonShadow:cell.checkBoxBtn];


        }
        else
        {
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
            
            cell.checkBoxBtn.layer.borderWidth = 1.0f;
            cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;
            [self cellButonShadowClear:cell.checkBoxBtn];


        }
        
//        cell.checkBoxBtn.tag = indexPath.row;
//
//        [cell.checkBoxBtn addTarget:self action:@selector(facingBtntapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedBtn = ^{
            
//            [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
            
            cell.checkBoxBtn.layer.borderWidth = 0.0f;
            cell.checkBoxBtn.layer.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
            //cell.titleLlb.textColor = [UIColor whiteColor];
            cell.titleLlb.textColor = [UIColor whiteColor];
            cell.checkBoxBtn.layer.cornerRadius =15.0f;
            cell.checkBoxBtn.layer.masksToBounds = YES;
            [self cellButonShadow:cell.checkBoxBtn];

            
            if ([facingSpecArray1 containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                [facingSpecArray1 removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [facingSpecTitleContained removeObject:[facingArray objectAtIndex:indexPath.row]];
                
                [facingSpecContained removeObject:[facingArrayMulti objectAtIndex:indexPath.row]];
                
//                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
                
                cell.checkBoxBtn.layer.borderWidth = 1.0f;
                cell.checkBoxBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                cell.checkBoxBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0];
                cell.checkBoxBtn.layer.cornerRadius =15.0f;
                cell.checkBoxBtn.layer.masksToBounds = YES;
                [self cellButonShadowClear:cell.checkBoxBtn];

                
                NSLog(@"filter contains string is %@",facingSpecContained);
                
                facingSpecStr = [[NSMutableString alloc]init];
                facinfSpecTitleStr = [[NSMutableString alloc]init];
                
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < facingSpecContained.count ; i++){
                    
                    if(i<facingSpecContained.count-1)
                    {
                        [facingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecContained objectAtIndex:i],appendStrig2]];
                        
                        [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecTitleContained objectAtIndex:i],appendStrig2]];
                        
                    }
                    else
                    {
                        [facingSpecStr appendString:[NSString stringWithFormat:@"%@",[facingSpecContained objectAtIndex:i]]];
                        
                        [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[facingSpecTitleContained objectAtIndex:i]]];
                    }
                }
            }
            else
            {
                [facingSpecArray1 addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
                
                [facingSpecTitleContained addObject:[facingArray objectAtIndex:indexPath.row]];
                
                [facingSpecContained addObject:[facingArrayMulti objectAtIndex:indexPath.row]];
                
                NSLog(@"filter contains string is %@",facingSpecContained);
                
                facingSpecStr = [[NSMutableString alloc]init];
                facinfSpecTitleStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";
                
                for (int i=0; i < facingSpecContained.count ; i++){
                    
                    if(i<facingSpecContained.count-1){
                        
                        [facingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecContained objectAtIndex:i],appendStrig2]];
                        
                        [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecTitleContained objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [facingSpecStr appendString:[NSString stringWithFormat:@"%@",[facingSpecContained objectAtIndex:i]]];
                        
                        [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[facingSpecTitleContained objectAtIndex:i]]];
                    }
                }
                NSLog(@"facing Spec string is %@",plotSpecTitleStr);
            }
        };
        return cell;
    }
    return 0;
}


-(void)locationCollectionBtn:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_locationcollectionView];
    
    NSIndexPath *indexPath = [_locationcollectionView indexPathForItemAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
    
    if ([table containsObject:[NSString stringWithFormat:@"%li",(long)button.tag]])
    {
        //[table removeObject:[locationArray objectAtIndex:indexPath.row]];
        
        [table removeObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [filterContainStringad removeObject:[locationArrayMulti objectAtIndex:indexPath.row]];
        
        [button setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        NSLog(@"filter contains string is %@",filterContainStringad);
        
        locationStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < filterContainStringad.count ; i++){
            
            if(i<filterContainStringad.count-1)
            {
                [locationStr appendString:[NSString stringWithFormat:@"%@%@",[filterContainStringad objectAtIndex:i],appendStrig2]];
                
            }
            else
            {
                [locationStr appendString:[NSString stringWithFormat:@"%@",[filterContainStringad objectAtIndex:i]]];
            }
        }
        
        NSLog(@"location Str is %@",locationStr);
    }
    else
    {
        [table addObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];
        
        [filterContainStringad addObject:[locationArrayMulti objectAtIndex:indexPath.row]];
        
        NSLog(@"filter contains string is %@",filterContainStringad);
        
        locationStr = [[NSMutableString alloc]init];
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < filterContainStringad.count ; i++){
            
            if(i<filterContainStringad.count-1){
                
                [locationStr appendString:[NSString stringWithFormat:@"%@%@",[filterContainStringad objectAtIndex:i],appendStrig2]];
            }
            else
            {
                [locationStr appendString:[NSString stringWithFormat:@"%@",[filterContainStringad objectAtIndex:i]]];
            }
        }
        
        NSLog(@"location Str is %@",locationStr);
    }
}

-(void)locationSpecCollectionBtn:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_locationSpecCollectionView];
    
    NSIndexPath *indexPath = [_locationSpecCollectionView indexPathForItemAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
    
    if ([locationSpecsArray1 containsObject:[NSString stringWithFormat:@"%li",(long)button.tag]])
    {
        [locationSpecsArray1 removeObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [locationSpecTitleContained removeObject:[locationSpecArray objectAtIndex:indexPath.row]];
        
        [locationSpecsContained removeObject:[locationSpecArrayMulti objectAtIndex:indexPath.row]];
        
        [button setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        NSLog(@"filter contains string is %@",locationSpecsContained);
        
        locationSpecStr = [[NSMutableString alloc]init];
        locationSpectitleStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < locationSpecsContained.count ; i++){
            
            if(i<locationSpecsContained.count-1)
            {
                [locationSpecStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecsContained objectAtIndex:i],appendStrig2]];
                
                [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecTitleContained objectAtIndex:i],appendStrig2]];
                
            }
            else
            {
                [locationSpecStr appendString:[NSString stringWithFormat:@"%@",[locationSpecsContained objectAtIndex:i]]];
                
                [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@",[locationSpecTitleContained objectAtIndex:i]]];
            }
        }
    }
    else
    {
        [locationSpecsArray1 addObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [locationSpecTitleContained addObject:[locationSpecArray objectAtIndex:indexPath.row]];
        
        [locationSpecsContained addObject:[locationSpecArrayMulti objectAtIndex:indexPath.row]];
        
        NSLog(@"filter contains string is %@",locationSpecsContained);
        
        locationSpecStr = [[NSMutableString alloc]init];
        
        locationSpectitleStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < locationSpecsContained.count ; i++){
            
            if(i<locationSpecsContained.count-1){
                
                [locationSpecStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecsContained objectAtIndex:i],appendStrig2]];
                
                [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@%@",[locationSpecTitleContained objectAtIndex:i],appendStrig2]];
            }
            else
            {
                [locationSpecStr appendString:[NSString stringWithFormat:@"%@",[locationSpecsContained objectAtIndex:i]]];
                
                [locationSpectitleStr appendString:[NSString stringWithFormat:@"%@",[locationSpecTitleContained objectAtIndex:i]]];
            }
        }
        
    }
}

-(void)plotSpecBtntapped:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_plotSpecCollectionView];
    
    NSIndexPath *indexPath = [_locationSpecCollectionView indexPathForItemAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
    
    if ([plotSpesArray1 containsObject:[NSString stringWithFormat:@"%li",(long)button.tag]])
    {
        [plotSpesArray1 removeObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [plotSpecTitleContained removeObject:[plotSpecArray objectAtIndex:indexPath.row]];
        
        [plotSpesContained removeObject:[plotSpecArrayMulti objectAtIndex:indexPath.row]];
        
        [button setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        NSLog(@"filter contains string is %@",plotSpesContained);
        
        plotSpecStr = [[NSMutableString alloc]init];
        plotSpecTitleStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < plotSpesContained.count ; i++){
            
            if(i<plotSpesContained.count-1)
            {
                [plotSpecStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpesContained objectAtIndex:i],appendStrig2]];
                
                [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpecTitleContained objectAtIndex:i],appendStrig2]];
                
                
            }
            else
            {
                [plotSpecStr appendString:[NSString stringWithFormat:@"%@",[plotSpesContained objectAtIndex:i]]];
                
                [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[plotSpecTitleContained objectAtIndex:i]]];
            }
        }
    }
    else
    {
        [plotSpesArray1 addObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [plotSpecTitleContained addObject:[plotSpecArray objectAtIndex:indexPath.row]];
        
        [plotSpesContained addObject:[plotSpecArrayMulti objectAtIndex:indexPath.row]];
        
        NSLog(@"filter contains string is %@",plotSpesContained);
        
        plotSpecStr = [[NSMutableString alloc]init];
        plotSpecTitleStr = [[NSMutableString alloc]init];
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < plotSpesContained.count ; i++){
            
            if(i<plotSpesContained.count-1){
                
                [plotSpecStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpesContained objectAtIndex:i],appendStrig2]];
                
                [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[plotSpecTitleContained objectAtIndex:i],appendStrig2]];
            }
            else
            {
                [plotSpecStr appendString:[NSString stringWithFormat:@"%@",[plotSpesContained objectAtIndex:i]]];
                
                [plotSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[plotSpecTitleContained objectAtIndex:i]]];
            }
        }
        
        NSLog(@"plot Spec string is %@",plotSpecTitleStr);
        
    }
}

-(void)facingBtntapped:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_facingCollectinView];
    
    NSIndexPath *indexPath = [_facingCollectinView indexPathForItemAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
    
    if ([facingSpecArray1 containsObject:[NSString stringWithFormat:@"%li",(long)button.tag]])
    {
        [facingSpecArray1 removeObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [facingSpecTitleContained removeObject:[facingArray objectAtIndex:indexPath.row]];
        
        [facingSpecContained removeObject:[facingArrayMulti objectAtIndex:indexPath.row]];
        
        [button setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        
        NSLog(@"filter contains string is %@",facingSpecContained);
        
        facingSpecStr = [[NSMutableString alloc]init];
        facinfSpecTitleStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < facingSpecContained.count ; i++){
            
            if(i<facingSpecContained.count-1)
            {
                [facingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecContained objectAtIndex:i],appendStrig2]];
                
                [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecTitleContained objectAtIndex:i],appendStrig2]];
                
            }
            else
            {
                [facingSpecStr appendString:[NSString stringWithFormat:@"%@",[facingSpecContained objectAtIndex:i]]];
                
                [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[facingSpecTitleContained objectAtIndex:i]]];
            }
        }
    }
    else
    {
        [facingSpecArray1 addObject:[NSString stringWithFormat:@"%li",(long)button.tag]];
        
        [facingSpecTitleContained addObject:[facingArray objectAtIndex:indexPath.row]];
        
        [facingSpecContained addObject:[facingArrayMulti objectAtIndex:indexPath.row]];
        
        NSLog(@"filter contains string is %@",facingSpecContained);
        
        facingSpecStr = [[NSMutableString alloc]init];
        facinfSpecTitleStr = [[NSMutableString alloc]init];
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < facingSpecContained.count ; i++){
            
            if(i<facingSpecContained.count-1){
                
                [facingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecContained objectAtIndex:i],appendStrig2]];
                
                [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@%@",[facingSpecTitleContained objectAtIndex:i],appendStrig2]];
            }
            else
            {
                [facingSpecStr appendString:[NSString stringWithFormat:@"%@",[facingSpecContained objectAtIndex:i]]];
                
                [facinfSpecTitleStr appendString:[NSString stringWithFormat:@"%@",[facingSpecTitleContained objectAtIndex:i]]];
            }
        }
        NSLog(@"facing Spec string is %@",plotSpecTitleStr);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _locationSpecCollectionView) {
        
        //return CGSizeMake((collectionView.frame.size.width)/2-10,50);
        return CGSizeMake((_locationSpecCollectionView.frame.size.width)/2-10,49);

    }
    else if(collectionView ==_plotSpecCollectionView){
        return CGSizeMake((collectionView.frame.size.width)/2-10,55);
        
    }
    else{
        //return CGSizeMake((collectionView.frame.size.width)/2-10,50);
        return CGSizeMake((collectionView.frame.size.width)/2-10,49);

    }

}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10; // This is the minimum inter item spacing, can be more
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


- (IBAction)selectAreabtnTapped:(id)sender {
    
    fldType = @"Select Area";
    [self showHUD:@""];
   // _popUpView.hidden = NO;
    
   // [self makePostCallForPage:LIVE_AREAS withParams:@{} withRequestCode:1];
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate=self;
    //    [self.navigationController pushViewController:vc animated:YES];
    vc.completionBlock = ^(NSMutableDictionary *area) {
        NSLog(@"%@",area);
//        snationality= area;
        areaId =[area valueForKey:@"id"];
        self.selectAreaFld.text = [[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]?[area valueForKey:@"value_arabic"]:[area valueForKey:@"value_english"];
        [self makePostCallForPage:LIVE_VALUES withParams:@{@"area_id":areaId} withRequestCode:100];
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}
- (IBAction)selectLandSizeBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Size";
        
        NSLog(@"result Array %@",resultArray1);
        
        landSizeArray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"value_english"];
        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
        if(landSizeArray.count>0){
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Size")
                                                rows:landSizeArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
            _selectLandSize.text=[NSString stringWithFormat:@"%@",[landSizeArray objectAtIndex:selectedIndex]];
                                               
            landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
    }
}


- (IBAction)selectStreetBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Street";
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            streetArray = [[resultArray1 valueForKey:@"street"] valueForKey:@"value_arabic"];
        }
        else{
            streetArray = [[resultArray1 valueForKey:@"street"] valueForKey:@"value_english"];
        }
        
        streetIdarray = [[resultArray1 valueForKey:@"street"] valueForKey:@"id"];
        streetMulti = [[resultArray1 valueForKey:@"street"] valueForKey:@"multiplication_factor"];
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Street")
                                                rows:streetArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _selectStreet.text=[NSString stringWithFormat:@"%@",[streetArray objectAtIndex:selectedIndex]];
                                               
                                               streetId = [NSString stringWithFormat:@"%@",[streetMulti objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)buildingAgeBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Building";

        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            buildingArray = [[[resultArray1 valueForKey:@"building_spec"][0] valueForKey:@"building_spec_values"] valueForKey:@"value_arabic"];
        }
        else{
            buildingArray = [[[resultArray1 valueForKey:@"building_spec"][0] valueForKey:@"building_spec_values"] valueForKey:@"value_english"];
        }
        
        buildingIdarray = [[[resultArray1 valueForKey:@"building_spec"][0] valueForKey:@"building_spec_values"] valueForKey:@"id"];
        
        buildingMulti = [[[resultArray1 valueForKey:@"building_spec"][0] valueForKey:@"building_spec_values"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Building Age")
                                                rows:buildingArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                                               _buildingAgeFl.text=[NSString stringWithFormat:@"%@",[buildingArray objectAtIndex:selectedIndex]];

                                               buildingId = [NSString stringWithFormat:@"%@",[buildingMulti objectAtIndex:selectedIndex]];
                                               
                                               NSString *appendStrig2 = @",";
                    buildingSpec1 = [NSString stringWithFormat:@"%@",[buildingMulti objectAtIndex:selectedIndex]];
            //[buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[buildingMulti objectAtIndex:selectedIndex],appendStrig2]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
        
//        _popUpView.hidden = NO;
//        _tablePopUpView.hidden = NO;
//        _tableBackView.hidden = NO;
//        [_tablePopUpView reloadData];

    }
}

- (IBAction)finishingQualityBtnTapped:(id)sender {
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Quality";
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            finishingArray = [[[resultArray1 valueForKey:@"building_spec"][1] valueForKey:@"building_spec_values"] valueForKey:@"value_arabic"];
        }
        else{
            finishingArray = [[[resultArray1 valueForKey:@"building_spec"][1] valueForKey:@"building_spec_values"] valueForKey:@"value_english"];
        }
        
        FinishIdarray = [[[resultArray1 valueForKey:@"building_spec"][1] valueForKey:@"building_spec_values"] valueForKey:@"id"];
        
        qaulityMulti = [[[resultArray1 valueForKey:@"building_spec"][1] valueForKey:@"building_spec_values"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Quality")
                                                rows:finishingArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                                               _finishingQualityFld.text=[NSString stringWithFormat:@"%@",[finishingArray objectAtIndex:selectedIndex]];

                                               finidhingId = [NSString stringWithFormat:@"%@",[qaulityMulti objectAtIndex:selectedIndex]];
                                               
                                      //         buildingSpecStr = [[NSMutableString alloc]init];
                                               NSString *appendStrig2 = @",";
                                               
                               // [buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[qaulityMulti objectAtIndex:selectedIndex],appendStrig2]];

                                               buildingSpec2 = [NSString stringWithFormat:@"%@",[qaulityMulti objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
        
//        _popUpView.hidden = NO;
//        _tablePopUpView.hidden = NO;
//        _tableBackView.hidden = NO;
//        [_tablePopUpView reloadData];
        
    }
}

- (IBAction)basementBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Basement";
        
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            basementArray = [[[resultArray1 valueForKey:@"building_spec"][2] valueForKey:@"building_spec_values"] valueForKey:@"value_arabic"];
        }
        else{
            basementArray = [[[resultArray1 valueForKey:@"building_spec"][2] valueForKey:@"building_spec_values"] valueForKey:@"value_english"];
        }
        
        basementIdarray = [[[resultArray1 valueForKey:@"building_spec"][2] valueForKey:@"building_spec_values"] valueForKey:@"id"];
        
        basementMulti = [[[resultArray1 valueForKey:@"building_spec"][2] valueForKey:@"building_spec_values"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Basement")
                                                rows:basementArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                                               _basementFld.text=[NSString stringWithFormat:@"%@",[basementArray objectAtIndex:selectedIndex]];

                                               basementId = [NSString stringWithFormat:@"%@",[basementMulti objectAtIndex:selectedIndex]];
                                               
                                             //  buildingSpecStr = [[NSMutableString alloc]init];
                                               NSString *appendStrig2 = @",";
                                               
//                                    [buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[basementMulti objectAtIndex:selectedIndex],appendStrig2]];
                                               buildingSpec3 = [NSString stringWithFormat:@"%@",[basementMulti objectAtIndex:selectedIndex]];

                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];

    }
}

- (IBAction)advancedSpecBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        if (_advancedBtn.selected == YES)
        {
            _advancedSpecImage.image = [UIImage imageNamed:@"add.png"];
            _advancedBtn.selected = NO;
            advancSpeString = @"";
            
            if ([status isEqualToString:@"1"]) {
                
                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                _sharingBtnHeight.constant = 0;
                 _shareBtnTop.constant = 0;
            }
            else if ([status isEqualToString:@"2"]){
                
                _buildingSpecHeight.constant = 480;
                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                //_plotSpecHeight.constant = 180;
               // _facingHeight.constant = 400;
                
                
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *55)+(locationSpecArray.count%2 *55);
                _facingHeight.constant = (facingArray.count/2 *55)+(facingArray.count%2 *55);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *55)+(curbCheckArray.count%2 *55);

//                _specCollectionViewHeight.constant = 150;
                _sharingBtnHeight.constant = 0;
                
                 _shareBtnTop.constant = 70;
            }
            
           // _advancedBtn.selected = NO;
        }
        else
        {
            _advancedSpecImage.image = [UIImage imageNamed:@"minus.png"];
            _advancedBtn.selected = YES;
            advancSpeString = @"SELECTED";
            
            if ([status isEqualToString:@"1"]) {
                
                _buildingSpecHeight.constant = 0;
                _buildingSpecView.hidden = YES;
                _allSpecsView.hidden = NO;
//                _allspecHeight.constant = 950;
                
                _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *55)+(locationSpecArray.count%2 *55);
                _facingHeight.constant = (facingArray.count/2 *55)+(facingArray.count%2 *55);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *55)+(curbCheckArray.count%2 *55);
//1
            _allspecHeight.constant = _plotSpecHeight.constant+_facingHeight.constant+_locationCheckHeight.constant+_sharedCollectionViewHeight.constant+300+20+70;
                
    //_shareBtnTop.constant = _plotSpecHeight.constant+_facingHeight.constant+_locationCheckHeight.constant+310+80;

//                _plotSpecHeight.constant = 180;
//                _facingHeight.constant = 400;
//                _specCollectionViewHeight.constant = 150;
                

                _sharingBtnHeight.constant = 20;
                _sharingBtnHeight.constant = 20;
            }
            else if ([status isEqualToString:@"2"]){
                
                _buildingSpecHeight.constant = 460;
                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = NO;
             //  _allspecHeight.constant = 950;
                
                _allspecTopHeight.constant = 90;
                
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *55)+(locationSpecArray.count%2 *55);
                _facingHeight.constant = (facingArray.count/2 *55)+(facingArray.count%2 *55);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *55)+(curbCheckArray.count%2 *55);

     _allspecHeight.constant = _plotSpecHeight.constant+_facingHeight.constant+ _specCollectionViewHeight.constant+240+_sharedCollectionViewHeight.constant;
                
    _shareBtnTop.constant =_plotSpecHeight.constant+_facingHeight.constant+ _specCollectionViewHeight.constant+310;
                
                _sharingBtnHeight.constant = 20;
            }
        }
    }
}
-(void)advancedSpecClear{
    
     if (_advancedBtn.selected == YES)
        {
            _advancedSpecImage.image = [UIImage imageNamed:@"add.png"];
            _advancedBtn.selected = NO;
            advancSpeString = @"";
            
            if ([status isEqualToString:@"1"]) {
                
                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                _sharingBtnHeight.constant = 0;
                _shareBtnTop.constant = 0;
            }
            else if ([status isEqualToString:@"2"]){
                
                _buildingSpecHeight.constant = 480;
                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                //_plotSpecHeight.constant = 180;
                // _facingHeight.constant = 400;
                
                
                
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *55)+(locationSpecArray.count%2 *55);
                _facingHeight.constant = (facingArray.count/2 *55)+(facingArray.count%2 *55);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *55)+(curbCheckArray.count%2 *55);

                //                _specCollectionViewHeight.constant = 150;
                _sharingBtnHeight.constant = 0;
                
                _shareBtnTop.constant = 70;
            }
            
            // _advancedBtn.selected = NO;
        }
        else
        {
            _advancedSpecImage.image = [UIImage imageNamed:@"minus.png"];
            _advancedBtn.selected = YES;
            advancSpeString = @"SELECTED";
            
            if ([status isEqualToString:@"1"]) {
                
                _buildingSpecHeight.constant = 0;
                _buildingSpecView.hidden = YES;
                _allSpecsView.hidden = NO;
                //                _allspecHeight.constant = 950;
                
                _locationCheckHeight.constant = (locationArray.count/2 *55)+(locationArray.count%2 *55);
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *50)+(locationSpecArray.count%2 *50);
                _facingHeight.constant = (facingArray.count/2 *50)+(facingArray.count%2 *50);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *50)+(curbCheckArray.count%2 *50);

                _allspecHeight.constant = _plotSpecHeight.constant+_facingHeight.constant+_locationCheckHeight.constant+_sharedCollectionViewHeight.constant+300+40;
                
                _shareBtnTop.constant = _plotSpecHeight.constant+_facingHeight.constant+_locationCheckHeight.constant+310+80;
                
                //                _plotSpecHeight.constant = 180;
                //                _facingHeight.constant = 400;
                //                _specCollectionViewHeight.constant = 150;
                
                
                _sharingBtnHeight.constant = 20;
                _sharingBtnHeight.constant = 20;
            }
            else if ([status isEqualToString:@"2"]){
                
                _buildingSpecHeight.constant = 480;
                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = NO;
                //  _allspecHeight.constant = 950;
                
                _allspecTopHeight.constant = 0;
                
                
                
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *50)+(locationSpecArray.count%2 *50);
                _facingHeight.constant = (facingArray.count/2 *50)+(facingArray.count%2 *50);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *50)+(curbCheckArray.count%2 *50);

                _allspecHeight.constant = _plotSpecHeight.constant+_facingHeight.constant+ _specCollectionViewHeight.constant+240+ _sharedCollectionViewHeight.constant;
                
                _shareBtnTop.constant =_plotSpecHeight.constant+_facingHeight.constant+ _specCollectionViewHeight.constant+310;
                
                _sharingBtnHeight.constant = 20;
            }
        }
    
}
- (IBAction)directionBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Direction";
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            directionArray = [[[resultArray1 valueForKey:@"direction"] valueForKey:@"direction_values"] valueForKey:@"value_arabic"];
        }
        else{
            directionArray = [[[resultArray1 valueForKey:@"direction"] valueForKey:@"direction_values"] valueForKey:@"value_english"];
        }
        
        directionIdarray = [[[resultArray1 valueForKey:@"direction"] valueForKey:@"direction_values"] valueForKey:@"id"];
        
        directionMulti = [[[resultArray1 valueForKey:@"direction"] valueForKey:@"direction_values"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Direction")
                                                rows:directionArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                            _selectdirectionFld.text=[NSString stringWithFormat:@"%@",[directionArray objectAtIndex:selectedIndex]];
                                               
                  directiontId = [NSString stringWithFormat:@"%@",[directionMulti objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)curbBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Curb";
        
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            curbArray = [[[resultArray1 valueForKey:@"crub"] valueForKey:@"crub_values"] valueForKey:@"value_arabic"];
        }
        else{
            curbArray = [[[resultArray1 valueForKey:@"crub"] valueForKey:@"crub_values"] valueForKey:@"value_english"];
        }
        
        curbIdarray = [[[resultArray1 valueForKey:@"crub"] valueForKey:@"crub_values"] valueForKey:@"id"];
        
        curbMulti = [[[resultArray1 valueForKey:@"crub"] valueForKey:@"crub_values"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Curb")
                                                rows:curbArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _selectCurbFLd.text=[NSString stringWithFormat:@"%@",[curbArray objectAtIndex:selectedIndex]];
                                               
                                              // _curbTextLbl.text = [NSString stringWithFormat:@"%@",[curbArray objectAtIndex:selectedIndex]];
                                               
                                               curbtId = [NSString stringWithFormat:@"%@",[curbMulti objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
        
    }
}

- (IBAction)locationBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        fldType = @"Select Location";
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            filedLocationArray = [[resultArray1 valueForKey:@"location"] valueForKey:@"value_arabic"];
        }
        else{
            filedLocationArray = [[resultArray1 valueForKey:@"location"] valueForKey:@"value_english"];
        }
        
        filedLocationIdArray = [[resultArray1 valueForKey:@"location"] valueForKey:@"id"];
        locationMulti = [[resultArray1 valueForKey:@"location"] valueForKey:@"multiplication_factor"];
        
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Location")
                                                rows:filedLocationArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _selectLocationFld.text=[NSString stringWithFormat:@"%@",[filedLocationArray objectAtIndex:selectedIndex]];
                                               
                                               filedLocationId = [NSString stringWithFormat:@"%@",[locationMulti objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];

    }
}

- (IBAction)floorsBtnTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    
    else{
        
        fldType = @"Select Floor";
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            noOfFloorsArray = [[[resultArray1 valueForKey:@"building_spec"][3] valueForKey:@"building_spec_values"] valueForKey:@"value_arabic"];
        }
        else{
            noOfFloorsArray = [[[resultArray1 valueForKey:@"building_spec"][3] valueForKey:@"building_spec_values"] valueForKey:@"value_english"];
        }
        
        noOfFloorsIdArray = [[[resultArray1 valueForKey:@"building_spec"][3] valueForKey:@"building_spec_values"] valueForKey:@"id"];
        
        floorMulti = [[[resultArray1 valueForKey:@"building_spec"][3] valueForKey:@"building_spec_values"] valueForKey:@"multiplication_factor"];
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Floor")
                                                rows:noOfFloorsArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _noOfFloorsFld.text=[NSString stringWithFormat:@"%@",[noOfFloorsArray objectAtIndex:selectedIndex]];
                                               
                                               noOfFloorsId = [NSString stringWithFormat:@"%@",[floorMulti objectAtIndex:selectedIndex]];
                                               
                            NSString *appendStrig2 = @",";

//                        [buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[floorMulti objectAtIndex:selectedIndex],appendStrig2]];
                                               buildingSpec4 = [NSString stringWithFormat:@"%@",[floorMulti objectAtIndex:selectedIndex]];

                                           }
         
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)popUpcancelBtnTapped:(id)sender {
    
    _popUpView.hidden = YES;
    _tablePopUpView.hidden = YES;
    _tableBackView.hidden = YES;
    
}

- (IBAction)calculateBtnTapped:(id)sender {
    
    
    if ([status isEqualToString:@"1"]) {
        
        if ([self.selectAreaFld.text length] == 0) {
            [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
        }
        else if ([self.selectLandSize.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please select Size")];
        }
        else if ([self.selectStreet.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select Street")];
        }
        else if ([self.selectLocationFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select Location")];
        }
        else{
            
            
            [self showHUD:@""];
            
            NSLog(@"location Str is %@",locationStr);
            
            if ([directiontId length]==0) {
                
                directiontId = @"";
            }
             if ([curbtId length]==0){
              curbtId = @"";
            }
            if ([sharedCheck length]==0){
                sharedCheck = @"";
            }
            if ([plotSpecStr length]==0) {
                plotSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([facingSpecStr length]==0) {
                facingSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([locationSpecStr length]==0) {
                locationSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([buildingSpecStr length]==0) {
                buildingSpecStr = [NSMutableString stringWithFormat:@""];
            }
                if([_seaFrontLengthsFld.text intValue]<15){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
                }else  if([_seaFrontLengthsFld.text intValue]>99){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
                }
            else
                if([_backStreetFld.text intValue]<15){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
                }else  if([_backStreetFld.text intValue]>99){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
                }
                else{
                    NSString *sharedidsStr=@"";
                    if(curbContainedStr.count>0){
                        sharedidsStr=[curbContainedStr componentsJoinedByString:@","];
                    }
            [self makePostCallForPage:LIVE_RESULT withParams:@{@"area_id":areaId,@"size":landSizeId,@"street":streetId,@"location":filedLocationId,@"sea_facing":[NSString stringWithFormat:@"%@,%@",_seaFrontLengthsFld.text,_backStreetFld.text],@"land_spec":[NSString stringWithFormat:@"%@",locationSpecStr],@"status":status,@"building_spec":[NSString stringWithFormat:@"%@,%@,%@,%@",buildingSpec1,buildingSpec2,buildingSpec3,buildingSpec4],@"location_check":[NSString stringWithFormat:@"%@",locationStr],@"plot_spec":[NSString stringWithFormat:@"%@",plotSpecStr],@"facing":[NSString stringWithFormat:@"%@",facingSpecStr],@"direction":[NSString stringWithFormat:@"%@",directiontId],@"crub":[NSString stringWithFormat:@"%@",curbtId],@"crub_check":[NSString stringWithFormat:@"%@",sharedidsStr]} withRequestCode:30];
                }
        }
    }
    else{
        
        if ([self.selectAreaFld.text length] == 0) {
            [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
        }
        else if ([self.selectLandSize.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please select Size")];
        }
        else if ([self.selectStreet.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select Street")];
        }
        else if ([self.selectLocationFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select Location")];
        }
        else if ([self.finishingQualityFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select finishing Quality")];
        }
        else{
            
//            instantValueEstimator1ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimator1ViewController"];
//            [self.navigationController pushViewController:obj animated:YES];
            
            if ([directiontId length]==0) {
                directiontId = @"";
            }
            if ([curbtId length]==0){
                curbtId = @"";
            }
            if ([sharedCheck length]==0){
                sharedCheck = @"";
            }
            if ([plotSpecStr length]==0) {
                plotSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([facingSpecStr length]==0) {
                facingSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([locationSpecStr length]==0) {
                locationSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if ([buildingSpecStr length]==0) {
                buildingSpecStr = [NSMutableString stringWithFormat:@""];
            }
            if([_seaFrontLengthsFld.text intValue]<15){
                [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
            }else  if([_seaFrontLengthsFld.text intValue]>99){
                [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
            }
            else
                if([_backStreetFld.text intValue]<15){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
                }else  if([_backStreetFld.text intValue]>99){
                    [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
                }
                else{
            [self showHUD:@""];
                    NSString *sharedidsStr=@"";
                    if(curbContainedStr.count>0){
                        sharedidsStr=[curbContainedStr componentsJoinedByString:@","];
                    }
            [self makePostCallForPage:LIVE_RESULT withParams:@{@"area_id":areaId,@"size":landSizeId,@"street":streetId,@"location":filedLocationId,@"sea_facing":[NSString stringWithFormat:@"%@,%@",_seaFrontLengthsFld.text,_backStreetFld.text],@"land_spec":[NSString stringWithFormat:@"%@",locationSpecStr],@"status":status,@"building_spec":[NSString stringWithFormat:@"%@,%@,%@,%@",buildingSpec1,buildingSpec2,buildingSpec3,buildingSpec4],@"location_check":[NSString stringWithFormat:@"%@",locationStr],@"plot_spec":[NSString stringWithFormat:@"%@",plotSpecStr],@"facing":[NSString stringWithFormat:@"%@",facingSpecStr],@"direction":[NSString stringWithFormat:@"%@",directiontId],@"crub":[NSString stringWithFormat:@"%@",curbtId],@"crub_check":[NSString stringWithFormat:@"%@",sharedidsStr]} withRequestCode:30];
                }
            
        }
    }
}

- (IBAction)sharingBtnTapped:(id)sender {
    
    if (_sharingBtn.selected == YES)
    {
        [_sharingBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        sharedCheck = @"";
        _sharingBtn.selected = NO;
    }
    else
    {
        [_sharingBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
        sharedCheck = [curbCheckArray objectAtIndex:0];
        _sharingBtn.selected = YES;
        
    }
}

- (IBAction)buildingTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        _landBtn.selected = NO;
        
        if (_buildingBtn.selected == YES)
        {
            [_buildingBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
            _buildingBtn.selected = NO;
            
            status = @"";
        }
        else
        {
            [_buildingBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
            [_landBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
            status = @"2";
            //_buildingSpecView.backgroundColor    = [UIColor redColor];

            if ([advancSpeString isEqualToString:@"SELECTED"]) {
               
                _buildingSpecHeight.constant = 500;
                _buildingSpecView.hidden = NO;
//                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                _sharingBtnHeight.constant = 0;
  //change
//                _buildingSpecHeight.constant = 0;
//                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = NO;
//                _allspecHeight.constant = 950;
       //         _allspecTopHeight.constant = 340;
                
 
                _plotSpecHeight.constant = (plotSpecArray.count/2 *58)+(plotSpecArray.count%2 *58);
                _specCollectionViewHeight.constant = (locationSpecArray.count/2 *55)+(locationSpecArray.count%2 *55);
                _facingHeight.constant = (facingArray.count/2 *55)+(facingArray.count%2 *55);
                _sharedCollectionViewHeight.constant =(curbCheckArray.count/2 *55)+(curbCheckArray.count%2 *55);

            _allspecHeight.constant = _plotSpecHeight.constant+_facingHeight.constant +_specCollectionViewHeight.constant+240+ _sharedCollectionViewHeight.constant;
                
//            _shareBtnTop.constant = _allspecHeight.constant-850;
                
 _shareBtnTop.constant = _plotSpecHeight.constant+_facingHeight.constant +_specCollectionViewHeight.constant+390+100+50;
                
//                _sharingBtnHeight.constant = 20;
//                _sharingBtnHeight.constant = 20;
                
            }
            else{
                _buildingSpecHeight.constant = 480;
                _buildingSpecView.hidden = NO;
                _allSpecsView.hidden = YES;
                _allspecHeight.constant = 0;
                _sharingBtnHeight.constant = 0;
                _shareBtnTop.constant = 50;
            }
        }
    }
    
}

- (IBAction)landTapped:(id)sender {
    
    if ([self.selectAreaFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please select area Type")];
    }
    else{
        
        _buildingBtn.selected = NO;
        if (_landBtn.selected == YES)
        {
            [_landBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
            _landBtn.selected = NO;
            status = @"";
        }
        else
        {
            [_landBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
            status = @"1";
            [_buildingBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
            _landBtn.selected = YES;
            
            NSLog(@"%f all Spec height",_allspecHeight.constant);
            
            if (_allspecHeight.constant > 700) {
                
//                _shareBtnTop.constant = _allspecHeight.constant -850;
               
                 _shareBtnTop.constant = _plotSpecHeight.constant+_facingHeight.constant +_specCollectionViewHeight.constant+215;
            }
            
            else{
                _shareBtnTop.constant = -30;
            }
            
            _buildingSpecHeight.constant = 0;
            _buildingSpecView.hidden = YES;
            _sharingBtnHeight.constant = 0;
            _allspecTopHeight.constant = 0;
        }
        
    }
}

//-(void)fieldsHidden{
//
//    _buildingBackLbl.hidden = YES;
//    _buildingLineLbl.hidden = YES;
//    _finishingLineLbl.hidden = YES;
//    _finishingBackgroundLbl.hidden = YES;
//    _numberOfFloorsBackLbl.hidden = YES;
//    _nooffloorsLineLbl.hidden = YES;
//    _finishingQualityLbl.hidden = YES;
//    _finishingQualityFld.hidden = YES;
//    _basementLbl.hidden = YES;
//    _basementFld.hidden = YES;
//    _noofFloorsLbl.hidden = YES;
//    _noOfFloorsFld.hidden = YES;
//    _buildingAgeLbl.hidden = YES;
//    _buildingAgeFl.hidden = YES;
//    _floorsImage.hidden = YES;
//    _buildingDownImage.hidden = YES;
//    _finishingDownImage.hidden = YES;
//    _basementDownImage.hidden = YES;
//    _locationSpecLbl.hidden = YES;
//    _plotSpecLbl.hidden = YES;
//    _facingSpecLbl.hidden = YES;
//    _directionBackLbl.hidden = YES;
//    _curbBackLbl.hidden = YES;
//    _selectCurbFLd.hidden = YES;
//    _selectdirectionFld.hidden = YES;
//    _plotSpecHeight.constant = 0;
//    _facingHeight.constant = 0;
//    _locationCheckHeight.constant = 0;
//    _specCollectionViewHeight.constant = 0;
//    _locationSpecUnderloneLbl.hidden = YES;
//    _plotSpecUnderloneLbl.constant = 0;
//    _facingUnderloneLbl.constant = 0;
//    _directionUnderloneLbl.hidden = YES;
//    _curbUnderloneLbl.hidden = YES;
//    _directionDownImage.hidden = YES;
//    _basementUdeLbl.hidden = YES;
//    _floorsUnderLineLbl.hidden = YES;
//    _plotsUnderLbl.hidden = YES;
//    _facingUnderLbl.hidden = YES;
//    _directioNLbl.hidden = YES;
//    _curbLbl.hidden = YES;
//    _additionFldTop.constant = 16;
//    _basementBackLbl.hidden = YES;
//    _curbDownImage.hidden = YES;
//
//}
//-(void)fieldsNotHidden{
//
//
//    _noofFloorsLbl.hidden = NO;
//    _noOfFloorsFld.hidden = NO;
//    _basementUdeLbl.hidden = NO;
//    _floorsUnderLineLbl.hidden = NO;
//    _buildingBackLbl.hidden = NO;
//    _buildingLineLbl.hidden = NO;
//    _finishingLineLbl.hidden = NO;
//    _finishingBackgroundLbl.hidden = NO;
//    _numberOfFloorsBackLbl.hidden = NO;
//    _nooffloorsLineLbl.hidden = NO;
//    _buildingAgeLbl.hidden = NO;
//    _buildingAgeFl.hidden = NO;
//    _finishingQualityLbl.hidden = NO;
//    _finishingQualityFld.hidden = NO;
//    _basementLbl.hidden = NO;
//    _basementFld.hidden = NO;
//    _buildingDownImage.hidden = NO;
//    _finishingDownImage.hidden = NO;
//    _basementDownImage.hidden = NO;
//    _floorsImage.hidden = NO;
//    _locationSpecLbl.hidden = NO;
//    _plotSpecLbl.hidden = NO;
//    _facingSpecLbl.hidden = NO;
//    _directionBackLbl.hidden = NO;
//    _curbBackLbl.hidden = NO;
//    _selectCurbFLd.hidden = NO;
//    _selectdirectionFld.hidden = NO;
//    _plotSpecHeight.constant = 100;
//    _facingHeight.constant = 100;
//    _locationCheckHeight.constant = 50;
//    _specCollectionViewHeight.constant = 100;
//    _locationSpecUnderloneLbl.hidden = NO;
//    _plotSpecUnderloneLbl.constant = 1;
//    _facingUnderloneLbl.constant = 1;
//    _directionUnderloneLbl.hidden = NO;
//    _curbUnderloneLbl.hidden = NO;
//    _directionDownImage.hidden = NO;
//    _buildingDownImage.hidden = NO;
//    _finishingDownImage.hidden = NO;
//    _basementDownImage.hidden = NO;
//    _plotsUnderLbl.hidden = NO;
//    _facingUnderLbl.hidden = NO;
//    _directioNLbl.hidden = NO;
//    _curbLbl.hidden = NO;
//    _additionFldTop.constant = 900;
//    _basementBackLbl.hidden = NO;
//    _curbDownImage.hidden = NO;
//}

#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([fldType isEqualToString:@"Select Area"]) {
        return resultArray.count;
    }
    else if ([fldType isEqualToString:@"Select Size"]){
        
        return landSizeArray.count;
    }
    else if ([fldType isEqualToString:@"Select Street"]){
        
        return streetArray.count;
    }
    else if ([fldType isEqualToString:@"Select Building"]){
        
        return buildingArray.count;
    }
    else if ([fldType isEqualToString:@"Select Quality"]){
        
        return finishingArray.count;
    }
    else if ([fldType isEqualToString:@"Select Basement"]){
        
        return basementArray.count;
    }
    else if ([fldType isEqualToString:@"Select Direction"]){
        
        return directionArray.count;
    }
    else if ([fldType isEqualToString:@"Select Curb"]){
        
        return curbArray.count;
    }
    else if ([fldType isEqualToString:@"Select Location"]){
        
        return filedLocationArray.count;
    }
    else if ([fldType isEqualToString:@"Select Floor"]){
        
        return noOfFloorsArray.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchTableViewCell";
    SearchTableViewCell *cell = [_tablePopUpView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([fldType isEqualToString:@"Select Area"]) {
        
        cell.titleLbl.text =[[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Size"]){
        
        cell.titleLbl.text = [landSizeArray objectAtIndex:indexPath.row];
        
    }
    else if ([fldType isEqualToString:@"Select Street"]){
        
        cell.titleLbl.text = [streetArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Building"]){
        
        cell.titleLbl.text = [buildingArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Quality"]){
        
        cell.titleLbl.text = [finishingArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Basement"]){
        
        cell.titleLbl.text = [basementArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Direction"]){
        
        cell.titleLbl.text = [directionArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Curb"]){
        
        cell.titleLbl.text = [curbArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Location"]){
        
        cell.titleLbl.text = [filedLocationArray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Floor"]){
        
        cell.titleLbl.text = [noOfFloorsArray objectAtIndex:indexPath.row];
    }
    
    else{
        
    }
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        [cell.titleLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:15]];
//    }
//    else{
//        [cell.titleLbl setFont:[UIFont fontWithName:@"DroidSans-Bold" size:15]];
//    }
    
    [cell.radioButton setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
    cell.radioButton.tag = indexPath.row;
    [cell.radioButton addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.titleBtn.tag = indexPath.row;
    [cell.titleBtn addTarget:self action:@selector(checkBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)checkBtnClicked1:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tablePopUpView];
    
    NSIndexPath *indexPath = [_tablePopUpView indexPathForRowAtPoint:buttonFrame.origin];
    
    if ([fldType isEqualToString:@"Select Area"]) {
        
        count = indexPath.row;
        
        if ([[[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row] isEqualToString:@"Sabah Sea City - 4"]) {
            
            _selectAreaFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
            _sabahCityView.hidden = NO;
            _sabahCityheight.constant = 220;
            _sabahCityTopHeight.constant = 0;
        }
        else{
            
            _selectAreaFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
            _sabahCityView.hidden = YES;
            _sabahCityheight.constant = 0;
            _sabahCityTopHeight.constant = 10;
        }
        
        areaId  = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
        
        NSString *strId = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
      
        [self makePostCallForPage:LIVE_VALUES withParams:@{@"area_id":strId} withRequestCode:100];
        
    }
    else if ([fldType isEqualToString:@"Select Size"]){
        
        _selectLandSize.text = [landSizeArray objectAtIndex:indexPath.row];
        landSizeId = [sizeIdarray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Street"]){
        
        _selectStreet.text = [streetArray objectAtIndex:indexPath.row];
        streetId = [streetMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Building"]){
        
        _buildingAgeFl.text =[buildingArray objectAtIndex:indexPath.row];
        buildingId = [buildingMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[buildingMulti objectAtIndex:indexPath.row]];
        
    }
    else if ([fldType isEqualToString:@"Select Quality"]){
        
        _finishingQualityFld.text =[finishingArray objectAtIndex:indexPath.row];
        finidhingId = [qaulityMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[qaulityMulti objectAtIndex:indexPath.row]];
        
    }
    else if ([fldType isEqualToString:@"Select Basement"]){
        
        _basementFld.text =[basementArray objectAtIndex:indexPath.row];
        basementId = [basementMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[basementMulti objectAtIndex:indexPath.row]];
    }
    else if ([fldType isEqualToString:@"Select Direction"]){
        
        _selectdirectionFld.text =[directionArray objectAtIndex:indexPath.row];
        directiontId = [directionMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Curb"]){
        
        _selectCurbFLd.text =[curbArray objectAtIndex:indexPath.row];
        curbtId = [curbMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Location"]){
        
        _selectLocationFld.text = [filedLocationArray objectAtIndex:indexPath.row];
        filedLocationId = [locationMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Floor"]){
        
        _noOfFloorsFld.text = [noOfFloorsArray objectAtIndex:indexPath.row];
        noOfFloorsId = [floorMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[floorMulti objectAtIndex:indexPath.row]];
    }
    else{
        
    }
    
    buildingSpecStr = [[NSMutableString alloc]init];
    NSString *appendStrig2 = @",";
    
    for (int i=0; i < buildingSpecsContained.count ; i++){
        
        if(i<buildingSpecsContained.count-1)
        {
            [buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[buildingSpecsContained objectAtIndex:i],appendStrig2]];
            
        }
        else
        {
            [buildingSpecStr appendString:[NSString stringWithFormat:@"%@",[buildingSpecsContained objectAtIndex:i]]];
        }
    }
    
    //    [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    _popUpView.hidden = YES;
    _tablePopUpView.hidden = YES;
    _tableBackView.hidden = YES;
}

-(void)checkBtnClicked:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tablePopUpView];
    
    NSIndexPath *indexPath = [_tablePopUpView indexPathForRowAtPoint:buttonFrame.origin];
    
    if ([fldType isEqualToString:@"Select Area"]) {
        
        count = indexPath.row;
        
        if ([[[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row] isEqualToString:@"Sabah Sea City - 4"]) {
            
            _selectAreaFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
            _sabahCityView.hidden = NO;
            _sabahCityheight.constant = 220;
            _sabahCityTopHeight.constant = 0;
        }
        else{
            
            _selectAreaFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
            _sabahCityView.hidden = YES;
            _sabahCityheight.constant = 0;
            _sabahCityTopHeight.constant = 10;
        }
        
        areaId  = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
        
        NSString *strId = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
        [self makePostCallForPage:LIVE_VALUES withParams:@{@"area_id":strId} withRequestCode:100];
        
    }
    else if ([fldType isEqualToString:@"Select Size"]){
        
        _selectLandSize.text = [landSizeArray objectAtIndex:indexPath.row];
        landSizeId = [sizeIdarray objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Street"]){
        
        _selectStreet.text = [streetArray objectAtIndex:indexPath.row];
        streetId = [streetMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Building"]){
        
        _buildingAgeFl.text =[buildingArray objectAtIndex:indexPath.row];
        buildingId = [buildingMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[buildingMulti objectAtIndex:indexPath.row]];
        
    }
    else if ([fldType isEqualToString:@"Select Quality"]){
        
        _finishingQualityFld.text =[finishingArray objectAtIndex:indexPath.row];
        finidhingId = [qaulityMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[qaulityMulti objectAtIndex:indexPath.row]];
        
    }
    else if ([fldType isEqualToString:@"Select Basement"]){
        
        _basementFld.text =[basementArray objectAtIndex:indexPath.row];
        basementId = [basementMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[basementMulti objectAtIndex:indexPath.row]];
    }
    else if ([fldType isEqualToString:@"Select Direction"]){
        
        _selectdirectionFld.text =[directionArray objectAtIndex:indexPath.row];
        directiontId = [directionMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Curb"]){
        
        _selectCurbFLd.text =[curbArray objectAtIndex:indexPath.row];
        curbtId = [curbMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Location"]){
        
        _selectLocationFld.text = [filedLocationArray objectAtIndex:indexPath.row];
        filedLocationId = [locationMulti objectAtIndex:indexPath.row];
    }
    else if ([fldType isEqualToString:@"Select Floor"]){
        
        _noOfFloorsFld.text = [noOfFloorsArray objectAtIndex:indexPath.row];
        noOfFloorsId = [floorMulti objectAtIndex:indexPath.row];
        [buildingSpecsContained addObject:[floorMulti objectAtIndex:indexPath.row]];
    }
    else{
        
    }
    
    buildingSpecStr = [[NSMutableString alloc]init];
    NSString *appendStrig2 = @",";
    
    for (int i=0; i < buildingSpecsContained.count ; i++){
        
        if(i<buildingSpecsContained.count-1)
        {
            [buildingSpecStr appendString:[NSString stringWithFormat:@"%@%@",[buildingSpecsContained objectAtIndex:i],appendStrig2]];
            
        }
        else
        {
            [buildingSpecStr appendString:[NSString stringWithFormat:@"%@",[buildingSpecsContained objectAtIndex:i]]];
        }
    }
    
    [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    _popUpView.hidden = YES;
    _tablePopUpView.hidden = YES;
    _tableBackView.hidden = YES;
}

- (IBAction)faceBookBtnTapped:(id)sender {
    
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
    SLComposeViewControllerCompletionHandler myBlock =
    ^(SLComposeViewControllerResult result){
        
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Done");
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    controller.completionHandler = myBlock;
    
    //Adding the Text to the facebook post value from iOS
    [controller setInitialText:@"Alhisba"];
    //    [controller addImage:_imageView.image];
    
    //Adding the URL to the facebook post value from iOS
    //    [controller addURL:[NSURL URLWithString:@"http://www.google.com"]];
    
    //Adding the Text to the facebook post value from iOS
    //    [self presentViewController:controller animated:YES completion:nil];
    
    UINavigationController *forShare = [[UINavigationController alloc] initWithRootViewController:controller];
    [forShare setNavigationBarHidden:YES];
    [self presentViewController:forShare animated:NO completion:nil];
}

- (IBAction)whatsappBtnTapped:(id)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
        
        //UIImage     * iconImage = _imageView.image;
        NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.jpg"];
        
        //        [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
        
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentInteractionController.UTI = @"net.whatsapp.image";
        _documentInteractionController.delegate = self;
        
        [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
        
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"No WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
- (IBAction)twitterBtnTapped:(id)sender {
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:@"Alhisba"];
    //  [tweetSheet addImage:_imageView.image];
    
    UINavigationController *forShare1 = [[UINavigationController alloc] initWithRootViewController:tweetSheet];
    [forShare1 setNavigationBarHidden:YES];
    [self presentViewController:forShare1 animated:NO completion:nil];
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
}

- (IBAction)instagramBtnTapped:(id)sender {
    
    NSURL *instagram = [NSURL URLWithString:@"instagram://app"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagram]) {
        
        //convert image into .png format.
        //NSData *imageData = UIImagePNGRepresentation(image);
        
        //create instance of NSFileManager
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //create an array and store result of our search for the documents directory in it
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        //create NSString object, that holds our exact path to the documents directory
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //add our image to the path
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"insta.igo"]];
        
        //finally save the path (image)
        //[fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
        
        CGRect rect = CGRectMake(0 ,0 , 0, 0);
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIGraphicsEndImageContext();
        
        NSString *fileNameToSave = [NSString stringWithFormat:@"Documents/insta.igo"];
        NSString *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:fileNameToSave];
        NSLog(@"jpg path %@",jpgPath);
        
        NSString *newJpgPath = [NSString stringWithFormat:@"file://%@",jpgPath];
        NSLog(@"with File path %@",newJpgPath);
        
        // NSURL *igImageHookFile = [[NSURL alloc]initFileURLWithPath:newJpgPath];
        
        NSURL *igImageHookFile = [NSURL URLWithString:newJpgPath];
        
        NSLog(@"url Path %@",igImageHookFile);
        
        UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
        documentController.delegate = self;
        [documentController setUTI:@"com.instagram.exclusivegram"];
        [documentController presentOpenInMenuFromRect:rect inView:self.view animated:YES];
        
    } else {
        // NSLog (@"Instagram not found");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Install Instagram"
                                                                       message:@" Before Sharing to Instagram, Please Install Instagram app to your Device. "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Thanks" style:UIAlertActionStyleDefault
                                                              handler:nil];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)textFldBoarders{
    
    _selectAreaFld.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectAreaFld.layer.borderWidth = 2.0f;
    _selectAreaFld.layer.cornerRadius = 10.0f;
    
    _selectLandSize.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectLandSize.layer.borderWidth = 2.0f;
    _selectLandSize.layer.cornerRadius = 10.0f;
    
    _selectStreet.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectStreet.layer.borderWidth = 2.0f;
    _selectStreet.layer.cornerRadius = 10.0f;
    
    _selectLocationFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _selectLocationFld.layer.borderWidth = 2.0f;
    _selectLocationFld.layer.cornerRadius = 10.0f;
    
    _buildingAgeFl.layer.borderColor = [UIColor whiteColor].CGColor;
//    _buildingAgeFl.layer.borderWidth = 2.0f;
    _buildingAgeFl.layer.cornerRadius = 10.0f;
    
    _finishingQualityFld.layer.borderColor = [UIColor whiteColor].CGColor;
//    _finishingQualityFld.layer.borderWidth = 2.0f;
    _finishingQualityFld.layer.cornerRadius = 10.0f;
    
    _basementFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _basementFld.layer.borderWidth = 2.0f;
    _basementFld.layer.cornerRadius = 10.0f;
    
    _noOfFloorsFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _noOfFloorsFld.layer.borderWidth = 2.0f;
    _noOfFloorsFld.layer.cornerRadius = 10.0f;
    
    _selectdirectionFld.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectdirectionFld.layer.borderWidth = 2.0f;
    _selectdirectionFld.layer.cornerRadius = 10.0f;
    
    _selectCurbFLd.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectCurbFLd.layer.borderWidth = 2.0f;
    _selectCurbFLd.layer.cornerRadius = 10.0f;
    
    
    _label1.layer.cornerRadius = 10;
    _label1.clipsToBounds = YES;
    _label2.layer.cornerRadius = 10;
    _label2.clipsToBounds = YES;
    _label3.layer.cornerRadius = 10;
    _label3.clipsToBounds = YES;
    _label4.layer.cornerRadius = 10;
    _label4.clipsToBounds = YES;
    _label5.layer.cornerRadius = 10;
    _label5.clipsToBounds = YES;
    _label6.layer.cornerRadius = 10;
    _label6.clipsToBounds = YES;
    _label7.layer.cornerRadius = 10;
    _label7.clipsToBounds = YES;
    _label8.layer.cornerRadius = 10;
    _label8.clipsToBounds = YES;
    _label9.layer.cornerRadius = 10;
    _label9.clipsToBounds = YES;
    _label10.layer.cornerRadius = 10;
    _label10.clipsToBounds = YES;
    _label11.layer.cornerRadius = 10;
    _label11.clipsToBounds = YES;
    _label12.layer.cornerRadius = 10;
    _label12.clipsToBounds = YES;
    
}
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _seaFrontLengthsFld) {
        NSString *rStr = [NSString stringWithFormat:@"%@%@",_seaFrontLengthsFld.text,string];
        NSInteger length = [_seaFrontLengthsFld.text length];
        if (length>1 && ![string isEqualToString:@""]) {
            if([rStr intValue]<15 || [rStr floatValue]>99){
                [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15 and LessThan 99")];
                return NO;

            }
            
//            else  if([_seaFrontLengthsFld.text intValue]>99){
//                if([_seaFrontLengthsFld.text floatValue]>99){
//                [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
//                return NO;
//                }
//
//            }
        }
        
        // This code will provide protection if user copy and paste more then 10 digit text
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_seaFrontLengthsFld.text length]>1) {
               // _seaFrontLengthsFld.text = [_seaFrontLengthsFld.text substringToIndex:2];
                
            }
        });
        
        return YES;
        
    }
    else if(textField == _backStreetFld){
        
        NSInteger length = [_backStreetFld.text length];
        NSString *rStr = [NSString stringWithFormat:@"%@%@",_backStreetFld.text,string];
        if (length>1 && ![string isEqualToString:@""]) {
            if([rStr intValue]<15 || [rStr floatValue]>99){
                [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15 and LessThan 99")];
                return NO;
                
            }
//        if (length>1 && ![string isEqualToString:@""]) {
//            if([_backStreetFld.text intValue]<15 || [_backStreetFld.text intValue]>99){
//                [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15 and LessThan 99")];
//                return NO;
//
//            }
//            if([_backStreetFld.text intValue]<15){
//                [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
//                return NO;
//
//            }else  if([_backStreetFld.text intValue]>99){
//                [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
//                return NO;
//
//            }
        
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_backStreetFld.text length]>1) {
               // _backStreetFld.text = [_backStreetFld.text substringToIndex:2];
            }
        });
        
        return YES;
    }
    else{
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _seaFrontLengthsFld) {
        if([_seaFrontLengthsFld.text intValue]<15 || [_seaFrontLengthsFld.text floatValue]>99){
            [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15 and LessThan 99")];
            
        }
//        if([_seaFrontLengthsFld.text intValue]<15){
//            [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
//        }else  if([_seaFrontLengthsFld.text intValue]>99){
//            [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
//        }
    }else if(textField == _backStreetFld){
        if([_backStreetFld.text intValue]<15 || [_backStreetFld.text floatValue]>99){
            [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15 and LessThan 99")];
            
        }
//        if([_backStreetFld.text intValue]<15){
//            [self showErrorAlertWithMessage:Localized(@"Please Enter Value GreaterThan 15")];
//        }else  if([_backStreetFld.text intValue]>99){
//            [self showErrorAlertWithMessage:Localized(@"Please Enter Value LessThan 99")];
//        }
    }
}
-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectAreaFld.rightView = paddingView;
        _selectAreaFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectLandSize.rightView = paddingView1;
        _selectLandSize.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectStreet.rightView = paddingView2;
        _selectStreet.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectLocationFld.rightView = paddingView3;
        _selectLocationFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _buildingAgeFl.rightView = paddingView4;
        _buildingAgeFl.rightViewMode = UITextFieldViewModeAlways;
        
        _finishingQualityFld.rightView = paddingView5;
        _finishingQualityFld.rightViewMode = UITextFieldViewModeAlways;
        
        _basementFld.rightView = paddingView6;
        _basementFld.rightViewMode = UITextFieldViewModeAlways;
        
        _noOfFloorsFld.rightView = paddingView7;
        _noOfFloorsFld.rightViewMode = UITextFieldViewModeAlways;
        
        _selectdirectionFld.rightView = paddingView8;
        _selectdirectionFld.rightViewMode = UITextFieldViewModeAlways;
        
        _selectCurbFLd.rightView = paddingView9;
        _selectCurbFLd.rightViewMode = UITextFieldViewModeAlways;
        
    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectAreaFld.leftView = paddingView;
        _selectAreaFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectLandSize.leftView = paddingView1;
        _selectLandSize.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectStreet.leftView = paddingView2;
        _selectStreet.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectLocationFld.leftView = paddingView3;
        _selectLocationFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _buildingAgeFl.leftView = paddingView4;
        _buildingAgeFl.leftViewMode = UITextFieldViewModeAlways;
        
        _finishingQualityFld.leftView = paddingView5;
        _finishingQualityFld.leftViewMode = UITextFieldViewModeAlways;
        
        _basementFld.leftView = paddingView6;
        _basementFld.leftViewMode = UITextFieldViewModeAlways;
        
        _noOfFloorsFld.leftView = paddingView7;
        _noOfFloorsFld.leftViewMode = UITextFieldViewModeAlways;
        
        _selectdirectionFld.leftView = paddingView8;
        _selectdirectionFld.leftViewMode = UITextFieldViewModeAlways;
        
        _selectCurbFLd.leftView = paddingView9;
        _selectCurbFLd.leftViewMode = UITextFieldViewModeAlways;
    }
}


- (IBAction)previewCloseBtnTapped:(id)sender {
    
    _popUpView.hidden = YES;
    _previewPopUp.hidden = YES;
}

-(void)settextAlignment:(UILabel *)label{
    
    [label setTextAlignment:NSTextAlignmentCenter];
}

-(void)viewWillAppear:(BOOL)animated{
    //change
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"INSTANTVALUE ESTIMATOR SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//    [self makePostCallForPage:LIVE_RESULT withParams:@{@"area_id":areaId,@"size":landSizeId,@"street":streetId,@"location":filedLocationId,@"sea_facing":[NSString stringWithFormat:@"%@,%@",_seaFrontLengthsFld.text,_backStreetFld.text],@"land_spec":[NSString stringWithFormat:@"%@",locationSpecStr],@"status":status,@"building_spec":[NSString stringWithFormat:@"%@,%@,%@,%@",buildingSpec1,buildingSpec2,buildingSpec3,buildingSpec4],@"location_check":[NSString stringWithFormat:@"%@",locationStr],@"plot_spec":[NSString stringWithFormat:@"%@",plotSpecStr],@"facing":[NSString stringWithFormat:@"%@",facingSpecStr],@"direction":[NSString stringWithFormat:@"%@",directiontId],@"crub":[NSString stringWithFormat:@"%@",curbtId],@"crub_check":[NSString stringWithFormat:@"%@",crubCheckStr]} withRequestCode:30];

   // reset all
    buildingSpec1=buildingSpec2=buildingSpec3=buildingSpec4=locationStr=locationSpecStr=plotSpecStr=facingSpecStr=directiontId=curbtId=areaId=landSizeId=streetId=filedLocationId=@"";
    curbContainedStr=[[NSMutableArray alloc]init];
    _selectAreaFld.text = @"";

    _selectLandSize.text = @"";

    _selectStreet.text = @"";

    _selectLocationFld.text = @"";

    _buildingAgeFl.text = @"";

    _finishingQualityFld.text = @"";

    _basementFld.text = @"";

    _noOfFloorsFld.text = @"";

    _selectdirectionFld.text = @"";

    _selectCurbFLd.text = @"";

    _selectdirectionFld.text = @"";
    
   // parseRe = @"parseRe";
    //_selectCurbFLd.textColor = [UIColor clearColor];
    _selectAreaFld.delegate = self;
    _selectLandSize.delegate = self;
    _selectStreet.delegate = self;
    _selectLocationFld.delegate = self;
    _buildingAgeFl.delegate = self;
    _finishingQualityFld.delegate = self;
    _basementFld.delegate = self;
    _noOfFloorsFld.delegate = self;
    
    _popUpView.hidden = YES;
    _tablePopUpView.hidden = YES;
    _tableBackView.hidden = YES;
    _previewPopUp.hidden = YES;
    _sabahCityView.hidden = YES;
    _sabahCityheight.constant = 0;
    _sabahCityTopHeight.constant = 0;
   // _shareBtnTop.constant = -30;
    //change
    _shareBtnTop.constant = 0;

    buildingSpecStr = [[NSMutableString alloc]init];
    
    
    [_estimatedPriceLbl setTextAlignment:NSTextAlignmentCenter];
    _propertyStatusLbl.text = Localized(@"Property Status");
    _sharingLbl.text = Localized(@"Shared");
    _advancedSpeLbl.text = Localized(@"Advanced Specification");
    
    _locationSpecLbl.text = Localized(@"Location Spec");
    _plotSpecLbl.text = Localized(@"Plot Spec");
    _facingSpecLbl.text = Localized(@"Facing Spec");
    [_calculateBtn setTitle:Localized(@"Calculate") forState:UIControlStateNormal];
    _directioNLbl.text = Localized(@"Direction");
    _curbLbl.text = Localized(@"Curb");
    
    table = [NSMutableArray array];
    filterContainStringad = [NSMutableArray array];
    
    locationSpecsArray1 = [NSMutableArray array];
    locationSpecsContained = [NSMutableArray array];
    locationSpecTitleContained = [NSMutableArray array];
    
    plotSpesArray1 = [NSMutableArray array];
    plotSpesContained = [NSMutableArray array];
    plotSpecTitleContained = [NSMutableArray array];
    
    facingSpecArray1 = [NSMutableArray array];
    facingSpecContained = [NSMutableArray array];
    facingSpecTitleContained = [NSMutableArray array];
    
    buildingArray = [NSMutableArray array];
    buildingSpecsContained = [NSMutableArray array];
    
    [_landBtn setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    //status = @"1";
    [_buildingBtn setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
    _landBtn.selected = YES;
    
    self.tableBackView.layer.borderColor = [UIColor blackColor].CGColor;
    [_tableBackView.layer setBorderColor:[UIColor colorWithRed:73.0f/255.0f green:82.0f/255.0f blue:125.0f/255.0f alpha:1.0].CGColor];
    _tableBackView.layer.cornerRadius = 15.0f;
    [_tableBackView.layer setBorderWidth:2.0f];
    [_tableBackView.layer setMasksToBounds:YES];
    
    //    [_tableBackView.layer setCornerRadius:5.0f];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _advancedSpeFld.rightView = paddingView;
        _advancedSpeFld.rightViewMode = UITextFieldViewModeAlways;
    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
        _advancedSpeFld.leftView = paddingView;
        _advancedSpeFld.leftViewMode = UITextFieldViewModeAlways;
    }
    
    // [self fieldsHidden];
    
//    _allspecHeight.constant = 0;
//    _buildingSpecHeight.constant = 0;
//    _buildingSpecView.hidden = YES;
//    _allSpecsView.hidden = YES;
//    _locationCheckHeight.constant = 0;
//    _sharingBtnHeight.constant = 0;
//    
//    
//    status = @"1";
//    [_areaLbl setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view setNeedsDisplay];
    _areaLbl.text = Localized(@"Area");
    _landSizeLbl.text = Localized(@"Land Size(Sqms)");
    _streetLbl.text = Localized(@"Street");
    _locationLbl.text = Localized(@"Location");
    _buildingAgeLbl.text = Localized(@"Building Age");
    _finishingQualityLbl.text = Localized(@"Finishing Quality");
    _basementLbl.text = Localized(@"Basement");
    _noofFloorsLbl.text = Localized(@"Select No Of Floors");
    
    
    UIColor *color = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    _selectAreaFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please select Area") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectLandSize.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Land Size") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectStreet.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Street") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectLocationFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Location") attributes:@{NSForegroundColorAttributeName: color}];
    
    _buildingAgeFl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Building Age") attributes:@{NSForegroundColorAttributeName: color}];
    
    _finishingQualityFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Finishing Quality") attributes:@{NSForegroundColorAttributeName: color}];
    
    _basementFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Basement") attributes:@{NSForegroundColorAttributeName: color}];
    
    _noOfFloorsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Please Select Number Of Floors") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectdirectionFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Direction") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectCurbFLd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Curb") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectdirectionFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Direction") attributes:@{NSForegroundColorAttributeName: color}];
    
    
    [_previewPopUp.layer setBorderWidth:2.0f];
    [_previewPopUp.layer setCornerRadius:5.0f];
    [_previewPopUp.layer setBorderColor:[UIColor colorWithRed:247.0f/255.0f green:189.0f/255.0f blue:95.0f/255.0f alpha:1.0f].CGColor];
    [_previewPopUp.layer setMasksToBounds:YES];
    
    [self textFldBoarders];
    [self paddingFlds];
    
//    if ([_fromMenu isEqualToString:@"fromMenu"]) {
//
//        UINavigationBar *navigationBar = self.navigationController.navigationBar;
//        UIImage *image = [UIImage imageNamed: @"NavImage.png"];
//        [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
//    }
//    else{
//
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                      forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
//        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//        self.navigationController.navigationBar.translucent = YES;
//        self.navigationController.view.backgroundColor = [UIColor clearColor];
//    }
    
    //self.navigationItem.title = Localized(@"Instant Value Estimator");
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
//    menuBtn = [[UIButton alloc] init];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//    // [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    _calculateBtn.layer.cornerRadius = 15.0f;
    _advancedSpeFld.layer.cornerRadius = 15.0f;
    //    _advancedSpeFld.text = @"Advanced Specification";
    //    _advancedSpeFld.textColor = [UIColor whiteColor];
    
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
    
    [_advancedSpeLbl setTextAlignment:NSTextAlignmentCenter];
    
    [self customSetup];
    
    
    _buildingLbl.text = Localized(@"Building");
    _landLbl.text = Localized(@"Land");
    
    [self clearToStart];
}

- (IBAction)areaInfoBtnAction:(id)sender {
    [self showInfo:Localized(@"info_area") :sender];
}

- (IBAction)landsizeBtnAction:(id)sender {
    [self showInfo:Localized(@"info_landsize") :sender];

}

- (IBAction)locationInfobtnAction:(id)sender {
    [self showInfo:Localized(@"info_location") :sender];

}
- (IBAction)streetInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_street") :sender];
    
}
- (IBAction)buildingAgeInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_building_age") :sender];
    
}
- (IBAction)finishingQualityInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_finishing_quality") :sender];
    
}
- (IBAction)basementInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_basement") :sender];
    
}
- (IBAction)numberofFloorInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_numberof_floors") :sender];
    
}
- (IBAction)locationSpecInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_locationspec") :sender];
    
}
- (IBAction)plotSpecInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_plotspec") :sender];
    
}
- (IBAction)facingInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_facing") :sender];
    
}
- (IBAction)directionInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_direction") :sender];
    
}
- (IBAction)crubInfobtnAction:(id)sender;{
    [self showInfo:Localized(@"info_crub") :sender];
    
}

-(void)cellButonShadow:(UIButton *)btn{
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:btn.bounds];
    btn.layer.masksToBounds = NO;
    btn.layer.shadowColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0].CGColor;
    btn.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    btn.layer.shadowOpacity = 0.3f;
    btn.layer.shadowPath = shadowPath.CGPath;
}

-(void)cellButonShadowClear:(UIButton *)btn{
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:btn.bounds];
    btn.layer.masksToBounds = NO;
    btn.layer.shadowColor = [UIColor clearColor].CGColor;
    btn.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    btn.layer.shadowOpacity = 0.1f;
    btn.layer.shadowPath = shadowPath.CGPath;
}

@end
