//
//  newsTableViewCell.h
//  Alhisba
//
//  Created by apple on 03/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsimageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *nesDes;

@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreBtn;


@end
