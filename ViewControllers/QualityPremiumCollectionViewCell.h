//
//  QualityPremiumCollectionViewCell.h
//  Alhisba
//
//  Created by Apple on 22/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QualityPremiumCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLlb;
@property (nonatomic) void (^selectedBtn)();
- (IBAction)selectedBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
