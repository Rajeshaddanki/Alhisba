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


// groups outlets

@property (weak, nonatomic) IBOutlet UILabel *questionLbl;

@property (weak, nonatomic) IBOutlet UILabel *answerLbl;

@property (weak, nonatomic) IBOutlet UITextField *questionFld;

@property (weak, nonatomic) IBOutlet UIButton *questionBtnTapped;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerLblTopConstraint;

@end
