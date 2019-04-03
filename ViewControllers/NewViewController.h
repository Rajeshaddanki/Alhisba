//
//  NewViewController.h
//  Alhisba
//
//  Created by apple on 02/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NewViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;


- (IBAction)segmentTouchIns:(id)sender;


@end
