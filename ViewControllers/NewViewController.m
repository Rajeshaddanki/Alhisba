//
//  NewViewController.m
//  Alhisba
//
//  Created by apple on 02/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NewViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "newsTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "detailsViewController.h"

@interface NewViewController (){
    
    UIButton *backBtn;
    NSMutableArray *newsArray;
    NSString *htmlString;
    
    NSString *pageLoading;
    int pageNumber;
     BOOL loaded;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageLoading = @"YES";
    pageNumber = 0;
    
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
//    [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];
    [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];

    self.navigationItem.title=Localized(@"NEWS");
     loaded = NO;
    
    // label
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"NEWS");
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

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"NEWS") :sender];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    self.segmentControl.layer.borderWidth = 1;
    self.segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentControl.layer.cornerRadius = 15.0f;
    self.segmentControl.layer.masksToBounds = YES;
    self.segmentControl.clipsToBounds = YES;
    
    UIFont *Boldfont = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:Boldfont forKey:UITextAttributeFont];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self.segmentControl setTitle:Localized(@"News") forSegmentAtIndex:0];
    
    [self.segmentControl setTitle:Localized(@"Articles") forSegmentAtIndex:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    // tintColor sets the buttons color of the navigation bar
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)segmentTouchIns:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"First was selected");
            
            [self forNews];
            [self showHUD:@""];
            //    [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];
            [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];
            break;
        case 1:
            NSLog(@"Second was selected");

            [self forArticles];
            [self showHUD:@""];
            [self makePostCallForPage:BLOG withParams:@{@"page":@"0"} withRequestCode:23];

            break;
        case 2:
            NSLog(@"Third was selected");
            break;
        default:
            break;
    }
}

-(void)goBack{
    
//    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:obj animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}


-(void)parseResult:(id)result withCode:(int)reqeustCode {
    [self hideHUD];

    if(reqeustCode==23){
       
        NSLog(@"Result is %lu",(unsigned long)newsArray.count);
        newsArray = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [newsArray addObject:dictionary];
        }
        NSLog(@"n %@",[newsArray valueForKey:@"id"]);
        //[_newsTableView reloadData];
        pageLoading = @"NO";
         loaded=NO;
        pageNumber = 1;
    }else if(reqeustCode==24){
        NSLog(@"Result isss %lu",(unsigned long)newsArray.count);
        
        NSArray *array = (NSArray *)result;
        if(array.count==0){
            pageLoading = @"YES";
            loaded=YES;
        }else{
            pageLoading = @"NO";
            loaded=NO;
            pageNumber = pageNumber+1;
        }
        for (NSDictionary *dictionary in result) {
            [newsArray addObject:dictionary];
        }
    }
    _newsTableView.reloadData;

}
-(void)loadmore
{
    //add datasource object here for tableview
    //now insert cell in tableview
    [_newsTableView beginUpdates];
    [_newsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[newsArray count]-1 inSection:0]]withRowAnimation:UITableViewRowAnimationAutomatic];
    [_newsTableView endUpdates];
}
#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *CellIdentifier = @"newsTableViewCell";
    
    newsTableViewCell *cell = [_newsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableDictionary *dic = [newsArray objectAtIndex:indexPath.row];
    cell.newsTitle.text = [dic  valueForKey:@"title_english"];
    
    cell.totalView.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
    cell.totalView.layer.borderWidth= 2.0f;
    cell.totalView.layer.cornerRadius = 15.0f;
    cell.totalView.layer.masksToBounds= YES;
    
    cell.newsimageView.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
    cell.newsimageView.layer.borderWidth= 2.0f;
    cell.newsimageView.layer.cornerRadius = 10.0f;
    cell.newsimageView.layer.masksToBounds= YES;
    
//    cell.separatorInset = UIEdgeInsetsMake(50, 50, 200, 50);
//    cell.layer.borderColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.6f].CGColor;

    [cell.newsimageView setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        htmlString = [dic  valueForKey:@"small_content_english"];
    }
    else{
        htmlString = [dic  valueForKey:@"small_content_english"];
    }
    
    [cell.readMoreBtn setTitle:Localized(@"Read More") forState:UIControlStateNormal];
    
    cell.readMoreBtn.tag = indexPath.row;
    
    [cell.readMoreBtn addTarget:self action:@selector(readBtnTapped:) forControlEvents:UIControlEventTouchUpInside];

    cell.nesDes.text = htmlString;

    return cell;
}

-(void)readBtnTapped:(UIButton*)sender
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [newsArray objectAtIndex:sender.tag];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [newsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return UITableViewAutomaticDimension;
//}

//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(tableView == _newsTableView){
//        if([pageLoading  isEqual: @"NO"]){
//            if (newsArray.count-1 == indexPath.row) {
//                pageLoading = @"YES";
//
//                [self makePostCallForPage:NEWS withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];
//            }
//        }
//    }
//}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
if(indexPath.row == newsArray.count){
    if(newsArray.count>0){
            [self makePostCallForPage:NEWS withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];

    }
}
}
#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

-(void)forNews{
    
    // label
    UILabel *tmpTitleLabel1 =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel1.text = Localized(@"NEWS");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel1 setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel1 setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel1.backgroundColor = [UIColor clearColor];
    tmpTitleLabel1.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel1 sizeToFit];
    UIImage *image = [UIImage imageNamed: @"badge.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame] ;
    [newView addSubview:imageView];
    [newView addSubview:tmpTitleLabel1];
    tmpTitleLabel1.center=newView.center;
    imageView.frame = CGRectMake(150+(tmpTitleLabel1.frame.size.width/2)+4, 10, 20, 20);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel1.frame.size.width/2)+4, 10, 20, 20)];
    [btn addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:btn];
    self.navigationItem.titleView = newView;
}

-(void)forArticles{
    
    UILabel *tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    tmpTitleLabel.text = Localized(@"Articles");
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
    }else{
        [tmpTitleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
    }
    tmpTitleLabel.backgroundColor = [UIColor clearColor];
    tmpTitleLabel.textColor = [UIColor colorWithRed:212.0f/255.0f green:175.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
    [tmpTitleLabel sizeToFit];
    UIImage *image1 = [UIImage imageNamed: @"badge.png"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage: image1];
    
    CGRect applicationFrame1 = CGRectMake(0, 0, 300, 40);
    UIView * newView1 = [[UIView alloc] initWithFrame:applicationFrame1] ;
    [newView1 addSubview:imageView1];
    [newView1 addSubview:tmpTitleLabel];
    tmpTitleLabel.center=newView1.center;
    imageView1.frame = CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20);
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(150+(tmpTitleLabel.frame.size.width/2)+4, 10, 20, 20)];
    [btn1 addTarget:self action:@selector(clickForInfo:) forControlEvents:UIControlEventTouchUpInside];
    [newView1 addSubview:btn1];
    self.navigationItem.titleView = newView1;
}



@end
