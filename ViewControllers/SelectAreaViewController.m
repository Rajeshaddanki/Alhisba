//
//  SelectAreaViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "SVProgressHUD.h"


@interface SelectAreaViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *areas;

@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.areas = [[NSMutableArray alloc] init];
    _searchBar.delegate = self;
    [self.tableView registerClass:[AppTableViewCell class] forCellReuseIdentifier:@"cell"];
    
//    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        // Add a negative spacer on iOS >= 7.0
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                           target:nil action:nil];
//        negativeSpacer.width = 10;
//        self.navItem.rightBarButtonItems = @[negativeSpacer, closeButton];
//    } else {
//        self.navItem.leftBarButtonItem = closeButton;
//    }
    
   
    
    self.navItem.title = Localized(@"Select Area");
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if ([self.restId length] > 0) {
        [dictionary setValue:self.restId forKey:@"rest_id"];
    }
    
    [self showHUD:@""];
    
    self.areas=_areasList;
    if([_from  isEqual: @"register"]){
        
    [self makePostCallForPage:REGISTERD_TRADES_FILTER
                   withParams:nil
              withRequestCode:11];
        
    }else{
        [self makePostCallForPage:LIVE_AREAS
                       withParams:nil
                  withRequestCode:1];
    }
    _searchBar.placeholder = Localized(@"Area Name");
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.layer.cornerRadius= 15.0f;
    
    // barTintColor sets the background color
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // tintColor sets the buttons color of the navigation bar
    
    self.navigationController.navigationBar.translucent = NO;
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    if ([searchText length]==0) {
//        [_areas removeAllObjects];
//        [Arrdata addObjectsFromArray:self.areas];
//
//    }
//    else{
//
//        [Arrdata removeAllObjects];
//
//        for (NSString *string in _areas) {
//
//            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
//
//            if (r.location != NSNotFound) {
//
//                [Arrdata addObject:string];
//
//            }
//        }
//
//    }
//
//    [_tableView reloadData];
//}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Cancel");
    [searchBar resignFirstResponder];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"GO");
    [searchBar resignFirstResponder];
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    //  NSLog(@"Search string is -> %@",searchText);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //    self.restaurants = [[NSMutableArray alloc] init];
    //    self.original = [[NSMutableArray alloc] init];

    [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
}

-(void)calServiceWithString{
    
    [self showHUD:@""];
    
    if(![_from  isEqual: @"register"]){

    [self makePostCallForPage:LIVE_AREAS withParams:@{@"search":_searchBar.text}  withRequestCode:1];
    }else{
        [self makePostCallForPage:REGISTERD_TRADES_FILTER
                       withParams:@{@"area_search":_searchBar.text}
                  withRequestCode:11];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.layer.cornerRadius= 15.0f;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if(![_from  isEqual: @"register"]){
    NSArray *array = (NSArray *)result;
//    for (NSDictionary *dictionary in array) {
//        [self.areas addObject:[Country instanceFromDictionary:dictionary]];
//    }
    self.areas = array.mutableCopy;
    [self.tableView reloadData];
    }else{
        NSDictionary *dict = (NSDictionary *)result;
        //    for (NSDictionary *dictionary in array) {
        //        [self.areas addObject:[Country instanceFromDictionary:dictionary]];
        //    }
        [self hideHUD];
        if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
            self.areas =[[result valueForKey:@"areas"] valueForKey:@"area_arabic"];
        }else{
            self.areas =[[result valueForKey:@"areas"] valueForKey:@"area_english"];

        }
        
        [self.tableView reloadData];
    }
    
    [self hideHUD];
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    Country *country = [self.areas objectAtIndex:section];
//    return country.title;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    Country *country = [self.areas objectAtIndex:section];
//    return [country.areas count];
    return self.areas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(![_from  isEqual: @"register"]){

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
//    Country *country = [self.areas objectAtIndex:indexPath.section];
//    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
    NSMutableDictionary *dic=[self.areas objectAtIndex:indexPath.row];
    if([dic objectForKey:@"value_english"] != nil){
        if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.areas objectAtIndex:indexPath.row] valueForKey:@"value_arabic"]];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.areas objectAtIndex:indexPath.row] valueForKey:@"value_english"]];
        }
        
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        
        cell.textLabel.textColor =  [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        
        [cell.textLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:16]];


}
    return cell;
    }else{
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
        //    Country *country = [self.areas objectAtIndex:indexPath.section];
        //    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
//        NSMutableDictionary *dic=[self.areas objectAtIndex:indexPath.row];
//        if([dic objectForKey:@"value_english"] != nil){
            if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
                cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.areas objectAtIndex:indexPath.row] ];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.areas objectAtIndex:indexPath.row] ];
            }
        
        cell.textLabel.textColor =  [UIColor colorWithRed:19.0f/255.0f green:40.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        [cell.textLabel setFont:[UIFont fontWithName:@"Cairo-Bold" size:16]];

        //}
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Country *country = [self.areas objectAtIndex:indexPath.section];
//    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
    if(![_from  isEqual: @"register"]){
        NSString *str1;
        if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
           str1=[[self.areas valueForKey:@"value_arabic"] objectAtIndex:indexPath.row];
        }
        else{
           str1=[[self.areas valueForKey:@"value_english"] objectAtIndex:indexPath.row];
        }
        
        NSUserDefaults *sta = [NSUserDefaults standardUserDefaults];
        [sta setObject:[[self.areas valueForKey:@"id"] objectAtIndex:indexPath.row] forKey:@"auctAreaid"];
        [sta synchronize];
        
    self.completionBlock2(str1);
    [self.delegate cancelButtonClicked:self];
    }else{
        NSString *str=[self.areas objectAtIndex:indexPath.row];
        self.completionBlock2(str);
        [self.delegate cancelButtonClicked:self];
    }

}


- (IBAction)close:(id)sender {
    [self.delegate cancelButtonClicked:self];

}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}
@end
