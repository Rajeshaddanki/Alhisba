//
//  ContactUsViewController.m
//  Bloomego
//
//  Created by apple on 08/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"
#import <MessageUI/MessageUI.h>
#import "ContactUsTableViewCell.h"

@interface ContactUsViewController ()<UITextFieldDelegate,MFMailComposeViewControllerDelegate,UITextViewDelegate>{
    
    UIButton *backButton,*cartButton;
    NSMutableArray *contactDetailsArray,*contactIconsArray;
    NSString *latString,*longString;
}

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = Localized(@"Contact Us");
    _mobileNoLbl.text = @"";
    _emailLbl.text = @"";
    _weblinkLbl.text = @"";
    
        _timeLbl.text = @"";
        _locationInfoLbl.text = @"";
    _nameFld.delegate = self;
    _emailFld.delegate = self;
    _phoneFld.delegate = self;
    _messageView.delegate = self;
    [ _phoneView setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//    [_submitBtn.layer setCornerRadius:10.0];//Set corner radius of label to change the shape.
    [_submitBtn setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    
    [self.messageView setText:@"Please enter your message here"];
    _ourSocialMediaChannelLbl.text = Localized(@"Our Social Media channels");
    _writeToUsLbl.text = Localized(@"Write to us");
    
    _submitBtn.layer.cornerRadius = 15.0f;

 
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;

  [_countryCodefld setTextAlignment:NSTextAlignmentCenter];
    
    UIColor *color = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    
    _nameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Full Name") attributes:@{NSForegroundColorAttributeName: color}];
    _emailFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Email Address") attributes:@{NSForegroundColorAttributeName: color  }];
    _phoneFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Mobile Number") attributes:@{NSForegroundColorAttributeName: color  }];
    _countryCodefld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"+965") attributes:@{NSForegroundColorAttributeName: color  }];

    _messageView.layer.masksToBounds=YES;
    _messageView.layer.borderWidth= 1.0f;
    _messageView.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    _messageView.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Please enter message")]];
    [_messageView setTextColor:[UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f]];
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        _messageView.font = [UIFont fontWithName:@"DroidArabicKufi-Bold" size:16];

    }
    else{
        
        _messageView.font = [UIFont fontWithName:@"DroidSans-Bold" size:16];
    }
    
    _messageView.textContainer.lineFragmentPadding = 20;
    
    _submitBtn.titleLabel.text = Localized(@"Submit");
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:Localized(@"Done")
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _phoneFld.inputAccessoryView = keyboardDoneButtonView;

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
    }
    else{
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
    }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    // Cart Button...
    
    cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartButton setImage:[UIImage imageNamed:@"cart-white.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    cartButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *customBarRightBtn3 = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
   // self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn3,nil];
    
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
    [self textFldBoarders];
    [self paddingFlds];
    
    [self showHUD:@""];
    [self makePostCallForPage:CONTACT withParams:@{} withRequestCode:23];
    
    contactIconsArray = [[NSMutableArray alloc] initWithObjects:@"phone-call.png",@"envelope.png",@"web.png",@"location.png", nil];

  //  [_contactTableView reloadData];
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Contact Us");
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];

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
    
    [self showInfo:Localized(@"Contact Us") :sender];
}

-(void)badgeInfoBtnTapped:(id)sender{
    
    [self showInfo:Localized(@"Contact Us") :sender];
}

-(void)backBtnClicked{
 
//    [self.navigationController popViewControllerAnimated:YES];
    
//    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:obj animated:NO];
    [self.navigationController popToRootViewControllerAnimated:NO];

}

-(void)cartBtnClicked{
//    CartViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
//    obj.fromDetails = @"fromDetails";
//    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)submitBtnClicked:(id)sender {
    
    if ([self.nameFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter name"];
    }
    else if ([self.emailFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter email address"];
    }
    else if ([self.phoneFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter phone no"];
    }
    else if ([self.messageView.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter message"];
    }
    else {
        [self makePostCallForPage:CONTACT_US withParams:@{@"name":self.nameFld.text,@"email":self.emailFld.text,@"phone":self.phoneFld.text,@"message":self.messageView.text} withRequestCode:1];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    if (reqeustCode == 23) {
        
        contactDetailsArray = result;
        
        _mobileNoLbl.text = [contactDetailsArray valueForKey:@"phone_no"];
        _emailLbl.text = [contactDetailsArray valueForKey:@"email"];
        _weblinkLbl.text = [contactDetailsArray valueForKey:@"website"];
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {

        _timeLbl.text = [contactDetailsArray valueForKey:@"timing_arabic"];
        _locationInfoLbl.text = [contactDetailsArray valueForKey:@"address_arabic"];
        }else{
            _timeLbl.text = [contactDetailsArray valueForKey:@"timing_english"];
            _locationInfoLbl.text = [contactDetailsArray valueForKey:@"address_english"];
        }
        
        latString = [contactDetailsArray valueForKey:@"latitude"];
        longString = [contactDetailsArray valueForKey:@"longitude"];
        
        _mapView.delegate = self;
        
        MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;
        myCoordinate.latitude=[latString floatValue];
        myCoordinate.longitude=[longString floatValue];
        annotation.coordinate = myCoordinate;
        // annotation.title=[dic valueForKey:@"title"];
        annotation.subtitle=@"";
        
        [_mapView setZoomEnabled:YES];
        [_mapView setScrollEnabled:YES];
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [latString floatValue];
        region.center.longitude = [longString floatValue];
        region.span.longitudeDelta = 10.0f;
        region.span.latitudeDelta = 10.0f;
        [_mapView setRegion:region animated:NO];
        [self.mapView addAnnotation:annotation];

    }
    else{
     
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    
                }
                
            }];
            
        });
    }
    
    [_contactTableView reloadData];
    
    [self hideHUD];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)callingBtnTapped:(id)sender {
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_mobileNoLbl.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)mailBtnTapped:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"info@alhisba.com"]];
        [composeViewController setSubject:@"example subject"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)webLinkBtnTapped:(id)sender {
    
    NSString* text = _weblinkLbl.text;
    NSURL*    url  = [[NSURL alloc] initWithString:text];
    
    if (url.scheme.length == 0)
    {
        text = [@"http://" stringByAppendingString:text];
        url  = [[NSURL alloc] initWithString:text];
    }
    
    [[UIApplication sharedApplication] openURL:url];
}



- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneFld) {
        
        NSInteger length = [_phoneFld.text length];
        if (length>7 && ![string isEqualToString:@""]) {
            return NO;
        }dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_phoneFld.text length]>7) {
                _phoneFld.text = [_phoneFld.text substringToIndex:8];
            }
        });
        
        return YES;
        
    }
    else{
        return YES;
    }
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    // [self.view endEditing:NO];
    [_phoneFld resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_phoneFld resignFirstResponder];
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _messageView.text=@"";
    self.messageView.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        
        _messageView.text=@"Please enter your message here";
        self.messageView.textColor = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        UIColor *color = [UIColor colorWithRed:22.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
        
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.messageView.text attributes:@{NSForegroundColorAttributeName:color}];
        self.messageView.attributedText = string;
        [_messageView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return contactIconsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ContactUsTableViewCell";
    
    ContactUsTableViewCell *cell = [_contactTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.row == 0) {
        
        cell.contactTitle.text = [contactDetailsArray valueForKey:@"phone_no"];
    }
    else if (indexPath.row ==1)
    {
        cell.contactTitle.text = [contactDetailsArray valueForKey:@"email"];

    }
    else if (indexPath.row == 2){
        cell.contactTitle.text = [contactDetailsArray valueForKey:@"website"];

    }
    else if (indexPath.row == 3){
        cell.contactTitle.text = [contactDetailsArray valueForKey:@"address_english"];

    }
    else{
        
    }
    
    cell.contactIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[contactIconsArray objectAtIndex:indexPath.row]]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
//    obj.detailsDic = [newsArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:obj animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 80;
    }
    else{
     return 65;
    }
}



#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

-(void)textFldBoarders{
    
        _nameFld.layer.borderColor = [UIColor whiteColor].CGColor;
        _nameFld.layer.borderWidth = 2.0f;
        _nameFld.layer.cornerRadius = 15.0f;
    
    _countryCodefld.layer.borderColor = [UIColor whiteColor].CGColor;
    _countryCodefld.layer.borderWidth = 2.0f;
    _countryCodefld.layer.cornerRadius = 15.0f;

        _emailFld.layer.borderColor = [UIColor whiteColor].CGColor;
        _emailFld.layer.borderWidth = 2.0f;
        _emailFld.layer.cornerRadius = 15.0f;
    
        _phoneFld.layer.borderColor = [UIColor whiteColor].CGColor;
        _phoneFld.layer.borderWidth = 2.0f;
        _phoneFld.layer.cornerRadius = 15.0f;
    
        _messageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _messageView.layer.borderWidth = 2.0f;
        _messageView.layer.cornerRadius = 15.0f;
    
//    _submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _submitBtn.layer.borderWidth = 2.0f;
    _submitBtn.layer.cornerRadius = 15.0f;

}


-(void)paddingFlds{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _nameFld.rightView = paddingView;
        _nameFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _emailFld.rightView = paddingView1;
        _emailFld.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _phoneFld.rightView = paddingView2;
        _phoneFld.rightViewMode = UITextFieldViewModeAlways;
        
    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _nameFld.leftView = paddingView;
        _nameFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _emailFld.leftView = paddingView1;
        _emailFld.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
        
        _phoneFld.leftView = paddingView2;
        _phoneFld.leftViewMode = UITextFieldViewModeAlways;
        
//        UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 20, 0)];
//
//        _messageView.leftView = paddingView3;
//        _phoneFld.leftViewMode = UITextFieldViewModeAlways;

        
    }
}


//-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    MKPinAnnotationView *MyPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
//    //MyPin.pinColor = MKPinAnnotationColorPurple;
//
//    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
//
//    /*MyPin.rightCalloutAccessoryView = advertButton;
//     MyPin.draggable = YES;
//
//     MyPin.animatesDrop=TRUE;
//     MyPin.canShowCallout = YES;*/
//    MyPin.highlighted = NO;
//    MyPin.image = [UIImage imageNamed:@"placeholder.png"];
//
//    return MyPin;
//}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    else
    {
        MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annot"];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKAnnotationView *customPinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annot"];
            customPinView.image = [UIImage imageNamed:@"placeholder.png"];
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
}


@end
