//
//  MenuTableViewCell.h
//  Alhisba
//
//  Created by Apple on 20/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;

@end

NS_ASSUME_NONNULL_END
