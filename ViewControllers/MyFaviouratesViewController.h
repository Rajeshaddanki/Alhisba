//
//  MyFaviouratesViewController.h
//  Alhisba
//
//  Created by Apple on 30/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFaviouratesViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UICollectionView *addCollectionView;
@property (strong, nonatomic)NSString *fromHome;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBa;

@property (weak, nonatomic) IBOutlet UILabel *searchLbl;
@property (weak, nonatomic) IBOutlet UIButton *advancedBtn;
@property (weak, nonatomic) IBOutlet UIButton *searcgBgBtn;

- (IBAction)searchBtnTapped:(id)sender;
- (IBAction)advancedBtnTapped:(id)sender;
- (IBAction)segmentTouchIns:(id)sender;

- (IBAction)dateFromBtnTapped:(id)sender;
- (IBAction)dateToBtnTapped:(id)sender;

- (IBAction)propertyTypeBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *priceTxtFld;
- (IBAction)clearBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
- (IBAction)advancedSearBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *advancedSearchBtn;

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *advancedView;

@property (weak, nonatomic) IBOutlet UIButton *dateFromBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateToBtn;
@property (weak, nonatomic) IBOutlet UIButton *propertyTypeBtn;

@property (weak, nonatomic) IBOutlet UILabel *noAddsLbl;


@end

NS_ASSUME_NONNULL_END
