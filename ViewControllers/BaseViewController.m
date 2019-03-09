//
//  BaseViewController.m
//  StreetWhere
//
//  Created by Amit Kulkarni on 10/04/15.
//  Copyright (c) 2015 Mobentia. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "Common.h"
#import "UIImage+GIF.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

//#import <GoogleAnalytics/GAI.h>
//#import <GoogleAnalytics/GAIDictionaryBuilder.h>
//#import <GoogleAnalytics/GAIFields.h>
#import "CMPopTipView.h"


@interface BaseViewController () <UIGestureRecognizerDelegate,MBProgressHUDDelegate,CMPopTipViewDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong)    NSMutableArray    *visiblePopTipViews;
@property (nonatomic, strong)    id                currentPopTipViewTarget;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    
 self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshItems)
                  forControlEvents:UIControlEventValueChanged];
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];;
    //    self.navigationController.navigationBar.translucent = YES;

    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAds)];

    //self.navigationController.navigationBar.opaque = YES;
    // self.navigationController.navigationBar.translucent = NO;
    
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:9.0f/255.0f green:118.0f/255.0f blue:221.0f/255.0f alpha:1], NSForegroundColorAttributeName,nil]];
  
    /*
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
        
    } else if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"GE Flow" size:17], NSFontAttributeName, nil]];
    }
    */
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [[UITableViewCell appearance] setTintColor:[UIColor colorWithRed:0.161  green:0.569  blue:0.718 alpha:1]];

    self.dismissProgress = YES;
}

- (void)showSideMenu {

}

- (void)refreshItems {
}

/*
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar1 {
    [searchBar resignFirstResponder];
    searchBar.hidden = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1 {
    [searchBar resignFirstResponder];
    searchBar.hidden = YES;

//    SearchViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"searchads"];
//    vc.searchTerm = searchBar.text;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchAds {
    if (!searchBar) {
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [searchBar setDelegate:self];
        [searchBar setShowsCancelButton:YES animated:YES];
        [self.view addSubview:searchBar];
        [self.view bringSubviewToFront:searchBar];
        
        // Remove the icon, which is located in the left view
        [UITextField appearanceWhenContainedIn:[UISearchBar class], nil].leftView = nil;
        
        // Give some left padding between the edge of the search bar and the text the user enters
        searchBar.searchTextPositionAdjustment = UIOffsetMake(10, 0);
    }
    searchBar.hidden = NO;
    [searchBar becomeFirstResponder];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code {
    
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }
    requestCode = code;
    [self performSelectorOnMainThread:@selector(showHUD:) withObject:nil waitUntilDone:YES];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
//    [dictionary setValue:[[MCLocalization sharedInstance] language] forKey:@"lang"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[[Utils createURLForPage:page withParameters:dictionary] absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [self.refreshControl endRefreshing];
        if (self.dismissProgress) [MBProgressHUD hideHUDForView:self.view animated:YES];
        //[self hideHUD];
        [self parseResult:responseObject withCode:requestCode];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (self.dismissProgress) [self hideHUD];
        NSLog(@"Error: %@", error);
    }];
}

- (void) makeGetCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code {
    
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }

    requestCode = code;
    [self performSelectorOnMainThread:@selector(showHUD:) withObject:nil waitUntilDone:YES];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
    [dictionary setValue:[[MCLocalization sharedInstance] language] forKey:@"lang"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[[Utils createURLForPage:page withParameters:dictionary] absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [self.refreshControl endRefreshing];
        if (self.dismissProgress)
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self hideHUD];
        [self parseResult:responseObject withCode:requestCode];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (self.dismissProgress) [self hideHUD];
        NSLog(@"Error: %@", error);
    }];
}

- (void) parseResult:(id) result withCode:(int)reqeustCode {
}

#pragma mark - textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Alerts

- (void) showSuccessMessage:(NSString *)message {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"OK") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void) showErrorAlertWithMessage:(NSString *)message {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"OK") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}
- (UIImage *)captureView: (UIView *)view inSize: (CGSize)size
{
   // UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);


    CGSize viewSize = view.frame.size;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect drawRect = CGRectMake(view.frame.origin.x, view.frame.origin.y,view.frame.size.width, view.frame.size.height);

    CGContextSetRGBFillColor(context, 1.0f/255.0f, 33.0f/255.0f, 72.0f/255.0f, 1.0f);
    CGContextFillRect(context, drawRect);
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];


    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;


}
//- (UIImage *)captureView: (UIView *)view inSize: (CGSize)size{
//  
//    // Begin context
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
//    
//    // Draw view in that context
//    drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
//    
//    // And finally, get image
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return image;
//    
//}
#pragma mark - HUD

- (void) showHUD:(NSString *)labelText {
    
    [HUD hideAnimated:true];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    
    HUD.label.text = labelText;
    HUD.bezelView.color = [UIColor clearColor];
    UIImageView *imageViewAnimatedGif = [[UIImageView alloc]init];
    
    //The key here is to save the GIF file or URL download directly into a NSData instead of making it a UIImage. Bypassing UIImage will let the GIF file keep the animation.
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"all" ofType: @"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile: filePath];
    imageViewAnimatedGif.image = [UIImage sd_animatedGIFWithData:gifData];
    
    HUD.customView = [[UIImageView alloc] initWithImage:imageViewAnimatedGif.image];
    CABasicAnimation *rotation;
   // rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 0.7f; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    rotation.removedOnCompletion = false;
   // [HUD.customView.layer addAnimation:rotation forKey:@"Spin"];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.contentColor = [UIColor redColor];
    [HUD showAnimated:NO];

//    [SVProgressHUD showImage:[UIImage imageNamed:@"logo.gif"] status:@""];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
}

- (void) hideHUD {
    
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
                withCallback:(void (^)(id))resultCallback {
    
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }
    
    [self performSelectorOnMainThread:@selector(showHUD:) withObject:nil waitUntilDone:YES];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
    [dictionary setValue:[[MCLocalization sharedInstance] language] forKey:@"lang"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[[Utils createURLForPage:page withParameters:dictionary] absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self.refreshControl endRefreshing];
        if (self.dismissProgress) [self hideHUD];
        resultCallback(responseObject);
        
        //[self parseResult:responseObject withCode:requestCode];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (self.dismissProgress) [self hideHUD];
        NSLog(@"Error: %@", error);
    }];
}

-(NSString*)decodeHTMLString:(NSString *)str{
    NSString* htmlString = str;
    NSData* stringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString* decodedAttributedString = [[NSAttributedString alloc] initWithData:stringData options:options documentAttributes:NULL error:NULL];
    NSString* decodedString = [decodedAttributedString string];
    NSLog(@"de%@",decodedString);
    return decodedString;
}

-(UIView*)addborderAndRoundRectTo:(UIView*)view;
{
    view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor blackColor ].CGColor;
        view.layer.cornerRadius=5;
       view.clipsToBounds=YES;
    return view;
}

-(void)addPushAnimation{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}
-(void)addPopAnimation{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}
- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (void)showInfo:(NSString*)Information:(id)sender
{
    [self dismissAllPopTipViews];
    
  
    if (sender == self.currentPopTipViewTarget) {
        // Dismiss the popTipView and that is all
        self.currentPopTipViewTarget = nil;
    }
    else {
        NSString *contentMessage = nil;
        UIView *contentView = nil;
    
//        contentMessage = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",Information,Information,Information,Information,Information,Information];
        contentMessage = Information;

        UIColor *backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:1];
        UIColor *textColor = [UIColor whiteColor];
        
        
        CMPopTipView *popTipView;
    
            popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
    
        popTipView.delegate = self;
        
        /* Some options to try.
         */
        //popTipView.disableTapToDismiss = YES;
        //popTipView.preferredPointDirection = PointDirectionUp;
        //popTipView.hasGradientBackground = NO;
        //popTipView.cornerRadius = 2.0;
        //popTipView.sidePadding = 30.0f;
        //popTipView.topMargin = 20.0f;
        //popTipView.pointerSize = 50.0f;
        //popTipView.hasShadow = NO;
        
        if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
            popTipView.backgroundColor = backgroundColor;
        }
        if (textColor && ![textColor isEqual:[NSNull null]]) {
            popTipView.textColor = textColor;
        }
        
//        popTipView.animation = arc4random() % 2;
//        popTipView.has3DStyle = (BOOL)(arc4random() % 2);
        popTipView.animation = YES;
        popTipView.has3DStyle = NO;
        popTipView.dismissTapAnywhere = YES;
       // [popTipView autoDismissAnimated:YES atTimeInterval:5.0];
        
        if ([sender isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)sender;
            [popTipView presentPointingAtView:button inView:self.view animated:YES];
        }
        else {
            UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
            [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
        }
        
        [self.visiblePopTipViews addObject:popTipView];
        self.currentPopTipViewTarget = sender;
    }
}


#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}


#pragma mark - UIViewController methods

- (void)willAnimateRotationToInterfaceOrientation:(__unused UIInterfaceOrientation)toInterfaceOrientation duration:(__unused NSTimeInterval)duration
{
    for (CMPopTipView *popTipView in self.visiblePopTipViews) {
        id targetObject = popTipView.targetObject;
        [popTipView dismissAnimated:NO];
        
        if ([targetObject isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)targetObject;
            [popTipView presentPointingAtView:button inView:self.view animated:NO];
        }
        else {
            UIBarButtonItem *barButtonItem = (UIBarButtonItem *)targetObject;
            [popTipView presentPointingAtBarButtonItem:barButtonItem animated:NO];
        }
    }
}
-(NSString *)strToCurrencyFormatter:(NSString *)num{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:0];
    [formatter setGroupingSeparator: [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    [formatter setGroupingSize:3];
    [formatter setSecondaryGroupingSize:3];

    NSNumber *num1 = @([num intValue]);
    NSString *str = [formatter stringFromNumber:num1];
    return str;
}
-(NSString*)anyLangtoEnglish:(NSString*)str{
    NSString *NumberString = @"۸۸۸";
    NSNumberFormatter *Formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"EN"];
    [Formatter setLocale:locale];
    NSNumber *newNum = [Formatter numberFromString:NumberString];
    if (newNum) {
        NSLog(@"%@", newNum);
    }
    return [NSString stringWithFormat:@"%@",newNum];
}
-(NSString *)convertToEnglishNumber:(NSString *) string {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"fa"];
    for (NSInteger i = 0; i < 10; i++) {
        NSNumber *num = @(i);
        string = [string stringByReplacingOccurrencesOfString:[formatter stringFromNumber:num] withString:num.stringValue];
    }
    
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ar"];
    for (NSInteger i = 0; i < 10; i++) {
        NSNumber *num = @(i);
        string = [string stringByReplacingOccurrencesOfString:[formatter stringFromNumber:num] withString:num.stringValue];
    }
    
    return string;
}
@end
