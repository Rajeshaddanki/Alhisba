//
//  ShowPopupViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ShowPopupViewController.h"

@interface ShowPopupViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *areas;

@end

@implementation ShowPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navItem.title = Localized(@"Privacy Policy");
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.ppTxtView.attributedText = _pptext;
//    self.ppTxtView.textColor = [UIColor colorWithRed:29/255.0f green:42/255.0f blue:56/255.0f alpha:1.0];
    self.agreeBtn.layer.cornerRadius=self.agreeBtn.frame.size.height/2;
    self.agreeBtn.clipsToBounds=YES;
  //  self.agreeBtn.layer.borderColor=[UIColor colorWithRed:29/255.0f green:42/255.0f blue:56/255.0f alpha:1.0].CGColor;
    //self.agreeBtn.layer.borderWidth=1;
    [self.agreeBtn setTitle:Localized(@"Agree") forState:UIControlStateNormal];
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
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if(![_from  isEqual: @"register"]){
    NSArray *array = (NSArray *)result;
//    for (NSDictionary *dictionary in array) {
//        [self.areas addObject:[Country instanceFromDictionary:dictionary]];
//    }
    [self hideHUD];
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
            
        //}
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Country *country = [self.areas objectAtIndex:indexPath.section];
//    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
    if(![_from  isEqual: @"register"]){

NSMutableDictionary *str=[self.areas objectAtIndex:indexPath.row];
    self.completionBlock(str);
    [self.delegate cancelButtonClicked:self];
    }else{
        NSString *str=[self.areas objectAtIndex:indexPath.row];
        self.completionBlock2(str);
        [self.delegate cancelButtonClicked:self];
    }
}


- (IBAction)agreeBtnAction:(id)sender {
    self.completionBlock2(@"");
    [self.delegate cancelButtonClicked:self];

}

- (IBAction)close:(id)sender {
    [self.delegate cancelButtonClicked:self];

}
@end
