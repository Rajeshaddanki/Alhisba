//
//  QualityPremiumCollectionViewCell.m
//  Alhisba
//
//  Created by Apple on 22/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "QualityPremiumCollectionViewCell.h"

@implementation QualityPremiumCollectionViewCell

- (IBAction)selectedBtnAction:(id)sender {
    if(self.selectedBtn){
        self.selectedBtn();
    }
}
@end
