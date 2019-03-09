//
//  FaqsViewController.h
//  Bloomego
//
//  Created by apple on 04/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JNExpandableTableView.h"


@interface FaqsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *textviewT;


@property (weak, nonatomic) IBOutlet JNExpandableTableView *tradesTableView;


@end
