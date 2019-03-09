//
//  LocationSpecCollectionViewCell.m
//  Alhisba
//
//  Created by apple on 27/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LocationSpecCollectionViewCell.h"

@implementation LocationSpecCollectionViewCell

- (IBAction)selectedBtnAction:(id)sender {
    if(self.selectedBtn){
        self.selectedBtn();
    }
}
@end
