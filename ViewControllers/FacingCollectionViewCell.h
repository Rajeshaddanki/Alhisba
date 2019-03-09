//
//  FacingCollectionViewCell.h
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacingCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLlb;
- (IBAction)selectedBtnAction:(id)sender;
@property (nonatomic) void (^selectedBtn)();

@end
