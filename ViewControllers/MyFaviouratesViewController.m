//
//  MyFaviouratesViewController.m
//  Alhisba
//
//  Created by Apple on 30/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MyFaviouratesViewController.h"
#import "SVProgressHUD.h"
#import "UIViewController+MJPopupViewController.h"
#import "AddsCollectionViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AddsDetailsViewController.h"
#import "PostAddViewController.h"

@interface MyFaviouratesViewController (){
    
    UIButton *backBtn;
    NSString *typeStr;
    NSMutableArray *lastArray;
}

@end

@implementation MyFaviouratesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    // barTintColor sets the background color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    
    typeStr = @"1";
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
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
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"My Faviorates");
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
    
    [self showHUD:@""];
    
    [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    
        lastArray =result;
    
    if ([lastArray count]==0) {
        _noAddsLbl.hidden = NO;
    }else{
        
        _noAddsLbl.hidden = YES;
        [self.addCollectionView reloadData];
    }
  //  [self.addCollectionView reloadData];
    
    [self hideHUD];

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
    
    [self showInfo:Localized(@"My Faviorates") :sender];
}

- (IBAction)segmentTouchIns:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"First was selected");
            typeStr = @"1";
            
            [self showHUD:@""];
            
            [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];

            break;
        case 1:
            NSLog(@"Second was selected");
            typeStr = @"2";
            
            [self showHUD:@""];
            
            [self makePostCallForPage:ADDS withParams:@{@"type":typeStr} withRequestCode:1];

            break;
        case 2:
            NSLog(@"Third was selected");
            break;
        default:
            break;
    }
}


#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;
    
    return lastArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AddsCollectionViewCell *cell = [self.addCollectionView dequeueReusableCellWithReuseIdentifier:@"AddsCollectionViewCell" forIndexPath:indexPath];
    
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    cell.layer.borderWidth= 5.0f;
    cell.layer.cornerRadius = 10.0f;
    cell.layer.masksToBounds= YES;
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 5.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSMutableDictionary *dic = [lastArray objectAtIndex:indexPath.row];
    
    NSLog(@"index is %d",index.intValue);
  
    cell.addsSubtitle.hidden = NO;
    cell.addsImage.hidden = NO;
    cell.plusBtn.hidden = YES;
    
    cell.addsMainTitle.hidden = NO;
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 5.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        cell.addsMainTitle.text = [[[lastArray valueForKey:@"area_id"] valueForKey:@"value_arabic"] objectAtIndex:indexPath.row];
        cell.addsSubtitle.text = [[[lastArray valueForKey:@"property_type_id"] valueForKey:@"value_arabic"] objectAtIndex:indexPath.row];
    }
    else{
        cell.addsMainTitle.text = [[[lastArray valueForKey:@"area_id"] valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        cell.addsSubtitle.text = [[[lastArray valueForKey:@"property_type_id"] valueForKey:@"value_english"] objectAtIndex:indexPath.row];
    }
    
    
    cell.addTitle.hidden = YES;
    
    [cell.addsImage setImageWithURL:[dic valueForKey:@"images"][0] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    [cell.plusBtn addTarget:self action:@selector(plusBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    //        cell.cellBackView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.5f];
    
    //
    //  [cell.addsMainTitle setTextAlignment:NSTextAlignmentCenter];
    //        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    //        dic = [lastArray objectAtIndex:indexPath.row];
    
    //   cell.addsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tradesImageArray objectAtIndex:indexPath.row]]];
    //
    //
    //      [cell.addsMainTitle setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

-(void)plusBtnTapped{
    
    PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)searchBtnTapped:(id)sender {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"index is %d",index.intValue);
    
    if( index.intValue == lastArray.count-1){
        
        PostAddViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostAddViewController"];
        [self.navigationController pushViewController:obj animated:YES];

    }
    else{
        
        AddsDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddsDetailsViewController"];
        obj.detailsArray = [lastArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-16, 220);
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
