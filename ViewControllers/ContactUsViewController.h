//
//  ContactUsViewController.h
//  Bloomego
//
//  Created by apple on 08/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface ContactUsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *nameFld;
@property (weak, nonatomic) IBOutlet UITextField *emailFld;
@property (weak, nonatomic) IBOutlet UITextField *phoneFld;
@property (weak, nonatomic) IBOutlet UITextField *countryCodefld;

@property (weak, nonatomic) IBOutlet UITextView *messageView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;


// Contact info.....

@property (weak, nonatomic) IBOutlet UILabel *mobileNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *weblinkLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationInfoLbl;
@property (weak, nonatomic) IBOutlet UIView *phoneView;


// Actions....

- (IBAction)callingBtnTapped:(id)sender;
- (IBAction)mailBtnTapped:(id)sender;
- (IBAction)webLinkBtnTapped:(id)sender;


@end
