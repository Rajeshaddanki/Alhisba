//
//  AddsDetailsViewController.m
//  Alhisba
//
//  Created by Apple on 11/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AddsDetailsViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"


@interface AddsDetailsViewController (){
 
    UIButton *backBtn;
}

@end

@implementation AddsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"FAQ'S")];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    _callOwnerBtn.layer.cornerRadius = 10.0f;
    _callOwnerBtn.layer.masksToBounds = YES;
    
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
    
    [_bannerImage setImageWithURL:[_detailsArray valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _apartmentType.text = [NSString stringWithFormat:@"%@  %@",[[_detailsArray valueForKey:@"property_type_id"]valueForKey:@"value_english"],[[_detailsArray valueForKey:@"ad_type_id"]valueForKey:@"value_english"]];
    
     _areaLbl.text = [NSString stringWithFormat:@"%@",[[_detailsArray valueForKey:@"area_id"]valueForKey:@"value_english"]];
    
    _kuwaitDinarPrice.text = [NSString stringWithFormat:@"%@",[_detailsArray valueForKey:@"price_1"]];
    
    _propertyValue.text = [NSString stringWithFormat:@"%@",[_detailsArray valueForKey:@"plot_size"]];
    
    _spaceValue.text = [NSString stringWithFormat:@"%@",[_detailsArray valueForKey:@"space"]];
    
    _additionalInfoValue.text = [NSString stringWithFormat:@"%@",[_detailsArray valueForKey:@"additional_info_english"]];
    
    
    // label
//    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
//    tmpTitleLabel.text = Localized(@"FAQ'S");
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
//}

}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)clickForInfo:(id)sender{
//
//    [self showInfo:Localized(@"FAQ'S") :sender];
//}



- (IBAction)callOwnerBtnTapped:(id)sender {
    
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString: @"tel:8975656"] options:@{} completionHandler:nil];
}
@end
