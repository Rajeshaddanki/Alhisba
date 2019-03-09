//
//  RegisterdTradesViewController.m
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "RegisterdTradesViewController.h"
#import "SVProgressHUD.h"
#import "TradesTableViewCell.h"
#import "ExpandTableViewCell.h"
#import "CalendarViewController.h"
#import "CalendarViewController1.h"
#import "SearchTableViewCell.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "ActionSheetStringPicker.h"
#import "SelectAreaViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface RegisterdTradesViewController ()<UITextFieldDelegate,PopViewControllerDelegate>{
    UIButton *menuBtn,*backBtn;
    NSMutableArray *resultArray,*searchArray;
    NSInteger pagesNumber;
    NSString *filterStr;
    NSString *areaStr,*dateFromStr,*dateToStr,*blockStr,*desStr,*propertyStr;
    SWRevealViewController *revealViewController;
    NSIndexPath *selectedCellIndexPath;
    ActionSheetStringPicker *picker;
    
    NSString *pageLoading;
}



@end

@implementation RegisterdTradesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBGBtn.layer.cornerRadius = 10;
    _searchBGBtn.clipsToBounds = YES;
    _noTradesLbl.text = Localized(@"NO TRADES AVAILABLE");
    _advancedBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _advancedBtn.layer.borderWidth=2.0;
    _advancedBtn.layer.cornerRadius=5;
    _advancedBtn.clipsToBounds=YES;
    _advSearchLbl.text = Localized(@"Advanced Search");
    _searchBtn.layer.cornerRadius = 10;
    _searchBtn.clipsToBounds = YES;
    
    _searchView.layer.cornerRadius = 10;
    _searchView.clipsToBounds = YES;

    _searchBackView.hidden = YES;
    _advancedBtn.layer.cornerRadius = 10;
    _advancedBtn.clipsToBounds = YES;
    _advancedBtn.layer.borderColor = [UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1].CGColor;
    [_advancedBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
    
    
    [_sizeFromTxtFld setFont:[UIFont fontWithName:@"Cairo-SemiBold" size:16]];
    [_sizeToTxtFld setFont:[UIFont fontWithName:@"Cairo-SemiBold" size:16]];

    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"dateString"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"dateString1"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    pageLoading = @"YES";
    _sizeFromTxtFld.delegate = self;
    _sizeToTxtFld.delegate = self;
    [self.tradesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    pagesNumber = 0;
    _searchTabeView.hidden = YES;
    _searchTableBackground.hidden = YES;
    _searchTablePopUpView.hidden = YES;
    _noTradesLbl.hidden = YES;
    _closeBtn.hidden = YES;
    
    [_dateFromBtn setTitle:Localized(@"Date From") forState:UIControlStateNormal];
    [_dateToBtn setTitle:Localized(@"Date To") forState:UIControlStateNormal];
    [_areaBtn setTitle:Localized(@"Area") forState:UIControlStateNormal];
    [_propertyBtn setTitle:Localized(@"Property Type") forState:UIControlStateNormal];
    [_blockBtn setTitle:Localized(@"Block") forState:UIControlStateNormal];
    [_descriptionBtn setTitle:Localized(@"Description") forState:UIControlStateNormal];
    _sizeToTxtFld.placeholder = Localized(@"Size To");
    _sizeFromTxtFld.placeholder = Localized(@"Size From");
    

    UIColor *color = [UIColor colorWithRed:24.0f/255.0f green:55.0f/255.0f blue:112.0f/255.0f alpha:1.0f];
    
    _sizeToTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Size To") attributes:@{NSForegroundColorAttributeName: color}];
    
    _sizeFromTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Size From") attributes:@{NSForegroundColorAttributeName: color}];

//    [_searchByTapBtn setTitle:Localized(@"Search by type,date,area") forState:UIControlStateNormal];
    //change
    [_serachBtLbl setText:Localized(@"Search")];
    [_searchBtn setTitle:Localized(@"Search") forState:UIControlStateNormal];
    [_dateFromBtn setTitle:Localized(Localized(@"Date From")) forState:UIControlStateNormal];
    [_dateToBtn setTitle:Localized(@"Date To") forState:UIControlStateNormal];

    _searchBtn.tag =1;
    
    if ([_fromMenu isEqualToString:@"fromMenu"]) {
        
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        UIImage *image = [UIImage imageNamed: @"NavImage.png"];
        [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    }
    else{
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];
    }
    
    self.navigationItem.title = Localized(@"Registerd Trades");
    
   
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Registerd Trades");
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
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
    _areaLbl.text = Localized(@"Area");
    _sizeLbl.text = Localized(@"Size");
    _descriptionLbl.text = Localized(@"Description");
    _priceInKdLbl.text = Localized(@"Price(KD)");
    _priceMc2Lbl.text = Localized(@"Price M2");
    
   
    
    [_areaLbl setTextAlignment:NSTextAlignmentCenter];
    [_sizeLbl setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLbl setTextAlignment:NSTextAlignmentCenter];
    [_priceInKdLbl setTextAlignment:NSTextAlignmentCenter];
    [_priceMc2Lbl setTextAlignment:NSTextAlignmentCenter];

    
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
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {

        // Search Btn...

        // Get the size of the text and image
        CGSize buttonLabelSize = [[self.searchBtn titleForState:UIControlStateNormal] sizeWithFont:self.searchBtn.titleLabel.font];
        CGSize buttonImageSize = [[self.searchBtn imageForState:UIControlStateNormal] size];

        // You can do this line in the xib too:
        self.searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        // Adjust Edge Insets according to the above measurement. The +2 adds a little space
//        self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(_searchBtn.frame.size.width-100));
        
        self.searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, buttonImageSize.width+2);

    } else {


// Search Btn...

//        CGSize buttonLabelSize = [[self.searchBtn titleForState:UIControlStateNormal] sizeWithFont:self.searchBtn.titleLabel.font];
//        CGSize buttonImageSize = [[self.searchBtn imageForState:UIControlStateNormal] size];
//        self.searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,_searchBtn.frame.size.width-20);
//        self.searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, buttonImageSize.width+2);

//        CGSize buttonLabelSize1 = [[self.searchByTapBtn titleForState:UIControlStateNormal] sizeWithFont:self.searchByTapBtn.titleLabel.font];
//        CGSize buttonImageSize1 = [[self.searchByTapBtn imageForState:UIControlStateNormal] size];
//        self.searchByTapBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        self.searchByTapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,_searchByTapBtn.frame.size.width-20);
//        self.searchByTapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, buttonImageSize.width+2);
        
//                self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.view.frame.origin.x);
        
}
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR])
    {
//        [_areaBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//        [_propertyBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//        [_blockBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//        [_descriptionBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        _areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _propertyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _blockBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _descriptionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _dateToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _dateFromBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;


    }
    else{
//        [_areaBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        [_propertyBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        [_blockBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        [_descriptionBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        
        _areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _propertyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _blockBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _descriptionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dateToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dateFromBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        [_areaLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//        [_sizeLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//        [_descriptionLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//        [_priceInKdLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//        [_priceMc2Lbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//    }
//    else{
//        [_areaLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:16]];
//        [_sizeLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:16]];
//        [_descriptionLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:16]];
//        [_priceInKdLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:16]];
//        [_priceMc2Lbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:16]];
//    }

    [self customSetup];
    // Hide search View ...
    
    _searchViewHeight.constant = 0;
    _searchView.hidden = YES;
    _viewTopConstraint.constant = 80;

    [self showHUD:@""];
    resultArray = [[NSMutableArray alloc] init];
    [self makePostCallForPage:REGISTERD_TRADES withParams:@{@"start":[NSString stringWithFormat:@"%ld",(long)pagesNumber],@"end":@"100",@"date_from":@"",@"date_to":@"",@"block":@"",@"prop_type":@"",@"prop_desc":@"",@"size_from":@"",@"size_to":@"",@"area":@""} withRequestCode:1];
    
    
    
    
}
-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"info_register_trades") :sender];
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

#pragma BackBtn Tapped:

-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    if (reqeustCode == 1) {
        pageLoading = @"NO";
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [resultArray addObject:dictionary];
        }
        if ([array count]==0) {
            if ([resultArray count]==0) {
            _noTradesLbl.hidden = NO;
            }else{
                pageLoading = @"YES";

                _noTradesLbl.hidden = YES;

            }
            NSLog(@"jsbdvhjbvns");
            [_tradesTableView reloadData];
            
        }
        else{
            
//            [resultArray addObjectsFromArray:(NSArray *)result];
             _noTradesLbl.hidden = YES;
            [_tradesTableView reloadData];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:resultArray.count-1 inSection:0];
//            NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//            [_tradesTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
//            [self.tradesTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:resultArray.count inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
            pageLoading  = @"NO";

            
        }
    }  else if (reqeustCode == 3) {
        resultArray = [[NSMutableArray    alloc] init];
        pageLoading = @"NO";
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [resultArray addObject:dictionary];
        }
        if ([array count]==0) {
            _noTradesLbl.hidden = NO;
            NSLog(@"jsbdvhjbvns");
            [_tradesTableView reloadData];
        }
        else{
            
            //            [resultArray addObjectsFromArray:(NSArray *)result];
            _noTradesLbl.hidden = YES;
            [_tradesTableView reloadData];
            //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:resultArray.count-1 inSection:0];
            //            NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
            //            [_tradesTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
            //            [self.tradesTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:resultArray.count inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
            pageLoading  = @"NO";
            
            
        }
    }
    else if (reqeustCode == 10){
        
        if ([filterStr isEqualToString:@"Area"]) {
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                searchArray = [[result valueForKey:@"areas"] valueForKey:@"area_arabic"];
            }
            else{
                searchArray = [[result valueForKey:@"areas"] valueForKey:@"area_english"];
            }
            
            
       
            [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Area")
                                                    rows:searchArray
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   
//            picker.pickerBackgroundColor = [UIColor redColor];
//            picker.toolbarBackgroundColor = [UIColor redColor];

                                                   
            [_areaBtn setTitle:[searchArray objectAtIndex:selectedIndex] forState:UIControlStateNormal];
            areaStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:selectedIndex]];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];

      //      [_searchTabeView reloadData];
            
        }
        
       else if ([filterStr isEqualToString:@"Property"]) {
           if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
               searchArray = [[result valueForKey:@"property_type"] valueForKey:@"property_type_arabic"];
           }
           else{
               searchArray = [[result valueForKey:@"property_type"] valueForKey:@"property_type_english"];
           }
           
   [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Property")
                                                   rows:searchArray
                                       initialSelection:0
                                              doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                  
 [_propertyBtn setTitle:[searchArray objectAtIndex:selectedIndex] forState:UIControlStateNormal];
 propertyStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:selectedIndex]];
                                                  
                                                  

                                              }
                                            cancelBlock:^(ActionSheetStringPicker *picker) {
                                                NSLog(@"Block Picker Canceled");
                                            }
                                                 origin:self.view];

           [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];

//           [_searchTabeView reloadData];
        }
        
        else if([filterStr isEqualToString:@"Block"]) {
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                searchArray = [[result valueForKey:@"block"] valueForKey:@"block_arabic"];
            }
            else{
                searchArray = [[result valueForKey:@"block"] valueForKey:@"block_english"];
            }
            
            [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Block")
                                                    rows:searchArray
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   
                                                   [_blockBtn setTitle:[searchArray objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                                                   blockStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:selectedIndex]];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];

//            [_searchTabeView reloadData];
        }
        else if([filterStr isEqualToString:@"Desc"]) {
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                searchArray = [[result valueForKey:@"description"] valueForKey:@"description_arabic"];
            }
            else{
                searchArray = [[result valueForKey:@"description"] valueForKey:@"description_english"];
            }
     
            [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Description")
                                                    rows:searchArray
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   
                                                   [_descriptionBtn setTitle:[searchArray objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                                                   desStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:selectedIndex]];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];
            
          //  [_searchTabeView reloadData];
        }
        else{
            
        }
    }
    
    [self hideHUD];

}


#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tradesTableView) {
        if([pageLoading  isEqual: @"NO"]){
        if (resultArray.count-1 == indexPath.row) {
            pagesNumber=resultArray.count;
            pageLoading = @"YES";
                [self makePostCallForPage:REGISTERD_TRADES withParams:@{@"start":[NSString stringWithFormat:@"%ld",(long)pagesNumber],@"end":@"100",@"date_from":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"]],@"date_to":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"]],@"block":[NSString stringWithFormat:@"%@",blockStr],@"prop_type":[NSString stringWithFormat:@"%@",propertyStr],@"prop_desc":[NSString stringWithFormat:@"%@",desStr],@"size_from":_sizeFromTxtFld.text,@"size_to":_sizeToTxtFld.text,@"area":[NSString stringWithFormat:@"%@",areaStr]} withRequestCode:1];
            
        }
    }
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tradesTableView) {
        
        return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,resultArray.count);
    }
    else if (tableView == _searchTabeView)
    {
        return searchArray.count;
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
            NSMutableDictionary *dic = [resultArray objectAtIndex:indexPath.row-1];
            
            [cell.propertyTypeLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.propertyTypeTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.notesLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.notesTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.percentageLbl setTextAlignment:NSTextAlignmentCenter];
            [cell.percentageTitle setTextAlignment:NSTextAlignmentCenter];
            
            cell.propertyTypeLbl.text = Localized(@"Proto Type :");
            cell.notesLbl.text = Localized(@"Notes :");
            cell.percentageLbl.text = Localized(@"Percentage :");
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR])
            {
                cell.propertyTypeTitle.text = [dic valueForKey:@"property_type_arabic"];
                cell.notesTitle.text = [dic valueForKey:@"notes_arabic"];
                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_arabic"]];
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.blockValue.text = [dic valueForKey:@"block_arabic"];
            }
            else{
                cell.propertyTypeTitle.text = [dic valueForKey:@"property_type_english"];
                cell.notesTitle.text = [dic valueForKey:@"notes_english"];
                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_english"]];
           
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.blockValue.text = [dic valueForKey:@"block_english"];
            }
            
           //change
            if (adjustedIndexPath.row % 2) {
       
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
             //   cell.colorView.backgroundColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];

            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
                
            //    cell.colorView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
            }
            
//            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//                [cell.propertyTypeTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.notesTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.percentageTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.blockTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//
//                [cell.propertyTypeLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.notesLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.percentageLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//            }
//            else{
//                [cell.propertyTypeTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.notesTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:15]];
//                [cell.percentageTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.blockTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:15]];
//
//                [cell.propertyTypeLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:14]];
//                [cell.notesLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:14]];
//                [cell.percentageLbl setFont:[UIFont fontWithName:@"DroidSans-Bold"size:14]];
//            }
            
            return cell;
        }
        
        else{
            
            static NSString *MyIdentifier = @"TradesTableViewCell";
            
            TradesTableViewCell *cell = [_tradesTableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
//            NSMutableDictionary *dic = [resultArray objectAtIndex:adjustedIndexPath];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            if(resultArray.count !=0){
            dic = [resultArray objectAtIndex:adjustedIndexPath.row];

            [cell.tradesDate setTextAlignment:NSTextAlignmentCenter];
            [cell.tradesDate setClipsToBounds:YES];
            [cell.tradesDate.layer setCornerRadius:5.0f];
//            cell.tradesDate.layer.backgroundColor=[UIColor whiteColor].CGColor;
                
            [cell.descriptionTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.title setTextAlignment:NSTextAlignmentCenter];
            [cell.sizePrice setTextAlignment:NSTextAlignmentCenter];
            [cell.priceInKd setTextAlignment:NSTextAlignmentCenter];
            [cell.priceM2 setTextAlignment:NSTextAlignmentCenter];
            }
            
//            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//                [cell.descriptionTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.title setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:15]];
//                [cell.sizePrice setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.priceInKd setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.priceM2 setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//                [cell.tradesDate setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
//
//            }
//            else{
//                [cell.descriptionTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.title setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.sizePrice setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.priceInKd setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.priceM2 setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
//                [cell.tradesDate setFont:[UIFont fontWithName:@"DroidSans-Bold"size:14]];
//            }
            
            if (adjustedIndexPath.row % 2) {
                
                cell.contentView.backgroundColor = [UIColor whiteColor];

            } else {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
                
                
            }
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                cell.sizePrice.text = [dic valueForKey:@"size_arabic"];
                cell.descriptionTitle.text = [dic valueForKey:@"description_arabic"];
                cell.priceInKd.text = [dic valueForKey:@"price_arabic"];
                cell.priceM2.text = [dic valueForKey:@"price_per_m2_arabic"];
                cell.tradesDate.text = [dic valueForKey:@"trans_date_arabic"];
                cell.title.text = [dic valueForKey:@"area_arabic"];
            }
            else{
                cell.sizePrice.text = [dic valueForKey:@"size_english"];
                cell.descriptionTitle.text = [dic valueForKey:@"description_english"];
                cell.priceInKd.text = [dic valueForKey:@"price_english"];
                cell.priceM2.text = [dic valueForKey:@"price_per_m2_english"];
                cell.tradesDate.text = [dic valueForKey:@"trans_date_english"];
                cell.title.text = [dic valueForKey:@"area_english"];
            }
            
            return cell;
        }
    }
    else if (tableView == _searchTabeView){
        
        static NSString *CellIdentifier = @"SearchTableViewCell";
        
        SearchTableViewCell *cell = [_searchTabeView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if ([filterStr isEqualToString:@"Area"]) {
                cell.titleLbl.text = [searchArray objectAtIndex:indexPath.row];
        }
        
        if ([filterStr isEqualToString:@"Property"]) {
                cell.titleLbl.text = [searchArray objectAtIndex:indexPath.row];
        }
        
        if ([filterStr isEqualToString:@"Block"]) {
                cell.titleLbl.text = [searchArray objectAtIndex:indexPath.row];
        }
        
        if ([filterStr isEqualToString:@"Desc"]) {
            
                cell.titleLbl.text = [searchArray objectAtIndex:indexPath.row];
        }
        

                if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
                    [cell.titleLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:14]];
                }
                else{
                    [cell.titleLbl setFont:[UIFont fontWithName:@"DroidSans-Bold" size:14]];
                }
        
        [cell.radioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
        cell.radioButton.tag = indexPath.row;
        [cell.radioButton addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    return 0;
}

-(void)checkBtnClicked:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_searchTabeView];
    
    NSIndexPath *indexPath = [_searchTabeView indexPathForRowAtPoint:buttonFrame.origin];
    
    [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    
    if ([filterStr isEqualToString:@"Area"]) {
        
        [_areaBtn setTitle:[searchArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        areaStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:indexPath.row]];
//        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    if ([filterStr isEqualToString:@"Property"]) {
       
    [_propertyBtn setTitle:[searchArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        propertyStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:indexPath.row]];
//        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    if ([filterStr isEqualToString:@"Block"]) {
      
        [_blockBtn setTitle:[searchArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        blockStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:indexPath.row]];
//        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    if ([filterStr isEqualToString:@"Desc"]) {
        
        [_descriptionBtn setTitle:[searchArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        desStr = [NSString stringWithFormat:@"%@",[searchArray objectAtIndex:indexPath.row]];
        //        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
   
    _searchTabeView.hidden = YES;
    _closeBtn.hidden = YES;
    _searchTableBackground.hidden = YES;
    _searchTablePopUpView.hidden = YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == _tradesTableView) {
        
        if ([indexPath isEqual:self.tradesTableView.expandedContentIndexPath])
        {
            return 140.0f;
        }
        else
            return 68.0f;
    }
    
    else if(tableView == _searchTabeView){
        
        return 60;
    }
    else{
        return 0;
    }
}

#pragma mark JNExpandableTableView DataSource

- (BOOL)tableView:(JNExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
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

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (IBAction)searchButtonTapped:(id)sender {
  
//    if(_searchBtn.tag ==1){

    if ([blockStr length]==0 && [desStr length]==0 && [_sizeToTxtFld.text length]==0 && [areaStr length]==0) {
        
        _searchViewHeight.constant = 0;
        _searchView.hidden = YES;
        _viewTopConstraint.constant = 80;
        _searchBtn.tag = 2;
        //_searchBtn.hidden = YES;
        _searchBtn.hidden = NO;
        _searchByTapBtn.hidden = NO;
        _searchIcon.hidden = NO;
        pagesNumber = 0;
        _searchBGBtn.hidden = NO;
        _serachBtLbl.hidden =NO;
        [_sizeToTxtFld resignFirstResponder];
        [_sizeFromTxtFld resignFirstResponder];

    }
    else{
        _searchBGBtn.hidden = NO;
        _serachBtLbl.hidden =NO;
        
        _searchViewHeight.constant = 0;
       // _searchView.hidden = YES;
        _viewTopConstraint.constant = 80;
        _searchBtn.tag = 2;
       // _searchBtn.hidden = YES;
        _searchBtn.hidden = NO;
        _searchByTapBtn.hidden = NO;
        _searchIcon.hidden = NO;
        pagesNumber = 0;
        
        [_sizeToTxtFld resignFirstResponder];
        [_sizeFromTxtFld resignFirstResponder];

       
//        [self makePostCallForPage:REGISTERD_TRADES withParams:@{@"start":[NSString stringWithFormat:@"%ld",(long)pagesNumber],@"end":@"100",@"date_from":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"]],@"date_to":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"]],@"block":[NSString stringWithFormat:@"%@",blockStr],@"prop_type":[NSString stringWithFormat:@"%@",propertyStr],@"prop_desc":[NSString stringWithFormat:@"%@",desStr],@"size_from":_sizeFromTxtFld.text,@"size_to":_sizeToTxtFld.text,@"area":[NSString stringWithFormat:@"%@",areaStr]} withRequestCode:3];
    }

    _searchView.hidden = YES;
    _searchBackView.hidden = YES;

//   }
//    else{
//
//        _searchViewHeight.constant = 290;
//        _searchView.hidden = YES;
//        _viewTopConstraint.constant = 8;
//        _searchBtn.tag = 1;
//    }
}

- (IBAction)searchBytypeBtnTapped:(id)sender {

    _searchViewHeight.constant = 500;
    _searchView.hidden = NO;
    _searchBackView.hidden = NO;
    
//    _viewTopConstraint.constant = 8;
//    _searchView.hidden = NO;
//    _searchByTapBtn.hidden = YES;
//    _searchIcon.hidden = YES;
//    _noTradesLbl.hidden = YES;
//    _searchBtn.hidden = NO;
//
//    _searchBGBtn.hidden = YES;
//    _serachBtLbl.hidden =YES;
    
    ////adv
//    _advView.hidden= YES;
//    _advHeight.constant=0;
}

- (IBAction)dateFromBtnTapped:(id)sender {
    
    _fromHome = @"Calendar";
    CalendarViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    
    [self.navigationController pushViewController:obj animated:YES];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
}

- (IBAction)dateToBtnTapped:(id)sender {
    if(![[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"]  isEqual: @""]){
    _fromHome = @"Calendar1";
    CalendarViewController1 *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController1"];
        obj.fromDate = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString"];
    [self.navigationController pushViewController:obj animated:YES];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
    }else{
        [self showErrorAlertWithMessage:Localized(@"Please Select From Date")];
    }
}

- (IBAction)areaBtnTapped:(id)sender {
    
    [self showHUD:@""];
    
    filterStr = @"Area";
//    _searchTabeView.hidden = NO;
//    _closeBtn.hidden = NO;
//    _searchTableBackground.hidden = NO;
//_searchTablePopUpView.hidden = NO;
    
    //[self makePostCallForPage:REGISTERD_TRADES_FILTER withParams:@{} withRequestCode:10];
    searchArray = [[NSMutableArray alloc]init];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate=self;
    vc.from = @"register";
    //    [self.navigationController pushViewController:vc animated:YES];
    vc.completionBlock2 = ^(NSString *area) {
        NSLog(@"%@",area);
        //        snationality= area;
        [_areaBtn setTitle:area forState:UIControlStateNormal];
        areaStr = [NSString stringWithFormat:@"%@",area];
        
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
  
    [self hideHUD];
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}


- (IBAction)propertyBtnTapped:(id)sender {
    
    filterStr = @"Property";
//    _searchTabeView.hidden = NO;
//    _closeBtn.hidden = NO;
//    _searchTableBackground.hidden = NO;
//    _searchTablePopUpView.hidden = NO;
    
    [self makePostCallForPage:REGISTERD_TRADES_FILTER withParams:@{} withRequestCode:10];
    
    searchArray = [[NSMutableArray alloc]init];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
}

- (IBAction)BlockBtnTapped:(id)sender {
    
     filterStr = @"Block";
//    _searchTabeView.hidden = NO;
//    _closeBtn.hidden = NO;
//    _searchTableBackground.hidden = NO;
//    _searchTablePopUpView.hidden = NO;
    
    [self makePostCallForPage:REGISTERD_TRADES_FILTER withParams:@{} withRequestCode:10];
    searchArray = [[NSMutableArray alloc]init];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
}

- (IBAction)descriptionBtnTapped:(id)sender {
    
    filterStr = @"Desc";
//    _searchTabeView.hidden = NO;
//    _closeBtn.hidden = NO;
//    _searchTableBackground.hidden = NO;
//    _searchTablePopUpView.hidden = NO;
    
    [self makePostCallForPage:REGISTERD_TRADES_FILTER withParams:@{} withRequestCode:10];
    searchArray = [[NSMutableArray alloc]init];
    
    [_sizeToTxtFld resignFirstResponder];
    [_sizeFromTxtFld resignFirstResponder];
}

- (IBAction)closeBtnTapped:(id)sender {
    
    _searchTabeView.hidden = YES;
    _closeBtn.hidden = YES;
    _searchTableBackground.hidden = YES;
    _searchTablePopUpView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
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
        }
    }
    else if([_fromHome isEqualToString:@"Calendar1"]){
        
        NSString *dateToStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"];

        if ([dateToStr length]==0) {
            
            [_dateToBtn setTitle:Localized(@"Date To") forState:UIControlStateNormal];
        }
        else{
            [_dateToBtn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"dateString1"] forState:UIControlStateNormal];
        }
    }
    else{
        
    }
    
  //  [self showHUD:@""];
//    resultArray = [[NSMutableArray alloc] init];
//    [self makePostCallForPage:REGISTERD_TRADES withParams:@{@"start":[NSString stringWithFormat:@"%ld",(long)pagesNumber],@"end":@"100",@"date_from":@"",@"date_to":@"",@"block":@"",@"prop_type":@"",@"prop_desc":@"",@"size_from":@"",@"size_to":@"",@"area":@""} withRequestCode:1];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)advsearchBtnAction:(id)sender {
   
//    if(_advView.isHidden){
//    _searchViewHeight.constant = 400;
//    _advsearchImage.image = [UIImage imageNamed:@"min.png"];
//
//    _advView.hidden= NO;
//    _advHeight.constant=227;
//    }else{
//        _searchViewHeight.constant = 160;
//        _advsearchImage.image = [UIImage imageNamed:@"plu.png"];
//
//        _advView.hidden= YES;
//        _advHeight.constant=0;
//    }
    
    _searchViewHeight.constant = 500;
    _searchView.hidden = NO;
    _searchBackView.hidden = NO;
    
}
@end
