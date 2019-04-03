//
//  RegisterdTradesViewController.h
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JNExpandableTableView.h"


@interface RegisterdTradesViewController : BaseViewController

@property (weak, nonatomic) IBOutlet JNExpandableTableView *tradesTableView;
@property (weak, nonatomic) IBOutlet UITableView *searchTabeView;
@property (weak, nonatomic) IBOutlet UIImageView *searchTableBackground;
@property (weak, nonatomic) IBOutlet UIView *searchTablePopUpView;
@property (strong, nonatomic)NSString *fromHome;
@property (weak, nonatomic) IBOutlet UITextField *sizeFromTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *sizeToTxtFld;
@property (weak, nonatomic) IBOutlet UILabel *noTradesLbl;
@property (strong, nonatomic)NSString *fromMenu;

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchByTapBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateFromBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateToBtn;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UIButton *propertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *blockBtn;
@property (weak, nonatomic) IBOutlet UIButton *descriptionBtn;

@property (weak, nonatomic) IBOutlet UILabel *searchByTypeLbl;


// Labels...
@property (weak, nonatomic) IBOutlet UILabel *areaLbl;
@property (weak, nonatomic) IBOutlet UILabel *sizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceInKdLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceMc2Lbl;
@property (weak, nonatomic) IBOutlet UIButton *searchIcon;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

- (IBAction)searchButtonTapped:(id)sender;
- (IBAction)searchBytypeBtnTapped:(id)sender;
- (IBAction)dateFromBtnTapped:(id)sender;
- (IBAction)dateToBtnTapped:(id)sender;
- (IBAction)areaBtnTapped:(id)sender;
- (IBAction)propertyBtnTapped:(id)sender;
- (IBAction)BlockBtnTapped:(id)sender;
- (IBAction)descriptionBtnTapped:(id)sender;
- (IBAction)closeBtnTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *serachBtLbl;
@property (weak, nonatomic) IBOutlet UIButton *searchBGBtn;
@property (weak, nonatomic) IBOutlet UIView *advView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *advHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainSearchViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *advSearchLbl;
- (IBAction)advsearchBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *advsearchImage;
@property (weak, nonatomic) IBOutlet UIButton *advancedBtn;

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (weak, nonatomic) IBOutlet UIView *searchBackView;

- (IBAction)clearBtnTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *gradientImageV;


@end
