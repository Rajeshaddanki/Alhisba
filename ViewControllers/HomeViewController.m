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
#import "CostEstimatorViewController.h"
#import "detailsViewController.h"
#import "NewViewController.h"
#import "TermsofUseViewController.h"
#import "FaqsViewController.h"
#import "ContactUsViewController.h"
#import "AboutUsViewController.h"
#import "PrivacyPolicyViewController.h"
#import "OfficialApraisalViewController.h"
#import "InstantValueEstimatorForRentsViewController.h"
#import "AccountViewController.h"


@interface HomeViewController ()<SWRevealViewControllerDelegate,UIScrollViewDelegate>{
    
    UIButton *menuBtn,*postAdd,*lanBtn;
    CGFloat height;
    NSMutableArray *resultArray,*tradesImageArray,*newsArray,*addsArray;
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
    
    _coverView.hidden = NO;
    
    [self.navigationController.navigationBar setHidden:YES];

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
    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_servicesView.bounds];
//    _servicesView.layer.masksToBounds = NO;
//    _servicesView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _servicesView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    _servicesView.layer.shadowOpacity = 0.5f;
//    _servicesView.layer.shadowPath = shadowPath.CGPath;
    
     _servicesView.clipsToBounds = false;
     _servicesView.layer.shadowOpacity=0.1;
     _servicesView.layer.shadowOffset =CGSizeMake(0, 5);


    
    _forSaleWantedLbl.text = Localized(@"For Sale/Wanted");
    [_moreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _forRentLbl.text = Localized(@"For Rent");
    [_rentMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];

    _officeForrentLbl.text = Localized(@"Office For Rent");
    [_officeforRentBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _latestNewsLbl.text = Localized(@"Latest News");
    [_latestNewsMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    
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
    
    //menuBtn = [[UIButton alloc] init];
    [_sideMenuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    //_sideMenuBtn.frame = CGRectMake(0, 0, 30, 30);
//     [menuBtn addTarget:self action:@selector(customSetup) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
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
    
    //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,backBarButtonItem1,nil];
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,nil];

    
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:image];
    [imageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:80].active = YES;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.navigationItem.titleView = imageView;
    
//    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    _postAddBtn.frame = CGRectMake(0, 0, 100, 10);
//    [_postAddBtn addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
//    [_postAddBtn setTitle:Localized(@"+ Post Ad") forState:UIControlStateNormal];
//    [_postAddBtn.widthAnchor constraintEqualToConstant:70].active = YES;
//    [_postAddBtn.heightAnchor constraintEqualToConstant:35].active = YES;
//
////    [postAdd.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:15.0]];
////    [postAdd.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
//    [_postAddBtn.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:40.0f]];
//
//    [_postAddBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
//    [_postAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    _postAddBtn.layer.cornerRadius = 5.0f;
//    _postAddBtn.clipsToBounds = YES;
//    _postAddBtn.layer.masksToBounds = YES;
//    [postAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
//    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:postAdd];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem1;

    _saleCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    _rentCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    _officeforrentCollectionview.decelerationRate=UIScrollViewDecelerationRateFast;
    
    [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
    [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
    [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];

    
    
//    [_saleCollectionView setPagingEnabled:YES];
    
    tradesImageArray = [[NSMutableArray alloc] initWithObjects:@"instant.png",@"registered.png",@"auctions.png",@"Re LoanCalculator.png",@"RegisteredTrades.png",@"ConstructionCost Estimator.png",@"approved.png",@"instant.png",@"instant.png", nil];
    
    [self customSetup];
    
    [self showHUD:@""];
    
    [self makePostCallForPage:SERVICES withParams:@{} withRequestCode:1];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.gradientImageV.bounds;
    
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
    
    [self.gradientImageV setImage:gradientImage1];
    
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = self.greadientImageV1.bounds;
    
    CGRect gradientFrame1 = self.navigationController.navigationBar.bounds;
    gradientFrame1.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
    gradientLayer1.frame = gradientFrame1;
    
    gradientLayer1.colors = @[ (__bridge id)[UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:147.0f/255.0f alpha:1].CGColor,
                              (__bridge id)[UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:147.0f/255.0f alpha:1].CGColor ];
    //    gradientLayer.startPoint = CGPointMake(1.0, 0);
    //    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext(gradientLayer1.bounds.size);
    [gradientLayer1 renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.greadientImageV1 setImage:gradientImage2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];

}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}


#pragma Language button Clicked....

-(void)languageBtnTapped{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        //     [_languageBtn setImage:[UIImage imageNamed:@"je90.png"] forState:UIControlStateNormal];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
        
        [_forwardBtn setImage:[UIImage imageNamed:@"whiteRight.png"] forState:UIControlStateNormal];
        
        [_backWardBtn setImage:[UIImage imageNamed:@"whiteLeft.png"] forState:UIControlStateNormal];
        
    } else {
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        // [_languageBtn setImage:[UIImage imageNamed:@"ja90.png"] forState:UIControlStateNormal];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
        
        [_forwardBtn setImage:[UIImage imageNamed:@"whiteLeft.png"] forState:UIControlStateNormal];
        
        [_backWardBtn setImage:[UIImage imageNamed:@"whiteRight.png"] forState:UIControlStateNormal];

    }
    
    [APP_DELEGATE reloadUIForLanguageChange];
    [APP_DELEGATE afterLoginSucess];

//    NSArray *windows = [UIApplication sharedApplication].windows;
//    for (UIWindow *window in windows) {
//        for (UIView *view in window.subviews) {
//            [view removeFromSuperview];
//            [window addSubview:view];
//        }
//    }
    
    _forSaleWantedLbl.text = Localized(@"For Sale/Wanted");
    [_moreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _forRentLbl.text = Localized(@"For Rent");
    [_rentMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    
    _officeForrentLbl.text = Localized(@"Office For Rent");
    [_rentMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _latestNewsLbl.text = Localized(@"Latest News");
    [_latestNewsMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    
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
    
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,backBarButtonItem1,nil];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,nil];

    [_service1Collectionview reloadData];
    [_servicesCollectionView reloadData];
    [_saleCollectionView reloadData];
    [_rentCollectionView reloadData];
    [_officeforrentCollectionview reloadData];
    [_newsCollectionView reloadData];
   
    [self customSetup];
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self afterDelay:0.1 ];
    
}


-(void)postAddBtnTapped{
    
//    [self.navigationController.navigationBar setHidden:NO];
//
//    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
//    [self.navigationController pushViewController:obj animated:YES];
}

- (void)customSetup
{
    [_sideMenuBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            //            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            //            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-120;
            
            [_sideMenuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
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
            
            [_sideMenuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
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
        [self updateCellsLayout];
        [self updateCellsLayout1];
        [self updateCellsLayout2];
        [self updateCellsLayout3];

         [self showHUD:@""];
         [self makePostCallForPage:ADDS withParams:@{@"type":@"1"} withRequestCode:15];

    }
    else if (reqeustCode == 15){
        
        addsArray = result;
        
        [self.saleCollectionView reloadData];
        [self.rentCollectionView reloadData];
        
        [self updateCellsLayout];
        [self updateCellsLayout1];
        [self updateCellsLayout3];
        [self updateCellsLayout2];
        
        [self hideHUD];
        
        [self showHUD:@""];
        
        [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];

    }
    else{
        
       // NSLog(@"Result is %lu",(unsigned long)newsArray.count);
        newsArray = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [newsArray addObject:dictionary];
        }
       // NSLog(@"n %@",[newsArray valueForKey:@"id"]);
        //[_newsTableView reloadData];
        
        [self updateCellsLayout];
        [self updateCellsLayout1];
        [self updateCellsLayout3];
        [self updateCellsLayout2];
        [self hideHUD];
        _coverView.hidden = YES;

        [_newsCollectionView reloadData];

    }
   // [self hideHUD];
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
        
        cell.cellBackView.layer.borderColor = [UIColor clearColor].CGColor;
       // cell.cellBackView.layer.borderWidth = 2;
        cell.cellBackView.layer.cornerRadius = 12; // optional
        cell.cellBackView.backgroundColor = [UIColor  whiteColor];
        
        cell.contentView.layer.cornerRadius = 15.0f;
    //    cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 0.5f;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;

        
        [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        
        dic = [resultArray objectAtIndex:indexPath.row];
        
        NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        NSLog(@"index is %d",index.intValue);
        
//        if( index.intValue > 2){
//
//            cell.tradesImage.hidden = YES;
//            cell.tradesTitle.hidden = YES;
//            cell.cellBackView.hidden = YES;
//        }
//        else{
        
            cell.tradesImage.hidden = NO;
            cell.tradesTitle.hidden = NO;
            cell.cellBackView.hidden = NO;

            cell.tradesImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tradesImageArray objectAtIndex:indexPath.row]]];
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                
                cell.tradesTitle.text = [dic valueForKey:@"name_arabic"];
            }
            else{
                cell.tradesTitle.text = [dic valueForKey:@"name_english"];
            }
            [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
//        }
        
        return cell;
    }
    
  else  if (collectionView == _service1Collectionview) {
        
        HomeCollectionViewCell *cell = [self.service1Collectionview dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
        
      cell.cellBackView.layer.borderColor = [UIColor clearColor].CGColor;
      // cell.cellBackView.layer.borderWidth = 2;
      cell.cellBackView.layer.cornerRadius = 12; // optional
      cell.cellBackView.backgroundColor = [UIColor  whiteColor];
      
      cell.contentView.layer.cornerRadius = 15.0f;
      //    cell.contentView.layer.borderWidth = 5.0f;
      cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
      cell.contentView.layer.masksToBounds = YES;
      
      cell.layer.shadowColor = [UIColor blackColor].CGColor;
      cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
      cell.layer.shadowRadius = 2.0f;
      cell.layer.shadowOpacity = 0.5f;
      cell.layer.masksToBounds = NO;
      cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;


        
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
        
        cell.priceLbl.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%0.2f %@", st.floatValue,Localized(@"KD")]];

        cell.areaSizeLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"plot_size"]];
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];
            
            cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_arabic"];
            
            cell.areaTitleLbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_arabic"];

        }
        else{
            cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_english"];
            
            cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_english"];
            
            cell.areaTitleLbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_english"];

        }
        
        cell.price.text = Localized(@"Price");
        cell.areaSize.text = Localized(@"Area Size");
        
        

        return cell;
    }
    else if (collectionView == _rentCollectionView){
        
        RentCollectionViewCell *cell = [self.rentCollectionView dequeueReusableCellWithReuseIdentifier:@"RentCollectionViewCell" forIndexPath:indexPath];
        
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

        cell.priceLbl.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%0.2f %@", st.floatValue,Localized(@"KD")]];
        
        cell.areaSizeLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"plot_size"]];
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];
            
            cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_arabic"];
            
            cell.areaTitleLbl.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_arabic"];

        }
        else{
            cell.landInfo.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_english"];
            
            cell.landlbl.text = [[dic valueForKey:@"property_type_id"] valueForKey:@"value_english"];
            
            cell.areaTitleLbl.text = [[dic valueForKey:@"area_id"] valueForKey:@"value_english"];

        }
        
        cell.kuwaitDinarLbl.text = Localized(@"Kuwait Dinar");
        cell.areaSize.text = Localized(@"Area Size");
        cell.bathroomLbl.text = Localized(@"Bathrooms");


        
        return cell;
    }
    else if (collectionView == _officeforrentCollectionview){
        
        OfficeforRentCollectionViewCell *cell = [self.officeforrentCollectionview dequeueReusableCellWithReuseIdentifier:@"OfficeforRentCollectionViewCell" forIndexPath:indexPath];
        
//        cell.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
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

        
        return cell;
    }
    else if (collectionView == _newsCollectionView){
        
        NewsCollectionViewCell *cell = [self.newsCollectionView dequeueReusableCellWithReuseIdentifier:@"NewsCollectionViewCell" forIndexPath:indexPath];
        
        cell.salesImage.layer.borderColor = [UIColor clearColor].CGColor;
        cell.salesImage.layer.borderWidth= 2.0f;
        cell.salesImage.layer.cornerRadius = 15.0f;
        cell.salesImage.layer.masksToBounds= YES;
        
        [self updateCellsLayout];
        [self updateCellsLayout1];
        [self updateCellsLayout3];
        [self updateCellsLayout2];

        
        [cell.readMoreBtn setTitle:Localized(@"Read More") forState:UIControlStateNormal];
        
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
        
        
        cell.readMoreBtn.tag = indexPath.row;
        
        [cell.readMoreBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    else{
        
        return 0;
    }
}

-(void)buttonPressed:(UIButton*)sender
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [newsArray objectAtIndex:sender.tag];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (collectionView == _servicesCollectionView) {
     
        if (indexPath.row ==2) {
            
    AuctionsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionsViewController"];
            [self.navigationController.navigationBar setHidden:NO];

    [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==0) {
            
            instantValueEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimatorViewController"];
            [self.navigationController.navigationBar setHidden:NO];

            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==1) {
            
            RegisterdTradesViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterdTradesViewController"];
            [self.navigationController.navigationBar setHidden:NO];

            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==3) {
            
            ReloanCalculatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ReloanCalculatorViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==4) {
            
            AddsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==5) {
            
            CostEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CostEstimatorViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==6) {
            
            OfficialApraisalViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficialApraisalViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
        }
        if (indexPath.row ==7) {
            
            InstantValueEstimatorForRentsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"InstantValueEstimatorForRentsViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
    
    if (collectionView == _service1Collectionview) {
        
        if (indexPath.row ==0) {
            
            ReloanCalculatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ReloanCalculatorViewController"];
            [self.navigationController.navigationBar setHidden:NO];

            [self.navigationController pushViewController:obj animated:YES];
            
        }
        if (indexPath.row ==1) {
            
            AddsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsViewController"];
            [self.navigationController.navigationBar setHidden:NO];

            [self.navigationController pushViewController:obj animated:YES];
            
        }
        
        if (indexPath.row ==2) {
            
            CostEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CostEstimatorViewController"];
            [self.navigationController.navigationBar setHidden:NO];

            [self.navigationController pushViewController:obj animated:YES];
            
        }
        
        if (indexPath.row ==3) {
            
    OfficialApraisalViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficialApraisalViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
        }
        
        if (indexPath.row ==4) {
            
InstantValueEstimatorForRentsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"InstantValueEstimatorForRentsViewController"];
            [self.navigationController.navigationBar setHidden:NO];
            
            [self.navigationController pushViewController:obj animated:YES];
            
        }
    }
    
     if (collectionView == _newsCollectionView) {
       
         detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
         obj.detailsDic = [newsArray objectAtIndex:indexPath.row];
         [self.navigationController.navigationBar setHidden:NO];

         [self.navigationController pushViewController:obj animated:YES];
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
        return CGSizeMake(width/3-7,110);
    }
    else if (collectionView == _service1Collectionview) {
        
        height = self.service1Collectionview.frame.size.height;
        CGFloat width  = self.service1Collectionview.frame.size.width;
        return CGSizeMake(width/3-7,120);
    }
    else if(collectionView == _saleCollectionView){
        
     //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 320;
        return cellSize;
    }
    else if(collectionView == _rentCollectionView){
        
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 330;
       // cellSize.height = 200+160;
        return cellSize;
    }
    else if(collectionView == _officeforrentCollectionview){
        
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
       cellSize.height = 330;
        //cellSize.height = 200+160;
        return cellSize;
    }
    else{
//           return  CGSizeMake(collectionView.frame.size.width-120, 200+160);
        //   return  CGSizeMake(collectionView.frame.size.width-100, 200+160);
        CGSize cellSize = collectionView.bounds.size;
        cellSize.width -= collectionView.contentInset.left * 2;
        cellSize.width -= collectionView.contentInset.right * 2;
        //cellSize.width = collectionView.frame.size.width-120;
        cellSize.height = 340;
        //cellSize.height = 200+160;
        return cellSize;

    }
}


//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//
//    if (collectionView == _servicesCollectionView) {
//      return UIEdgeInsetsMake(0, 10,0, 10); // top, left, bottom, right
//    }
//   else if (collectionView == _service1Collectionview) {
//        return UIEdgeInsetsMake(0,10,0, 10); // top, left, bottom, right
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
    
    AddsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsViewController"];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:obj animated:YES];

}

- (IBAction)officeForRentBtnTappped:(id)sender {
}

- (IBAction)latestNewsMoreBtnTapped:(id)sender {
    
    NewViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)menuBtnTapped:(id)sender {
    
    [_sideMenuBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            //            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            //            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-120;
            
            [_sideMenuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
            }
            
        }else{
            
            [_sideMenuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
              
            }
        }
        
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
    
}

- (IBAction)forwardBtnTapped:(id)sender {
    
        NSArray *visibleItems = [self.servicesCollectionView indexPathsForVisibleItems];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
        if (currentItem.row+2>resultArray.count) {
    
            NSLog(@"No crash");
        }
        else{
            NSIndexPath *nextItem = [NSIndexPath indexPathForRow:currentItem.row+6 inSection:0];
    
            NSLog(@"next item%@",nextItem);
    
            if (currentItem.row+6 >= resultArray.count) {
    
                NSLog(@"no crash");
            }
            else{
    
                [_servicesCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
                [_servicesCollectionView reloadData];
            }
        }
}

- (IBAction)backwardbtnTapped:(id)sender {
    
    NSArray *visibleItems = [self.servicesCollectionView indexPathsForVisibleItems];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
    
        if (currentItem.item == 1) {
    
            NSIndexPath *nextItem = [NSIndexPath indexPathForRow:currentItem.row - 2 inSection:currentItem.section];
           
            [self.servicesCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
        }
        else{
            if (currentItem.item == 0) {
    
                NSLog(@"No crash");
            }
    
            else{
    
                NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 2 inSection:currentItem.section];
                
                [_servicesCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }
        }
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
    
    [self.navigationController.navigationBar setHidden:NO];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *myObject = [userInfo objectForKey:@"raj"];

    if ([myObject isEqualToString:@"terms"]) {
     
    TermsofUseViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsofUseViewController"];
        [self.navigationController pushViewController:obj animated:NO];
    }
   else if ([myObject isEqualToString:@"news"]) {
        
        NewViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
        [self.navigationController pushViewController:obj animated:NO];
    }
   else if ([myObject isEqualToString:@"account"]) {
       
       AccountViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
       [self.navigationController pushViewController:obj animated:NO];
   }
   else if ([myObject isEqualToString:@"home"]) {
       
//       NewViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
//       [self.navigationController pushViewController:obj animated:NO];
       
//       [self updateCellsLayout];
//       [self updateCellsLayout1];
//       [self updateCellsLayout3];
//       [self updateCellsLayout2];
//       [super viewWillLayoutSubviews];
//       [self viewDidLoad];
       
       _saleCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
       _rentCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
       _officeforrentCollectionview.decelerationRate=UIScrollViewDecelerationRateFast;
       
       //    [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
       //    [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
       //    [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
       //    [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
       
       [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
       [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
       [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
       [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];

       
       [self performSelector:@selector(scrollViewDidScroll:) withObject:self afterDelay:0.1 ];
       
       [self updateCellsLayout];
       [self updateCellsLayout2];
       [self updateCellsLayout1];
       [self updateCellsLayout3];
       [self viewWillLayoutSubviews];

       
   }
   else if ([myObject isEqualToString:@"about"]) {
       
       AboutUsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
       [self.navigationController pushViewController:obj animated:NO];
   }
   else if ([myObject isEqualToString:@"contact"]) {
       
       ContactUsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
       [self.navigationController pushViewController:obj animated:NO];
   }
   else if ([myObject isEqualToString:@"privacy"]) {
       
       PrivacyPolicyViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
       [self.navigationController pushViewController:obj animated:NO];
   }
   else if ([myObject isEqualToString:@"faqs"]) {
       
       FaqsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqsViewController"];
       [self.navigationController pushViewController:obj animated:NO];
   }
   else  {

   }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
   
    revealViewController.delegate = self;
  //  self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar setHidden:NO];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];

    [self.navigationController.navigationBar setHidden:YES];

    // barTintColor sets the background color
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    _saleCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
    _rentCollectionView.decelerationRate=UIScrollViewDecelerationRateFast;
   _officeforrentCollectionview.decelerationRate=UIScrollViewDecelerationRateFast;
    
//    [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
//    [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 10, 30)];
//    [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
//    [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];

    [_saleCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    [_rentCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    [_officeforrentCollectionview setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    [_newsCollectionView setContentInset:UIEdgeInsetsMake(0, 20, 0, 30)];
    
  //  menuBtn = [[UIButton alloc] init];
    
    
    [_sideMenuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
   // _sideMenuBtn.frame = CGRectMake(0, 0, 30, 30);
    
    
    //     [menuBtn addTarget:self action:@selector(customSetup) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
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
    
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,backBarButtonItem1,nil];
 //   self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backBarButtonItem,nil];

   // postAdd = [[UIButton alloc] init];
    //    [postAdd setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
 //   postAdd.frame = CGRectMake(0, 0, 100, 10);
    [_postAddBtn addTarget:self action:@selector(postAddBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [_postAddBtn setTitle:Localized(@"+ Post Ad") forState:UIControlStateNormal];
    [_postAddBtn.widthAnchor constraintEqualToConstant:70].active = YES;
    [_postAddBtn.heightAnchor constraintEqualToConstant:32].active = YES;
    
    //    [postAdd.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:15.0]];
    //    [postAdd.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [_postAddBtn.titleLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:18.0f]];
    [_postAddBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:194.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    [_postAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _postAddBtn.layer.cornerRadius = 5.0f;
    _postAddBtn.clipsToBounds = YES;
    _postAddBtn.layer.masksToBounds = YES;
    //    [postAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
//    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:postAdd];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem1;

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
    
//    UIView *headerView = [[UIView alloc] init];
//    headerView.frame = CGRectMake(0, 0, 320, 44);
//
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
//    imgView.frame = CGRectMake(headerView.frame.size.width-350, -25, 300, 75);
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
//
//    [headerView addSubview:imgView];
//
//    self.navigationController.navigationBar.topItem.titleView = headerView;
    

    _forSaleWantedLbl.text = Localized(@"For Sale");
    [_moreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _forRentLbl.text = Localized(@"For Rent");
    [_rentMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _officeForrentLbl.text = Localized(@"Office For Rent");
    [_rentMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    _latestNewsLbl.text = Localized(@"Latest News");
    [_latestNewsMoreBtn setTitle:Localized(@"More") forState:UIControlStateNormal];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [_forwardBtn setImage:[UIImage imageNamed:@"whiteLeft.png"] forState:UIControlStateNormal];
        
        [_backWardBtn setImage:[UIImage imageNamed:@"whiteRight.png"] forState:UIControlStateNormal];
        
    } else {
     
        [_forwardBtn setImage:[UIImage imageNamed:@"whiteRight.png"] forState:UIControlStateNormal];
        [_backWardBtn setImage:[UIImage imageNamed:@"whiteLeft.png"] forState:UIControlStateNormal];
    }
    
    [self customSetup];
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self afterDelay:0.1];
    
    [self updateCellsLayout];
    [self updateCellsLayout1];
    [self updateCellsLayout3];
    [self updateCellsLayout2];

    [self viewWillLayoutSubviews];
    
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
  
    [super viewWillLayoutSubviews];
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

- (IBAction)postAddBtnTaped:(id)sender {
    
    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:obj animated:YES];
}

@end
