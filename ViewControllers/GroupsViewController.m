//
//  GroupsViewController.m
//  Alhisba
//
//  Created by Apple on 26/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "GroupsViewController.h"
#import "SVProgressHUD.h"
#import "articlesTableViewCell.h"
#import "ActionSheetStringPicker.h"



@interface GroupsViewController (){
    
    UIButton *backBtn;
    NSMutableArray *groupsArray;
    NSMutableArray *sectionArray,*questionsArray;
    UILabel *lbl;
}

@end

@implementation GroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
        
    }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    
    [self showHUD:@""];
    [self makePostCallForPage:GROUPS withParams:@{} withRequestCode:23];
    
    self.navigationItem.title=Localized(@"Groups");
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Groups");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel.backgroundColor = [UIColor clearColor];
    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel sizeToFit];
    UIImage *image = [UIImage imageNamed: @"badge.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame] ;
    [newView addSubview:imageView];
    [newView addSubview:tmpTitleLabel];
    tmpTitleLabel.center=newView.center;
    imageView.frame = CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20)];
    [btn addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:btn];
    self.navigationItem.titleView = newView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btng.png"] forBarMetrics:UIBarMetricsDefault];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.navigationController.navigationBar.bounds;
    
    CGRect gradientFrame = self.navigationController.navigationBar.bounds;
    gradientFrame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
    gradientLayer.frame = gradientFrame;
    
    gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1].CGColor,
                              (__bridge id)[UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:147.0f/255.0f alpha:1].CGColor ];
    //    gradientLayer.startPoint = CGPointMake(1.0, 0);
    //    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:gradientImage1 forBarMetrics:UIBarMetricsDefault];
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Groups") :sender];
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{

    groupsArray = result;
    
    sectionArray = [groupsArray valueForKey:@"value_english"];
    
    questionsArray = [groupsArray valueForKey:@"questions"];
    
    [self.groupTableView reloadData];
    [self hideHUD];
    
}

#pragma table view delegate & Data Source.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionArray.count; //one male and other female
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
//    Country *country = [self.areas objectAtIndex:section];
    return [sectionArray objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *arr = [questionsArray objectAtIndex:section];
        //   NSLog(@"%lu",(unsigned long)[country.areas count]);
    return arr.count;
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    lbl = [[UILabel alloc] init];
////            lbl.textAlignment = UITextAlignmentCenter;
//    [lbl setTextAlignment:NSTextAlignmentCenter];
//    lbl.font = [UIFont fontWithName:@"DroidSans-Bold" size:20];
//    lbl.text = [self tableView:tableView titleForHeaderInSection:section];
//    lbl.textColor = [UIColor whiteColor];
//    lbl.backgroundColor = [UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1];
//    lbl.shadowOffset = CGSizeMake(0,1);
//    //    lbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"my_head_bg"]];
//    lbl.alpha = 0.9;
//
//    return lbl;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"articlesTableViewCell";
    
    articlesTableViewCell *cell = [_groupTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableArray *ar1;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        ar1 = [[questionsArray valueForKey:@"value_arabic"] objectAtIndex:indexPath.section];

    }
    else{
        ar1 = [[questionsArray valueForKey:@"value_english"] objectAtIndex:indexPath.section];
    }
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
//        [cell.textLabel setFont:[UIFont fontWithName:@"Hacen Tunisia" size:18]];
//
//
//    } else {
//        [cell.textLabel setFont:[UIFont fontWithName:@"DroidSans" size:18]];
//
//        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
//    }
    
    cell.answerLbl.hidden = YES;
    
    [cell.questionFld setBackgroundColor:[UIColor clearColor]];
    [cell.questionFld setTextColor:[UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1]];
    [cell.questionFld.layer setBorderColor:[UIColor colorWithRed:16.0f/255.0f green:35.0f/255.0f blue:71.0f/255.0f alpha:1].CGColor];
    [cell.questionFld.layer setCornerRadius:10.0f];
    [cell.questionFld.layer setMasksToBounds:YES];
    [cell.questionFld.layer setBorderWidth:2.0f];
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        cell.questionFld.rightView = paddingView;
        cell.questionFld.rightViewMode = UITextFieldViewModeAlways;

    }
    else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 15, 0)];
        
        cell.questionFld.leftView = paddingView;
        cell.questionFld.leftViewMode = UITextFieldViewModeAlways;

    }
    

    
    cell.questionFld.text = [ar1 objectAtIndex:indexPath.row];
    
    [cell.questionBtnTapped addTarget:self
                               action:@selector(questionBtnTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    
    cell.questionBtnTapped.tag = indexPath.row;
    
    cell.answerLblTopConstraint.constant = 30;
    
    return cell;
}

-(void)questionBtnTapped:(UIButton *)sender{
    
    UIButton* button = (UIButton*)sender;
    
    CGRect buttonFrame =[button convertRect:button.bounds toView:_groupTableView];
    
    NSIndexPath *indexPath = [_groupTableView indexPathForRowAtPoint:buttonFrame.origin];
    
    NSMutableArray *ar1;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
       
        ar1 = [[[questionsArray valueForKey:@"answers"] valueForKey:@"value_arabic"] objectAtIndex:indexPath.section];
    }
    else{
        
        ar1 = [[[questionsArray valueForKey:@"answers"] valueForKey:@"value_english"] objectAtIndex:indexPath.section];
    }
    
    
    [ActionSheetStringPicker showPickerWithTitle:Localized(@"Select Answer")
                                            rows:ar1[0]
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
        articlesTableViewCell *cell = [self.groupTableView cellForRowAtIndexPath:indexPath];

        cell.answerLblTopConstraint.constant = 16;
        cell.answerLbl.hidden = NO;
        cell.answerLbl.textAlignment = NSTextAlignmentCenter;
        cell.answerLbl.text=[NSString stringWithFormat:@"%@",[ar1[0] objectAtIndex:selectedIndex]];
        [cell.answerLbl.layer setCornerRadius:10.0f];
        [cell.answerLbl.layer setMasksToBounds:YES];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
