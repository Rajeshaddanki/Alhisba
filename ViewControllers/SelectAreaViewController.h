//
//  SelectAreaViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "AppTableViewCell.h"


@interface SelectAreaViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *restId;
@property (nonatomic, copy) void (^completionBlock)(NSMutableDictionary *area);
@property(nonatomic,strong)NSMutableArray *areasList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSString *from;
@property (nonatomic, copy) void (^completionBlock2)(NSString *area);

- (IBAction)close:(id)sender;
@end
