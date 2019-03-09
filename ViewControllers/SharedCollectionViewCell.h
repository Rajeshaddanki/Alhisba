//
//  SharedCollectionViewCell.h
//  Alhisba
//
//  Created by apple on 29/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
- (IBAction)selectedBtnAction:(id)sender;
@property(nonatomic) void (^selectedBtn)();
@end

NS_ASSUME_NONNULL_END
