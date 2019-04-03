//
//  OfficialApraisalViewController.m
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "OfficialApraisalViewController.h"
#import "SearchTableViewCell.h"
#import "SVProgressHUD.h"
//#import "VisaCardViewController.h"
#import "LoginOrSignUpViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "Photos/Photos.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ActionSheetStringPicker.h"

@interface OfficialApraisalViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate>{
UIButton *menuBtn,*backBtn;
NSString *emailRegEx,*propertyId,*specificationId,*areaId,*buttonTap,*reasonId,*termsStr;
NSPredicate *emailTest;
NSMutableArray *resultArray,*specificationAra,*areaAray,*reasonAray,*personReqArray,*priceArray;
    NSUInteger count;
    NSString *byteArray;
    UIImage *chosenImage;
    NSString *base64;
    Byte *byteData;
    NSData *infoData;
    SWRevealViewController *revealViewController;
    NSString *fldType;
}

@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;

@end

@implementation OfficialApraisalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _slectPropetyTypeFld.delegate = self;
    _selectSpecificationFld.delegate = self;
    _selectAreaFld.delegate = self;
    _enterBlockFld.delegate = self;
    _enterStreetFld.delegate = self;
    _enterAvenueFld.delegate = self;
    _enterPlotHousenumberFld.delegate = self;
    _additionalDetaislFld.delegate = self;
    _ownerNameFld.delegate = self;
    _selectPersonRequestAppraisalFld.delegate = self;
    _enterPhoneFld.delegate = self;
    _enterEmalFld.delegate = self;
    _selectPersonRequestAppraisalFld.delegate = self;
    _selectReasonFld.delegate = self;
    
    _popUpView.hidden = YES;
    _tapleViewpopUp.hidden = YES;
    _tableContainView.hidden = YES;
    _previewView.hidden = YES;
    
    _tableContainView.layer.borderColor = [UIColor blackColor].CGColor;
    // [_tableBackView.layer setBorderColor:[UIColor blackColor].CGColor];
    [_tableContainView.layer setBorderWidth:2.0f];
    [_tableContainView.layer setMasksToBounds:YES];
    [_tableContainView.layer setCornerRadius:5.0f];
    
//    self.previewView.layer.borderColor = [UIColor blackColor].CGColor;
    // [_tableBackView.layer setBorderColor:[UIColor blackColor].CGColor];
    [_previewView.layer setBorderWidth:2.0f];
    [_previewView.layer setMasksToBounds:YES];
    [_previewView.layer setCornerRadius:5.0f];
    _requestReportBtn.layer.cornerRadius = 15.0f;
    termsStr = @"NO";
    
    [_diffTanOwnerFld setTextAlignment:NSTextAlignmentCenter];
    [_attachDocFld setTextAlignment:NSTextAlignmentCenter];
    
    _chooseFileBtn.layer.cornerRadius = 10; // this value vary as per your desire
    [_chooseFileBtn setBackgroundColor:[UIColor whiteColor]];
    _chooseFileBtn.clipsToBounds = YES;
    
    _propertyTypeLbl.text = Localized(@"Property Type");
    _propertySpecificationsLbl.text = Localized(@"Property Specification");
    [_chooseFileBtn setTitle:Localized(@"Choose file") forState:UIControlStateNormal];
    _nofileSlectedLbl.text = Localized(@"No file selected");
    
    _areaLbl.text = Localized(@"Area");
    _blockNumberLbl.text = Localized(@"PACCI No.");
    _streetLbl.text = Localized(@"Property Address");
    _avenueLbl.text = Localized(@"Applicant Name");
    _plotHouseNoLbl.text = Localized(@"Applicant Capacity");
    _additionalDetailsLbl.text = Localized(@"Additional Details");
    _ownerNameLbl.text = Localized(@"Owner Name");
    _personRequestingAppraisalLbl.text = Localized(@"Person Requesting Appraisal");
    _phoneLbl.text = Localized(@"Phone Number");
    _emailLbl.text = Localized(@"Email Address");
    _reasonForRequestingAppraisalLbl.text = Localized(@"Reason for requesting appraisal");
    [_termsandConditionBtn setTitle:Localized(@"I agree to terms and conditions") forState:UIControlStateNormal];
    [_requestReportBtn setTitle:Localized(@"Request For Report") forState:UIControlStateNormal];
    
    _remarksLbl.text = Localized(@"Remarks");
    _apraisalCostAppearLbl.text = Localized(@"");

    UIColor *color = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    UIColor *color1 = [UIColor whiteColor];


    _slectPropetyTypeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Property Type") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectSpecificationFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Speccifications") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectAreaFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Area") attributes:@{NSForegroundColorAttributeName: color}];
    
    _enterBlockFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter PACCI No.") attributes:@{NSForegroundColorAttributeName: color}];
    
    _enterStreetFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Property Address") attributes:@{NSForegroundColorAttributeName: color}];
    
     _diffTanOwnerFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"If Applicant Different Than Owner") attributes:@{NSForegroundColorAttributeName: color1}];
    
    _attachDocFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Attach Document") attributes:@{NSForegroundColorAttributeName: color1}];
    
    
    [_diffTanOwnerFld setFont:[UIFont fontWithName:@"Cairo-Bold" size:17]];
    [_attachDocFld setFont:[UIFont fontWithName:@"Cairo-Bold" size:17]];


    
    _enterRemarksFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Remarks") attributes:@{NSForegroundColorAttributeName: color}];
    
    
    _enterAvenueFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Applicant Name") attributes:@{NSForegroundColorAttributeName: color}];
    
    _enterPlotHousenumberFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Applicant Capacity") attributes:@{NSForegroundColorAttributeName: color}];
    
    _appraisalFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Appraisal Cost Appear") attributes:@{NSForegroundColorAttributeName: color}];

    
    _additionalDetaislFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Additional Details") attributes:@{NSForegroundColorAttributeName: color}];
    
    _ownerNameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Owner Name") attributes:@{NSForegroundColorAttributeName: color}];
    
    _selectPersonRequestAppraisalFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Person Requesting Appraisal") attributes:@{NSForegroundColorAttributeName: color}];
    
    _enterPhoneFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Phone") attributes:@{NSForegroundColorAttributeName: color}];
    
    _enterEmalFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Enter Email Address") attributes:@{NSForegroundColorAttributeName: color}];

    _selectReasonFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Select Reason") attributes:@{NSForegroundColorAttributeName: color}];


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
    
    self.navigationItem.title = Localized(@"Official Appraisal Report");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
//    menuBtn = [[UIButton alloc] init];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//    // [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
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
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _enterPhoneFld.inputAccessoryView = keyboardDoneButtonView;
    
    emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

    [self customSetup];
    
    _confirmBtn.layer.cornerRadius = 15.0f;
    
    [self paddingFlds];
    [self textFldBoarders];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.navigationController.navigationBar.bounds;
    
    CGRect gradientFrame = self.navigationController.navigationBar.bounds;
    gradientFrame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
    gradientLayer.frame = gradientFrame;
    
    gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1].CGColor,
                              (__bridge id)[UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:147.0f/255.0f alpha:1].CGColor ];
    //    gradientLayer.startPoint = CGPointMake(1.0, 0);
    //    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:gradientImage1 forBarMetrics:UIBarMetricsDefault];
    
    [self makePostCallForPage:APPRAISAL_SETTINGS withParams:@{} withRequestCode:1];

}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
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

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _enterPhoneFld) {
        
        NSInteger length = [_enterPhoneFld.text length];
        if (length>7 && ![string isEqualToString:@""]) {
            return NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_enterPhoneFld.text length]>7) {
                _enterPhoneFld.text = [_enterPhoneFld.text substringToIndex:8];
                
            }
        });
        
        return YES;
        
    }
    else{
        return YES;
    }
}

-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_enterPhoneFld resignFirstResponder];
}

-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}

- (IBAction)selectPropertyTypeBtnTapped:(id)sender {
    
  //  [self showHUD:@""];
//    buttonTap = @"Property";
//    _popUpView.hidden = NO;
//
////    _popUpView.hidden = NO;
////    _tapleViewpopUp.hidden = NO;
////    _tableContainView.hidden = NO;
//
//    [_enterBlockFld resignFirstResponder];
//    [_enterStreetFld resignFirstResponder];
//    [_enterAvenueFld resignFirstResponder];
//    [_enterPlotHousenumberFld resignFirstResponder];
//    [_additionalDetaislFld resignFirstResponder];
//    [_ownerNameFld resignFirstResponder];
//    [_enterPhoneFld resignFirstResponder];
//    [_enterEmalFld resignFirstResponder];
//    [_selectReasonFld resignFirstResponder];
    
    
    fldType = @"Select Area";
    
    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *areaArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        areaArray = [[resultArray valueForKey:@"types"][0] valueForKey:@"value_arabic"];
    }
    else{
        areaArray = [[resultArray valueForKey:@"types"][0] valueForKey:@"value_english"];
    }
    
    //        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                    _slectPropetyTypeFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               //
                                               //                                                   landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
    
}

- (IBAction)propertySpecificationsBtnTapped:(id)sender {
    
//    if ([self.slectPropetyTypeFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Type")];
//
//        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
//    }
//    else{
//
//        // [self showHUD:@""];
//        buttonTap = @"Specification";
//        //    [self makePostCallForPage:APPRAISAL_TYPES withParams:@{} withRequestCode:2];
//        //specificationAra = [resultArray objectAtIndex:count];
//        //  [specificationAra addObjectsFromArray:[resultArray objectAtIndex:count]];
//
//        specificationAra = [[NSMutableArray alloc] initWithObjects:[resultArray objectAtIndex:count], nil];
//
//        if ([[specificationAra[0] valueForKey:@"specifications"] count] == 0) {
//
//            [self showErrorAlertWithMessage:Localized(@"No Specifications Found")];
//          //   [_tapleViewpopUp reloadData];
//        }
//        else{
//            _popUpView.hidden = NO;
//            _tapleViewpopUp.hidden = NO;
//            _tableContainView.hidden = NO;
//            [_tapleViewpopUp reloadData];
//        }

    [_enterBlockFld resignFirstResponder];
        [_enterStreetFld resignFirstResponder];
        [_enterAvenueFld resignFirstResponder];
        [_enterPlotHousenumberFld resignFirstResponder];
        [_additionalDetaislFld resignFirstResponder];
        [_ownerNameFld resignFirstResponder];
        [_enterPhoneFld resignFirstResponder];
        [_enterEmalFld resignFirstResponder];
        [_selectReasonFld resignFirstResponder];
    
    fldType = @"Select Specifications";
    
    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *areaArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        areaArray = [[resultArray valueForKey:@"status"][0] valueForKey:@"value_arabic"];
    }
    else{
        areaArray = [[resultArray valueForKey:@"status"][0] valueForKey:@"value_english"];
    }
    
    //        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Specifications")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
            _selectSpecificationFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               //
                                               //                                                   landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }

}

- (IBAction)selectAreaBtnTapped:(id)sender {
   
//    if ([self.slectPropetyTypeFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Type")];
//
//        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
//    }
//    else{
//        buttonTap = @"Area";
//        // [self showHUD:@""];
//        //    [self makePostCallForPage:APPRAISAL_TYPES withParams:@{} withRequestCode:3];
//        areaAray = [[NSMutableArray alloc] initWithObjects:[resultArray objectAtIndex:count], nil];
//
//        if ([[[areaAray[0] valueForKey:@"specifications"]valueForKey:@"areas"] count] == 0) {
//
//            [self showErrorAlertWithMessage:Localized(@"No areas Found")];
//             //  [_tapleViewpopUp reloadData];
//        }
//        else{
//            _popUpView.hidden = NO;
//            _tapleViewpopUp.hidden = NO;
//            _tableContainView.hidden = NO;
//            [_tapleViewpopUp reloadData];
//        }
//
//        [_enterBlockFld resignFirstResponder];
//        [_enterStreetFld resignFirstResponder];
//        [_enterAvenueFld resignFirstResponder];
//        [_enterPlotHousenumberFld resignFirstResponder];
//        [_additionalDetaislFld resignFirstResponder];
//        [_ownerNameFld resignFirstResponder];
//        [_enterPhoneFld resignFirstResponder];
//        [_enterEmalFld resignFirstResponder];
//        [_selectReasonFld resignFirstResponder];
//    }
    
    fldType = @"Select Area";
    
    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *areaArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        areaArray = [[resultArray valueForKey:@"areas"][0] valueForKey:@"value_arabic"];

    }
    else{
       areaArray = [[resultArray valueForKey:@"areas"][0] valueForKey:@"value_english"];
    }
    
    //        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _selectAreaFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               //
                                               //                                                   landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)personReqAprBtnTapped:(id)sender {
    
//    if ([self.slectPropetyTypeFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Type")];
//
//        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
//    }
//    else{
//        //[self showHUD:@""];
//        buttonTap = @"Person Req";
//        personReqArray = [[NSMutableArray alloc]initWithObjects:@"Owner",@"Representative", nil];
//
//        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Property")
//                                                rows:personReqArray
//                                    initialSelection:0
//                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
//                _selectPersonRequestAppraisalFld.text = [personReqArray objectAtIndex:selectedIndex];
//                                           }
//                                         cancelBlock:^(ActionSheetStringPicker *picker) {
//                                             NSLog(@"Block Picker Canceled");
//                                         }
//                                              origin:self.view];
//
//
////        _popUpView.hidden = NO;
////        _tapleViewpopUp.hidden = NO;
////        _tableContainView.hidden = NO;
////        [_tapleViewpopUp reloadData];
//
//        [_enterBlockFld resignFirstResponder];
//        [_enterStreetFld resignFirstResponder];
//        [_enterAvenueFld resignFirstResponder];
//        [_enterPlotHousenumberFld resignFirstResponder];
//        [_additionalDetaislFld resignFirstResponder];
//        [_ownerNameFld resignFirstResponder];
//        [_enterPhoneFld resignFirstResponder];
//        [_enterEmalFld resignFirstResponder];
//        [_selectReasonFld resignFirstResponder];
//    }
    
    
    fldType = @"Person Request Appraisal";
    
    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *areaArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        areaArray = [[resultArray valueForKey:@"reasons"][0] valueForKey:@"value_arabic"];
    }
    else{
        areaArray = [[resultArray valueForKey:@"reasons"][0] valueForKey:@"value_english"];
    }
    
    
    //        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Person Request Appraisal")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               _selectReasonFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               //
                                               //                                                   landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)reasonReqApraBtnTapped:(id)sender {
    
//    if ([self.slectPropetyTypeFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Type")];
//
//        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
//    }
//    else{
//        [self showHUD:@""];
//        buttonTap = @"Reason";
//
//        [self makePostCallForPage:APPRAISAL_REASONS withParams:@{} withRequestCode:4];
//
////        _popUpView.hidden = NO;
////        _tapleViewpopUp.hidden = NO;
////        _tableContainView.hidden = NO;
//
//        [_enterBlockFld resignFirstResponder];
//        [_enterStreetFld resignFirstResponder];
//        [_enterAvenueFld resignFirstResponder];
//        [_enterPlotHousenumberFld resignFirstResponder];
//        [_additionalDetaislFld resignFirstResponder];
//        [_ownerNameFld resignFirstResponder];
//        [_enterPhoneFld resignFirstResponder];
//        [_enterEmalFld resignFirstResponder];
//        [_selectReasonFld resignFirstResponder];
//    }
    
    fldType = @"Reason Appraisal";
    
    //   NSLog(@"result Array %@",resultArray1);
    
  //  NSMutableArray  *areaArray = [[resultArray valueForKey:@"reasons"][0] valueForKey:@"value_english"];
    
    NSMutableArray  *areaArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        areaArray = [[resultArray valueForKey:@"reasons"][0] valueForKey:@"value_arabic"];
    }
    else{
        areaArray = [[resultArray valueForKey:@"reasons"][0] valueForKey:@"value_english"];
    }
    
    //        sizeIdarray = [[resultArray1 valueForKey:@"sizes"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Reason Appraisal")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
            _selectReasonFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               //
                                               //                                                   landSizeId = [NSString stringWithFormat:@"%@",[sizeIdarray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)equestForreportBtnTapped:(id)sender {
    
//    if ([self.slectPropetyTypeFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Type")];
//        
//        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
//    } else if ([self.selectSpecificationFld.text length] == 0) {
//        
//        [self showErrorAlertWithMessage:Localized(@"Please Select Property Specification")];
//        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
//    }
//    else if ([self.selectAreaFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Area")];
//        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
//    }
//    else if ([self.enterBlockFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter block number")];
//    }
//    else if ([self.enterStreetFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter Street")];
//    }
//    else if ([self.enterAvenueFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter avenue")];
//    }
//    else if ([self.enterPlotHousenumberFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter plot/House Number")];
//    }
//    else if ([self.additionalDetaislFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter Additional Details")];
//    }
//    else if ([self.ownerNameFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please enter Owner Name")];
//    }
//    else if ([self.selectPersonRequestAppraisalFld.text length] == 0) {
//        [self showErrorAlertWithMessage:Localized(@"Please Select Prson Requesting Appraisal")];
//    }
//    else if ([self.enterPhoneFld.text length] == 0) {
//        
//        [self showErrorAlertWithMessage:Localized(@"Please Enter Mobile Number")];
//        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
//    }
//    else if([_enterPhoneFld.text length]<8){
//        
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please enter Valid Phone No." preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
//        [alert addAction:button];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//
//    else if (![emailTest evaluateWithObject:_enterEmalFld.text] == YES)
//    {
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:Localized(@"Alert") message:Localized(@"Please enter valid email") preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
//        
//        [alert addAction:button];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//    else if ([self.selectReasonFld.text length] == 0) {
//        
//        [self showErrorAlertWithMessage:Localized(@"Please Select Reason")];
//    }
//    else if ([termsStr isEqualToString:@"NO"]) {
//        
//        [self showErrorAlertWithMessage:Localized(@"Please agree terms and condition")];
//    }
//    else {
//        
//        [self showHUD:@""];
//        
//        [self makePostCallForPage:APPRAISAL_PRICE withParams:@{@"type_id":propertyId, @"specification_id":specificationId, @"area_id":areaId} withRequestCode:100];
//    }
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    
    resultArray = result;
    
//    if (reqeustCode == 120) {
//
//        _popUpView.hidden = YES;
//        _tapleViewpopUp.hidden = YES;
//        _tableContainView.hidden = YES;
//        _previewView.hidden = YES;
//
//        if ([[result valueForKey:@"status"] isEqualToString:@"Success"]) {
//
//            UIAlertController * alert=[UIAlertController
//
//                                       alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//                                            //Handle your yes please button action here
//
//            NSUserDefaults *reqId = [NSUserDefaults standardUserDefaults];
//            [reqId setObject:[result valueForKey:@"request_id"] forKey:@"reqId"];
//            [reqId synchronize];
//
//                NSString *totalString = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
//
//            if (totalString.length==0) {
//
//        LoginOrSignUpViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
//                obj.fromOfficial = @"fromOfficial";
//        [self.navigationController pushViewController:obj animated:YES];
//            }
//            else{
//
//    [self makePostCallForPage:UPLOAD_IMAGE withParams:@{@"request_id":[result valueForKey:@"request_id"], @"file":infoData} withRequestCode:110];
//
////                VisaCardViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"VisaCardViewController"];
////                obj.paymentType = @"TAP";
////                [self.navigationController pushViewController:obj animated:YES];
//
//            }
//     }];
//
//            [alert addAction:yesButton];
//            [self presentViewController:alert animated:YES completion:nil];
//
//        }
//        else{
//            UIAlertController * alert=[UIAlertController
//
//                                       alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
// }
//    else  if (reqeustCode == 1){
//
//        resultArray = result;
//
//        _popUpView.hidden = YES;
//
//        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Property")
//                                                rows:[resultArray valueForKey:@"value_english"]
//                                    initialSelection:0
//                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
// _slectPropetyTypeFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:selectedIndex];
//                                               propertyId = [[resultArray valueForKey:@"id"] objectAtIndex:selectedIndex];
//
//                                           }
//                                         cancelBlock:^(ActionSheetStringPicker *picker) {
//                                             NSLog(@"Block Picker Canceled");
//                                         }
//                                              origin:self.view];
//
////        [_tapleViewpopUp reloadData];
//    }
//    else  if (reqeustCode == 2){
//        resultArray = result;
//     //   specificationAra = [resultArray objectAtIndex:count];
//
//        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Specification")
//                                                rows:[specificationAra valueForKey:@"specifications"][0]
//                                    initialSelection:0
//                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
//                                               _slectPropetyTypeFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:selectedIndex];
//                                               propertyId = [[resultArray valueForKey:@"id"] objectAtIndex:selectedIndex];
//
//                                               NSMutableDictionary *dic = [[specificationAra valueForKey:@"specifications"][0] objectAtIndex:selectedIndex];
//
//                                        _selectSpecificationFld.text  =  [dic valueForKey:@"value_english"];
//
//                                               specificationId  =  [dic valueForKey:@"id"];
//
//                                           }
//                                         cancelBlock:^(ActionSheetStringPicker *picker) {
//                                             NSLog(@"Block Picker Canceled");
//                                         }
//                                              origin:self.view];
//
////        [_tapleViewpopUp reloadData];
//    }
//    else  if (reqeustCode == 3){
//
//       // areaAray = [resultArray objectAtIndex:count];
//
//        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
//                                                rows:[areaAray valueForKey:@"specifications"][0]
//                                    initialSelection:0
//                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
//                                               NSMutableDictionary *dic = [[areaAray valueForKey:@"specifications"][0] objectAtIndex:selectedIndex];
//
//                                               areaId = [[dic valueForKey:@"areas"][0] valueForKey:@"id"];
//
//                                               if ([[[dic valueForKey:@"areas"][0] valueForKey:@"value_english"] isKindOfClass:[NSNull class]]) {
//
//                                                   _selectAreaFld.text = @"";
//                                               }
//                                               else{
//                                                   _selectAreaFld.text = [[dic valueForKey:@"areas"][0] valueForKey:@"value_english"];
//                                               }
//                                           }
//
//                                         cancelBlock:^(ActionSheetStringPicker *picker) {
//                                             NSLog(@"Block Picker Canceled");
//                                         }
//                                              origin:self.view];
//
//    //    [_tapleViewpopUp reloadData];
//    }
//    else  if (reqeustCode == 4){
//
//        reasonAray = result;
//
//        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Reason")
//                                                rows:[resultArray valueForKey:@"value_english"]
//                                    initialSelection:0
//                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
////                                               _slectPropetyTypeFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:selectedIndex];
////                                               propertyId = [[resultArray valueForKey:@"id"] objectAtIndex:selectedIndex];
//
//                                               _selectReasonFld.text = [[reasonAray valueForKey:@"value_english"] objectAtIndex:selectedIndex];
//
//                                               reasonId = [[reasonAray valueForKey:@"id"] objectAtIndex:selectedIndex];
//                                           }
//
//                                         cancelBlock:^(ActionSheetStringPicker *picker) {
//                                             NSLog(@"Block Picker Canceled");
//                                         }
//                                              origin:self.view];
//
//     //   [_tapleViewpopUp reloadData];
//    }
//
//    else  if (reqeustCode == 100){
//
//        priceArray = result;
//
//        [_preDetailsLbl setTextAlignment:NSTextAlignmentCenter];
//        _prepropertyType.text = [NSString stringWithFormat:@"%@ %@",@"Property Type: ",_slectPropetyTypeFld.text];
//        _prePropertySpeci.text = [NSString stringWithFormat:@"%@ %@",@"Property Specifications: ",_selectSpecificationFld.text];
//        _prePropertyArea.text  = [NSString stringWithFormat:@"%@ %@",@"Area: ",_selectAreaFld.text];
//        _preBlockNumber.text = [NSString stringWithFormat:@"%@ %@",@"Block: ",_enterBlockFld.text];
//        _preStreet.text = [NSString stringWithFormat:@"%@ %@",@"Street: ",_enterStreetFld.text];
//        _preAvenue.text = [NSString stringWithFormat:@"%@ %@",@"Avenue: ",_enterAvenueFld.text];
//        _preAvenue.text = [NSString stringWithFormat:@"%@ %@",@"Avenue: ",_enterAvenueFld.text];
//        _prePlotHouseNumber.text = [NSString stringWithFormat:@"%@ %@",@"Plot/House Number: ",_enterPlotHousenumberFld.text];
//        _preaddition.text = [NSString stringWithFormat:@"%@",_additionalDetaislFld.text];
//        _ownerName.text = [NSString stringWithFormat:@"%@ %@",@"Owner Name: ",_ownerNameFld.text];
//        _prePersonRequesting.text = [NSString stringWithFormat:@"%@ %@",@"Personal Requesting: ",_selectPersonRequestAppraisalFld.text];
//        _preRepresentativeName.text = [NSString stringWithFormat:@"%@ %@",@"Personal Requesting: ",@""];
//        _preestimatedPrice.text = [NSString stringWithFormat:@"%@ %@ %@",@"Estimated Price: ",[result valueForKey:@"price"],@"KD"];
//        _preAppraisal.text = [NSString stringWithFormat:@"%@ %@",@"Appraisal Report: ",_selectPersonRequestAppraisalFld.text];
//        _preReasonforRequesting.text = [NSString stringWithFormat:@"%@ %@",@"Select Reason: ",_selectReasonFld.text];
//
//        NSString *sta = [result valueForKey:@"price"];
//        NSUserDefaults *sta1 = [NSUserDefaults standardUserDefaults];
//        [sta1 setObject:sta forKey:@"Price"];
//        [sta1 synchronize];
//
//        _prePhone.text = [NSString stringWithFormat:@"%@ %@",@"Phone: ",_enterPhoneFld.text];
//        _preEmail.text = [NSString stringWithFormat:@"%@ %@",@"Email: ",_enterEmalFld.text];
//
//        _popUpView.hidden = NO;
//        _previewView.hidden = NO;
//
//    }
//    else if (reqeustCode ==110){
//
//        NSLog(@"result is %@",result);
//
////        VisaCardViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"VisaCardViewController"];
////        obj.paymentType = @"TAP";
////        [self.navigationController pushViewController:obj animated:YES];
//  }
//    else{
//    }
    
    [self hideHUD];

}


#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([buttonTap isEqualToString:@"Property"]) {
        return resultArray.count;
    }
    else if ([buttonTap isEqualToString:@"Specification"]){
        
     return specificationAra.count;
    }
    else if ([buttonTap isEqualToString:@"Area"]){
        
        return areaAray.count;
    }
    else if ([buttonTap isEqualToString:@"Reason"]){
        return reasonAray.count;
    }
    else if ([buttonTap isEqualToString:@"Person Req"]){
        return personReqArray.count;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchTableViewCell";
    SearchTableViewCell *cell = [_tapleViewpopUp dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([buttonTap isEqualToString:@"Property"]) {
        cell.titleLbl.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Specification"]){

        cell.titleLbl.text = [[[specificationAra valueForKey:@"specifications"][0] valueForKey:@"value_english"]objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Area"]){
        
        NSMutableDictionary *dic = [[areaAray valueForKey:@"specifications"][0] objectAtIndex:indexPath.row];
        
        if ([[[dic valueForKey:@"areas"][0] valueForKey:@"value_english"] isKindOfClass:[NSNull class]]) {
            
            cell.titleLbl.text = @"";
        }
        else{
            cell.titleLbl.text = [[dic valueForKey:@"areas"][0] valueForKey:@"value_english"];
        }
  }
    
    else if ([buttonTap isEqualToString:@"Reason"]){
        
        cell.titleLbl.text = [[reasonAray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Person Req"]){
        
        cell.titleLbl.text = [personReqArray objectAtIndex:indexPath.row];
    }
    
    else{
        
    }
    
    [cell.radioButton setImage:[UIImage imageNamed:@"radio-off-button.png"] forState:UIControlStateNormal];
    cell.radioButton.tag = indexPath.row;
    cell.titleBtn.tag = indexPath.row;
    
    [cell.radioButton addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.titleBtn addTarget:self action:@selector(checkBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];

   return cell;
}

-(void)checkBtnClicked1:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tapleViewpopUp];
    
    NSIndexPath *indexPath = [_tapleViewpopUp indexPathForRowAtPoint:buttonFrame.origin];
    
    if ([buttonTap isEqualToString:@"Property"]) {
        
        count = indexPath.row;
        _slectPropetyTypeFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        propertyId = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Specification"]){
        
        NSMutableDictionary *dic = [[specificationAra valueForKey:@"specifications"][0] objectAtIndex:indexPath.row];
        
        _selectSpecificationFld.text  =  [dic valueForKey:@"value_english"];
        
        specificationId  =  [dic valueForKey:@"id"];
    }
    else if ([buttonTap isEqualToString:@"Area"]){
        
        NSMutableDictionary *dic = [[areaAray valueForKey:@"specifications"][0] objectAtIndex:indexPath.row];
        
        areaId = [[dic valueForKey:@"areas"][0] valueForKey:@"id"];
        
        if ([[[dic valueForKey:@"areas"][0] valueForKey:@"value_english"] isKindOfClass:[NSNull class]]) {
            
            _selectAreaFld.text = @"";
        }
        else{
            _selectAreaFld.text = [[dic valueForKey:@"areas"][0] valueForKey:@"value_english"];
        }
        
    }
    else if ([buttonTap isEqualToString:@"Reason"]){
        
        _selectReasonFld.text = [[reasonAray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        
        reasonId = [[reasonAray valueForKey:@"id"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Person Req"]){
        
        _selectPersonRequestAppraisalFld.text = [personReqArray objectAtIndex:indexPath.row];
    }
    else{
        
    }
    
   // [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];
    
    _popUpView.hidden = YES;
    _tapleViewpopUp.hidden = YES;
    _tableContainView.hidden = YES;
}

-(void)checkBtnClicked:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tapleViewpopUp];
    
    NSIndexPath *indexPath = [_tapleViewpopUp indexPathForRowAtPoint:buttonFrame.origin];
    
    if ([buttonTap isEqualToString:@"Property"]) {
        
        count = indexPath.row;
        _slectPropetyTypeFld.text = [[resultArray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        propertyId = [[resultArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Specification"]){
        
        NSMutableDictionary *dic = [[specificationAra valueForKey:@"specifications"][0] objectAtIndex:indexPath.row];

     _selectSpecificationFld.text  =  [dic valueForKey:@"value_english"];
        
    //    _selectSpecificationFld.text = [[[specificationAra valueForKey:@"specifications"][0] valueForKey:@"value_english"]objectAtIndex:indexPath.row];
        
       // specificationId = [[[resultArray valueForKey:@"specifications"][0] valueForKey:@"id"]objectAtIndex:indexPath.row];
        
         specificationId  =  [dic valueForKey:@"id"];
  }
    else if ([buttonTap isEqualToString:@"Area"]){
        
        NSMutableDictionary *dic = [[areaAray valueForKey:@"specifications"][0] objectAtIndex:indexPath.row];
        
        areaId = [[dic valueForKey:@"areas"][0] valueForKey:@"id"];

        if ([[[dic valueForKey:@"areas"][0] valueForKey:@"value_english"] isKindOfClass:[NSNull class]]) {
            
            _selectAreaFld.text = @"";
        }
        else{
            _selectAreaFld.text = [[dic valueForKey:@"areas"][0] valueForKey:@"value_english"];
        }
        
    }
    else if ([buttonTap isEqualToString:@"Reason"]){
        
        _selectReasonFld.text = [[reasonAray valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        
        reasonId = [[reasonAray valueForKey:@"id"] objectAtIndex:indexPath.row];
    }
    else if ([buttonTap isEqualToString:@"Person Req"]){
        
        _selectPersonRequestAppraisalFld.text = [personReqArray objectAtIndex:indexPath.row];
    }
    else{
        
    }
    
    [button setImage:[UIImage imageNamed:@"radio-on-button.png"] forState:UIControlStateNormal];

    _popUpView.hidden = YES;
    _tapleViewpopUp.hidden = YES;
    _tableContainView.hidden = YES;
}

- (IBAction)termsandConditionBoxTapped:(id)sender {
    
    if (_termsBtn.selected == YES)
    {
        [_termsBtn setImage:[UIImage imageNamed:@"boxuncheck.png"] forState:UIControlStateNormal];
        _termsBtn.selected = NO;
        termsStr = @"NO";
    }
    else
    {
        [_termsBtn setImage:[UIImage imageNamed:@"boxchecked.png"] forState:UIControlStateNormal];
        termsStr = @"Yes";
        _termsBtn.selected = YES;
    }
}

- (IBAction)iAgreeTermsAndConditionBtnTapped:(id)sender {
}

- (IBAction)closeBtnTapped:(id)sender {
    
    _popUpView.hidden = YES;
    _tapleViewpopUp.hidden = YES;
    _tableContainView.hidden = YES;
}

- (IBAction)chooseFileBtnTapped:(id)sender {
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"" message:@"Upload Image / File." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhoto=[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];

        }
        else{
           
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Alert"
                                         message:@"Device has no camera!"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }

        [alertController dismissViewControllerAnimated:YES completion:nil];

    }];
    [alertController addAction:takePhoto];
    
    UIAlertAction *choosePhoto=[UIAlertAction actionWithTitle:@"Select Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = NO;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:choosePhoto];
    
    UIAlertAction *choosedocument=[UIAlertAction actionWithTitle:@"Select Document" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        
        pickerView.allowsEditing = NO;
        
        pickerView.delegate = self;
        
//        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image"]
//                                                                                                                inMode:UIDocumentPickerModeImport];
//        documentPicker.delegate = self;
//        documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
//        [self presentViewController:documentPicker animated:YES completion:nil];
        UIDocumentMenuViewController *documentProviderMenu =
        [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"public.image", @"public.audio", @"public.movie", @"public.text", @"public.item", @"public.content", @"public.source-code"]
                                                             inMode:UIDocumentPickerModeImport];
        
        documentProviderMenu.delegate = self;
        [self presentViewController:documentProviderMenu animated:YES completion:nil];
       // [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        [self presentModalViewController:pickerView animated:YES];
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:choosedocument];
    
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma document Picker.....

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url lastPathComponent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Import"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
    
    if (controller.documentPickerMode== UIDocumentPickerModeImport) {
        //taking the path of the file selected
        NSString *path = [url path];
        //converting to NSData
        infoData = [[NSFileManager defaultManager] contentsAtPath:path];
    }
}

#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    chosenImage = info[UIImagePickerControllerOriginalImage];
    
    infoData = UIImagePNGRepresentation(chosenImage);
    base64 = [infoData base64EncodedStringWithOptions:NSUTF8StringEncoding];
    NSLog(@"base64 =%@",base64);
    
//    NSUInteger len = [infoData length];
//    byteData= (Byte*)malloc(len);
//    NSString *byteArray  = [infoData base64Encoding];
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSString *imageName = [imagePath lastPathComponent];
//    _nofileSlectedLbl.text = imageName;
    

    // get the ref url
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        _nofileSlectedLbl.text = [imageRep filename];
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];

    

     [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)preConfirmBtnTapped:(id)sender {
    
    [self showHUD:@""];
    
    [self makePostCallForPage:APPRAISAL_REPORT withParams:@{@"property_type_id":propertyId, @"property_specification_id":specificationId, @"property_area_id":areaId, @"property_reason_id":reasonId,@"block_number":_enterBlockFld.text,@"street":_enterStreetFld.text,@"avenue":_enterAvenueFld.text,@"plot":_enterPlotHousenumberFld.text,@"additional_details":_additionalDetaislFld.text,@"owner_name":_ownerNameFld.text,@"person_requesting":_selectPersonRequestAppraisalFld.text,@"representative_name":_selectPersonRequestAppraisalFld.text,@"phone":_enterPhoneFld.text,@"email":_enterEmalFld.text,@"reason_details":_selectReasonFld.text} withRequestCode:120];
}

- (IBAction)preCloseBtnTapped:(id)sender {

    _popUpView.hidden = YES;
    _tapleViewpopUp.hidden = YES;
    _tableContainView.hidden = YES;
    _previewView.hidden = YES;
}

- (IBAction)doneClicked:(id)sender
{
    // [self.view endEditing:NO];
    [_enterPhoneFld resignFirstResponder];
}

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


-(void)textFldBoarders{
    
    
    _slectPropetyTypeFld.layer.borderColor = [UIColor whiteColor].CGColor;
   // _slectPropetyTypeFld.layer.borderWidth = 2.0f;
    _slectPropetyTypeFld.layer.cornerRadius = 10.0f;
    
    _enterRemarksFld.layer.borderColor = [UIColor whiteColor].CGColor;
    // _slectPropetyTypeFld.layer.borderWidth = 2.0f;
    _enterRemarksFld.layer.cornerRadius = 10.0f;
    
    _selectSpecificationFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _selectSpecificationFld.layer.borderWidth = 2.0f;
    _selectSpecificationFld.layer.cornerRadius = 10.0f;
    
    _selectAreaFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _selectAreaFld.layer.borderWidth = 2.0f;
    _selectAreaFld.layer.cornerRadius = 10.0f;
    
    _enterBlockFld.layer.borderColor = [UIColor whiteColor].CGColor;
   // _enterBlockFld.layer.borderWidth = 2.0f;
    _enterBlockFld.layer.cornerRadius = 10.0f;
    
    _enterStreetFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _enterStreetFld.layer.borderWidth = 2.0f;
    _enterStreetFld.layer.cornerRadius = 10.0f;
    
    _enterAvenueFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _enterAvenueFld.layer.borderWidth = 2.0f;
    _enterAvenueFld.layer.cornerRadius = 10.0f;
    
    

    
    _enterPlotHousenumberFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _enterPlotHousenumberFld.layer.borderWidth = 2.0f;
    _enterPlotHousenumberFld.layer.cornerRadius = 10.0f;
    
    _appraisalFld.layer.borderColor = [UIColor whiteColor].CGColor;
    //  _enterPlotHousenumberFld.layer.borderWidth = 2.0f;
    _appraisalFld.layer.cornerRadius = 10.0f;

    
    _additionalDetaislFld.layer.borderColor = [UIColor whiteColor].CGColor;
//    _additionalDetaislFld.layer.borderWidth = 2.0f;
    _additionalDetaislFld.layer.cornerRadius = 10.0f;
    
    _ownerNameFld.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _ownerNameFld.layer.borderWidth = 2.0f;
    _ownerNameFld.layer.cornerRadius = 10.0f;
    
    _selectPersonRequestAppraisalFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _selectPersonRequestAppraisalFld.layer.borderWidth = 2.0f;
    _selectPersonRequestAppraisalFld.layer.cornerRadius = 10.0f;
    
    _enterPhoneFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _enterPhoneFld.layer.borderWidth = 2.0f;
    _enterPhoneFld.layer.cornerRadius = 10.0f;
    
    _enterEmalFld.layer.borderColor = [UIColor whiteColor].CGColor;
 //   _enterEmalFld.layer.borderWidth = 2.0f;
    _enterEmalFld.layer.cornerRadius = 10.0f;
    
    _selectReasonFld.layer.borderColor = [UIColor whiteColor].CGColor;
//    _selectReasonFld.layer.borderWidth = 2.0f;
    _selectReasonFld.layer.cornerRadius = 10.0f;
    
    [self shadow:_slectPropetyTypeFld];
    [self shadow:_enterRemarksFld];
    [self shadow:_selectSpecificationFld];
    [self shadow:_selectAreaFld];
    [self shadow:_enterBlockFld];
    [self shadow:_enterStreetFld];
    [self shadow:_enterAvenueFld];
    [self shadow:_enterPlotHousenumberFld];
    [self shadow:_appraisalFld];
    [self shadow:_additionalDetaislFld];
    [self shadow:_ownerNameFld];
    [self shadow:_selectPersonRequestAppraisalFld];
    [self shadow:_enterPhoneFld];
    [self shadow:_enterEmalFld];
    [self shadow:_selectReasonFld];

    
}

-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _slectPropetyTypeFld.rightView = paddingView;
        _slectPropetyTypeFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectSpecificationFld.rightView = paddingView1;
        _selectSpecificationFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectAreaFld.rightView = paddingView2;
        _selectAreaFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _enterBlockFld.rightView = paddingView3;
        _enterBlockFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];


        _enterStreetFld.rightView = paddingView4;
        _enterStreetFld.rightViewMode = UITextFieldViewModeAlways;
        
        _enterAvenueFld.rightView = paddingView5;
        _enterAvenueFld.rightViewMode = UITextFieldViewModeAlways;
        
        _enterPlotHousenumberFld.rightView = paddingView6;
        _enterPlotHousenumberFld.rightViewMode = UITextFieldViewModeAlways;
        
        _additionalDetaislFld.rightView = paddingView7;
        _additionalDetaislFld.rightViewMode = UITextFieldViewModeAlways;
        
        _ownerNameFld.rightView = paddingView8;
        _ownerNameFld.rightViewMode = UITextFieldViewModeAlways;
        
        _selectPersonRequestAppraisalFld.rightView = paddingView9;
        _selectPersonRequestAppraisalFld.rightViewMode = UITextFieldViewModeAlways;
        
        _enterPhoneFld.rightView = paddingView10;
        _enterPhoneFld.rightViewMode = UITextFieldViewModeAlways;
        
        _enterEmalFld.rightView = paddingView11;
        _enterEmalFld.rightViewMode = UITextFieldViewModeAlways;
        
        _selectReasonFld.rightView = paddingView12;
        _selectReasonFld.rightViewMode = UITextFieldViewModeAlways;
        
        _appraisalFld.rightView = paddingView13;
        _appraisalFld.rightViewMode = UITextFieldViewModeAlways;
        
        _enterRemarksFld.rightView = paddingView14;
        _enterRemarksFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _attachDocFld.rightView = paddingView15;
        _attachDocFld.rightViewMode = UITextFieldViewModeAlways;
        
        _diffTanOwnerFld.rightView = paddingView16;
        _diffTanOwnerFld.rightViewMode = UITextFieldViewModeAlways;

    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _slectPropetyTypeFld.leftView = paddingView;
        _slectPropetyTypeFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectSpecificationFld.leftView = paddingView1;
        _selectSpecificationFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _selectAreaFld.leftView = paddingView2;
        _selectAreaFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        _enterBlockFld.leftView = paddingView3;
        _enterBlockFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];

        UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];

        UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];

        _attachDocFld.leftView = paddingView15;
        _attachDocFld.leftViewMode = UITextFieldViewModeAlways;

        _diffTanOwnerFld.leftView = paddingView16;
        _diffTanOwnerFld.leftViewMode = UITextFieldViewModeAlways;

        _enterStreetFld.leftView = paddingView4;
        _enterStreetFld.leftViewMode = UITextFieldViewModeAlways;
        
        _enterAvenueFld.leftView = paddingView5;
        _enterAvenueFld.leftViewMode = UITextFieldViewModeAlways;
        
        _enterPlotHousenumberFld.leftView = paddingView6;
        _enterPlotHousenumberFld.leftViewMode = UITextFieldViewModeAlways;
        
        _additionalDetaislFld.leftView = paddingView7;
        _additionalDetaislFld.leftViewMode = UITextFieldViewModeAlways;
        
        _ownerNameFld.leftView = paddingView8;
        _ownerNameFld.leftViewMode = UITextFieldViewModeAlways;
        
        _selectPersonRequestAppraisalFld.leftView = paddingView9;
        _selectPersonRequestAppraisalFld.leftViewMode = UITextFieldViewModeAlways;
        
        _enterPhoneFld.leftView = paddingView10;
        _enterPhoneFld.leftViewMode = UITextFieldViewModeAlways;
        
        _enterEmalFld.leftView = paddingView11;
        _enterEmalFld.leftViewMode = UITextFieldViewModeAlways;
        
        _selectReasonFld.leftView = paddingView12;
        _selectReasonFld.leftViewMode = UITextFieldViewModeAlways;
        
        _appraisalFld.leftView = paddingView13;
        _appraisalFld.leftViewMode = UITextFieldViewModeAlways;

        _enterRemarksFld.leftView = paddingView14;
        _enterRemarksFld.leftViewMode = UITextFieldViewModeAlways;

    }
}


-(void)shadow:(UITextField*)txtFld{
    
    txtFld.layer.cornerRadius = txtFld.frame.size.height/2-15;
    txtFld.clipsToBounds = false;
    txtFld.layer.shadowOpacity=0.2;
    txtFld.layer.shadowColor = [[UIColor blackColor] CGColor];
    txtFld.layer.shadowOffset =CGSizeMake(0, 2);
}




@end
