//
//  HomeViewController.h
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseViewController

// Outlets..

@property (weak, nonatomic) IBOutlet UIButton *postAdBtn;
@property (weak, nonatomic) IBOutlet UIView *servicesView;
@property (weak, nonatomic) IBOutlet UICollectionView *servicesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *service1Collectionview;

@property (weak, nonatomic) IBOutlet UILabel *forSaleWantedLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *saleCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *rentCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *officeforrentCollectionview;
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *latestNewsLbl;
@property (weak, nonatomic) IBOutlet UILabel *officeForrentLbl;

@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;

@property (weak, nonatomic) IBOutlet UIButton *backWardBtn;

@property (weak, nonatomic) IBOutlet UIButton *postAddBtn;

- (IBAction)postAddBtnTaped:(id)sender;

// rentCollection

@property (weak, nonatomic) IBOutlet UILabel *forRentLbl;
@property (weak, nonatomic) IBOutlet UIButton *rentMoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *officeforRentBtn;
@property (weak, nonatomic) IBOutlet UIButton *latestNewsMoreBtn;

@property (weak, nonatomic) IBOutlet UIView *gradientView;

@property (weak, nonatomic) IBOutlet UIImageView *gradientImageV;
@property (weak, nonatomic) IBOutlet UIImageView *greadientImageV1;

@property (weak, nonatomic) IBOutlet UIButton *sideMenuBtn;

@property (weak, nonatomic) IBOutlet UIView *coverView;


// Button Actions...

- (IBAction)postAdBtnTapped:(id)sender;
- (IBAction)rentMoreBtnTapped:(id)sender;
- (IBAction)saleMoreBtnTapped:(id)sender;
- (IBAction)officeForRentBtnTappped:(id)sender;
- (IBAction)latestNewsMoreBtnTapped:(id)sender;
- (IBAction)menuBtnTapped:(id)sender;
- (IBAction)forwardBtnTapped:(id)sender;
- (IBAction)backwardbtnTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
