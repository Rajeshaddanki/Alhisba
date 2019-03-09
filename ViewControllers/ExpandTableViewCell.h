//
//  ExpandTableViewCell.h
//  Bloomego
//
//  Created by apple on 09/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *blockTitle;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeTitle;
@property (weak, nonatomic) IBOutlet UILabel *notesLbl;
@property (weak, nonatomic) IBOutlet UILabel *notesTitle;
@property (weak, nonatomic) IBOutlet UILabel *percentageLbl;
@property (weak, nonatomic) IBOutlet UILabel *percentageTitle;
@property (weak, nonatomic) IBOutlet UILabel *m2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *m2Value;
@property (weak, nonatomic) IBOutlet UILabel *residentialValue;

@property (weak, nonatomic) IBOutlet UILabel *blockValue;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *bloackValue;

@property (weak, nonatomic) IBOutlet UITextView *answerLbl;

@end
