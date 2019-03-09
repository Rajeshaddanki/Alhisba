//
//  OfficeforRentCollectionViewCell.h
//  Alhisba
//
//  Created by Apple on 20/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OfficeforRentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UILabel *landlbl;
@property (weak, nonatomic) IBOutlet UILabel *landInfo;

@end

NS_ASSUME_NONNULL_END
