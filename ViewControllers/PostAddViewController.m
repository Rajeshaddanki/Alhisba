//
//  PostAddViewController.m
//  Alhisba
//
//  Created by Apple on 05/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PostAddViewController.h"

@interface PostAddViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    
    UIButton *backBtn;
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
//    _saleMobileFld.delegate = self;
//    _rentCityFdl.delegate = self;
//    _rentPriceFld.delegate = self;
    
    _saleDes.delegate = self;
    _rentDes.delegate = self;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"Post Ad")];
    
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
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = (@"Post Ad");
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
    
    
    _chooseCateLbl.text = Localized(@"Choose Category");
    _selectLbl.text = Localized(@"Select");
    _addUptoLbl.text = Localized(@"Add up to 9 pictures & 1 Video");
   
    _addUptoView.layer.cornerRadius = 15.0f;
    _addUptoView.layer.masksToBounds = YES;
    
    
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:99.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    _saleCityFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"City") attributes:@{NSForegroundColorAttributeName: color}];
    
    _salePropertyTypeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Propeety Type") attributes:@{NSForegroundColorAttributeName: color}];
    
    _saleAreaSizeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Area Size") attributes:@{NSForegroundColorAttributeName: color}];
    
    _saleNameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Name*") attributes:@{NSForegroundColorAttributeName: color}];
   
    _saleMobileFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Mobile No*") attributes:@{NSForegroundColorAttributeName: color}];
    
    _rentCityFdl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"City") attributes:@{NSForegroundColorAttributeName: color}];
    _rentPriceFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Price") attributes:@{NSForegroundColorAttributeName: color}];
    _rentPropertyTypeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Property Type") attributes:@{NSForegroundColorAttributeName: color}];

    _rentNoofroomsFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Number of rooms") attributes:@{NSForegroundColorAttributeName: color}];
    
    _rentAreaSizeFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Area Size") attributes:@{NSForegroundColorAttributeName: color}];
   
    _rentNameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Name*") attributes:@{NSForegroundColorAttributeName: color}];
    
    _rentMobileNoFls.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Mobile No*") attributes:@{NSForegroundColorAttributeName: color}];
    
    _saleDes.layer.masksToBounds=YES;
    _saleDes.layer.borderWidth= 1.0f;
    _saleDes.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    _saleDes.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Description")]];
   
    [_saleDes setTextColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        _saleDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];

    }
    else{

        _saleDes.font = [UIFont fontWithName:@"Cairo-Regular" size:18];
    }
    
    _saleDes.textContainer.lineFragmentPadding = 20;

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
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Post Ad") :sender];
}


- (IBAction)selectBtnTapped:(id)sender {
}

- (IBAction)saveDraftBtnTapped:(id)sender {
}

- (IBAction)proceedBtnTapped:(id)sender {
}

- (IBAction)segmentTouchIns:(id)sender {
}


-(void)textFldBoarders{
    
 // Sale...
    
    _saleCityFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleCityFld.layer.borderWidth = 1.0f;
    _saleCityFld.layer.cornerRadius = 15.0f;
    
    _salePropertyTypeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _salePropertyTypeFld.layer.borderWidth = 1.0f;
    _salePropertyTypeFld.layer.cornerRadius = 15.0f;
    
    _saleAreaSizeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleAreaSizeFld.layer.borderWidth = 1.0f;
    _saleAreaSizeFld.layer.cornerRadius = 15.0f;
    
    _saleDes.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleDes.layer.borderWidth = 1.0f;
    _saleDes.layer.cornerRadius = 15.0f;
    
    _saleNameFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleNameFld.layer.borderWidth = 1.0f;
    _saleNameFld.layer.cornerRadius = 15.0f;
    
    
    _saleMobileFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _saleMobileFld.layer.borderWidth = 1.0f;
    _saleMobileFld.layer.cornerRadius = 15.0f;
    
  // Rent...
    
    
    _rentCityFdl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentCityFdl.layer.borderWidth = 1.0f;
    _rentCityFdl.layer.cornerRadius = 15.0f;
    
    _rentPriceFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentPriceFld.layer.borderWidth = 1.0f;
    _rentPriceFld.layer.cornerRadius = 15.0f;

    _rentPropertyTypeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentPropertyTypeFld.layer.borderWidth = 1.0f;
    _rentPropertyTypeFld.layer.cornerRadius = 15.0f;
    
    _rentNoofroomsFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentNoofroomsFld.layer.borderWidth = 1.0f;
    _rentNoofroomsFld.layer.cornerRadius = 15.0f;
    
    _rentAreaSizeFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentAreaSizeFld.layer.borderWidth = 1.0f;
    _rentAreaSizeFld.layer.cornerRadius = 15.0f;
    
    _rentDes.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentDes.layer.borderWidth = 1.0f;
    _rentDes.layer.cornerRadius = 15.0f;
    
    
    _rentNameFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentNameFld.layer.borderWidth = 1.0f;
    _rentNameFld.layer.cornerRadius = 15.0f;

    _rentMobileNoFls.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rentMobileNoFls.layer.borderWidth = 1.0f;
    _rentMobileNoFls.layer.cornerRadius = 15.0f;
    
    _saveDraftBtn.layer.cornerRadius = 15.0f;
    _proceedbtn.layer.cornerRadius = 15.0f;

}


-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleCityFld.rightView = paddingView;
        _saleCityFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _salePropertyTypeFld.rightView = paddingView1;
        _salePropertyTypeFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleAreaSizeFld.rightView = paddingView2;
        _saleAreaSizeFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleNameFld.rightView = paddingView3;
        _saleNameFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleMobileFld.rightView = paddingView4;
        _saleMobileFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentCityFdl.rightView = paddingView5;
        _rentCityFdl.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentPriceFld.rightView = paddingView6;
        _rentPriceFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentPropertyTypeFld.rightView = paddingView7;
        _rentPropertyTypeFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentNoofroomsFld.rightView = paddingView8;
        _rentNoofroomsFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentAreaSizeFld.rightView = paddingView9;
        _rentAreaSizeFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentNameFld.rightView = paddingView10;
        _rentNameFld.rightViewMode = UITextFieldViewModeAlways;

        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentMobileNoFls.rightView = paddingView11;
        _rentMobileNoFls.rightViewMode = UITextFieldViewModeAlways;
        
    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleCityFld.leftView = paddingView;
        _saleCityFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _salePropertyTypeFld.leftView = paddingView1;
        _salePropertyTypeFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleAreaSizeFld.leftView = paddingView2;
        _saleAreaSizeFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleNameFld.leftView = paddingView3;
        _saleNameFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _saleMobileFld.leftView = paddingView4;
        _saleMobileFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentCityFdl.leftView = paddingView5;
        _rentCityFdl.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentPriceFld.leftView = paddingView6;
        _rentPriceFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentPropertyTypeFld.leftView = paddingView7;
        _rentPropertyTypeFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentNoofroomsFld.leftView = paddingView8;
        _rentNoofroomsFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentAreaSizeFld.leftView = paddingView9;
        _rentAreaSizeFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentNameFld.leftView = paddingView10;
        _rentNameFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _rentMobileNoFls.leftView = paddingView11;
        _rentMobileNoFls.leftViewMode = UITextFieldViewModeAlways;

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
        _rentDes.text=@"";
        self.rentDes.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == _saleDes) {
        
        if ([_saleDes.text isEqualToString:@""]) {
            
            _saleDes.text=@"Please enter your message here";
            self.saleDes.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
            
        }
    }
    else{
        if ([_rentDes.text isEqualToString:@""]) {
            
            _rentDes.text=@"Please enter your message here";
            self.rentDes.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
            
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
            
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.rentDes.text attributes:@{NSForegroundColorAttributeName:color}];
            self.rentDes.attributedText = string;
            [_rentDes resignFirstResponder];
            
            return NO;
        }
        
        return YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self.segmentControl.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
    [[self.segmentControl.subviews objectAtIndex:0] setBackgroundColor:[UIColor colorWithRed:211.0f/255.0f green:174.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    
    self.segmentControl.tintColor = [UIColor clearColor];
    
    UIFont *objFont = [UIFont fontWithName:@"DroidSans" size:18.0f];
    
    [self.segmentControl insertSegmentWithTitle:Localized(@"For Sale") atIndex:0 animated:NO];
    [self.segmentControl insertSegmentWithTitle:Localized(@"For Rent") atIndex:1 animated:NO];
    
    // Add font object to Dictionary
    NSDictionary *dictAttributes = [NSDictionary dictionaryWithObject:objFont forKey:NSFontAttributeName];
    
    [_segmentControl setTitleTextAttributes:dictAttributes forState:UIControlStateNormal];
    
}

@end
