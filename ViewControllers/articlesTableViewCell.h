//
//  articlesTableViewCell.h
//  Alhisba
//
//  Created by apple on 03/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface articlesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articlesImageView;

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleDes;

@property (weak, nonatomic) IBOutlet UIView *totalView;


@end
