//
//  instantValueEstimator1ViewController.m
//  Alhisba
//
//  Created by apple on 10/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "instantValueEstimator1ViewController.h"
#import "JBWhatsAppActivity.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "RentCollectionViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "OfficialApraisalViewController.h"


@interface instantValueEstimator1ViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UIButton *menuBtn,*backBtn;
    NSMutableArray *addsArray;
}

@end

@implementation instantValueEstimator1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scollView.delegate = self;
    
    self.navigationItem.title = Localized(@"Instant Value Estimator");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName,nil];
    
    //let label = PaddingLabel(8, 8, 16, 16)

//    _propertySpecificationLbl.layer.position = CGPointMake(16, _propertySpecificationLbl.frame.origin.y);
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"Share.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
     [menuBtn addTarget:self action:@selector(shareBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
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
    
    
     if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
         
         [_landSpecsTitle setTextAlignment:NSTextAlignmentLeft];
         [_plotSpecsTitles setTextAlignment:NSTextAlignmentLeft];
         [_facingSpecsTitles setTextAlignment:NSTextAlignmentLeft];
     }
     else{
         [_landSpecsTitle setTextAlignment:NSTextAlignmentRight];
         [_plotSpecsTitles setTextAlignment:NSTextAlignmentRight];
         [_facingSpecsTitles setTextAlignment:NSTextAlignmentRight];
     }
    
    _topView.layer.cornerRadius = 15.0f;
//    _previewPop.layer.cornerRadius = 15.0f;
    
    
    _landValueView.layer.cornerRadius = 15.0f;
    _landValueView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _bannerImage.layer.cornerRadius = 15.0f;
    _bannerImage.layer.masksToBounds = YES;
    
    _propertyValueView.layer.cornerRadius = 15.0f;

    _estimatedPriceValue.layer.cornerRadius = 15.0f;
    _estimatedPriceValue.layer.masksToBounds = YES;
    
    _clickHereOfficialBtn.layer.cornerRadius = 15.0f;
    _clickHereOfficialBtn.layer.masksToBounds = YES;
    
    [_clickHereOfficialBtn setTitle:Localized(@"Click here for an Official evaluation") forState:UIControlStateNormal];

    [_lastUpdateonLbl setTextAlignment:NSTextAlignmentCenter];
    
    [_estimatedPriceValue setTextAlignment:NSTextAlignmentCenter];
    
    NSLog(@"area title is %@",_areaTitle1);
    
    
    [_landSpecsTitle  setFont: [UIFont fontWithName:@"Cairo-SemiBold" size:16]];
    [_plotSpecsTitles  setFont: [UIFont fontWithName:@"Cairo-SemiBold" size:16]];
    [_facingSpecsTitles  setFont: [UIFont fontWithName:@"Cairo-SemiBold" size:16]];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_propertyValueView.bounds];
    _propertyValueView.layer.masksToBounds = NO;
    _propertyValueView.layer.shadowColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0f].CGColor;
    _propertyValueView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    _propertyValueView.layer.shadowOpacity = 0.3f;
    _propertyValueView.layer.shadowPath = shadowPath.CGPath;

    
    _areaTitle.text = _areaTitle1.length>0?[NSString stringWithFormat:@"%@",_areaTitle1]:Localized(@"NA");
    
    _preViewArea.text = _areaTitle1.length>0?[NSString stringWithFormat:@"%@",_areaTitle1]:Localized(@"NA");
    
    _landSizeTitle.text = _landSizeTitle1.length>0?[NSString stringWithFormat:@"%@",_landSizeTitle1]:Localized(@"NA");
    _streetTitle.text = _streetTitle1.length>0?[NSString stringWithFormat:@"%@",_streetTitle1]:Localized(@"NA");
    _locationTitle.text =_locationTitle1.length>0?[NSString stringWithFormat:@"%@",_locationTitle1]:Localized(@"NA");
    _buildingAgeTitle.text = _buildingAgeTitle1.length>0?[NSString stringWithFormat:@"%@",_buildingAgeTitle1]:Localized(@"NA");
    _finishingQualityTitle.text = _finishingQualityTitle1.length>0?[NSString stringWithFormat:@"%@",_finishingQualityTitle1]:Localized(@"NA");
    _basementTitle.text = _basementTitle1.length>0?[NSString stringWithFormat:@"%@",_basementTitle1]:Localized(@"NA");
    _noOffloorsTitle.text = _noOffloorsTitle1.length>0?[NSString stringWithFormat:@"%@",_noOffloorsTitle1]:Localized(@"NA");
   _seaFrontTitle.text = @"NA";
    _backStreetTitle.text = @"NA";
   _directionTitle.text = _directionTitle1.length>0?[NSString stringWithFormat:@"%@",_directionTitle1]:Localized(@"NA");
   _curbTitle.text = _curbTitle1.length>0?[NSString stringWithFormat:@"%@",_curbTitle1]:Localized(@"NA");
   _estimateValue.text =_estimatedPriceValue1.length>0?[NSString stringWithFormat:@"%@",_estimatedPriceValue1]:Localized(@"NA");
    _landValue.text = _landValue1.length>0?[NSString stringWithFormat:@"%@",_landValue1]:Localized(@"NA");
    
    
    if ([_landSpecsTitle1 length] == 0){
     
        _landSpecsTitle1 =Localized(@"NA");
    }
    if ([_plotSpecsTitles1 length]==0){
      
        _plotSpecsTitles1 = Localized(@"NA");
    }
    if ([_facingSpecsTitles1 length]==0){
        
       _facingSpecsTitles1 =Localized(@"NA");
    }
    
    _buildingValue.text = [NSString stringWithFormat:@"%@",_buildingValue1];
    _landSpecsTitle.text = [NSString stringWithFormat:@"%@",_landSpecsTitle1];
    _plotSpecsTitles.text = [NSString stringWithFormat:@"%@",_plotSpecsTitles1];
   _facingSpecsTitles.text = [NSString stringWithFormat:@"%@",_facingSpecsTitles1];
    
    [self settextAlignment:_estimatedPriceValue];
    [self settextAlignment:_areaTitle];
    [self settextAlignment:_landSizeTitle];
    [self settextAlignment:_streetTitle];
    [self settextAlignment:_locationTitle];
    [self settextAlignment:_buildingAgeTitle];
    [self settextAlignment:_finishingQualityTitle];
    [self settextAlignment:_basementTitle];
    [self settextAlignment:_noOffloorsTitle];
    [self settextAlignment:_seaFrontTitle];
    [self settextAlignment:_backStreetTitle];
    [self settextAlignment:_directionTitle];
    [self settextAlignment:_curbTitle];
    
    [self settextAlignment:_previewAreaLbl];
    [self settextAlignment:_previewLandSizeLbl];
    [self settextAlignment:_previewstreetLbl];
    [self settextAlignment:_previewLocationLbl];
    [self settextAlignment:_previewbuildingAgeLbl];
    [self settextAlignment:_previewfinishingQuali];
    [self settextAlignment:_previewbasementLlb];
    [self settextAlignment:_previewnoOfFloors];
    [self settextAlignment:_previewSeaFrontLbl];
    [self settextAlignment:_previewbackStreetLenght];
    [self settextAlignment:_previewDirectionLbl];
    [self settextAlignment:_previewCurbFld];
   // [self settextAlignment:_previewDetailsLbl];
    [self settextAlignment:_totalProperty];
    [self settextAlignment:_estimateValue];

    [_scollView setShowsVerticalScrollIndicator:YES];
    
    //_lastUpdateonLbl.text = [NSString stringWithFormat:@"%@ %@",Localized(@"Area values were last update on:"),_date];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",Localized(@"Area values were last update on:"),_date]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(string.length-_date.length, _date.length)];
    
//    _lastUpdateonLbl.attributedText = string;
    
    _lastUpdateonLbl.text = Localized(@"Area values were last update on:");
    
    _dateLbl.text = [NSString stringWithFormat:@"%@",_date];
    
    [_lastUpdateonLbl setFont:[UIFont boldSystemFontOfSize:18]];

    _totalProperty.text = Localized(@"Total Property Value");
    _landValueLbl.text = Localized(@"Land Value");
    _buildingValueLbl.text = Localized(@"Building Value");
    _previewAreaLbl.text = Localized(@"Area");
    _previewLandSizeLbl.text = Localized(@"Land Size(Sqm)");
    _previewstreetLbl.text = Localized(@"Street");
    _previewLocationLbl.text = Localized(@"Location");
    _previewbuildingAgeLbl.text = Localized(@"Building Age");
    _previewfinishingQuali.text = Localized(@"Finishing Quality");
    _previewbasementLlb.text = Localized(@"Basement");
    _previewnoOfFloors.text = Localized(@"No of floors");
    _previewSeaFrontLbl.text = Localized(@"Sea Front Lengths");
    _previewbackStreetLenght.text = Localized(@"Back Street Lengths");
    _previewDirectionLbl.text = Localized(@"Direction");
    _previewCurbFld.text = Localized(@"Curb");
    _previewDetailsLbl.text = Localized(@"Property Description");
    _propertySpecificationLbl.text = Localized(@"Property Specifications");
    _facingSpecLbl.text = Localized(@"Facing");
    _locationSpecLbl.text = Localized(@"Location Specs");
    _plotSpecLbl.text = Localized(@"Plot Specs");
    _shareResultLbl.text = Localized(@"Share result");
    _descTxtView.text = Localized(@"* Hesba instant is the rating * is one of th eservice provided by Al Hesba Real Estate application in order to give the user of th eapplication only an indicative estimate value.");
    
    [_descTxtView setTextAlignment:NSTextAlignmentCenter];
    
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];
    
    [_relatedCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    [_relatedCollectionView reloadData];
    [self updateCellsLayout];
    
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
    
    [self showHUD:@""];
    [self makePostCallForPage:ADDS withParams:@{@"type":@"1"} withRequestCode:15];
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    addsArray = result;
    [self.relatedCollectionView reloadData];
    [self hideHUD];
}


- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"INSTANTVALUE ESTIMATOR RESULT SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
-(void)shareBtnTapped{
    
//    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:[NSString stringWithFormat:@"%@",_estimatedPriceValue1] forABID:@"Alhisba"];
//
//    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
//    NSArray *excludedActivities    = @[UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeMessage];
//    NSArray *activityItems         = @[[NSString stringWithFormat:@"%@",_estimatedPriceValue1], whatsappMsg];
//
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
//    activityViewController.excludedActivityTypes = excludedActivities;
//
//    [self presentViewController:activityViewController animated:YES completion:^{}];
    
    
    UIImage *imageToShare = [self captureView:_sharedView inSize:_sharedView.frame.size];
    
    
    NSMutableArray *activityItems = [NSMutableArray arrayWithObjects: imageToShare, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[
                                                     UIActivityTypePrint,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypeSaveToCameraRoll,
                                                     UIActivityTypeAddToReadingList,
                                                     UIActivityTypeAirDrop];
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    //get refrence of vertical indicator
    UIImageView *verticalIndicator = ((UIImageView *)[_scollView.subviews objectAtIndex:(_scollView.subviews.count-1)]);
    //set color to vertical indicator
    [verticalIndicator setBackgroundColor:[UIColor yellowColor]];
    
    [super viewWillLayoutSubviews];
    [self updateCellsLayout];

}


-(void)backBtnTapped{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)settextAlignment:(UILabel *)label{
    
    [label setTextAlignment:NSTextAlignmentCenter];
}


- (IBAction)clickhereOfficialBtnTapped:(id)sender {
    
    OfficialApraisalViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficialApraisalViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}


#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        RentCollectionViewCell *cell = [self.relatedCollectionView dequeueReusableCellWithReuseIdentifier:@"RentCollectionViewCell" forIndexPath:indexPath];
        
        //    cell.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
        //        cell.layer.borderWidth= 2.0f;
        //        cell.layer.cornerRadius = 15.0f;
        //        cell.layer.masksToBounds= YES;
        
        cell.areaTitleBackView.layer.cornerRadius = 15.0f;
        cell.areaTitleBackView.layer.masksToBounds = YES;
    
        cell.contentView.layer.cornerRadius = 15.0f;
        cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 0.5f;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    NSMutableDictionary *dic = [addsArray objectAtIndex:indexPath.row];
    
    [cell.salesImage setImageWithURL:[dic valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSString *st = [dic valueForKey:@"price_1"];
    
  //  cell.priceLbl.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%0.2f %@", st.floatValue,Localized(@"KD")]];
    
    cell.priceLbl.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%0.2f", st.floatValue]];
    
    cell.areaSizeLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"plot_size"]];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];
        
        cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_arabic"];
     
        cell.areaTitleLbl.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];
    }
    else{
        cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_english"];
        
        cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_english"];
        
        cell.areaTitleLbl.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];

    }
    
    cell.kuwaitDinarLbl.text = Localized(@"Kuwait Dinar");
    cell.areaSize.text = Localized(@"Area Size");
    cell.bathroomLbl.text = Localized(@"Bathrooms");
    
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
    CGSize cellSize = collectionView.bounds.size;
    cellSize.width -= collectionView.contentInset.left * 2;
    cellSize.width -= collectionView.contentInset.right * 2;
    //cellSize.width = collectionView.frame.size.width-120;
    cellSize.height = 330;
    // cellSize.height = 200+160;
    return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  
        return 0;
}

-(void)updateCellsLayout{
    float centerX =_relatedCollectionView.contentOffset.x+(self.view.frame.size.width)/2;
    NSArray *arr =[_relatedCollectionView visibleCells];
    for (UICollectionViewCell *cell in arr){
        
        float offsetX = centerX-cell.center.x;
        if(offsetX<0){
            offsetX*=-1;
        }
        cell.transform = CGAffineTransformIdentity;
        float offsetPercentage = offsetX/(self.view.bounds.size.width*5);
        float scaleX = 1-offsetPercentage;
        
        cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleX);
    }
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self updateCellsLayout];
}

@end
