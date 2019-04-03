//
//  PostAddViewController.m
//  Alhisba
//
//  Created by Apple on 05/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PostAddViewController.h"
#import "SVProgressHUD.h"
#import "PopViewControllerDelegate.h"
#import "ActionSheetStringPicker.h"
#import "locationcheckCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AddsViewController.h"
#import "LoginOrSignUpViewController.h"
#import "HomeCollectionViewCell.h"
#import "AFNetworking.h"
#import "Utils.h"
#import "Common.h"
#import "UIImage+GIF.h"
#import <QuartzCore/QuartzCore.h>



@interface PostAddViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    
    UIButton *backBtn;
    NSMutableArray *resultArray;
    NSString *fldType;
    NSMutableArray *locArray,*curbArray,*facadeArray,*finishingArray,*conditionsArray,*addonsArray,*propertyIdArray,*areaIdArray,*priceTypeIdArray,*priceType2IdArray,*locationIdArray,*curbIdArray,*streetIdArray,*facingIdArray,*directionIdArray,*generalIdArray,*ageIdarray,*chaletsIdArray,*rentalIdArray;
    NSMutableArray *table,*filterContainStringad,*curbContainStringad,*facadeContainStringad,*finishingContainStringad,*conditionContainStringad,*addonsContainStringad,*imagesArray;
    NSMutableString *locationStr,*propertyStr,*areaStr,*priceTypeStr,*priceType2Str,*locaStr,*curbStr,*streetStr,*facingStr,*directionStr,*generalStr,*ageStr,*charletStr,*rentalStr,*curbddlStr,*responceArray,*postImageAray;
    
    NSMutableString *locationColStr,*curnColStr,*facadeStr,*finishStr,*conditionStr,*addonStr;
    
    NSString *byteArray,*typeId;
    UIImage *chosenImage;
    NSString *base64;
    Byte *byteData;
     NSData *infoData;
    UIImageView *chosenIm;

}

@end

@implementation PostAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _saleCityFld.delegate = self;
//    _salePropertyTypeFld.delegate = self;
//    _saleAreaSizeFld.delegate = self;
//    _saleDes.delegate = self;
//    _saleNameFld.delegate = self;
    _saleMobileFld.delegate = self;
//    _rentCityFdl.delegate = self;
//    _rentPriceFld.delegate = self;
    
    self.photoesCollectionView.hidden = YES;
    
    filterContainStringad = [NSMutableArray array];
    curbContainStringad = [[NSMutableArray alloc] init];
    facadeContainStringad = [[NSMutableArray alloc] init];
    finishingContainStringad = [[NSMutableArray alloc] init];
    conditionContainStringad = [[NSMutableArray alloc] init];
    addonsContainStringad = [[NSMutableArray alloc] init];
    
    imagesArray = [[NSMutableArray alloc] init];
    
    _saleDes.delegate = self;
    _rentDes.delegate = self;
    _additionInfoArabic.delegate = self;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"Post Ads")];
    
    [_saveDraftBtn setTitle:Localized(@"Save Draft") forState:UIControlStateNormal];
    
    [_proceedbtn setTitle:Localized(@"Proceed") forState:UIControlStateNormal];
    _addUptoLbl.text = Localized(@"Add upto 9 pictures and 1 video");
    _forSaleLbl.text = Localized(@"For Sale");
    _forRentLbl.text = Localized(@"For Rent");
    _facadeLbl.text = Localized(@"Facade");
    _finishingLbl.text = Localized(@"Finishing");
    _conditionsLbl.text = Localized(@"Conditions");
    _addonsLbl.text = Localized(@"Add-Ons");
    
    _roomFldHeight.constant = 0;
    _roomFldTop.constant = 0;
    _roomsTextFld.userInteractionEnabled = NO;
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _saleMobileFld.inputAccessoryView = keyboardDoneButtonView;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
        
        _selectIcon.image = [UIImage imageNamed:@"left.png"];
       // _adduptoXConstraint.constant = 15;
        
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
        
        _selectIcon.image = [UIImage imageNamed:@"right1.png"];
        
//        _adduptoXConstraint.constant = -15;
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Post Ads");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel.backgroundColor = [UIColor clearColor];
    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel sizeToFit];
    UIImage *image = [UIImage imageNamed:@"badge.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame] ;
    [newView addSubview:imageView];
    [newView addSubview:tmpTitleLabel];
    tmpTitleLabel.center=newView.center;
    imageView.frame = CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20)];
    [btn addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:btn];
    self.navigationItem.titleView = newView;
    
    
    _chooseCateLbl.text = Localized(@"Choose Category");
    _selectLbl.text = Localized(@"Select");
    _addUptoLbl.text = Localized(@"Add up to 9 pictures & 1 Video");
   
    _addUptoView.layer.cornerRadius = 15.0f;
    _addUptoView.layer.masksToBounds = YES;
    
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    
    _titleFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Title *") attributes:@{NSForegroundColorAttributeName: color}];
    
    _propertyTypeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Property Type") attributes:@{NSForegroundColorAttributeName: color}];
    
    _expiryDateFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Expiry Date") attributes:@{NSForegroundColorAttributeName: color}];

    _areaFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Area") attributes:@{NSForegroundColorAttributeName: color}];
    
    _saleMobileFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Mobile Number *") attributes:@{NSForegroundColorAttributeName: color}];

    _mobileNoFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Space *") attributes:@{NSForegroundColorAttributeName: color}];
    
    _roomsTextFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Rooms") attributes:@{NSForegroundColorAttributeName: color}];
   
    _AlternativeMobileFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Alternative Mobile Number") attributes:@{NSForegroundColorAttributeName: color}];
    
    _landSizefld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Land Size") attributes:@{NSForegroundColorAttributeName: color}];
    
    _priceFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price") attributes:@{NSForegroundColorAttributeName: color}];
    
    _price2Fld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price 2") attributes:@{NSForegroundColorAttributeName: color}];

    _priceTypeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price Type") attributes:@{NSForegroundColorAttributeName: color}];
    
    _priceType2Fld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price Type 2") attributes:@{NSForegroundColorAttributeName: color}];
   
    _locationFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Location") attributes:@{NSForegroundColorAttributeName: color}];
    
    _streetFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Street") attributes:@{NSForegroundColorAttributeName: color}];
    
    _facingFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Facing") attributes:@{NSForegroundColorAttributeName: color}];
    _directionFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Direction") attributes:@{NSForegroundColorAttributeName: color}];
    _generalFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"General") attributes:@{NSForegroundColorAttributeName: color}];
    _ageFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Age") attributes:@{NSForegroundColorAttributeName: color}];
    _buildUpAreaFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Build Up Area(%)") attributes:@{NSForegroundColorAttributeName: color}];

    _charletsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Chalets") attributes:@{NSForegroundColorAttributeName: color}];
    
    _rentalFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Rental") attributes:@{NSForegroundColorAttributeName: color}];
    
    _entranceFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Entrance No.") attributes:@{NSForegroundColorAttributeName: color}];
    
    _seaFrontFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Sea Front (lm)") attributes:@{NSForegroundColorAttributeName: color}];
    
    _backSideFrontFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Backside Front (lm)") attributes:@{NSForegroundColorAttributeName: color}];
    
    _monthlyRentFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Monthly Rent") attributes:@{NSForegroundColorAttributeName: color}];

    _noofFlatsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"No. Of Flats") attributes:@{NSForegroundColorAttributeName: color}];

    _flatSizeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Flat Size") attributes:@{NSForegroundColorAttributeName: color}];

    _noofBedroomsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"No. Of Bedrooms") attributes:@{NSForegroundColorAttributeName: color}];

    _noofBathroomsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"No. Of Bathrooms") attributes:@{NSForegroundColorAttributeName: color}];


    
    
    _saleDes.layer.masksToBounds=YES;
    _saleDes.layer.borderWidth= 1.0f;
    _saleDes.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    _saleDes.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Description")]];
   
    [_saleDes setTextColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];
    
    _additionInfoArabic.layer.masksToBounds=YES;
    _additionInfoArabic.layer.borderWidth= 1.0f;
    _additionInfoArabic.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    _additionInfoArabic.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Description")]];
    
    [_additionInfoArabic setTextColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        _saleDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
        _additionInfoArabic.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
    }
    else{

        _saleDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
        _additionInfoArabic.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
    }
    
    _saleDes.textContainer.lineFragmentPadding = 20;
    _additionInfoArabic.textContainer.lineFragmentPadding = 20;

    _rentDes.layer.masksToBounds=YES;
    _rentDes.layer.borderWidth= 1.0f;
    _rentDes.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    _rentDes.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Description")]];
    
    [_rentDes setTextColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        _rentDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
        
    }
    else{
        
        _rentDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
    }
    
    _rentDes.textContainer.lineFragmentPadding = 20;


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
    
    

    [self shadow:_titleFld];
    [self shadow:_propertyTypeFld];
    [self shadow:_areaFld];
    [self shadow:_mobileNoFld];
    [self shadow:_AlternativeMobileFld];
    [self shadow:_landSizefld];
    [self shadow:_priceFld];
    [self shadow:_priceTypeFld];
    [self shadow:_price2Fld];
    [self shadow:_priceType2Fld];
    [self shadow:_roomsTextFld];

    [self shadow:_streetFld];
    [self shadow:_facingFld];
    [self shadow:_directionFld];
    [self shadow:_generalFld];
    [self shadow:_ageFld];
    [self shadow:_buildUpAreaFld];

    [self shadow:_charletsFld];
    [self shadow:_rentalFld];
    [self shadow:_entranceFld];
    [self shadow:_seaFrontFld];
    [self shadow:_backSideFrontFld];
    [self shadow:_monthlyRentFld];

    [self shadow:_noofFlatsFld];
    [self shadow:_flatSizeFld];
    [self shadow:_noofBedroomsFld];
    [self shadow:_noofBathroomsFld];
    [self shadow:_expiryDateFld];

    
    [self showHUD:@""];
    
    [self makePostCallForPage:ADD_CATEG withParams:@{} withRequestCode:1];
    
 //   @"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]

}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{

    if (reqeustCode == 1) {
        
        resultArray = result;
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            locArray = [[[resultArray valueForKey:@"location_2"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _locationCollectionviewHeight.constant = locArray.count * 30;
            
            curbArray = [[[resultArray valueForKey:@"curb_2"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _curbCollectionviewHeight.constant = curbArray.count * 30;
            
            facadeArray = [[[resultArray valueForKey:@"facade"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _facadeCollectionViewHeight.constant = facadeArray.count * 30;
            
            finishingArray = [[[resultArray valueForKey:@"finishing"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _finishingCollectionViewHeight.constant = finishingArray.count * 30;
            
            conditionsArray = [[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _conditioncollectionviewHeight.constant = finishingArray.count * 30;
            
            conditionsArray = [[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _conditioncollectionviewHeight.constant = conditionsArray.count * 30;
            
            addonsArray = [[[resultArray valueForKey:@"add_ons"] valueForKey:@"values"] valueForKey:@"value_arabic"];
            _addonsCollectionviewHeight.constant = addonsArray.count * 30;
        }
        else{
            
            locArray = [[[resultArray valueForKey:@"location_2"] valueForKey:@"values"] valueForKey:@"value_english"];
            _locationCollectionviewHeight.constant = locArray.count * 30;
            
            curbArray = [[[resultArray valueForKey:@"curb_2"] valueForKey:@"values"] valueForKey:@"value_english"];
            _curbCollectionviewHeight.constant = curbArray.count * 30;
            
            facadeArray = [[[resultArray valueForKey:@"facade"] valueForKey:@"values"] valueForKey:@"value_english"];
            _facadeCollectionViewHeight.constant = facadeArray.count * 30;
            
            finishingArray = [[[resultArray valueForKey:@"finishing"] valueForKey:@"values"] valueForKey:@"value_english"];
            _finishingCollectionViewHeight.constant = finishingArray.count * 30;
            
            conditionsArray = [[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"value_english"];
            _conditioncollectionviewHeight.constant = finishingArray.count * 30;
            
            conditionsArray = [[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"value_english"];
            _conditioncollectionviewHeight.constant = conditionsArray.count * 30;
            
            addonsArray = [[[resultArray valueForKey:@"add_ons"] valueForKey:@"values"] valueForKey:@"value_english"];
            _addonsCollectionviewHeight.constant = addonsArray.count * 30;
        }
       
        
        
        [_locationCollectionView reloadData];
        [_curbCollectionView reloadData];
        [_facadeCollectionView reloadData];
        [_finishingCollectionView reloadData];
        [_conditionsCollectionView reloadData];
        [_addonsCollectionView reloadData];
    }
    else if (reqeustCode == 20){
        
        responceArray  =result;
        
        NSLog(@"responce array is %@",responceArray);
        
        [self showHUD:@""];
        
        NSMutableString *imageStr = [[NSMutableString alloc]init];
        
        NSString *appendStrig2 = @",";
        
        for (int i=0; i < imagesArray.count ; i++){
            
            if(i<imagesArray.count-1)
            {
                [imageStr appendString:[NSString stringWithFormat:@"%@%@",[imagesArray objectAtIndex:i],appendStrig2]];
                
            }
            else
            {
                [imageStr appendString:[NSString stringWithFormat:@"%@",[imagesArray objectAtIndex:i]]];
            }
        }
        

            //http://clients.yellowsoft.in/lawyers/api/add-member-image.php
        
        NSLog(@"location Str is %@",locationStr);
        
        NSString *str = [result valueForKey:@"add_id"];
        
//        [self makePostCallForPage:POST_ADDIMAGE withParams:@{@"ad_id":[NSString stringWithFormat:@"%d",str.intValue],@"file1":imageStr} withRequestCode:10];

    NSString *serverURL = [NSString stringWithFormat:@"%@/%@", SERVER_URL,POST_ADDIMAGE];

        NSDictionary *parameters = @{@"ad_id":[NSString stringWithFormat:@"%d",str.intValue]};
            
            //    UIImage *image = user_uiimage;
            UIImage *image = [UIImage imageWithCGImage:chosenImage.CGImage scale:0.25 orientation:chosenImage.imageOrientation];
        
            if (image == nil) {
                [self hideHUD];
                [Utils showAlertWithMessage:[MCLocalization stringForKey:@"Sucessfully"]];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            // image = [image resizedImageToFitInSize:CGSizeMake(960, 640) scaleIfSmaller:NO];
            
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serverURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                            name:@"file1"
                                        fileName:@"file.png"
                                        mimeType:@"image/png"];
            } error:nil];
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            NSURLSessionUploadTask *uploadTask;
            
            uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                       progress:^(NSProgress * _Nonnull uploadProgress) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
                                                           });
                                                       }
                                              completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                  if (error) {
                                                      NSLog(@"Failure %@", error.description);
                                                      [self hideHUD];
                                                      [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"error_while_posting_ad"]];
                                                      
                                                  } else {
                                                      
                                                      NSLog(@"Success %@", responseObject);
                                                      
                                                      [self hideHUD];
                                                      [Utils showAlertWithMessage:[MCLocalization stringForKey:@"Sucessfully"]];
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }
                                              }];
            
            
            
            [uploadTask resume];

    }
    else if (reqeustCode == 10){
        
        postImageAray = result;
        if ([[result valueForKey:@"status"] isEqualToString:@"Success"]) {
            
            AddsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"AddsViewController"];
            [self.navigationController pushViewController:obj animated:YES];
        }
        else{
            
        }
        
        NSLog(@"post image Array %@",postImageAray);
    }
  
    [self hideHUD];
}
//
- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);

    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return outputImage;
}
//
-(void)goBack{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickForInfo:(id)sender{

    [self showInfo:Localized(@"Post Ads") :sender];
}


- (IBAction)selectBtnTapped:(id)sender {
}

- (IBAction)saveDraftBtnTapped:(id)sender {
}

- (IBAction)proceedBtnTapped:(id)sender {
    
    if ([typeId isEqualToString:@"1"]) {
        
        if ([self.areaFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select area")];
        }
        else if ([self.propertyTypeFld.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please select property type")];
        }
        else if ([self.mobileNoFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter Space")];
        }
        else if ([self.priceFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter price")];
        }
        else if ([self.saleDes.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter Description")];
        }
        else if ([self.saleMobileFld.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please enter mobile number")];
        }
        else{
            
            NSString  *valid = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
            
            NSLog(@"valid Details are %@",valid);
            
            NSString *strin = valid;
            if([strin class]==NULL){
                strin=@"";
            }
            if ([strin length]>0) {
                
                [self showHUD:@""];
                
                [self makePostCallForPage:POST_ADD withParams:@{@"user_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"ad_type_id":typeId,@"property_type_id":propertyStr,@"area_id":[NSString stringWithFormat:@"%@",areaStr],@"price_1":_priceFld.text,@"rental_num_bedrooms":_roomsTextFld.text,@"additional_info_english":_saleDes.text,@"phone_num_1":_saleMobileFld.text} withRequestCode:20];
            }
            else{
                
                LoginOrSignUpViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
                obj.fromPostAdd = @"fromPostAdd";
                obj.loginOrSign = @"login";
                [self.navigationController pushViewController:obj animated:YES];
                
            }
        }
    }
    else{
        if ([self.areaFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please select area")];
        }
        else if ([self.propertyTypeFld.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please select property type")];
        }
        else if ([self.roomsTextFld.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please enter no of rooms.")];
        }
        else if ([self.mobileNoFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter Space")];
        }
        else if ([self.priceFld.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter price")];
        }
        else if ([self.saleDes.text length] == 0){
            [self showErrorAlertWithMessage:Localized(@"Please enter Description")];
        }
        else if ([self.saleMobileFld.text length] == 0){
            
            [self showErrorAlertWithMessage:Localized(@"Please enter mobile number")];
        }
        else{
            
            NSString  *valid = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
            
            NSLog(@"valid Details are %@",valid);
            
            NSString *strin = valid;
            if([strin class]==NULL){
                strin=@"";
            }
            if ([strin length]>0) {
                
                [self showHUD:@""];
                
                [self makePostCallForPage:POST_ADD withParams:@{@"user_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"ad_type_id":typeId,@"property_type_id":propertyStr,@"area_id":[NSString stringWithFormat:@"%@",areaStr],@"price_1":_priceFld.text,@"rental_num_bedrooms":_roomsTextFld.text,@"additional_info_english":_saleDes.text,@"phone_num_1":_saleMobileFld.text} withRequestCode:20];
            }
            else{
                
                LoginOrSignUpViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
                obj.fromPostAdd = @"fromPostAdd";
                obj.loginOrSign = @"login";
                [self.navigationController pushViewController:obj animated:YES];
                
            }
        }
    }

   
}

- (IBAction)segmentTouchIns:(UISegmentedControl*)sender {

    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"First was selected");

//            _forRentViewHeigthConstarint.constant = 0;
//            _forRentTopConstraint.constant = 600;
//            _forRentView.hidden = YES;
//            _forRentLbl.hidden = YES;
//            _forrentBtn.hidden = YES;
//            _forSaleView.hidden = NO;
//            _forSaleLbl.hidden = NO;
//            _forSaleBtn.hidden = NO;

//            _forRentTopConstraint.constant = 0;
//            _forSaleView.hidden = NO;
//            _forSaleLbl.hidden = NO;
//            _forSaleBtn.hidden = NO;
//            _forRentView.hidden = YES;
//            _forRentLbl.hidden = YES;
//            _forrentBtn.hidden = YES;
            
            _roomFldHeight.constant = 0;
            _roomFldTop.constant = 0;
            _roomsTextFld.userInteractionEnabled = NO;

            typeId = @"1";
            
            _forSaleLbl.text = Localized(@"For Sale");

            break;
        case 1:
            NSLog(@"Second was selected");

//            _forRentTopConstraint.constant = 20;
//            _forRentViewHeigthConstarint.constant = 700;
//            _forSaleView.hidden = YES;
//            _forSaleLbl.hidden = YES;
//            _forSaleBtn.hidden = YES;
//            _forRentView.hidden = NO;
//            _forRentLbl.hidden = NO;
//            _forrentBtn.hidden = NO;
            
            _roomFldHeight.constant = 50;
            _roomFldTop.constant = 12;
            _roomsTextFld.userInteractionEnabled = YES;

            typeId = @"2";
            _forSaleLbl.text = Localized(@"For Rent");

            break;
        case 2:
            NSLog(@"Third was selected");
            break;
        default:
            break;
    }
}

-(void)textFldBoarders{

 // Sale...
    _titleFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _titleFld.layer.borderWidth = 1.0f;
    _titleFld.layer.cornerRadius = 15.0f;

    _curbFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _curbFld.layer.borderWidth = 1.0f;
    _curbFld.layer.cornerRadius = 15.0f;
    
    _saleMobileFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleMobileFld.layer.borderWidth = 1.0f;
    _saleMobileFld.layer.cornerRadius = 15.0f;

    _locationFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _locationFld.layer.borderWidth = 1.0f;
    _locationFld.layer.cornerRadius = 15.0f;

    _propertyTypeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _propertyTypeFld.layer.borderWidth = 1.0f;
    _propertyTypeFld.layer.cornerRadius = 15.0f;

    _areaFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _areaFld.layer.borderWidth = 1.0f;
    _areaFld.layer.cornerRadius = 15.0f;

    _saleDes.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleDes.layer.borderWidth = 1.0f;
    _saleDes.layer.cornerRadius = 15.0f;

    _additionInfoArabic.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _additionInfoArabic.layer.borderWidth = 1.0f;
    _additionInfoArabic.layer.cornerRadius = 15.0f;

    _mobileNoFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mobileNoFld.layer.borderWidth = 1.0f;
    _mobileNoFld.layer.cornerRadius = 15.0f;


    _AlternativeMobileFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _AlternativeMobileFld.layer.borderWidth = 1.0f;
    _AlternativeMobileFld.layer.cornerRadius = 15.0f;


    _landSizefld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _landSizefld.layer.borderWidth = 1.0f;
    _landSizefld.layer.cornerRadius = 15.0f;

    _priceFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _priceFld.layer.borderWidth = 1.0f;
    _priceFld.layer.cornerRadius = 15.0f;

    _price2Fld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _price2Fld.layer.borderWidth = 1.0f;
    _price2Fld.layer.cornerRadius = 15.0f;

    _priceTypeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _priceTypeFld.layer.borderWidth = 1.0f;
    _priceTypeFld.layer.cornerRadius = 15.0f;

    _priceType2Fld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _priceType2Fld.layer.borderWidth = 1.0f;
    _priceType2Fld.layer.cornerRadius = 15.0f;

    _streetFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _streetFld.layer.borderWidth = 1.0f;
    _streetFld.layer.cornerRadius = 15.0f;

    _facingFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _facingFld.layer.borderWidth = 1.0f;
    _facingFld.layer.cornerRadius = 15.0f;

    _directionFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _directionFld.layer.borderWidth = 1.0f;
    _directionFld.layer.cornerRadius = 15.0f;

    _generalFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _generalFld.layer.borderWidth = 1.0f;
    _generalFld.layer.cornerRadius = 15.0f;

    _ageFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _ageFld.layer.borderWidth = 1.0f;
    _ageFld.layer.cornerRadius = 15.0f;

    _buildUpAreaFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _buildUpAreaFld.layer.borderWidth = 1.0f;
    _buildUpAreaFld.layer.cornerRadius = 15.0f;

    _charletsFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _charletsFld.layer.borderWidth = 1.0f;
    _charletsFld.layer.cornerRadius = 15.0f;

    _rentalFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentalFld.layer.borderWidth = 1.0f;
    _rentalFld.layer.cornerRadius = 15.0f;

    _entranceFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _entranceFld.layer.borderWidth = 1.0f;
    _entranceFld.layer.cornerRadius = 15.0f;

    _seaFrontFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _seaFrontFld.layer.borderWidth = 1.0f;
    _seaFrontFld.layer.cornerRadius = 15.0f;

    _backSideFrontFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _backSideFrontFld.layer.borderWidth = 1.0f;
    _backSideFrontFld.layer.cornerRadius = 15.0f;

    _monthlyRentFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _monthlyRentFld.layer.borderWidth = 1.0f;
    _monthlyRentFld.layer.cornerRadius = 15.0f;

    _noofFlatsFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _noofFlatsFld.layer.borderWidth = 1.0f;
    _noofFlatsFld.layer.cornerRadius = 15.0f;

    _flatSizeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _flatSizeFld.layer.borderWidth = 1.0f;
    _flatSizeFld.layer.cornerRadius = 15.0f;

    _noofBedroomsFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _noofBedroomsFld.layer.borderWidth = 1.0f;
    _noofBedroomsFld.layer.cornerRadius = 15.0f;

    _noofBathroomsFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _noofBathroomsFld.layer.borderWidth = 1.0f;
    _noofBathroomsFld.layer.cornerRadius = 15.0f;

    _expiryDateFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _expiryDateFld.layer.borderWidth = 1.0f;
    _expiryDateFld.layer.cornerRadius = 15.0f;

    _roomsTextFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _roomsTextFld.layer.borderWidth = 1.0f;
    _roomsTextFld.layer.cornerRadius = 15.0f;

    _saveDraftBtn.layer.cornerRadius = 15.0f;
    _proceedbtn.layer.cornerRadius = 15.0f;

}

-(void)paddingFlds{

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {

        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _titleFld.rightView = paddingView;
        _titleFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _propertyTypeFld.rightView = paddingView1;
        _propertyTypeFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _areaFld.rightView = paddingView2;
        _areaFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _mobileNoFld.rightView = paddingView3;
        _mobileNoFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _AlternativeMobileFld.rightView = paddingView4;
        _AlternativeMobileFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _landSizefld.rightView = paddingView5;
        _landSizefld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceFld.rightView = paddingView6;
        _priceFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _price2Fld.rightView = paddingView7;
        _price2Fld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceTypeFld.rightView = paddingView8;
        _priceTypeFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceType2Fld.rightView = paddingView9;
        _priceType2Fld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _locationFld.rightView = paddingView10;
        _locationFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _curbFld.rightView = paddingView11;
        _curbFld.rightViewMode = UITextFieldViewModeAlways;


        UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView17 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView18 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView19 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView20 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView21 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView22 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView23 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView24 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView25 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView26 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
           UIView *paddingView27 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView28 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView29 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView30 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
          UIView *paddingView31 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleMobileFld.rightView = paddingView31;
        _saleMobileFld.rightViewMode = UITextFieldViewModeAlways;


        _roomsTextFld.rightView = paddingView30;
        _roomsTextFld.rightViewMode = UITextFieldViewModeAlways;

        _expiryDateFld.rightView = paddingView12;
        _expiryDateFld.rightViewMode = UITextFieldViewModeAlways;


        _priceTypeFld.rightView = paddingView13;
        _priceTypeFld.rightViewMode = UITextFieldViewModeAlways;


        _streetFld.rightView = paddingView14;
        _streetFld.rightViewMode = UITextFieldViewModeAlways;

        _facingFld.rightView = paddingView15;
        _facingFld.rightViewMode = UITextFieldViewModeAlways;

        _directionFld.rightView = paddingView16;
        _directionFld.rightViewMode = UITextFieldViewModeAlways;

        _generalFld.rightView = paddingView17;
        _generalFld.rightViewMode = UITextFieldViewModeAlways;

        _ageFld.rightView = paddingView18;
        _ageFld.rightViewMode = UITextFieldViewModeAlways;

        _buildUpAreaFld.rightView = paddingView19;
        _buildUpAreaFld.rightViewMode = UITextFieldViewModeAlways;

        _charletsFld.rightView = paddingView20;
        _charletsFld.rightViewMode = UITextFieldViewModeAlways;

        _rentalFld.rightView = paddingView21;
        _rentalFld.rightViewMode = UITextFieldViewModeAlways;

        _entranceFld.rightView = paddingView22;
        _entranceFld.rightViewMode = UITextFieldViewModeAlways;

        _seaFrontFld.rightView = paddingView23;
        _seaFrontFld.rightViewMode = UITextFieldViewModeAlways;

        _backSideFrontFld.rightView = paddingView24;
        _backSideFrontFld.rightViewMode = UITextFieldViewModeAlways;

        _monthlyRentFld.rightView = paddingView25;
        _monthlyRentFld.rightViewMode = UITextFieldViewModeAlways;

        _noofFlatsFld.rightView = paddingView26;
        _noofFlatsFld.rightViewMode = UITextFieldViewModeAlways;

        _flatSizeFld.rightView = paddingView27;
        _flatSizeFld.rightViewMode = UITextFieldViewModeAlways;

        _noofBathroomsFld.rightView = paddingView28;
        _noofBathroomsFld.rightViewMode = UITextFieldViewModeAlways;

        _noofBedroomsFld.rightView = paddingView29;
        _noofBedroomsFld.rightViewMode = UITextFieldViewModeAlways;

    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _titleFld.leftView = paddingView;
        _titleFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _propertyTypeFld.leftView = paddingView1;
        _propertyTypeFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _areaFld.leftView = paddingView2;
        _areaFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _mobileNoFld.leftView = paddingView3;
        _mobileNoFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _AlternativeMobileFld.leftView = paddingView4;
        _AlternativeMobileFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _landSizefld.leftView = paddingView5;
        _landSizefld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceFld.leftView = paddingView6;
        _priceFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _price2Fld.leftView = paddingView7;
        _price2Fld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceTypeFld.leftView = paddingView8;
        _priceTypeFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _priceType2Fld.leftView = paddingView9;
        _priceType2Fld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _locationFld.leftView = paddingView10;
        _locationFld.leftViewMode = UITextFieldViewModeAlways;

        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        _curbFld.leftView = paddingView11;
        _curbFld.leftViewMode = UITextFieldViewModeAlways;


        UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView17 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView18 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView19 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView20 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView21 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView22 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView23 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView24 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView25 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView26 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        UIView *paddingView27 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView28 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];

        UIView *paddingView29 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        UIView *paddingView31 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleMobileFld.leftView = paddingView31;
        _saleMobileFld.leftViewMode = UITextFieldViewModeAlways;

        
        _roomsTextFld.leftView = paddingView29;
        _roomsTextFld.leftViewMode = UITextFieldViewModeAlways;

        _expiryDateFld.leftView = paddingView12;
        _expiryDateFld.leftViewMode = UITextFieldViewModeAlways;

        _streetFld.leftView = paddingView13;
        _streetFld.leftViewMode = UITextFieldViewModeAlways;

        _facingFld.leftView = paddingView14;
        _facingFld.leftViewMode = UITextFieldViewModeAlways;

        _directionFld.leftView = paddingView15;
        _directionFld.leftViewMode = UITextFieldViewModeAlways;

        _generalFld.leftView = paddingView16;
        _generalFld.leftViewMode = UITextFieldViewModeAlways;

        _ageFld.leftView = paddingView17;
        _ageFld.leftViewMode = UITextFieldViewModeAlways;

        _buildUpAreaFld.leftView = paddingView18;
        _buildUpAreaFld.leftViewMode = UITextFieldViewModeAlways;

        _charletsFld.leftView = paddingView19;
        _charletsFld.leftViewMode = UITextFieldViewModeAlways;

        _rentalFld.leftView = paddingView20;
        _rentalFld.leftViewMode = UITextFieldViewModeAlways;

        _entranceFld.leftView = paddingView21;
        _entranceFld.leftViewMode = UITextFieldViewModeAlways;

        _seaFrontFld.leftView = paddingView22;
        _seaFrontFld.leftViewMode = UITextFieldViewModeAlways;

        _backSideFrontFld.leftView = paddingView23;
        _backSideFrontFld.leftViewMode = UITextFieldViewModeAlways;

        _monthlyRentFld.leftView = paddingView24;
        _monthlyRentFld.leftViewMode = UITextFieldViewModeAlways;

        _noofFlatsFld.leftView = paddingView25;
        _noofFlatsFld.leftViewMode = UITextFieldViewModeAlways;

        _flatSizeFld.leftView = paddingView26;
        _flatSizeFld.leftViewMode = UITextFieldViewModeAlways;

        _noofBathroomsFld.leftView = paddingView27;
        _noofBathroomsFld.leftViewMode = UITextFieldViewModeAlways;

        _noofBedroomsFld.leftView = paddingView28;
        _noofBedroomsFld.leftViewMode = UITextFieldViewModeAlways;

    }
}

#pragma textView Delegates...


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == _saleDes) {
        _saleDes.text=@"";
        self.saleDes.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    }
    else{
        _additionInfoArabic.text=@"";
        self.additionInfoArabic.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == _saleDes) {

        if ([_saleDes.text isEqualToString:@""]) {

            _saleDes.text= Localized(@"Please enter your message here") ;
            self.saleDes.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
        }
    }
    else{
        if ([_additionInfoArabic.text isEqualToString:@""]) {

            _additionInfoArabic.text= Localized(@"Please enter your message here");
            self.additionInfoArabic.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];

        }
    }


}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if (textView == _saleDes) {

        if([text isEqualToString:@"\n"]) {

            UIColor *color = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];

            NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.saleDes.text attributes:@{NSForegroundColorAttributeName:color}];
            self.saleDes.attributedText = string;
            [_saleDes resignFirstResponder];

            return NO;
        }

        return YES;
    }
    else{

        if([text isEqualToString:@"\n"]) {

            UIColor *color = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];

            NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.additionInfoArabic.text attributes:@{NSForegroundColorAttributeName:color}];
            self.additionInfoArabic.attributedText = string;
            [_additionInfoArabic resignFirstResponder];

            return NO;
        }

        return YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{

//    [[self.segmentControl.subviews objectAtIndex:0] setBackgroundColor:[UIColor whiteColor]];
//
//    [[self.segmentControl.subviews objectAtIndex:1] setBackgroundColor:[UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];

   // self.segmentControl.tintColor = [UIColor clearColor];
    
    typeId = @"1";
    
    self.segmentControl.layer.borderWidth = 1;
    self.segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentControl.layer.cornerRadius = 15.0f;
    self.segmentControl.layer.masksToBounds = YES;
    self.segmentControl.clipsToBounds = YES;

    UIFont *Boldfont = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:Boldfont forKey:UITextAttributeFont];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];

 //   _forRentTopConstraint.constant = -50;
//    _forRentViewHeigthConstarint.constant = 0;
    _forSaleView.hidden = NO;
    _forSaleLbl.hidden = NO;
    _forSaleBtn.hidden = NO;
    _forRentView.hidden = YES;
    _forRentLbl.hidden = YES;
    _forrentBtn.hidden = YES;

//    [self.segmentControl insertSegmentWithTitle:Localized(@"For Sale") atIndex:0 animated:NO];
//    [self.segmentControl insertSegmentWithTitle:Localized(@"For Rent") atIndex:1 animated:NO];
//
//    self.segmentControl.layer.cornerRadius = 10;

    [self.segmentControl setTitle:Localized(@"For Sale") forSegmentAtIndex:0];

    [self.segmentControl setTitle:Localized(@"For Rent") forSegmentAtIndex:1];

}

- (IBAction)forSaleBtnTapped:(id)sender {
}
- (IBAction)forrentBtnTapped:(id)sender {
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}
- (IBAction)propertyTypeBtnTapped:(id)sender {

        fldType = @"Select Propert Type";

     //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *propertyArea;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        propertyArea = [[[resultArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
       propertyArea = [[[resultArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"value_english"];
    }

        propertyIdArray = [[[resultArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"id"];

        if(propertyArea.count>0){

            [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Propert Type")
                                                    rows:propertyArea
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

            _propertyTypeFld.text=[NSString stringWithFormat:@"%@",[propertyArea objectAtIndex:selectedIndex]];

    propertyStr = [NSString stringWithFormat:@"%@",[propertyIdArray objectAtIndex:selectedIndex]];

                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];
        }
}

- (IBAction)areaBtnTapped:(id)sender {

    fldType = @"Select Area";

    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *areaArray;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        areaArray = [[[resultArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        areaArray = [[[resultArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"value_english"];

    }

    areaIdArray = [[[resultArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"id"];

    if(areaArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                rows:areaArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

            _areaFld.text=[NSString stringWithFormat:@"%@",[areaArray objectAtIndex:selectedIndex]];
                                               
        areaStr = [NSString stringWithFormat:@"%@",[areaIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)priceTypeBtnTapped:(id)sender {

    fldType = @"Select Price Type";

    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *priceArray ;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
    
        priceArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        
        priceArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


    priceTypeIdArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"id"];

    if(priceArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Price Type")
                                                rows:priceArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                        _priceTypeFld.text=[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:selectedIndex]];
                                              
    priceTypeStr = [NSString stringWithFormat:@"%@",[priceTypeIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)priceType2BtnTapped:(id)sender {

    fldType = @"Select Price Type2";

    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *priceArray;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
       priceArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        priceArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


    priceType2IdArray = [[[resultArray valueForKey:@"price_type_1"] valueForKey:@"values"] valueForKey:@"id"];

    if(priceArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Price Type2")
                                                rows:priceArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                _priceType2Fld.text=[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:selectedIndex]];
                                               //
        self->priceType2Str = [NSString stringWithFormat:@"%@",[priceType2IdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)locationBtnTapped:(id)sender {

    fldType = @"Select Location";

    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *locationArray;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        locationArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        locationArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


    locationIdArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"id"];

    if(locationArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Price Type2")
                                                rows:locationArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                _locationFld.text=[NSString stringWithFormat:@"%@",[locationArray objectAtIndex:selectedIndex]];
                                               
            locaStr = [NSString stringWithFormat:@"%@",[locationIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)curbBtnTapped:(id)sender {

    fldType = @"Select Curb";

    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *locationArray;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        locationArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        locationArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


    curbIdArray = [[[resultArray valueForKey:@"location_1"] valueForKey:@"values"] valueForKey:@"id"];

    if(locationArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Curb")
                                                rows:locationArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                    _curbFld.text=[NSString stringWithFormat:@"%@",[locationArray objectAtIndex:selectedIndex]];
                                               //
        curbddlStr = [NSString stringWithFormat:@"%@",[curbIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)streetBtnTapped:(id)sender {

    fldType = @"Select Street";

    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *streetArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        streetArray = [[[resultArray valueForKey:@"street"] valueForKey:@"values"] valueForKey:@"value_arabic"];
    }
    else{
        streetArray = [[[resultArray valueForKey:@"street"] valueForKey:@"values"] valueForKey:@"value_english"];
    }

    streetIdArray = [[[resultArray valueForKey:@"street"] valueForKey:@"values"] valueForKey:@"id"];

    if(streetArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Street")
                                                rows:streetArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                _streetFld.text=[NSString stringWithFormat:@"%@",[streetArray objectAtIndex:selectedIndex]];
                                               //
        streetStr = [NSString stringWithFormat:@"%@",[streetIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)facingBtnTapped:(id)sender {

    fldType = @"Select Facing";

    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *facingArray;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        facingArray = [[[resultArray valueForKey:@"facing"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        facingArray = [[[resultArray valueForKey:@"facing"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


            facingIdArray = [[[resultArray valueForKey:@"facing"] valueForKey:@"values"] valueForKey:@"id"];

    if(facingArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Facing")
                                                rows:facingArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

  _facingFld.text=[NSString stringWithFormat:@"%@",[facingArray objectAtIndex:selectedIndex]];
                                               
        facingStr = [NSString stringWithFormat:@"%@",[facingIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}
- (IBAction)directionBtnTapped:(id)sender {

    fldType = @"Select Direction";

    //   NSLog(@"result Array %@",resultArray1);

    NSMutableArray  *directionArray;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        directionArray = [[[resultArray valueForKey:@"direction"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        directionArray = [[[resultArray valueForKey:@"direction"] valueForKey:@"values"] valueForKey:@"value_english"];
    }

    directionIdArray = [[[resultArray valueForKey:@"direction"] valueForKey:@"values"] valueForKey:@"id"];

    if(directionArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Direction")
                                                rows:directionArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

            _directionFld.text=[NSString stringWithFormat:@"%@",[directionArray objectAtIndex:selectedIndex]];
                                               
       directionStr = [NSString stringWithFormat:@"%@",[directionIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)generalBtnTapped:(id)sender {

    fldType = @"Select General";

    //   NSLog(@"result Array %@",resultArray1);

    NSMutableArray  *generalArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        generalArray = [[[resultArray valueForKey:@"general"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        generalArray = [[[resultArray valueForKey:@"general"] valueForKey:@"values"] valueForKey:@"value_english"];

    }

            generalIdArray = [[[resultArray valueForKey:@"general"] valueForKey:@"values"] valueForKey:@"id"];

    if(generalArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select General")
                                                rows:generalArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                _generalFld.text=[NSString stringWithFormat:@"%@",[generalArray objectAtIndex:selectedIndex]];
                                               //
        generalStr = [NSString stringWithFormat:@"%@",[generalIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)ageBtnTapped:(id)sender {

    fldType = @"Select Age";

    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *generalArray;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        generalArray = [[[resultArray valueForKey:@"age"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
       generalArray = [[[resultArray valueForKey:@"age"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


    ageIdarray = [[[resultArray valueForKey:@"age"] valueForKey:@"values"] valueForKey:@"id"];

    if(generalArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Age")
                                                rows:generalArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                    _ageFld.text=[NSString stringWithFormat:@"%@",[generalArray objectAtIndex:selectedIndex]];
                                               
         ageStr = [NSString stringWithFormat:@"%@",[ageIdarray objectAtIndex:selectedIndex]];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)charletsBtnTapped:(id)sender {

    fldType = @"Select Chalets";

    //   NSLog(@"result Array %@",resultArray1);
    
    NSMutableArray  *generalArray;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        generalArray = [[[resultArray valueForKey:@"chalets"] valueForKey:@"values"] valueForKey:@"value_arabic"];

    }
    else{
        generalArray = [[[resultArray valueForKey:@"chalets"] valueForKey:@"values"] valueForKey:@"value_english"];

    }


            chaletsIdArray = [[[resultArray valueForKey:@"chalets"] valueForKey:@"values"] valueForKey:@"id"];

    if(generalArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Chalets")
                                                rows:generalArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                _charletsFld.text=[NSString stringWithFormat:@"%@",[generalArray objectAtIndex:selectedIndex]];
                                               //
                                               charletStr = [NSString stringWithFormat:@"%@",[chaletsIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)rentalBtnTapped:(id)sender {

    fldType = @"Select Rental";

    //   NSLog(@"result Array %@",resultArray1);

    NSMutableArray  *generalArray;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        generalArray = [[[resultArray valueForKey:@"rental"] valueForKey:@"values"] valueForKey:@"value_arabic"];
    }
    else{
       generalArray = [[[resultArray valueForKey:@"rental"] valueForKey:@"values"] valueForKey:@"value_english"];
    }
    
    rentalIdArray = [[[resultArray valueForKey:@"rental"] valueForKey:@"values"] valueForKey:@"id"];

    if(generalArray.count>0){

        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Rental")
                                                rows:generalArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                                               _rentalFld.text=[NSString stringWithFormat:@"%@",[generalArray objectAtIndex:selectedIndex]];
                                               //
        rentalStr = [NSString stringWithFormat:@"%@",[rentalIdArray objectAtIndex:selectedIndex]];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)appupto9Photoestapped:(id)sender {

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
//
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
//
    #pragma mark- ImagePicker delegate

    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
        // UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        chosenImage = info[UIImagePickerControllerOriginalImage];

        infoData = UIImagePNGRepresentation(chosenImage);
        
        [imagesArray addObject:infoData];
        
//        NSLog(@"imagesArray Data %@",imagesArray);

        base64 = [infoData base64EncodedStringWithOptions:NSUTF8StringEncoding];
//        NSLog(@"base64 =%@",base64);

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
           // _nofileSlectedLbl.text = [imageRep filename];
        };

        // get the asset library and fetch the asset based on the ref url (pass in block above)
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];

        [picker dismissViewControllerAnimated:YES completion:NULL];
        
        self.photoesCollectionView.hidden = NO;
        
        [self.photoesCollectionView reloadData];
    }
//
//
//
#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;

    if (collectionView == _locationCollectionView) {

        return locArray.count;
    }
    else if (collectionView == _curbCollectionView) {

        return curbArray.count;
    }
    else if (collectionView == _facadeCollectionView){

        return facadeArray.count;
    }
    else if (collectionView == _finishingCollectionView){

        return finishingArray.count;
    }
    else if (collectionView == _conditionsCollectionView){

        return conditionsArray.count;
    }
    else if (collectionView == _addonsCollectionView){

        return addonsArray.count;
    }
    else if (collectionView == _photoesCollectionView){
        
        return imagesArray.count;
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == _locationCollectionView) {

        locationcheckCollectionViewCell *cell = [_locationCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [locArray objectAtIndex:indexPath.row];

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

                [filterContainStringad removeObject:[[[[resultArray valueForKey:@"location_2"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

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

                [filterContainStringad addObject:[[[[resultArray valueForKey:@"location_2"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

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
    }

    if (collectionView == _curbCollectionView) {

        locationcheckCollectionViewCell *cell = [_locationCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [curbArray objectAtIndex:indexPath.row];

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

                [curbContainStringad removeObject:[[[[resultArray valueForKey:@"curb_2"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];

                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];


                NSLog(@"filter contains string is %@",curbContainStringad);

                curbStr = [[NSMutableString alloc]init];

                NSString *appendStrig2 = @",";

                for (int i=0; i < curbContainStringad.count ; i++){

                    if(i<curbContainStringad.count-1)
                    {
                        [curbStr appendString:[NSString stringWithFormat:@"%@%@",[curbContainStringad objectAtIndex:i],appendStrig2]];

                    }
                    else
                    {
                        [curbStr appendString:[NSString stringWithFormat:@"%@",[curbContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",curbStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];

                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];

                [curbContainStringad addObject:[[[[resultArray valueForKey:@"curb_2"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                NSLog(@"filter contains string is %@",curbContainStringad);

                curbStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";

                for (int i=0; i < curbContainStringad.count ; i++){

                    if(i<curbContainStringad.count-1){

                        [curbStr appendString:[NSString stringWithFormat:@"%@%@",[curbContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [curbStr appendString:[NSString stringWithFormat:@"%@",[curbContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"curb Str is %@",curbStr);
            }
        };
        return cell;
    }

    if (collectionView == _facadeCollectionView) {

        locationcheckCollectionViewCell *cell = [_facadeCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [facadeArray objectAtIndex:indexPath.row];

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

                [facadeContainStringad removeObject:[[[[resultArray valueForKey:@"facade"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];

                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];


                NSLog(@"filter contains string is %@",facadeContainStringad);

                facadeStr = [[NSMutableString alloc]init];

                NSString *appendStrig2 = @",";

                for (int i=0; i < facadeContainStringad.count ; i++){

                    if(i<facadeContainStringad.count-1)
                    {
                        [facadeStr appendString:[NSString stringWithFormat:@"%@%@",[facadeContainStringad objectAtIndex:i],appendStrig2]];

                    }
                    else
                    {
                        [facadeStr appendString:[NSString stringWithFormat:@"%@",[facadeContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",facadeStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];

                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];

                [facadeContainStringad addObject:[[[[resultArray valueForKey:@"facade"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                NSLog(@"filter contains string is %@",facadeContainStringad);

                facadeStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";

                for (int i=0; i < facadeContainStringad.count ; i++){

                    if(i<facadeContainStringad.count-1){

                        [facadeStr appendString:[NSString stringWithFormat:@"%@%@",[facadeContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [facadeStr appendString:[NSString stringWithFormat:@"%@",[facadeContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",facadeStr);
            }
        };
        return cell;
    }

    if (collectionView == _finishingCollectionView) {

        locationcheckCollectionViewCell *cell = [_finishingCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [finishingArray objectAtIndex:indexPath.row];

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

                [finishingContainStringad removeObject:[[[[resultArray valueForKey:@"finishing"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];

                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];


                NSLog(@"filter contains string is %@",finishingContainStringad);

                finishStr = [[NSMutableString alloc]init];

                NSString *appendStrig2 = @",";

                for (int i=0; i < finishingContainStringad.count ; i++){

                    if(i<finishingContainStringad.count-1)
                    {
                        [finishStr appendString:[NSString stringWithFormat:@"%@%@",[filterContainStringad objectAtIndex:i],appendStrig2]];

                    }
                    else
                    {
                        [finishStr appendString:[NSString stringWithFormat:@"%@",[filterContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",finishStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];

                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];

                [finishingContainStringad addObject:[[[[resultArray valueForKey:@"finishing"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                NSLog(@"filter contains string is %@",filterContainStringad);

                finishStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";

                for (int i=0; i < finishingContainStringad.count ; i++){

                    if(i<finishingContainStringad.count-1){

                        [finishStr appendString:[NSString stringWithFormat:@"%@%@",[finishingContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [finishStr appendString:[NSString stringWithFormat:@"%@",[finishingContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",finishStr);
            }
        };
        return cell;
    }

    if (collectionView == _conditionsCollectionView) {

        locationcheckCollectionViewCell *cell = [_conditionsCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [conditionsArray objectAtIndex:indexPath.row];
        
     //   NSMutableDictionary *dic = [resultArray objectAtIndex:indexPath.row];

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

                [conditionContainStringad removeObject:[[[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];

                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];


                NSLog(@"filter contains string is %@",conditionContainStringad);

                conditionStr = [[NSMutableString alloc]init];

                NSString *appendStrig2 = @",";

                for (int i=0; i < conditionContainStringad.count ; i++){

                    if(i<conditionContainStringad.count-1)
                    {
                        [conditionStr appendString:[NSString stringWithFormat:@"%@%@",[conditionContainStringad objectAtIndex:i],appendStrig2]];

                    }
                    else
                    {
                        [conditionStr appendString:[NSString stringWithFormat:@"%@",[conditionContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",conditionStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];

                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];

                [conditionContainStringad addObject:[[[[resultArray valueForKey:@"conditions"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                NSLog(@"filter contains string is %@",conditionContainStringad);

                conditionStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";

                for (int i=0; i < conditionContainStringad.count ; i++){

                    if(i<conditionContainStringad.count-1){

                        [conditionStr appendString:[NSString stringWithFormat:@"%@%@",[conditionContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [conditionStr appendString:[NSString stringWithFormat:@"%@",[conditionContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",conditionStr);
            }
        };
        return cell;
    }
    if (collectionView == _addonsCollectionView) {

        locationcheckCollectionViewCell *cell = [_addonsCollectionView dequeueReusableCellWithReuseIdentifier:@"locationcheckCollectionViewCell" forIndexPath:indexPath];

        cell.titleLlb.text = [addonsArray objectAtIndex:indexPath.row];

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

                [addonsContainStringad removeObject:[[[[resultArray valueForKey:@"add_ons"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                [cell.checkBoxBtn setImage:[UIImage imageNamed:@"checkoff.png"] forState:UIControlStateNormal];

                cell.titleLlb.textColor = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];


                NSLog(@"filter contains string is %@",addonsContainStringad);

                addonStr = [[NSMutableString alloc]init];

                NSString *appendStrig2 = @",";

                for (int i=0; i < addonsContainStringad.count ; i++){

                    if(i<addonsContainStringad.count-1)
                    {
                        [addonStr appendString:[NSString stringWithFormat:@"%@%@",[addonsContainStringad objectAtIndex:i],appendStrig2]];

                    }
                    else
                    {
                        [addonStr appendString:[NSString stringWithFormat:@"%@",[addonsContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",addonStr);
            }
            else
            {
                [table addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];

                //  [filterContainStringad addObject:[locationArray objectAtIndex:indexPath.row]];

                [addonsContainStringad addObject:[[[[resultArray valueForKey:@"add_ons"] valueForKey:@"values"] valueForKey:@"id"] objectAtIndex:indexPath.row]];

                NSLog(@"filter contains string is %@",filterContainStringad);

                addonStr = [[NSMutableString alloc]init];
                NSString *appendStrig2 = @",";

                for (int i=0; i < addonsContainStringad.count ; i++){

                    if(i<addonsContainStringad.count-1){

                        [addonStr appendString:[NSString stringWithFormat:@"%@%@",[addonsContainStringad objectAtIndex:i],appendStrig2]];
                    }
                    else
                    {
                        [addonStr appendString:[NSString stringWithFormat:@"%@",[addonsContainStringad objectAtIndex:i]]];
                    }
                }

                NSLog(@"location Str is %@",addonStr);
            }
        };
        return cell;
    }
    
    if (collectionView == _photoesCollectionView) {
        
        HomeCollectionViewCell *cell = [_photoesCollectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
        
       cell.tradesImage.image = [UIImage imageWithData:[imagesArray objectAtIndex:indexPath.row]];
        
        cell.closeBtnTapped.tag = indexPath.row;
        
        [cell.closeBtnTapped addTarget:self action:@selector(deleteCellInCollectionViewAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
//        _addUptoLbl.text = [NSString stringWithFormat:@"%@ %@",Localized(@"You can add upto"),str];
        
        return cell;
    }
    return 0;
}

-(void)deleteCellInCollectionViewAtIndex:(UIButton *)sender{
    
    if (self.photoesCollectionView) {

        UIButton* button = (UIButton*)sender;
        
        CGRect buttonFrame =[button convertRect:button.bounds toView:_photoesCollectionView];
        
        NSIndexPath *indexPath = [_photoesCollectionView indexPathForItemAtPoint:buttonFrame.origin];

        [imagesArray removeObjectAtIndex:indexPath.row];
        [_photoesCollectionView reloadData];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{

}

-(void)shadow:(UITextField*)txtFld{

    txtFld.layer.cornerRadius = txtFld.frame.size.height/2-15;
    txtFld.clipsToBounds = false;
    txtFld.layer.shadowOpacity=0.2;
    txtFld.layer.shadowColor = [[UIColor blackColor] CGColor];
    txtFld.layer.shadowOffset =CGSizeMake(0, 2);
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _saleMobileFld) {
        
        NSInteger length = [_saleMobileFld.text length];
        if (length>7 && ![string isEqualToString:@""]) {
            return NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_saleMobileFld.text length]>7) {
                _saleMobileFld.text = [_saleMobileFld.text substringToIndex:8];
                
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

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    // [self.view endEditing:NO];
    [_saleMobileFld resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_saleMobileFld resignFirstResponder];
}



@end
