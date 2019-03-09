//
//  HomeCollectionViewCell.h
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tradesImage;

@property (weak, nonatomic) IBOutlet UILabel *tradesTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopCollectionView;

@property (weak, nonatomic) IBOutlet UIView *cellBackView;

@end
