//
//  AddsDetailsViewController.h
//  Alhisba
//
//  Created by Apple on 11/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddsDetailsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *callOwnerBtn;
@property (strong, nonatomic)NSMutableArray *detailsArray;

// Outlets...

@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;


// Outlets..

@property (weak, nonatomic) IBOutlet UILabel *apartmentType;
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *kuwaitDinarLbl;
@property (weak, nonatomic) IBOutlet UILabel *kuwaitDinarPrice;
@property (weak, nonatomic) IBOutlet UILabel *bedroomsLbl;
@property (weak, nonatomic) IBOutlet UILabel *bedroomsValue;
@property (weak, nonatomic) IBOutlet UILabel *bathroomsLbl;
@property (weak, nonatomic) IBOutlet UILabel *bathroomsValue;
@property (weak, nonatomic) IBOutlet UILabel *propertyDesLbl;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *areaValue;
@property (weak, nonatomic) IBOutlet UILabel *propetyType;
@property (weak, nonatomic) IBOutlet UILabel *propertyValue;
@property (weak, nonatomic) IBOutlet UILabel *space;
@property (weak, nonatomic) IBOutlet UILabel *spaceValue;
@property (weak, nonatomic) IBOutlet UILabel *additionalinfo;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfoValue;



- (IBAction)callOwnerBtnTapped:(id)sender;


@end

NS_ASSUME_NONNULL_END
