//
//  AuctionsViewController.m
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AuctionsViewController.h"
#import "auctionsTableViewCell.h"
#import "SVProgressHUD.h"
#import "ExpandTableViewCell.h"
#import "TradesTableViewCell.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Auctions1ViewController.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "SelectAreaViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>



@interface AuctionsViewController ()<UISearchBarDelegate,PopViewControllerDelegate,EKEventEditViewDelegate>{
    
    UIButton *menuBtn,*backBtn;
    NSMutableArray *resultArray,*popUpList;
    NSUInteger count;
    SWRevealViewController *revealViewController;
    NSMutableArray *tableArray;
    BOOL Expand;
    SVProgressHUD *hud;
    TradesTableViewCell *cell2;
    NSString *type;

}

@property (strong, nonatomic) EKEventStore *eventStore;
@property (nonatomic) BOOL isAccessToEventStoreGranted;


@end

@implementation AuctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar.delegate = self;
    Expand= NO;
    _coverView.hidden = NO;
    
    [hud setForegroundColor:[UIColor lightGrayColor]];
    
    _historicalUnderLbl.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    _todayUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _upcomingUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    
    [_historicalBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_todayBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_upcomingBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    _underLineLbl.hidden = YES;

    _auctionTitleLbl.text = Localized(@"Auctions");
    _searchBar.placeholder = Localized(@"Search");
    
    type = @"hostorical";
    
    _backGroundViewImage.hidden = YES;
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _tradesTableView.hidden = YES;
    _summaryListView.hidden = YES;

    _mojImahe.hidden = YES;
    _mojDateLbl.hidden = YES;
    _clendarBtn.hidden = YES;
    _mojTitleLbl.hidden = YES;
    _searchBar.hidden = NO;
    _tableView.hidden = NO;
    _mojImahe.layer.cornerRadius = 10.0f;
    _mojImahe.layer.masksToBounds = YES;

    
    _propertyListBackBtn.hidden = YES;
    _noAuctionsLbl.hidden = YES;
     tableArray = [NSMutableArray array];
    
    [_auctionOrganizerLbl setTextAlignment:NSTextAlignmentCenter];
    [_dateLbl setTextAlignment:NSTextAlignmentCenter];
    [_venueLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertyTypeLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertListedLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertySoldLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertyNotSoldLbl setTextAlignment:NSTextAlignmentCenter];
    [_totalSaleLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertyDescLbl setTextAlignment:NSTextAlignmentCenter];
    [_additionalInfoLbl setTextAlignment:NSTextAlignmentCenter];
    [_propertyArea setTextAlignment:NSTextAlignmentCenter];
    
    [_auctionOrganizerValue setTextAlignment:NSTextAlignmentCenter];
    [_dateValue setTextAlignment:NSTextAlignmentCenter];
    [_venueValu setTextAlignment:NSTextAlignmentCenter];
    [_propertyAreaValue setTextAlignment:NSTextAlignmentCenter];
    [_propertyTypeValue setTextAlignment:NSTextAlignmentCenter];
    [_propertListedValue setTextAlignment:NSTextAlignmentCenter];
    [_propertySoldValue setTextAlignment:NSTextAlignmentCenter];
    [_propertyNotSoldVlaue setTextAlignment:NSTextAlignmentCenter];
    [_totalSaleValue setTextAlignment:NSTextAlignmentCenter];
    [_propertyDescValue setTextAlignment:NSTextAlignmentCenter];
    [_additionalnfoValue setTextAlignment:NSTextAlignmentCenter];
    
    [_historicalBtn setTitle:Localized(@"Historical") forState:UIControlStateNormal];
    [_todayBtn setTitle:Localized(@"Today") forState:UIControlStateNormal];
    [_upcomingBtn setTitle:Localized(@"Upcoming") forState:UIControlStateNormal];
    [_propertyListBackBtn setTitle:Localized(@"Auction Summary") forState:UIControlStateNormal];
    
    self.navigationItem.title = Localized(@"Auctions");
    
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.searchBar.inputAccessoryView = keyboardToolbar;
    
    
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Auctions");
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
    
//    [_historicalBtn setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1]];
    
    _historicalUnderLbl.hidden = NO;
    _todayUnderLbl.hidden = YES;
    _upcomingUnderLbl.hidden = YES;

    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;

  
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
    
    [self customSetup];
    [self showHUD:@""];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];

    
    [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"history"} withRequestCode:1];

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

-(void)badgeInfoBtnTapped:(id)sender{
    
    [self showInfo:Localized(@"Auctions") :sender];
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"The latest data available in the Ministry of justice - Real Estate Registration and Documentation") :sender];
}
-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"AUCTIONS SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

   // [_tradesTableView reloadData];
    
    _historicalUnderLbl.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    _todayUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _upcomingUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _underLineLbl.hidden = YES;

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

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    resultArray = result;
    
    if ([resultArray count]==0) {
        
        _noAuctionsLbl.hidden = NO;
        _mojImahe.hidden = YES;
        _clendarBtn.hidden = YES;
        _mojDateLbl.hidden = YES;
        _mojTitleLbl.hidden = YES;
        [_tableView reloadData];
    }
    else{
        _noAuctionsLbl.hidden = YES;
        _mojImahe.hidden = YES;
        _clendarBtn.hidden = YES;
        _mojDateLbl.hidden = YES;
        _mojTitleLbl.hidden = YES;
        [_tableView reloadData];
    }
    
    [_tradesTableView reloadData];
    
    _coverView.hidden = YES;
    
    [self hideHUD];
}

-(void)backBtnTapped{
    if(![_tradesTableView isHidden]){
        Expand= NO;
        
        _backGroundViewImage.hidden = YES;
        _backGroundView.hidden = YES;
        _priceListView.hidden = YES;
        _titleLbl.hidden = YES;
        _tradesTableView.hidden = YES;
        _summaryListView.hidden = YES;
        
        _propertyListBackBtn.hidden = YES;
        _noAuctionsLbl.hidden = YES;
        _mojImahe.hidden = YES;
        _clendarBtn.hidden = YES;
        _mojDateLbl.hidden = YES;
        _mojTitleLbl.hidden = YES;
        _tableView.hidden = NO;
        _searchBar.hidden = NO;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
   // [self.navigationController popViewControllerAnimated:YES];
    
//    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:obj animated:YES];

}

- (IBAction)auctionSummaryBackBtnTapped:(id)sender {
    
    _summaryListView.hidden = YES;
}

- (IBAction)upComingBtnTapped:(id)sender{
    [self scrollToTop];

//    [_upcomingBtn setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1]];
//
//     [_todayBtn setBackgroundColor:[UIColor colorWithRed:12.0f/255.0f green:49.0f/255.0f blue:76.0f/255.0f alpha:1.0]];
//
//     [_historicalBtn setBackgroundColor:[UIColor colorWithRed:12.0f/255.0f green:49.0f/255.0f blue:76.0f/255.0f alpha:1.0]];
    
    _historicalUnderLbl.hidden = YES;
    _todayUnderLbl.hidden = YES;
    _upcomingUnderLbl.hidden = NO;
    
    _lineLbl.hidden = NO;
    _searchIconBtn.hidden = NO;
    _searchBackBtn.hidden = NO;
    _searchTextLbl.hidden = NO;

    _backGroundViewImage.hidden = YES;
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _tradesTableView.hidden = YES;
    _summaryListView.hidden = YES;
    _propertyListBackBtn.hidden = YES;
    
    _tableView.hidden = NO;
    
    type = @"upcoming";
    
    _historicalUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _todayUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _upcomingUnderLbl.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    
    [_upcomingBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [_historicalBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_todayBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    _underLineLbl.hidden = YES;
    
    _searchTextLbl.text = Localized(@"Search");

    _coverView.hidden = NO;
    [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"upcoming"} withRequestCode:1];
    [self showHUD:@""];

}
-(void) scrollToTop
{
    if ([self numberOfSectionsInTableView:self.tableView] > 0)
    {
        NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
        [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
- (IBAction)todayBtnTapped:(id)sender{
    [self scrollToTop];

//    [_upcomingBtn setBackgroundColor:[UIColor colorWithRed:12.0f/255.0f green:49.0f/255.0f blue:76.0f/255.0f alpha:1.0]];
//
//    [_todayBtn setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1]];
//
//    [_historicalBtn setBackgroundColor:[UIColor colorWithRed:12.0f/255.0f green:49.0f/255.0f blue:76.0f/255.0f alpha:1.0]];
    
    _historicalUnderLbl.hidden = YES;
    _todayUnderLbl.hidden = NO;
    _upcomingUnderLbl.hidden = YES;
    
    _lineLbl.hidden = NO;
    _searchIconBtn.hidden = NO;
    _searchBackBtn.hidden = NO;
    _searchTextLbl.hidden = NO;


    _backGroundViewImage.hidden = YES;
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _tradesTableView.hidden = YES;
    _summaryListView.hidden = YES;
    _propertyListBackBtn.hidden = YES;
    
    type = @"today";
    
    _historicalUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _upcomingUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _todayUnderLbl.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    
    [_todayBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [_historicalBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_upcomingBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];


    _searchTextLbl.text = Localized(@"Search");
    
    _coverView.hidden = NO;
    
    _underLineLbl.hidden = YES;
    
    [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"today"}  withRequestCode:1];
    [self showHUD:@""];
}

- (IBAction)historicalBtnTapped:(id)sender{
    
    [self scrollToTop];

    _lineLbl.hidden = NO;
    _searchIconBtn.hidden = NO;
    _searchBackBtn.hidden = NO;
    _searchTextLbl.hidden = NO;

    _historicalUnderLbl.hidden = NO;
    _todayUnderLbl.hidden = YES;
    _upcomingUnderLbl.hidden = YES;
   
//    _backGroundViewImage.hidden = YES;
//    _backGroundView.hidden = YES;
//    _priceListView.hidden = YES;
//    _titleLbl.hidden = YES;
//    _tradesTableView.hidden = YES;
//    _summaryListView.hidden = YES;
    
    _backGroundViewImage.hidden = YES;
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _tradesTableView.hidden = YES;
    _summaryListView.hidden = YES;
    _propertyListBackBtn.hidden = YES;
    _tableView.hidden = NO;

    
    type = @"historical";
    
    _todayUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _upcomingUnderLbl.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _historicalUnderLbl.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    
    [_historicalBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [_todayBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_upcomingBtn setTitleColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];


    _underLineLbl.hidden = YES;
    _coverView.hidden = NO;
    [self showHUD:@""];
    
    
    
    [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"history"} withRequestCode:1];
}

- (IBAction)auctionProperttListTapped:(id)sender {
    
    popUpList = [[resultArray valueForKey:@"auctions"] objectAtIndex:count];

    _backGroundViewImage.hidden = NO;
    _backGroundView.hidden = NO;
    _priceListView.hidden = NO;
    _titleLbl.hidden = NO;
    _tradesTableView.hidden = NO;
    _propertyListBackBtn.hidden = NO;
    _summaryListView.hidden = YES;
   
    [_tradesTableView reloadData];
}

- (IBAction)propertyListBackBtnTapped:(id)sender {
    
    _backGroundViewImage.hidden = YES;
    _backGroundView.hidden = YES;
    _priceListView.hidden = YES;
    _titleLbl.hidden = YES;
    _propertyListBackBtn.hidden = YES;
    _tradesTableView.hidden = YES;
    _mojImahe.hidden = YES;
    _clendarBtn.hidden = YES;
    _mojDateLbl.hidden = YES;
    _mojTitleLbl.hidden = YES;
    _tableView.hidden = NO;
    _searchBar.hidden = NO;
    
    
    Auctions1ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"Auctions1ViewController"];
    obj.auctionList = [[NSUserDefaults standardUserDefaults] valueForKey:@"aucList"];
    obj.fromProp = @"fromPop";
    obj.popUpList1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"aucList1"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)searchBtnTapped:(id)sender {
  
    [self showHUD:@""];
    
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate=self;
    //vc.from = @"register";
    //    [self.navigationController pushViewController:vc animated:YES];
    vc.completionBlock2 = ^(NSString *area) {
        NSLog(@"%@",area);
        //        snationality= area;
//        [_areaBtn setTitle:area forState:UIControlStateNormal];
       
      //  _searchBar.text = [NSString stringWithFormat:@"%@",area];
        
        _searchTextLbl.text = [NSString stringWithFormat:@"%@",area];
        
        NSString *areId1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"auctAreaid"]];
        
        
        if ([type isEqualToString:@"historical"]) {
            
            [self showHUD:@""];
            
            [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"history",@"area_id":[NSString stringWithFormat:@"%d",areId1.intValue]}  withRequestCode:1];
        }
        else  if ([type isEqualToString:@"today"]){
            
            [self showHUD:@""];
            
            [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"today",@"area_id":[NSString stringWithFormat:@"%d",areId1.intValue]}  withRequestCode:1];
        }
        else{
            [self showHUD:@""];
            
            [self makePostCallForPage:HISTORICAl withParams:@{@"type":@"upcoming",@"area_id":[NSString stringWithFormat:@"%d",areId1.intValue]}  withRequestCode:1];
        }
        
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
    
    [self hideHUD];
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tradesTableView) {
        
        return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,popUpList.count);
    }
    else if (tableView == _tableView)
    {
        return resultArray.count;
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
            NSMutableDictionary *dic = [popUpList objectAtIndex:indexPath.row-1];
            
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
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                cell.propertyTypeTitle.text = [NSString stringWithFormat:@"%@",Localized([dic valueForKey:@"status"])];
//                cell.notesTitle.text = [self decodeHTMLString:[dic valueForKey:@"notes_english"]];
                cell.notesTitle.text = [NSString stringWithFormat:@"%@%@",[dic valueForKey:@"percentage_premium_paid"],@"%"];

                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"starting_price_per_sqr_meter"]];
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.bloackValue.text = [dic valueForKey:@"block"];
                
                 cell.residentialValue.text = [[dic valueForKey:@"property_type"] valueForKey:@"value_arabic"];
                cell.m2Value.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"sale_price_per_sqr_meter"]];
            }
            else{
                cell.propertyTypeTitle.text = [NSString stringWithFormat:@"%@",Localized([dic valueForKey:@"status"])];
//                cell.notesTitle.text = [self decodeHTMLString:[dic valueForKey:@""]];
                cell.notesTitle.text = [NSString stringWithFormat:@"%@%@",[dic valueForKey:@"percentage_premium_paid"],@"%"];

                cell.percentageTitle.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"starting_price_per_sqr_meter"]];
              
                cell.blockTitle.text = [NSString stringWithFormat:@"%@",Localized(@"Block :")];
                
                cell.bloackValue.text = [dic valueForKey:@"block"];

                cell.residentialValue.text = [[dic valueForKey:@"property_type"] valueForKey:@"value_english"];
                cell.m2Value.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"sale_price_per_sqr_meter"]];
            }
            
            if (adjustedIndexPath.row % 2) {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];

            } else {
                
                cell.contentView.backgroundColor = [UIColor whiteColor];

            }
            return cell;
        }
        
        else{
            
            static NSString *MyIdentifier = @"TradesTableViewCell";
            
            TradesTableViewCell *cell = [_tradesTableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            dic=[popUpList objectAtIndex:adjustedIndexPath.row];
            
            [cell.tradesDate setTextAlignment:NSTextAlignmentCenter];
            [cell.tradesDate setClipsToBounds:YES];
            [cell.tradesDate.layer setCornerRadius:5.0f];
            cell.tradesDate.layer.backgroundColor=[UIColor whiteColor].CGColor;
            
//            cell.expandBtn.layer.cornerRadius = 0.3 * cell.expandBtn.bounds.size.width;
//            cell.expandBtn.layer.borderColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f].CGColor;
//            cell.expandBtn.layer.borderWidth = 2.0f;
            
//            if ([tableArray containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
//            {
//                [cell.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
//            }
//            else
//            {
//                [cell.expandBtn setImage:[UIImage imageNamed:@"expandP.png"] forState:UIControlStateNormal];
//            }
            
            [cell.descriptionTitle setTextAlignment:NSTextAlignmentCenter];
            [cell.sizePrice setTextAlignment:NSTextAlignmentCenter];
            [cell.priceInKd setTextAlignment:NSTextAlignmentCenter];
            [cell.priceM2 setTextAlignment:NSTextAlignmentCenter];
            [cell.title setTextAlignment:NSTextAlignmentCenter];
            
            if (adjustedIndexPath.row % 2) {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:215.0f/255.0f blue:227.0f/255.0f alpha:1.0f];

            } else {

                cell.contentView.backgroundColor = [UIColor whiteColor];

//                cell.contentView.backgroundColor = [UIColor colorWithRed:12.0f/255.0f green:49.0f/255.0f blue:76.0f/255.0f alpha:1.0];
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
    
    else if (tableView == _tableView){
        static NSString *CellIdentifier = @"auctionsTableViewCell";
        
        auctionsTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
//        cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
//        cell.layer.borderWidth = 5.0f;
//        cell.layer.borderColor = [UIColor whiteColor].CGColor;
//        cell.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.8].CGColor;

//        cell.layer.cornerRadius = 10.0f;
        //cell.backgroundView = nil;
//        cell.layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.backView.bounds];
        cell.backView.layer.masksToBounds = NO;
        cell.backView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.backView.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        cell.backView.layer.shadowOpacity = 0.3f;
        cell.backView.layer.shadowPath = shadowPath.CGPath;

        cell.backView.layer.cornerRadius = 15.0f;
        
        NSMutableDictionary *dic = [resultArray objectAtIndex:indexPath.row];
        
        [cell.textViewheadLbl setTextAlignment:NSTextAlignmentCenter];
        [cell.textViewLbl setTextAlignment:NSTextAlignmentCenter];
        
        [cell.textViewLbl setTextAlignment:NSTextAlignmentCenter];
        [cell.textViewheadLbl setTextAlignment:NSTextAlignmentCenter];
        
        cell.logoView.layer.cornerRadius = 10.0f;
        cell.logoView.layer.masksToBounds = YES;
        
        cell.wishListBtn.layer.cornerRadius = 5.0f;
//        cell.wishListBtn.layer.masksToBounds = YES;
        cell.wishListBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.wishListBtn.layer.borderWidth = 1.0f;
        
    [cell.logoView setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            cell.textViewLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
            
            cell.textViewheadLbl.text = [dic valueForKey:@"event_date"];
            
            _titleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
        }
        else{
            cell.textViewLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
            
            cell.textViewheadLbl.text = [dic valueForKey:@"event_date"];
            
            _titleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
        }
        
        [cell.propertiesListTapBtn setTitle:Localized(@"Properties List") forState:UIControlStateNormal];
        
        [cell.auctionSummaryBtnTap setTitle:Localized(@"Auction Summary") forState:UIControlStateNormal];
        
        [cell.propertiesListTapBtn.layer setCornerRadius:5.0f];
        [cell.auctionSummaryBtnTap.layer setCornerRadius:5.0f];
        
        [cell.propertiesListTapBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.auctionSummaryBtnTap addTarget:self action:@selector(checkBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else{
        
    }

    return 0;
}

-(void)checkBtnClicked:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tableView];

    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonFrame.origin];
    
    _mojImahe.hidden = NO;
    _mojDateLbl.hidden = NO;
    _clendarBtn.hidden = NO;
    _mojTitleLbl.hidden = NO;
    _tableView.hidden = YES;
    _searchBar.hidden = YES;
    
    _lineLbl.hidden = YES;
    _searchIconBtn.hidden = YES;
    _searchBackBtn.hidden = YES;
    _searchTextLbl.hidden = YES;
    
    popUpList = [[resultArray valueForKey:@"auctions"] objectAtIndex:indexPath.row];
    
    [_mojImahe setImageWithURL:[[resultArray valueForKey:@"image"] objectAtIndex:indexPath.row] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _mojDateLbl.text = [[resultArray valueForKey:@"event_date"] objectAtIndex:indexPath.row];
    
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults];
    [sta setObject:[resultArray objectAtIndex:indexPath.row] forKey:@"aucList"];
    [sta synchronize];
    
    NSUserDefaults *sta1 = [NSUserDefaults standardUserDefaults];
    [sta1 setObject:[[resultArray valueForKey:@"auctions"] objectAtIndex:indexPath.row] forKey:@"aucList1"];
    [sta1 synchronize];


    NSUserDefaults *sta2 = [NSUserDefaults standardUserDefaults];
    [sta2 setObject:[[resultArray valueForKey:@"image"] objectAtIndex:indexPath.row] forKey:@"popImage"];
    [sta2 synchronize];
    
    count = indexPath.row;
    _backGroundViewImage.hidden = NO;
    _backGroundView.hidden = NO;
    _priceListView.hidden = NO;
    _titleLbl.hidden = NO;
    _tradesTableView.hidden = NO;
    _propertyListBackBtn.hidden = NO;
    NSMutableDictionary *dic = [resultArray objectAtIndex:indexPath.row];
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        _titleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
        
        _mojTitleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
    }
    else{
        
        _titleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
        
        _mojTitleLbl.text = [[dic valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
    }
    
    NSLog(@"disc value is %@",[[resultArray valueForKey:@"auctions"] objectAtIndex:indexPath.row]);
    
    [_tradesTableView reloadData];
    
}

-(void)checkBtnClicked1:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tableView];
    
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonFrame.origin];
    
    popUpList = [resultArray objectAtIndex:indexPath.row];
    
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults];
    [sta setObject:[resultArray objectAtIndex:indexPath.row] forKey:@"aucList"];
    [sta synchronize];
    
    NSUserDefaults *sta1 = [NSUserDefaults standardUserDefaults];
    [sta1 setObject:[[resultArray valueForKey:@"auctions"] objectAtIndex:indexPath.row] forKey:@"aucList1"];
    [sta1 synchronize];
    
    Auctions1ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"Auctions1ViewController"];
    obj.auctionList = [resultArray objectAtIndex:indexPath.row];
    obj.popUpList1 = [[resultArray valueForKey:@"auctions"] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:obj animated:YES];
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        
//        _auctionOrganizerValue.text = [[popUpList valueForKey:@"organiser"] valueForKey:@"organiser_name_arabic"];
//        _dateValue.text = [popUpList valueForKey:@"event_date"];
//        _venueValu.text = [popUpList valueForKey:@"venue_arabic"];
//        _propertyTypeValue.text = [[popUpList valueForKey:@"properties"][0] valueForKey:@"value_arabic"];
//        _propertyArea.text = [[popUpList valueForKey:@"areas"][0] valueForKey:@"value_arabic"];
//        _propertListedValue.text = [popUpList valueForKey:@"num_properties_listed"];
//        _propertySoldValue.text = [popUpList valueForKey:@"num_properties_sold"];
//        _propertyNotSoldVlaue.text = [popUpList valueForKey:@"num_properties_Notsold"];
//        _totalSaleValue.text = [popUpList valueForKey:@"total_sale"];
//        _propertyDescValue.text = [popUpList valueForKey:@"event_description_arabic"];
//        _additionalnfoValue.text = [popUpList valueForKey:@"event_additionalInfo_arabic"];
//    }
//    else{
//        _auctionOrganizerValue.text = [[popUpList valueForKey:@"organiser"] valueForKey:@"organiser_name_english"];
//        _dateValue.text = [popUpList valueForKey:@"event_date"];
//        _venueValu.text = [popUpList valueForKey:@"venue_english"];
//        _propertyTypeValue.text = [[popUpList valueForKey:@"properties"][0] valueForKey:@"value_english"];
//        _propertyArea.text = [[popUpList valueForKey:@"areas"][0] valueForKey:@"value_english"];
//        _propertListedValue.text = [popUpList valueForKey:@"num_properties_listed"];
//        _propertySoldValue.text = [popUpList valueForKey:@"num_properties_sold"];
//        _propertyNotSoldVlaue.text = [popUpList valueForKey:@"num_properties_Notsold"];
//        _totalSaleValue.text = [popUpList valueForKey:@"total_sale"];
//        _propertyDescValue.text = [popUpList valueForKey:@"event_description_english"];
//        _additionalnfoValue.text = [popUpList valueForKey:@"event_additionalInfo_english"];
//    }
//    
//    NSLog(@"poplist is %@",popUpList);
//    
//    _summaryListView.hidden = NO;
    
//    [_tradesTableView reloadData];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tradesTableView) {
        
        if ([indexPath isEqual:self.tradesTableView.expandedContentIndexPath])
        {
            return 178.0f;
        }
        else
            return 70.0f;
    }
    
    else if(tableView == _tableView){
        
        return 120;
    }
    else{
        return 0;
    }
}

#pragma mark JNExpandableTableView DataSource
- (BOOL)tableView:(JNExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
    
//    TradesTableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
//    if ([tableArray containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]])
//    {
//        [cell.expandBtn setImage:[UIImage imageNamed:@"expandP.png"] forState:UIControlStateNormal];
//
//        [tableArray removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
//    }
//    else
//    {
//        [cell.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
//
//        [tableArray addObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
//    }
    
    UITableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
    cell2 = cell;

    if (![self.tradesTableView.expandedContentIndexPath isEqual:indexPath])
    {
        UITableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[TradesTableViewCell class]]) {
            //do specific code
//            TradesTableViewCell *cell2 = cell;
            [cell2.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
        }else{
            //            TradesTableViewCell *cell2 = [self.tradesTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.tradesTableView.expandedContentIndexPath.row-1 inSection:indexPath.section]];
        [cell2.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
        }
    }
    
    return YES;
}
- (void)tableView:(JNExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath
{
    
    Expand = YES;
    NSLog(@"Will Expand: %ld",(long)indexPath.row);
    
    UITableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];

    if (![self.tradesTableView.expandedContentIndexPath isEqual:indexPath])
    {
        UITableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[TradesTableViewCell class]]) {
            //do specific code
            TradesTableViewCell *cell2 = cell;
            [cell2.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
            
        }else{
//            TradesTableViewCell *cell2 = [self.tradesTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.tradesTableView.expandedContentIndexPath.row-1 inSection:indexPath.section]];
//            [cell2.expandBtn setImage:[UIImage imageNamed:@"expandM.png"] forState:UIControlStateNormal];
        }
    }
    
}
- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    Expand = NO;

    NSLog(@"Will Collapse: %ld",(long)indexPath.row);
   
    TradesTableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];

    if (![self.tradesTableView.expandedContentIndexPath isEqual:indexPath])
    {
//        TradesTableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
        [cell.expandBtn setImage:[UIImage imageNamed:@"expandP.png"] forState:UIControlStateNormal];

    }
    else{
//        TradesTableViewCell *cell = [self.tradesTableView cellForRowAtIndexPath:indexPath];
        [cell.expandBtn setImage:[UIImage imageNamed:@"expandP.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


- (IBAction)auctionsinfoBtnAction:(id)sender {
    [self showInfo:Localized(@"info_auction") :sender];
}

#pragma searchBar delegate.

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
    [_searchBar resignFirstResponder];
}

-(void)yourTextViewDoneButtonPressed
{
    // [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
    [_searchBar resignFirstResponder];
}




- (IBAction)calendarBtnTapped:(id)sender {
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    if([store respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // iOS 6
        [store requestAccessToEntityType:EKEntityTypeEvent
                              completion:^(BOOL granted, NSError *error) {
                                  if (granted)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self createEventAndPresentViewController:store];
                                      });
                                  }
                              }];
    } else
    {
        // iOS 5
        [self createEventAndPresentViewController:store];
    }

}

- (void)createEventAndPresentViewController:(EKEventStore *)store
{
    EKEvent *event = [self findOrCreateEvent:store];
    
    EKEventEditViewController *controller = [[EKEventEditViewController alloc] init];
    controller.event = event;
    controller.eventStore = store;
    controller.editViewDelegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (EKEvent *)findOrCreateEvent:(EKEventStore *)store
{
    NSString *title = @"Moj";
    
    // try to find an event
    
    EKEvent *event = [self findEventWithTitle:title inEventStore:store];
    
    // if found, use it
    
    if (event)
        return event;
    
    // if not, let's create new event
    
    event = [EKEvent eventWithEventStore:store];
    
    event.title = title;
    event.notes = @"Alhisba";
    event.location = @"Kuwait";
    event.calendar = [store defaultCalendarForNewEvents];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 4;
    event.startDate = [calendar dateByAddingComponents:components
                                                toDate:[NSDate date]
                                               options:0];
    components.hour = 1;
    event.endDate = [calendar dateByAddingComponents:components
                                              toDate:event.startDate
                                             options:0];
    
    return event;
}

- (EKEvent *)findEventWithTitle:(NSString *)title inEventStore:(EKEventStore *)store
{
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start range date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    
    // Create the end range date components
    NSDateComponents *oneWeekFromNowComponents = [[NSDateComponents alloc] init];
    oneWeekFromNowComponents.day = 7;
    NSDate *oneWeekFromNow = [calendar dateByAddingComponents:oneWeekFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                            endDate:oneWeekFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    
    for (EKEvent *event in events)
    {
        if ([title isEqualToString:event.title])
        {
            return event;
        }
    }
    
    return nil;
}


@end


