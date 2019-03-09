//
//  BaseViewController.h
//  StreetWhere
//
//  Created by Amit Kulkarni on 10/04/15.
//  Copyright (c) 2015 Mobentia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "Utils.h"
//#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface BaseViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    int requestCode;
    
}

@property (nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic) BOOL dismissProgress;
-(NSString*)decodeHTMLString:(NSString *)str;
- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code;

- (void) makeGetCallForPage:(NSString *)page
                 withParams:(NSDictionary *)params
            withRequestCode:(int)code;

- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
                withCallback:(void (^)(id))resultCallback;

- (void) parseResult:(id) result withCode:(int)reqeustCode;
- (void) showErrorAlertWithMessage:(NSString *)message;
- (void) showSuccessMessage:(NSString *)message;
-(void)toastMessage:(NSString*)message;

- (void) showHUD:(NSString *)labelText;
- (void) hideHUD;
- (void)refreshItems;
- (void)showSideMenu;
-(void)addPushAnimation;
-(void)addPopAnimation;
- (UIImage *)captureView: (UIView *)view inSize: (CGSize)size;
-(UIView*)addborderAndRoundRectTo:(UIView*)view;
- (void)showInfo:(NSString*)Information:(id)sender;
-(NSString *)strToCurrencyFormatter:(NSString *)num;
-(NSString *)convertToEnglishNumber:(NSString *) string;
@end
