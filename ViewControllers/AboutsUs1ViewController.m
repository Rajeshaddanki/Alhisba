//
//  AboutsUs1ViewController.m
//  Alhisba
//
//  Created by Apple on 21/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AboutsUs1ViewController.h"

@interface AboutsUs1ViewController ()

@end

@implementation AboutsUs1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setHidden:NO];
    
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor colorWithRed:21.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    //
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:21.0f/255.0f green:46.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
}


@end
