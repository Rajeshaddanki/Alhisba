//
//  RentCollectionViewCell.h
//  Alhisba
//
//  Created by Apple on 20/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UILabel *landlbl;
@property (weak, nonatomic) IBOutlet UILabel *landInfo;

@property (weak, nonatomic) IBOutlet UIView *areaTitleBackView;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UILabel *areaSizeLbl;

@property (weak, nonatomic) IBOutlet UILabel *areaSize;

@property (weak, nonatomic) IBOutlet UILabel *kuwaitDinarLbl;

@property (weak, nonatomic) IBOutlet UILabel *bathroomLbl;

@property (weak, nonatomic) IBOutlet UILabel *bathroomValue;

@property (weak, nonatomic) IBOutlet UILabel *areaTitleLbl;


@end

NS_ASSUME_NONNULL_END
