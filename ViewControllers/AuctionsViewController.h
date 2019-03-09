//
//  AuctionsViewController.h
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JNExpandableTableView.h"

@interface AuctionsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *upcomingBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *historicalBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet JNExpandableTableView *tradesTableView;

@property (weak, nonatomic) IBOutlet UILabel *noAuctionsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *mojImahe;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *sizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalIfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *startPrice;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundViewImage;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIView *priceListView;
@property (weak, nonatomic) IBOutlet UIView *summaryListView;
@property (weak, nonatomic) IBOutlet UILabel *auctionTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *auctionsinfoBtn;
- (IBAction)auctionsinfoBtnAction:(id)sender;


// Auctions Summary Details...

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
@property (weak, nonatomic) IBOutlet UIButton *auvtionSummaryBack;
@property (weak, nonatomic) IBOutlet UIButton *propertyListBackBtn;



// UnderLabels ...

@property (weak, nonatomic) IBOutlet UILabel *historicalUnderLbl;
@property (weak, nonatomic) IBOutlet UILabel *todayUnderLbl;
@property (weak, nonatomic) IBOutlet UILabel *upcomingUnderLbl;

- (IBAction)auctionSummaryBackBtnTapped:(id)sender;
- (IBAction)upComingBtnTapped:(id)sender;
- (IBAction)todayBtnTapped:(id)sender;
- (IBAction)historicalBtnTapped:(id)sender;
- (IBAction)auctionProperttListTapped:(id)sender;
- (IBAction)propertyListBackBtnTapped:(id)sender;


@end
