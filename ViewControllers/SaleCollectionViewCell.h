//
//  SaleCollectionViewCell.h
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UILabel *landlbl;
@property (weak, nonatomic) IBOutlet UILabel *landInfo;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UILabel *areaSizeLbl;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *areaSize;

@property (weak, nonatomic) IBOutlet UIView *areaTitleBackView;

@property (weak, nonatomic) IBOutlet UILabel *areaTitleLbl;


@end

NS_ASSUME_NONNULL_END
