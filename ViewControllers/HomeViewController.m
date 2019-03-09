//
//  HomeViewController.m
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "SaleCollectionViewCell.h"
#import "SVProgressHUD.h"
#import "UIViewController+MJPopupViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "RentCollectionViewCell.h"
#import "OfficeforRentCollectionViewCell.h"
#import "NewsCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "AuctionsViewController.h"
#import "instantValueEstimatorViewController.h"
#import "RegisterdTradesViewController.h"
#import "ReloanCalculatorViewController.h"
#import "PostAddViewController.h"
#import "PopViewControllerDelegate.h"
#import "ShowPopupViewController.h"
#import "MyCustomCollectionViewFlowLayout.h"
#import "AddsViewController.h"

@interface HomeViewController ()<SWRevealViewControllerDelegate,UIScrollViewDelegate>{
    
    UIButton *menuBtn,*postAdd,*lanBtn;
    CGFloat height;
    NSMutableArray *resultArray,*tradesImageArray,*newsArray;
    SWRevealViewController *revealViewController;
    NSMutableString *htmlString;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"INSTALLED"] isEqualToString:@"YES"]){
        [self showTCpopup];
    }
    
    revealViewController.delegate = self;
    
    // post btn corners ..
    resultArray = [[NSMutableArray alloc] init];
    _postAdBtn.layer.cornerRadius = 15.0f;
    _postAdBtn.clipsToBounds = YES;
    _postAdBtn.layer.masksToBounds = YES;
   // _postAdBtn.layer.borderWidth = 2.0f;
    
    _moreBtn.layer.cornerRadius = 15.0f; // this value vary as per your desire
    _moreBtn.clipsToBounds = YES;
    _moreBtn.layer.masksToBounds = YES;
   // _moreBtn.layer.borderWidth = 2.0f;

    _rentMoreBtn.layer.cornerRadius = 15.0f; // this value vary as per your desire
    _rentMoreBtn.clipsToBounds = YES;
    _rentMoreBtn.layer.masksToBounds = YES;
    // Services view corners
    
    _servicesView.layer.cornerRadius = 15.0f; // this value vary as per your desire
    _servicesView.clipsToBounds = YES;
    _servicesView.layer.masksToBounds = YES;
    //_servicesView.layer.borderWidth = 2.0f;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_servicesView.bounds];
    _servicesView.layer.masksToBounds = NO;
    _servicesView.layer.shadowColor = [UIColor blackColor].CGColor;
    _servicesView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    _servicesView.layer.shadowOpacity = 0.5f;
    _servicesView.layer.shadowPath = shadowPath.CGPath;

    
    _officeforRentBtn.layer.cornerRadius = 15.0f; // this value vary as per your desire
    _officeforRentBtn.clipsToBounds = YES;
    _officeforRentBtn.layer.masksToBounds = YES;

    _latestNewsMoreBtn.layer.cornerRadius = 15.0f; // this value vary as per your desire
    _latestNewsMoreBtn.clipsToBounds = YES;
    _latestNewsMoreBtn.layer.masksToBounds = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.view.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;

 // Menu button...
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
//     [menuBtn addTarget:self action:@selector(customSetup) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
 //   self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    
    lanBtn = [[UIButton alloc] init];
    lanBtn.frame = CGRectMake(0, 0, 50, 30);
    [lanBtn addTarget:self action:@selector(languageBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [lanBtn.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:16.0f]];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    else{
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:lanBtn];
   // self.navigationItem.leftBarButtonItem = backBarButtonItem1;

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,backBarButtonItem1,nil];
    
    
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:image];
    [imageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:80].active = YES;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.navigationItem.titleView = imageView;
    
    
    postAdd = [[UIButton alloc] init];
//    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    postAdd.frame = CGRectMake(0, 0, 100, 10);
    [postAdd addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [postAdd setTitle:Localized(@"+ Post Ad") forState:UIControlStateNormal];
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

    _saleCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    _rentCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    _officeforrentCollectionview.decelerationRate=UIScrollViewDecelerationRateFast;
    
    [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    
//    [_saleCollectionView setPagingEnabled:YES];
    
    tradesImageArray = [[NSMutableArray alloc] initWithObjects:@"instant.png",@"registered.png",@"auctions.png",@"ConstructionCost Estimator.png",@"Official AppraisalRequest.png",@"Re LoanCalculator.png",@"instant.png",@"registered.png",@"auctions.png",@"auctions.png", nil];
    
    [self customSetup];
    [self showHUD:@""];
    [self makePostCallForPage:SERVICES withParams:@{} withRequestCode:1];
}


#pragma Language button Clicked....

-(void)languageBtnTapped{
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
//        [Utils setLanguage:KEY_LANGUAGE_AR];
//        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
//        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
//    } else {
//        [Utils setLanguage:KEY_LANGUAGE_EN];
//        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
//        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
//    }
//
////    [APP_DELEGATE reloadUIForLanguageChange];
//   // [self customSetup];
//
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    for (UIWindow *window in windows) {
//        for (UIView *view in window.subviews) {
//            [view removeFromSuperview];
//            [window addSubview:view];
//        }
//    }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        //     [_languageBtn setImage:[UIImage imageNamed:@"je90.png"] forState:UIControlStateNormal];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];

        
    } else {
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        // [_languageBtn setImage:[UIImage imageNamed:@"ja90.png"] forState:UIControlStateNormal];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];

    }
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
            [window addSubview:view];
        }
    }
    [APP_DELEGATE reloadUIForLanguageChange];
    
    [_service1Collectionview reloadData];
    [_servicesCollectionView reloadData];
    [_saleCollectionView reloadData];
    [_rentCollectionView reloadData];
    [_officeforrentCollectionview reloadData];
    [_newsCollectionView reloadData];
    [self updateCellsLayout];
    [self updateCellsLayout1];
    [self updateCellsLayout2];
    [self updateCellsLayout3];
}


-(void)postAddBtnTapped{
    
    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
    [self.navigationController pushViewController:obj animated:YES];
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
            
            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
//                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
//
//                    case 1920:
//                        printf("iPhone 6+/6S+/7+/8+");
//                        //  self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-135;
//                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-50;
//                        break;
//                    case 2436:
//                        printf("iPhone X");
//                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-50;
//                        break;
//                    case 2688:
//                        printf("iPhone Xs Max");
//                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-50;
//
//                        break;
//                    default:
//                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-50;
//                        printf("unknown");
//                }
            }
            
        }else{
            
            [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
//                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
//
//                    case 1920:
//                        printf("iPhone 6+/6S+/7+/8+");
//                        // self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-135;
//                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-50;
//                        break;
//                    case 2436:
//                        printf("iPhone X");
//                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-50;
//                        break;
//                    case 2688:
//                        printf("iPhone Xs Max");
//                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-50;
//
//                        break;
//                    default:
//                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
//                        printf("unknown");
//                }
            }
        }
        
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
    if (reqeustCode == 1) {
        
        //    resultArray = result;
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [resultArray addObject:dictionary];
        }
        
        [_servicesCollectionView reloadData];
        [_service1Collectionview reloadData];
        
        [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];

        [self hideHUD];
    }
    else{
        
        NSLog(@"Result is %lu",(unsigned long)newsArray.count);
        newsArray = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [newsArray addObject:dictionary];
        }
        NSLog(@"n %@",[newsArray valueForKey:@"id"]);
        //[_newsTableView reloadData];
        
        [_newsCollectionView reloadData];
    }
}

#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;
    
    if (collectionView == _servicesCollectionView) {
        
      return resultArray.count;
    }
   else if (collectionView == _service1Collectionview) {
        
        return resultArray.count-3;
    }
    else if (collectionView == _saleCollectionView){
        
        return 10;
    }
    else if (collectionView == _rentCollectionView){
        
        return 10;
    }
    else if (collectionView == _officeforrentCollectionview){
        
        return 10;
    }
    else if (collectionView == _newsCollectionView){
        
        return 10;
    }

    else{
        return 0;
    }
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _servicesCollectionView) {
        
        HomeCollectionViewCell *cell = [self.servicesCollectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
        
        cell.cellBackView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f].CGColor;
        cell.cellBackView.layer.borderWidth = 2;
        cell.cellBackView.layer.cornerRadius = 12; // optional
        cell.cellBackView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.5f];
        

        [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        
        dic = [resultArray objectAtIndex:indexPath.row];
        
        cell.tradesImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tradesImageArray objectAtIndex:indexPath.row]]];
       
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            cell.tradesTitle.text = [dic valueForKey:@"name_arabic"];
            
        }
        else{
            cell.tradesTitle.text = [dic valueForKey:@"name_english"];
        }
        
        [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
        
//        [cell.tradesImage setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
//        cell.tradesTitle.numberOfLines = 4;
//        [cell.tradesTitle setFont:[UIFont boldSystemFontOfSize:16]];
//
//        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//            [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:12]];
//        }
//        else{
//            [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:12]];
//        }
        
        return cell;
    }
  else  if (collectionView == _service1Collectionview) {
        
        HomeCollectionViewCell *cell = [self.service1Collectionview dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
        
        cell.cellBackView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f].CGColor;
        cell.cellBackView.layer.borderWidth = 2;
        cell.cellBackView.layer.cornerRadius = 12; // optional
        cell.cellBackView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.5f];
        
        [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        
        dic = [resultArray objectAtIndex:indexPath.row+3];
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            cell.tradesTitle.text = [dic valueForKey:@"name_arabic"];
            
        }
        else{
            cell.tradesTitle.text = [dic valueForKey:@"name_english"];
        }
      
      [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
      
//        [cell.tradesImage setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      
      cell.tradesImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tradesImageArray objectAtIndex:indexPath.row+3]]];
      
       // cell.tradesTitle.numberOfLines = 4;
//        [cell.tradesTitle setFont:[UIFont boldSystemFontOfSize:16]];
      
//        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//            [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:12]];
//        }
//        else{
//            [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:12]];
//        }
      
        return cell;
    }
    else if (collectionView == _saleCollectionView){
        
        SaleCollectionViewCell *cell = [self.saleCollectionView dequeueReusableCellWithReuseIdentifier:@"SaleCollectionViewCell" forIndexPath:indexPath];
        
       cell.layer.borderColor = [UIColor clearColor].CGColor;
        cell.layer.borderWidth= 5.0f;
        cell.layer.cornerRadius = 15.0f;
        cell.layer.masksToBounds= YES;
        

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


        return cell;
    }
    else if (collectionView == _rentCollectionView){
        
        RentCollectionViewCell *cell = [self.rentCollectionView dequeueReusableCellWithReuseIdentifier:@"RentCollectionViewCell" forIndexPath:indexPath];
        
    //    cell.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
//        cell.layer.borderWidth= 2.0f;
//        cell.layer.cornerRadius = 15.0f;
//        cell.layer.masksToBounds= YES;
        
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

        
        return cell;
    }
    else if (collectionView == _officeforrentCollectionview){
        
        OfficeforRentCollectionViewCell *cell = [self.officeforrentCollectionview dequeueReusableCellWithReuseIdentifier:@"OfficeforRentCollectionViewCell" forIndexPath:indexPath];
        
//        cell.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
//        cell.layer.borderWidth= 2.0f;
//        cell.layer.cornerRadius = 15.0f;
//        cell.layer.masksToBounds= YES;
        
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

        
        return cell;
    }
    else if (collectionView == _newsCollectionView){
        
        NewsCollectionViewCell *cell = [self.newsCollectionView dequeueReusableCellWithReuseIdentifier:@"NewsCollectionViewCell" forIndexPath:indexPath];
        
        cell.salesImage.layer.borderColor = [UIColor clearColor].CGColor;
        cell.salesImage.layer.borderWidth= 2.0f;
        cell.salesImage.layer.cornerRadius = 15.0f;
        cell.salesImage.layer.masksToBounds= YES;
        
        
        cell.layer.borderColor = [UIColor clearColor].CGColor;
        cell.layer.borderWidth= 5.0f;
        cell.layer.cornerRadius = 15.0f;
        cell.layer.masksToBounds= YES;
        
        cell.contentView.layer.cornerRadius = 15.0f;
        cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
//        cell.layer.shadowColor = [UIColor blackColor].CGColor;
//        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
//        cell.layer.shadowRadius = 2.0f;
//        cell.layer.shadowOpacity = 0.5f;
//        cell.layer.masksToBounds = NO;
//        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        
        NSMutableDictionary *dic = [newsArray objectAtIndex:indexPath.row];
        cell.landlbl.text = [dic  valueForKey:@"title_english"];
      //  cell.landLbl1.text = [dic  valueForKey:@"title_english"];

        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            htmlString = [dic  valueForKey:@"small_content_english"];
        }
        else{
            htmlString = [dic  valueForKey:@"small_content_english"];
            
        }
        
        [cell.salesImage setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

        cell.landLbl1.text = htmlString;

        return cell;
    }
    else{
        
        return 0;
    }
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (collectionView == _servicesCollectionView) {
     
        if (indexPath.row ==2) {
            
    AuctionsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionsViewController"];
    [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==0) {
            
            instantValueEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimatorViewController"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==1) {
            
            RegisterdTradesViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterdTradesViewController"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
    }
    
    if (collectionView == _service1Collectionview) {
        
        if (indexPath.row ==2) {
            
            ReloanCalculatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ReloanCalculatorViewController"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==1) {
            
            AddsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsViewController"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
    }
    
}


//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if (collectionView == _servicesCollectionView) {
//
//        height = self.servicesCollectionView.frame.size.height;
//        CGFloat width  = self.servicesCollectionView.frame.size.width;
//        return CGSizeMake(width/3-15,120);
//    }
//   else if (collectionView == _service1Collectionview) {
//
//        height = self.service1Collectionview.frame.size.height;
//        CGFloat width  = self.service1Collectionview.frame.size.width;
//        return CGSizeMake(width/3-8,120);
//    }
//    else{
//
//        return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
//    }
//
//}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _servicesCollectionView) {
        
        height = self.servicesCollectionView.frame.size.height;
        CGFloat width  = self.servicesCollectionView.frame.size.width;
        return CGSizeMake(width/3-15,120);
    }
    else if (collectionView == _service1Collectionview) {
        
        height = self.service1Collectionview.frame.size.height;
        CGFloat width  = self.service1Collectionview.frame.size.width;
        return CGSizeMake(width/3-8,120);
    }
    else if(collectionView == _saleCollectionView){
        
     //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 200+160;
        return cellSize;
    }
    else if(collectionView == _rentCollectionView){
        
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 200+160;
        return cellSize;
    }
    else if(collectionView == _officeforrentCollectionview){
        
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 200+160;
        return cellSize;
    }
    else{
//           return  CGSizeMake(collectionView.frame.size.width-120, 200+160);
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 200+160;
        return cellSize;

    }
}


//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//
//    if (collectionView == _servicesCollectionView) {
//      return UIEdgeInsetsMake(0, 6,0, 6); // top, left, bottom, right
//    }
//   else if (collectionView == _service1Collectionview) {
//        return UIEdgeInsetsMake(0, 6,0, 6); // top, left, bottom, right
//    }
//    else if(collectionView == _saleCollectionView){
//      return UIEdgeInsetsMake(0, 30,0, 30); // top, left, bottom, right
//    }
//    else{
//         return UIEdgeInsetsMake(0, 30,0, 30); // top, left, bottom, right
//    }
//
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 50;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//   return 50;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == _servicesCollectionView) {
        return 4;
            }
           else if (collectionView == _service1Collectionview) {
                return  4;
            }
            else if(collectionView == _saleCollectionView){
                return 0;
            }
            else{
                return 0;
            }
}

- (IBAction)postAdBtnTapped:(id)sender {
    
//    _postAdBtn.layer.cornerRadius = 10.0f; // this value vary as per your desire
//    _postAdBtn.clipsToBounds = YES;
//    _postAdBtn.layer.masksToBounds = YES;
//   // _postAdBtn.layer.borderWidth = 2.0f;
//    _postAdBtn.layer.cornerRadius = _postAdBtn.bounds.size.height/2;
    
}

- (IBAction)rentMoreBtnTapped:(id)sender {
}

- (IBAction)saleMoreBtnTapped:(id)sender {
}

- (IBAction)officeForRentBtnTappped:(id)sender {
}

- (IBAction)latestNewsMoreBtnTapped:(id)sender {
}

- (IBAction)menuBtnTapped:(id)sender {
    
    
}

- (IBAction)forwardBtnTapped:(id)sender {
    
        NSArray *visibleItems = [self.service1Collectionview indexPathsForVisibleItems];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
        if (currentItem.row+2>resultArray.count) {
    
            NSLog(@"No crash");
        }
        else{
            NSIndexPath *nextItem = [NSIndexPath indexPathForRow:currentItem.row+4 inSection:0];
    
            NSLog(@"next item%@",nextItem);
    
            if (currentItem.row+4 >= resultArray.count) {
    
                NSLog(@"no crash");
            }
            else{
    
                [_service1Collectionview scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
                
                [_service1Collectionview reloadData];
            }
        }
}

- (IBAction)backwardbtnTapped:(id)sender {
    
    NSArray *visibleItems = [self.service1Collectionview indexPathsForVisibleItems];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
    
        if (currentItem.item == 1) {
    
            NSIndexPath *nextItem = [NSIndexPath indexPathForRow:currentItem.row - 3 inSection:currentItem.section];
           
            [self.service1Collectionview scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
        }
        else{
            if (currentItem.item == 0) {
    
                NSLog(@"No crash");
            }
    
            else{
    
                NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 2 inSection:currentItem.section];
                
                [_service1Collectionview scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }
        }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    revealViewController.delegate = self;
//    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];

    // barTintColor sets the background color
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
    //     [menuBtn addTarget:self action:@selector(customSetup) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    //   self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    
    lanBtn = [[UIButton alloc] init];
    lanBtn.frame = CGRectMake(0, 0, 50, 30);
    [lanBtn addTarget:self action:@selector(languageBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [lanBtn.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:18.0f]];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    else{
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:lanBtn];
    // self.navigationItem.leftBarButtonItem = backBarButtonItem1;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,backBarButtonItem1,nil];

    postAdd = [[UIButton alloc] init];
    //    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    postAdd.frame = CGRectMake(0, 0, 100, 10);
    [postAdd addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [postAdd setTitle:Localized(@"+ Post Ad") forState:UIControlStateNormal];
    [postAdd.widthAnchor constraintEqualToConstant:90].active = YES;
    [postAdd.heightAnchor constraintEqualToConstant:32].active = YES;
    
    //    [postAdd.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:15.0]];
    //    [postAdd.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [postAdd.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:18.0f]];
    [postAdd setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    [postAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postAdd.layer.cornerRadius = 5.0f;
    postAdd.clipsToBounds = YES;
    postAdd.layer.masksToBounds = YES;
    //    [postAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:postAdd];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem1;

    
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 105, 105)];
    [imageView setImage:image];
    [imageView.widthAnchor constraintEqualToConstant:105].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:105].active = YES;
 //   imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [imageView.centerYAnchor constraintEqualToAnchor:].active = YES;

//    [imageView.topAnchor constraintEqualToConstant:110].active = YES;
//    [imageView.topAnchor constraintEqualToConstant:100].active = YES;
    
    imageView.layer.masksToBounds = true;
    
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.navigationItem.titleView = imageView;

    [self customSetup];

}

#pragma  RevealviewController Delegate...

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position;
{
    
    [self resignFirstResponder];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        static NSInteger tagLockView = 4207868622;
        if (revealController.frontViewPosition == FrontViewPositionLeft) {
            UIView *lock = [self.view viewWithTag:tagLockView];
            [UIView animateWithDuration:0.25 animations:^{
                lock.alpha = 0;
            } completion:^(BOOL finished) {
                [lock removeFromSuperview];
            }];
        } else if (revealController.frontViewPosition == FrontViewPositionRight) {
            UIView *lock = [[UIView alloc] initWithFrame:self.view.bounds];
            lock.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            lock.tag = tagLockView;
            lock.backgroundColor = [UIColor blackColor];
            lock.alpha = 0;
            [lock addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)]];
            [self.view addSubview:lock];
            [UIView animateWithDuration:0.75 animations:^{
                lock.alpha = 0.333;
            }];
        }
        
    } else {
        static NSInteger tagLockView = 4207868622;
        if (revealController.frontViewPosition == FrontViewPositionRight) {
            UIView *lock = [self.view viewWithTag:tagLockView];
            [UIView animateWithDuration:0.25 animations:^{
                lock.alpha = 0;
            } completion:^(BOOL finished) {
                [lock removeFromSuperview];
            }];
        } else if (revealController.frontViewPosition == FrontViewPositionLeft) {
            UIView *lock = [[UIView alloc] initWithFrame:self.view.bounds];
            lock.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            lock.tag = tagLockView;
            lock.backgroundColor = [UIColor blackColor];
            lock.alpha = 0;
            [lock addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)]];
            [self.view addSubview:lock];
            [UIView animateWithDuration:0.75 animations:^{
                lock.alpha = 0.333;
            }];
        }        }
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

//- (IBAction)bestSellerForward:(id)sender {
//
//    NSArray *visibleItems = [self.collectionView3 indexPathsForVisibleItems];
//    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
//
//    if (currentItem.item+2>mostProductsList.count) {
//
//        NSLog(@"No crash");
//    }
//    else{
//        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item + 2 inSection:currentItem.section];
//
//        NSLog(@"next item%@",nextItem);
//
//        if (currentItem.item+2==mostProductsList.count) {
//
//
//        }
//        else{
//
//            [_collectionView3 scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//        }
//
//    }
//}
//
//- (IBAction)bestSellerBackWard:(id)sender {
//    NSArray *visibleItems = [self.collectionView3 indexPathsForVisibleItems];
//    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
//
//
//    if (currentItem.item == 1) {
//
//        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 1 inSection:currentItem.section];
//        [self.collectionView3 scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//
//    }
//    else{
//        if (currentItem.item == 0) {
//
//            NSLog(@"No crash");
//        }
//
//        else{
//
//            NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 2 inSection:currentItem.section];
//            [_collectionView3 scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//        }
//    }
//
//
//}


-(void)showTCpopup{
    
    //NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"SETTINGS"];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    //    NSData *data = [currentDefaults objectForKey:@"SETTINGS"];
    NSDictionary *dict = [currentDefaults objectForKey:@"SETTINGS"];
    NSAttributedString *str = @"";
    //    if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
    //        str = [dict valueForKey:@"terms_ar"];
    //    }else{
    //        str = [dict valueForKey:@"terms"];
    //
    //    }
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        NSString *htmlString = [dict valueForKey:@"privacy_policy_app_ar"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                       options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                       documentAttributes: nil
                                                       error: nil
                                                       ];
        str = attributedString;
        
    } else {
        NSString *htmlString = [dict valueForKey:@"privacy_policy_app"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                       options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, }
                                                       documentAttributes: nil
                                                       error: nil
                                                       ];
        str = attributedString;
        
        
    }
    
    ShowPopupViewController *vc = [[ShowPopupViewController alloc] initWithNibName:@"ShowPopupViewController" bundle:nil];
    vc.delegate=self;
    vc.pptext = str;
    //    [self.navigationController pushViewController:vc animated:YES];
    vc.completionBlock2 = ^(NSString *area) {
        NSLog(@"%@",area);
        
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"INSTALLED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

-(void)updateCellsLayout{
    float centerX =_saleCollectionView.contentOffset.x+(self.view.frame.size.width)/2;
    NSArray *arr =[_saleCollectionView visibleCells];
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

-(void)updateCellsLayout1{
    float centerX =_rentCollectionView.contentOffset.x+(self.view.frame.size.width)/2;
    NSArray *arr =[_rentCollectionView visibleCells];
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

-(void)updateCellsLayout2{
    float centerX =_officeforrentCollectionview.contentOffset.x+(self.view.frame.size.width)/2;
    NSArray *arr =[_officeforrentCollectionview visibleCells];
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
-(void)updateCellsLayout3{
    float centerX =_newsCollectionView.contentOffset.x+(self.view.frame.size.width)/2;
    NSArray *arr =[_newsCollectionView visibleCells];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateCellsLayout];
    [self updateCellsLayout1];
    [self updateCellsLayout2];
    [self updateCellsLayout3];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self updateCellsLayout];
    [self updateCellsLayout1];
    [self updateCellsLayout2];
    [self updateCellsLayout3];
}

@end
