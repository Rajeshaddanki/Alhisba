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

@property (weak, nonatomic) IBOutlet UILabel *addTitle;

@property (weak, nonatomic) IBOutlet UIButton *plusBtn;



// My adds..

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
