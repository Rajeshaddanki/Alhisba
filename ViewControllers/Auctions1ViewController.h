//
//  Auctions1ViewController.h
//  Alhisba
//
//  Created by apple on 09/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JNExpandableTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Auctions1ViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *auctionsView;
@property (strong, nonatomic)NSMutableArray *auctionList;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *propertyListBtn;

@property (weak, nonatomic) IBOutlet UITableView *auctionTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *auctionTableHeight;

// Auction List ...


@property (weak, nonatomic) IBOutlet UILabel *auctionOrganizerLbl;
@property (weak, nonatomic) IBOutlet UILabel *auctionOrganizerValue;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateValue;
@property (weak, nonatomic) IBOutlet UILabel *venueLbl;
@property (weak, nonatomic) IBOutlet UILabel *venueValu;
@property (weak, nonatomic) IBOutlet UILabel *propertyArea;
@property (weak, nonatomic) IBOutlet UILabel *propertyAreaValue;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *propertListedLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertListedValue;
@property (weak, nonatomic) IBOutlet UILabel *propertySoldLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertySoldValue;
@property (weak, nonatomic) IBOutlet UILabel *propertyNotSoldLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertyNotSoldVlaue;
@property (weak, nonatomic) IBOutlet UILabel *totalSaleLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalSaleValue;
@property (weak, nonatomic) IBOutlet UILabel *propertyDescLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertyDescValue;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalnfoValue;


@property (weak, nonatomic) IBOutlet JNExpandableTableView *tradesTableView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIView *priceListView;
@property (weak, nonatomic) IBOutlet UIButton *propertyListBackBtn1;
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *sizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalIfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *startPrice;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong , nonatomic)NSMutableArray *popUpList1;


@property (weak, nonatomic) IBOutlet UIImageView *auctionImageView;

// labels...

@property (weak, nonatomic) IBOutlet UILabel *auctionOrganizerLlb;


- (IBAction)backBtnTapped:(id)sender;
- (IBAction)propertyBtnTapped:(id)sender;
- (IBAction)propertyListBackBtnTapped:(id)sender;


@end

NS_ASSUME_NONNULL_END
