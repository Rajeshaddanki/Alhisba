//
//  Auctions1ViewController.m
//  Alhisba
//
//  Created by apple on 09/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "Auctions1ViewController.h"
#import "ExpandTableViewCell.h"
#import "TradesTableViewCell.h"
#import "JBWhatsAppActivity.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"



@interface Auctions1ViewController (){
    
    UIButton *menuBtn,*backBtn;
    NSMutableArray *tableArray;

}

@end

@implementation Auctions1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _venueValu.textAlignment = NSTextAlignmentCenter;
    _venueValu.textAlignment = NSTextAlignmentCenter;
    _auctionOrganizerValue.textAlignment = NSTextAlignmentCenter;
    _dateLbl.textAlignment = NSTextAlignmentCenter;
    _dateValue.textAlignment = NSTextAlignmentCenter;
    _venueLbl.textAlignment = NSTextAlignmentCenter;
    _venueValu.textAlignment = NSTextAlignmentCenter;
    _propertyArea.textAlignment = NSTextAlignmentCenter;
    _propertyTypeLbl.textAlignment = NSTextAlignmentCenter;
    _propertyTypeValue.textAlignment = NSTextAlignmentCenter;
    _propertListedLbl.textAlignment = NSTextAlignmentCenter;
    _propertListedValue.textAlignment = NSTextAlignmentCenter;
    _propertySoldLbl.textAlignment = NSTextAlignmentCenter;
    _propertySoldValue.textAlignment = NSTextAlignmentCenter;
    _propertyNotSoldLbl.textAlignment = NSTextAlignmentCenter;
    _propertyNotSoldVlaue.textAlignment = NSTextAlignmentCenter;
    _totalSaleLbl.textAlignment = NSTextAlignmentCenter;
    _totalSaleValue.textAlignment = NSTextAlignmentCenter;
    _propertyDescLbl.textAlignment = NSTextAlignmentCenter;
    _propertyDescValue.textAlignment = NSTextAlignmentCenter;
    _additionalInfoLbl.textAlignment = NSTextAlignmentCenter;
  //  self.navigationItem.title = Localized(@"Auctions");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
//    menuBtn = [[UIButton alloc] init];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"shareWhite.png"] forState:UIControlStateNormal];
//    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//     [menuBtn addTarget:self action:@selector(shareBtnTapped) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = backBarButtonItem;

    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _tradesTableView.hidden = YES;
    _propertyListBackBtn1.hidden = YES;
    tableArray = [NSMutableArray array];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
        
        _propertyAreaValue.textAlignment = NSTextAlignmentLeft;
        _additionalnfoValue.textAlignment = NSTextAlignmentLeft;


    }
    else{
        
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem1;
        
        _propertyAreaValue.textAlignment = NSTextAlignmentRight;
         _additionalnfoValue.textAlignment = NSTextAlignmentRight;
    }

    _auctionsView.layer.cornerRadius = 15.0f;
   // _auctionsView.layer.borderWidth = 5.0f;
    _backBtn.layer.cornerRadius = 10.0f;
    //_backBtn.layer.borderWidth = 5.0f;
    _propertyListBtn.layer.cornerRadius = 10.0f;
    //_propertyListBtn.layer.borderWidth = 5.0f;
    
    [_additionalnfoValue setTextAlignment:NSTextAlignmentCenter];
    
    [self listDetails];
    
    _auctionOrganizerLlb.text = Localized(@"Auction Organizer");
    _dateLbl.text = Localized(@"Date");
    _venueLbl.text = Localized(@"Venue");
    _propertyTypeLbl.text = Localized(@"Property Type");
    _propertyArea.text = Localized(@"Property Area");
    _propertListedLbl.text = Localized(@"Property Listed");
    _propertySoldLbl.text = Localized(@"Property Sold");
    _propertyNotSoldLbl.text = Localized(@"Property not Sold");
    _propertyDescLbl.text = Localized(@"Property Description");
    _additionalInfoLbl.text = Localized(@"Additional Information");
    _totalSaleLbl.text = Localized(@"Total Sale");
    _areaLbl.text = Localized(@"Area");
    _sizeLbl.text = Localized(@"Size M2");
    _additionalIfoLbl.text = Localized(@"Additional info");
    _startPrice.text = Localized(@"Start Price");
    _salePrice.text = Localized(@"Sale Price");

    [_areaLbl setTextAlignment:NSTextAlignmentCenter];
    [_sizeLbl setTextAlignment:NSTextAlignmentCenter];
    [_additionalIfoLbl setTextAlignment:NSTextAlignmentCenter];
    [_startPrice setTextAlignment:NSTextAlignmentCenter];
    [_salePrice setTextAlignment:NSTextAlignmentCenter];
    
    [_backBtn setTitle:Localized(@"Back") forState:UIControlStateNormal];
    [_propertyListBackBtn1 setTitle:Localized(@"Back") forState:UIControlStateNormal];
    
    [_propertyListBtn setTitle:Localized(@"Properties List") forState:UIControlStateNormal];
    
    [_additionalIfoLbl setTextAlignment:NSTextAlignmentCenter];
    
    [_tradesTableView reloadData];
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"MOJ- Auction Summary");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel.backgroundColor = [UIColor clearColor];
    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel sizeToFit];
    UIImage *image = [UIImage imageNamed: @"badge.png"];
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
    
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"MOJ- Auction Summary") :sender];
}

-(void)badgeInfoBtnTapped:(id)sender{
    
    [self showInfo:Localized(@"MOJ- Auction Summary") :sender];
}

-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"AUCTIONS RESULT SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

-(void)shareBtnTapped{
    
    UIImage *imageToShare = [self captureView:_auctionsView inSize:_auctionsView.frame.size];
    
    
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

-(void)backBtnTapped{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)listDetails{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        _auctionOrganizerValue.text = [[_auctionList valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
      
        _organizerTelephoneNo.text = [[_auctionList valueForKey:@"organiser"] valueForKey:@"organiser_phone"];
        
        NSLog(@"Organizes Values %@",[_auctionList valueForKey:@"organiser"]);
        
        _dateValue.text = [_auctionList valueForKey:@"event_date"];
        _venueValu.text = [_auctionList valueForKey:@"venue_arabic"];
        _propertyTypeValue.text = [[_auctionList valueForKey:@"properties"][0] valueForKey:@"value_arabic"];
        NSMutableArray *arr= [_auctionList valueForKey:@"areas"];
        NSString *str = @"";
        for (int i=0; i<arr.count; i++) {
            if(str.length==0){
                str = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] valueForKey:@"value_arabic"]];
                
            }else{
                str = [NSString stringWithFormat:@"%@,%@",str,[[arr objectAtIndex:i] valueForKey:@"value_arabic"]];
            }
        }
        
        
        if ([_fromProp isEqualToString:@"fromPop"]) {
            
           
            [_auctionImageView setImageWithURL:[[NSUserDefaults standardUserDefaults]valueForKey:@"popImage"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [_auctionImage1 setImageWithURL:[[NSUserDefaults standardUserDefaults]valueForKey:@"popImage"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
        }
        else{
            
            [_auctionImageView setImageWithURL:[_auctionList valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [_auctionImage1 setImageWithURL:[_auctionList valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

            
        }
        
       
        
        _auctionImageView.layer.cornerRadius = 10.0f;
        _auctionImageView.layer.masksToBounds = YES;
        
        _auctionImage1.layer.cornerRadius = 10.0f;
        _auctionImage1.layer.masksToBounds = YES;
        
        NSLog(@"Auctions Image %@",[_auctionList valueForKey:@"image"]);

        _propertyAreaValue.text = str;
        _propertListedValue.text = [_auctionList valueForKey:@"num_properties_listed"];
        _propertySoldValue.text = [_auctionList valueForKey:@"num_properties_sold"];
        _propertyNotSoldVlaue.text = [_auctionList valueForKey:@"num_properties_Notsold"];
        _totalSaleValue.text = [_auctionList valueForKey:@"total_sale"];
        _propertyDescValue.text = [_auctionList valueForKey:@"event_description_arabic"];
        _additionalnfoValue.text = [_auctionList valueForKey:@"event_additionalInfo_arabic"];
    }
    else{
        _auctionOrganizerValue.text = [[_auctionList valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
        
        _organizerTelephoneNo.text = [[_auctionList valueForKey:@"organiser"] valueForKey:@"organiser_phone"];
        
        NSLog(@"Organizes Values %@",[_auctionList valueForKey:@"image"]);

        
        if ([_fromProp isEqualToString:@"fromPop"]) {
            
            
            [_auctionImageView setImageWithURL:[[NSUserDefaults standardUserDefaults]valueForKey:@"popImage"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [_auctionImage1 setImageWithURL:[[NSUserDefaults standardUserDefaults]valueForKey:@"popImage"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        else{
            
            [_auctionImageView setImageWithURL:[_auctionList valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [_auctionImage1 setImageWithURL:[_auctionList valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            
        }

        NSLog(@"Auctions Image %@",[_auctionList valueForKey:@"image"]);
        
        _auctionImageView.layer.cornerRadius = 10.0f;
        _auctionImageView.layer.masksToBounds = YES;
        
        _auctionImage1.layer.cornerRadius = 10.0f;
        _auctionImage1.layer.masksToBounds = YES;
        
        _dateValue.text = [_auctionList valueForKey:@"event_date"];
        _venueValu.text = [_auctionList valueForKey:@"venue_english"];
        _propertyTypeValue.text = [[_auctionList valueForKey:@"properties"][0] valueForKey:@"value_english"];
//        _propertyArea.text = [[_auctionList valueForKey:@"areas"][0] valueForKey:@"value_english"];
        NSMutableArray *arr= [_auctionList valueForKey:@"areas"];
        NSString *str = @"";
        for (int i=0; i<arr.count; i++) {
            if(str.length==0){
                str = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] valueForKey:@"value_english"]];

            }else{
            str = [NSString stringWithFormat:@"%@,%@",str,[[arr objectAtIndex:i] valueForKey:@"value_english"]];
            }
        }
        _propertyAreaValue.text = [NSString stringWithFormat:@"%@",str];
        _propertListedValue.text = [_auctionList valueForKey:@"num_properties_listed"];
        _propertySoldValue.text = [_auctionList valueForKey:@"num_properties_sold"];
        _propertyNotSoldVlaue.text = [_auctionList valueForKey:@"num_properties_Notsold"];
        _totalSaleValue.text = [_auctionList valueForKey:@"total_sale"];
        _propertyDescValue.text = [_auctionList valueForKey:@"event_description_english"];
        _additionalnfoValue.text = [_auctionList valueForKey:@"event_additionalInfo_english"];
    }
}

- (IBAction)backBtnTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)propertyBtnTapped:(id)sender {
    
    _backGroundView.hidden = NO;
    _priceListView.hidden = NO;
    _titleLbl.hidden = NO;
    _tradesTableView.hidden = NO;
    _propertyListBackBtn1.hidden = NO;
    [_tradesTableView reloadData];
}


// .......


#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tradesTableView) {
        
        return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,_popUpList1.count);
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tradesTableView) {
        
        NSIndexPath * adjustedIndexPath = [self.tradesTableView adjustedIndexPathFromTable:indexPath];
        
        if ([self.tradesTableView.expandedContentIndexPath isEqual:indexPath])
        {
            static NSString *CellIdentifier = @"expandedCell";
            
            ExpandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSMutableDictionary *dic = [_popUpList1 objectAtIndex:indexPath.row-1];
            
            if ([tableArray containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
            {
                //   [shopCell.checkBtn setImage:[UIImage imageNamed:@"Sortchecked.png"] forState:UIControlStateNormal];
            }
            else
            {
                //  [shopCell.checkBtn setImage:[UIImage imageNamed:@"Sortuncheck.png"] forState:UIControlStateNormal];
            }
            
            [cell.propertyTypeLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.propertyTypeTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.notesLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.notesTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.percentageLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.percentageTitle setTextAlignment:NSTextAlignmentCenter];
            
            cell.propertyTypeLbl.text = Localized(@"Status");
            cell.notesLbl.text = Localized(@"Premium");
            cell.percentageLbl.text = Localized(@"M2");
            cell.m2Lbl.text = Localized(@"M2");
            
            if (adjustedIndexPath.row % 2) {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
                
            } else {
                
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                cell.propertyTypeTitle.text = [NSString stringWithFormat:@"%@",Localized([dic valueForKey:@"status"])];
                //                cell.notesTitle.text = [self decodeHTMLString:[dic valueForKey:@"notes_english"]];
                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"starting_price_per_sqr_meter"]];
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.bloackValue.text = [dic valueForKey:@"block"];
                cell.residentialValue.text = [[dic valueForKey:@"property_type"] valueForKey:@"value_arabic"];
                cell.m2Value.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"sale_price_per_sqr_meter"]];
            }
            else{
                cell.propertyTypeTitle.text = [NSString stringWithFormat:@"%@",Localized([dic valueForKey:@"status"])];
                //                cell.notesTitle.text = [self decodeHTMLString:[dic valueForKey:@""]];
                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"starting_price_per_sqr_meter"]];
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.bloackValue.text = [dic valueForKey:@"block"];
                
                cell.residentialValue.text = [[dic valueForKey:@"property_type"] valueForKey:@"value_english"];
                cell.m2Value.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"sale_price_per_sqr_meter"]];
            }
            return cell;
        }
        
        else{
            
            static NSString *MyIdentifier = @"TradesTableViewCell";
            
            TradesTableViewCell *cell = [_tradesTableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
            dic=[_popUpList1 objectAtIndex:adjustedIndexPath.row];
            
            [cell.tradesDate setTextAlignment:NSTextAlignmentCenter];
            [cell.tradesDate setClipsToBounds:YES];
            [cell.tradesDate.layer setCornerRadius:5.0f];
            cell.tradesDate.layer.backgroundColor=[UIColor whiteColor].CGColor;
            
            [cell.descriptionTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.sizePrice setTextAlignment:NSTextAlignmentCenter];
            [cell.priceInKd setTextAlignment:NSTextAlignmentCenter];
            [cell.priceM2 setTextAlignment:NSTextAlignmentCenter];
            [cell.title setTextAlignment:NSTextAlignmentCenter];
            
            if (adjustedIndexPath.row % 2) {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
                
            } else {
                
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                cell.sizePrice.text = [dic valueForKey:@"size"];
                cell.descriptionTitle.text = [dic valueForKey:@"additional_info_arabic"];
                cell.priceInKd.text = [dic valueForKey:@"starting_price"];
                cell.priceM2.text = [dic valueForKey:@"sale_price"];
                cell.title.text = [[dic valueForKey:@"property_area_id"] valueForKey:@"value_arabic"];
                cell.plotValue.text = [NSString stringWithFormat:@"%@: %@",Localized(@"Plot:"),[dic valueForKey:@"plot_number"]];
            }
            else{
                cell.sizePrice.text = [dic valueForKey:@"size"];
                cell.descriptionTitle.text = [dic valueForKey:@"additional_info_english"];
                cell.priceInKd.text = [dic valueForKey:@"starting_price"];
                cell.priceM2.text = [dic valueForKey:@"sale_price"];
                cell.title.text = [[dic valueForKey:@"property_area_id"] valueForKey:@"value_english"];
                cell.plotValue.text = [NSString stringWithFormat:@"%@: %@",Localized(@"Plot:"),[dic valueForKey:@"plot_number"]];
            }
            
            [cell.plotValue setTextAlignment:NSTextAlignmentCenter];
            
            return cell;
        }
    }
    else{
        
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tradesTableView) {
        
        if ([indexPath isEqual:self.tradesTableView.expandedContentIndexPath])
        {
            return 170.0f;
        }
        else
            return 65.0f;
    }
    else{
        return 0;
    }
}

#pragma mark JNExpandableTableView DataSource
- (BOOL)tableView:(JNExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
    if ([tableArray containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
    {
        [tableArray removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
    }
    else
    {
        [tableArray addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
    }
    
    return YES;
}
- (void)tableView:(JNExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath
{
    
    NSLog(@"Will Expand: %@",indexPath);
}
- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    NSLog(@"Will Collapse: %@",indexPath);
}

- (IBAction)propertyListBackBtnTapped:(id)sender {
    
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _propertyListBackBtn1.hidden = YES;
    _tradesTableView.hidden = YES;
}


@end
