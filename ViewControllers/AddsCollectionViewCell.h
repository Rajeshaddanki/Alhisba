//
//  AddsCollectionViewCell.h
//  Alhisba
//
//  Created by Apple on 08/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *addsImage;
@property (weak, nonatomic) IBOutlet UILabel *addsMainTitle;
@property (weak, nonatomic) IBOutlet UILabel *addsSubtitle;
@property (weak, nonatomic) IBOutlet UIView *cellBackView;

@end

NS_ASSUME_NONNULL_END
