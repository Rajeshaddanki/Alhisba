//
//  SharedCollectionViewCell.m
//  Alhisba
//
//  Created by apple on 29/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "SharedCollectionViewCell.h"

@implementation SharedCollectionViewCell

- (IBAction)selectedBtnAction:(id)sender {
    if(self.selectedBtn){
        self.selectedBtn();
    }
}
@end
