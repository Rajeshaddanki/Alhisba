//
//  articlesViewController.m
//  Alhisba
//
//  Created by apple on 02/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "articlesViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"
#import "articlesTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "detailsViewController.h"

@interface articlesViewController (){
    
    UIButton *backBtn;
    NSMutableArray *articlesArray;
    NSString *pageLoading;
    int pageNumber;
}

@end

@implementation articlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageLoading = @"YES";
    pageNumber = 0;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;

    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold" size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0f/255.0f green:97.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    //    self.navigationController.navigationBar.translucent = NO;
    
    
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
//    [self makePostCallForPage:BLOG withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:23];
    [self makePostCallForPage:BLOG withParams:@{} withRequestCode:23];

    self.navigationItem.title=Localized(@"Articles");
    
    // label
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
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image1];
    
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
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)clickForInfo:(id)sender{
    
    [self showInfo:Localized(@"Articles") :sender];
}

-(void)goBack{
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}


-(void)parseResult:(id)result withCode:(int)reqeustCode
 
    
    {
        
        if(reqeustCode==23){
            pageLoading = @"NO";
            pageNumber = 1;
            NSLog(@"Result is %@",result);
            articlesArray = [[NSMutableArray alloc] init];
            NSArray *array = (NSArray *)result;
            for (NSDictionary *dictionary in array) {
                [articlesArray addObject:dictionary];
            }
            [_articlesTableView reloadData];
          
        }else{
        
            NSArray *array = (NSArray *)result;
            if(array.count==0){
                pageLoading = @"YES";
            }else{
                pageLoading = @"NO";
                pageNumber = pageNumber+1;
            }
            for (NSDictionary *dictionary in array) {
                [articlesArray addObject:dictionary];
            }
            [_articlesTableView reloadData];
            
        }
        
        [self hideHUD];
    
}


#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return articlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"articlesTableViewCell";
    
    articlesTableViewCell *cell = [_articlesTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableDictionary *dic = [articlesArray objectAtIndex:indexPath.row];
    cell.articleTitle.text = [dic  valueForKey:@"title_english"];
    
//    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    cell.layer.borderWidth = 5;
//    cell.layer.borderColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.6f].CGColor;
    
    cell.totalView.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
    cell.totalView.layer.borderWidth= 2.0f;
    cell.totalView.layer.cornerRadius = 15.0f;
    cell.totalView.layer.masksToBounds= YES;
    
    cell.articlesImageView.layer.borderColor = [UIColor colorWithRed:230.0f/250.0f green:230.0f/250.0f blue:230.0f/250.0f alpha:1.0f].CGColor;
   cell.articlesImageView.layer.borderWidth= 2.0f;
    cell.articlesImageView.layer.cornerRadius = 10.0f;
    cell.articlesImageView.layer.masksToBounds= YES;
    
    //    cell.separatorInset = UIEdgeInsetsMake(50, 50, 200, 50);
    //    cell.layer.borderColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.6f].CGColor;

    
    [cell.articlesImageView setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    NSString *htmlString = [dic  valueForKey:@"small_content_english"];
    
//    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
//                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
//                                            documentAttributes: nil
//                                            error: nil
//                                            ];
//    cell.articleDes.attributedText = attributedString;
    cell.articleDes.text = htmlString;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [articlesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}
//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if([pageLoading  isEqual: @"NO"]){
//        if (articlesArray.count-1 == indexPath.row) {
//            pageLoading = @"YES";
//
//            [self makePostCallForPage:BLOG withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];
//        }
//    }
//
//
//}
#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


@end
