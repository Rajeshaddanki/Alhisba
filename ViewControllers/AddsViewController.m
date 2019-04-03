
//  AddsViewController.m
//  Alhisba
//  Created by Apple on 08/03/19.
//  Copyright © 2019 Apple. All rights reserved.

#import "AddsViewController.h"
#import "AddsCollectionViewCell.h"
#import "AddsDetailsViewController.h"
#import "PostAddViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SVProgressHUD.h"
#import "PostAddViewController.h"
#import "AddsDetailsViewController.h"
#import "ActionSheetStringPicker.h"
#import "CalendarViewController.h"
#import "CalendarViewController1.h"


@interface AddsViewController ()<UISearchBarDelegate>{
    
    UIButton *backBtn,*postAdd,*shareBtn;
    NSMutableArray *lastArray,*areaArray,*areaIdArray,*propertyIdArray;
    NSString *areaStr,*typeStr,*propertyStr;
    UIBarButtonItem *negativeSpacer;
}

@end

@implementation AddsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"Adds")];
    
    _coverView.hidden = YES;
    _advancedView.hidden = YES;
    _noAddsLbl.hidden = YES;
    
    typeStr = @"1";
    
    _advancedBtn.layer.cornerRadius = 10;
    _advancedBtn.clipsToBounds = YES;
    _advancedBtn.layer.borderWidth = 2.0f;
    _advancedBtn.layer.borderColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1].CGColor;
    [_advancedBtn.titleLabel setTextAlignment:UITextAlignmentCenter];

    _clearBtn.layer.cornerRadius = 10;
    _clearBtn.clipsToBounds = YES;
    [_clearBtn.titleLabel setTextAlignment:UITextAlignmentCenter];

    _advancedSearchBtn.layer.cornerRadius = 10;
    _advancedSearchBtn.clipsToBounds = YES;
    [_advancedSearchBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
    
    _advancedView.layer.cornerRadius = 10;
    _advancedView.clipsToBounds = YES;

    
    _searchLbl.text= Localized(@"Search");
    [_advancedBtn setTitle:Localized(@"Advanced") forState:UIControlStateNormal];
    
    UIColor *color = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    _priceTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price") attributes:@{NSForegroundColorAttributeName: color}];
    

    _searchBa.placeholder = Localized(@"Search");
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
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
    
    postAdd = [[UIButton alloc] init];
    //    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    postAdd.frame = CGRectMake(0, 0, 100, 10);
    [postAdd addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [postAdd setTitle:Localized(@"+ Ad") forState:UIControlStateNormal];
    [postAdd.widthAnchor constraintEqualToConstant:90].active = YES;
    [postAdd.heightAnchor constraintEqualToConstant:35].active = YES;
    
    //    [postAdd.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:15.0]];
    //    [postAdd.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [postAdd.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:40.0f]];
    
    [postAdd setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    [postAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    postAdd.layer.cornerRadius = 5.0f;
    postAdd.clipsToBounds = YES;
    postAdd.layer.masksToBounds = YES;
    //    [postAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:postAdd];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem1;
    
    
    negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    [negativeSpacer setWidth:-10];

    
    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"Share.png"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(0, 0, 20, 20);
//    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem1,customBarRightBtn,nil];
    self.navigationItem.title = Localized(@"Adds");
    
// label
//    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
//    tmpTitleLabel.text = Localized(@"Adds");
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
    
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.searchBa.inputAccessoryView = keyboardToolbar;
    
//    lastArray = [[NSMutableArray alloc] initWithObjects:@"vfrv",@"vgrt",@"lrkemt",@"vrve",@"teve",@"vteve",@"vet",@"bvet",@"eve",@"ebve", nil];
    
//    [self showHUD:@""];
    
//    [self makePostCallForPage:ADDS withParams:@{@"type":@"1"} withRequestCode:1];
    
    [self showHUD:@""];
    
    [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];

}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{

    if (reqeustCode == 1) {
        
        lastArray =result;
        
        if ([lastArray count]==0) {
            _noAddsLbl.hidden = NO;
        }else{
            
            _noAddsLbl.hidden = YES;
            [self.addCollectionView reloadData];
        }
        _coverView.hidden = YES;
        _advancedView.hidden = YES;

        [self showHUD:@""];
        [self makePostCallForPage:ADD_CATEG withParams:@{} withRequestCode:10];

    }
    else if (reqeustCode == 10) {
        
        areaArray = result;
        [self hideHUD];
    }
    else{
        
    }
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Adds") :sender];
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;
    
    return lastArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        AddsCollectionViewCell *cell = [self.addCollectionView dequeueReusableCellWithReuseIdentifier:@"AddsCollectionViewCell" forIndexPath:indexPath];
        
//        cell.cellBackView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f].CGColor;
//        cell.cellBackView.layer.borderWidth = 2;
//        cell.cellBackView.layer.cornerRadius = 15; // optional
    
   // NSMutableDictionary *dic = [lastArray objectAtIndex:indexPath.row];
    
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    cell.layer.borderWidth= 5.0f;
    cell.layer.cornerRadius = 10.0f;
    cell.layer.masksToBounds= YES;
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 5.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSMutableDictionary *dic = [lastArray objectAtIndex:indexPath.row];
    
    NSLog(@"index is %d",index.intValue);
    
    if( index.intValue == lastArray.count-1){
        
        cell.addTitle.text = [NSString stringWithFormat:@"%@", Localized(@"Add Ad")];
        cell.addsSubtitle.text = @"";
//        [cell.addsImage setImageWithURL:[lastArray valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        cell.addsMainTitle.hidden = YES;
        cell.addTitle.hidden = NO;
        [cell.addsImage setImageWithURL:[dic valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

        cell.addTitle.textAlignment = NSTextAlignmentCenter;
        
        cell.addTitle.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f  alpha:1.0f];
        
        cell.addsSubtitle.hidden = YES;
        cell.addsImage.hidden = YES;
        cell.plusBtn.hidden = NO;
        
       [cell.addTitle setFont:[UIFont fontWithName:@"Cairo-SemiBold" size:20]];

        cell.contentView.layer.cornerRadius = 10.0f;
        cell.contentView.layer.borderWidth = 2.0f;
        cell.contentView.layer.borderColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f].CGColor;
        cell.contentView.layer.masksToBounds = YES;

    }
    else{
//        cell.addsMainTitle.text = [lastArray objectAtIndex:indexPath.row];
        cell.addsSubtitle.hidden = NO;
        cell.addsImage.hidden = NO;
        cell.plusBtn.hidden = YES;
        
        cell.addsMainTitle.hidden = NO;
        cell.contentView.layer.cornerRadius = 10.0f;
        cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            cell.addsMainTitle.text = [[[lastArray valueForKey:@"area_id"] valueForKey:@"value_arabic"] objectAtIndex:indexPath.row];
            cell.addsSubtitle.text = [[[lastArray valueForKey:@"property_type_id"] valueForKey:@"value_arabic"] objectAtIndex:indexPath.row];
        }
        else{
            cell.addsMainTitle.text = [[[lastArray valueForKey:@"area_id"] valueForKey:@"value_english"] objectAtIndex:indexPath.row];
            cell.addsSubtitle.text = [[[lastArray valueForKey:@"property_type_id"] valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        }
        
        
        cell.addTitle.hidden = YES;
        
        [cell.addsImage setImageWithURL:[dic valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    }
    
    [cell.plusBtn addTarget:self action:@selector(plusBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
  
//        cell.cellBackView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.5f];

//
      //  [cell.addsMainTitle setTextAlignment:NSTextAlignmentCenter];
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
//        dic = [lastArray objectAtIndex:indexPath.row];

     //   cell.addsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tradesImageArray objectAtIndex:indexPath.row]]];
//
//
  //      [cell.addsMainTitle setTextAlignment:NSTextAlignmentCenter];
    
        return cell;
}

-(void)plusBtnTapped{
 
    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
    [self.navigationController pushViewController:obj animated:YES];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    NSLog(@"index is %d",index.intValue);
    
    if( index.intValue == lastArray.count-1){
        
        PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
        [self.navigationController pushViewController:obj animated:YES];
        

    }
    else{
        
    AddsDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsDetailsViewController"];
        obj.detailsArray = [lastArray objectAtIndex:indexPath.row];
        NSLog(@"details Array is %@",obj.detailsArray);
    [self.navigationController pushViewController:obj animated:YES];

    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-16, 220);
}


//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//        return 15;
//}

- (IBAction)searchBtnTapped:(id)sender {
    
    //   NSLog(@"result Array %@",resultArray1);
    NSMutableArray  *areaArray1;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        areaArray1 = [[[areaArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"value_arabic"];
        
    }
    else{
        areaArray1 = [[[areaArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"value_english"];
        
    }
    
    areaIdArray = [[[areaArray valueForKey:@"area"] valueForKey:@"values"] valueForKey:@"id"];
    
    if(areaArray.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                rows:areaArray1
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                    self->_searchLbl.text=[NSString stringWithFormat:@"%@",[areaArray1 objectAtIndex:selectedIndex]];
                                               
                areaStr = [NSString stringWithFormat:@"%@",[areaIdArray objectAtIndex:selectedIndex]];
                                               
                
                                               [self showHUD:@""];
                                               
                                               [self makePostCallForPage:ADDS withParams:@{@"type":typeStr,@"area_id":areaStr} withRequestCode:1];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (IBAction)advancedBtnTapped:(id)sender {
    
    _coverView.hidden = NO;
    _advancedView.hidden = NO;
}

- (IBAction)segmentTouchIns:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"First was selected");
            typeStr = @"1";
            
            [self showHUD:@""];
            
            [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];

            break;
        case 1:
            NSLog(@"Second was selected");
            typeStr = @"2";
            
            [self showHUD:@""];
            
            [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];

            break;
        case 2:
            NSLog(@"Third was selected");
            break;
        default:
            break;
    }
}

- (IBAction)dateFromBtnTapped:(id)sender {
    
     _fromHome = @"Calendar";
    CalendarViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)dateToBtnTapped:(id)sender {
    
     _fromHome = @"Calendar1";
    CalendarViewController1 *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController1"];
    [self.navigationController pushViewController:obj animated:YES];

}

- (IBAction)propertyTypeBtnTapped:(id)sender {
    
    NSMutableArray  *propertyArea;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        propertyArea = [[[areaArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"value_arabic"];
        
    }
    else{
        propertyArea = [[[areaArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"value_english"];
    }
    
    propertyIdArray = [[[areaArray valueForKey:@"property_type"] valueForKey:@"values"] valueForKey:@"id"];
    
    if(propertyArea.count>0){
        
        [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Propert Type")
                                                rows:propertyArea
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
//                    _propertyTypeBtn.titleLabel.text=[NSString stringWithFormat:@"%@",[propertyArea objectAtIndex:selectedIndex]];
                                               
                [_propertyTypeBtn setTitle:[NSString stringWithFormat:@"%@",[propertyArea objectAtIndex:selectedIndex]] forState:UIControlStateNormal];
                                               
                propertyStr = [NSString stringWithFormat:@"%@",[propertyIdArray objectAtIndex:selectedIndex]];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.segmentControl.layer.borderWidth = 1;
    self.segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentControl.layer.cornerRadius = 15.0f;
    self.segmentControl.layer.masksToBounds = YES;
    self.segmentControl.clipsToBounds = YES;
    
    UIFont *Boldfont = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:Boldfont forKey:UITextAttributeFont];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self.segmentControl setTitle:Localized(@"For Sale") forSegmentAtIndex:0];
    
    [self.segmentControl setTitle:Localized(@"For Rent") forSegmentAtIndex:1];
    
  //  _searchBa.text = Localized(@"Search");
    
    postAdd = [[UIButton alloc] init];
    //    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    postAdd.frame = CGRectMake(0, 0, 100, 10);
    [postAdd addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [postAdd setTitle:Localized(@"+ Ad") forState:UIControlStateNormal];
    [postAdd.widthAnchor constraintEqualToConstant:70].active = YES;
    [postAdd.heightAnchor constraintEqualToConstant:32].active = YES;
    
    //    [postAdd.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:15.0]];
    //    [postAdd.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [postAdd.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:16.0f]];
    
    [postAdd setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    [postAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    postAdd.layer.cornerRadius = 5.0f;
    postAdd.clipsToBounds = YES;
    postAdd.layer.masksToBounds = YES;
    //    [postAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:postAdd];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem1;
    
    negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    [negativeSpacer setWidth:-10];
    
    
    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"Share.png"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(0, 0, 20, 20);
    //    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem1,customBarRightBtn,nil];
    
    
    if ([_fromHome isEqualToString:@"fromHome"]) {
        
        [_dateFromBtn setTitle:Localized(@"Date From") forState:UIControlStateNormal];
        [_dateToBtn setTitle:Localized(@"Date To") forState:UIControlStateNormal];
    }
    else if ([_fromHome isEqualToString:@"Calendar"]){
        
        NSString *dateFromStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"];
        if ([dateFromStr length]==0) {
            
            [_dateFromBtn setTitle:Localized(@"Date From") forState:UIControlStateNormal];
        }
        else{
            
            [_dateFromBtn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"] forState:UIControlStateNormal];
            
//            _dateFromBtn.titleLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"];
        }
    }
    else if([_fromHome isEqualToString:@"Calendar1"]){
        
        NSString *dateToStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"];
        
        if ([dateToStr length]==0) {
            
            [_dateToBtn setTitle:Localized(@"Date To") forState:UIControlStateNormal];
        }
        else{
            [_dateToBtn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"] forState:UIControlStateNormal];
            
//            _dateToBtn.titleLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"];
        }
    }
    else{
        
    }
}

-(void)postAddBtnTapped{
    
    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
    [self.navigationController pushViewController:obj animated:YES];
    
}


#pragma searchBar delegate.

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBa resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
    [_searchBa resignFirstResponder];
}

-(void)yourTextViewDoneButtonPressed
{
    // [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
    [_searchBa resignFirstResponder];
}


#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


- (IBAction)clearBtnTapped:(id)sender {
    
    [_dateFromBtn  setTitle:Localized(@"Date From") forState:UIControlStateNormal];
    [_dateToBtn  setTitle:Localized(@"Date To") forState:UIControlStateNormal];
    [_propertyTypeBtn  setTitle:Localized(@"Property Type") forState:UIControlStateNormal];
    _priceTxtFld.text = @"";
    
    _coverView.hidden = YES;
    _advancedView.hidden = YES;
}

- (IBAction)advancedSearBtnTapped:(id)sender {
    
    [self showHUD:@""];
    
    [self makePostCallForPage:ADDS withParams:@{@"type":typeStr,@"date_from":_dateFromBtn.titleLabel.text,@"date_to":_dateToBtn.titleLabel.text,@"prop_type":propertyStr,@"price":_priceTxtFld.text} withRequestCode:1];
}
@end
