//
//  auctionsTableViewCell.m
//  Alhisba
//
//  Created by apple on 24/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "auctionsTableViewCell.h"

@implementation auctionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _wishListBtn.layer.cornerRadius = 15.0f;
    _wishListBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
