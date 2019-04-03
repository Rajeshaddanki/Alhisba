//
//  AppDelegate.m
//  Alhisba
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "Reachability.h"
#import "Utils.h"
#import "SWRevealViewController.h"
#import "Common.h"


@implementation UILabel (Helper)

- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
   
    // NSLog(@"%@",name);
    //    NSLog(@"%@-%@ --%@---%@",self.font.fontName,self.font.fontDescriptor.fontAttributes,self.font,self.font.fontDescriptor.postscriptName,self.font.fontDescriptor.matrix );
   // NSLog(@"%@",self.font.fontDescriptor.postscriptName);
    if ([self.font.fontDescriptor.postscriptName  isEqual: @".SFUIText-Semibold"]){
        NSString *str =[NSString stringWithFormat:@"%@-SemiBold",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
    else if(isBold(self.font.fontDescriptor)){
        NSString *str =[NSString stringWithFormat:@"%@-Bold",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
    
    else{
//        self.font = [UIFont fontWithName:name size:self.font.pointSize];
        NSString *str =[NSString stringWithFormat:@"%@-Regular",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
}

BOOL isBold(UIFontDescriptor * fontDescriptor)
{
    return (fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) != 0;
}

@end
@implementation UITextView (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    
    if ([self.font.fontDescriptor.postscriptName  isEqual: @".SFUIText-Semibold"]){
        NSString *str =[NSString stringWithFormat:@"%@-SemiBold",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
    else if(isBold(self.font.fontDescriptor)){
        NSString *str =[NSString stringWithFormat:@"%@-Bold",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
    
    else{
        //        self.font = [UIFont fontWithName:name size:self.font.pointSize];
        NSString *str =[NSString stringWithFormat:@"%@-Regular",name];
        self.font = [UIFont fontWithName:str size:self.font.pointSize];
    }
}

@end



//@interface UIFont (SystemFontOverride)
//@end
//@implementation UIFont (SystemFontOverride)
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//
//+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
//
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        return [UIFont fontWithName:@"DroidArabicKufi-Bold" size:fontSize];
//    }else{
//        return [UIFont fontWithName:@"DroidSans-Bold" size:fontSize];
//    }
//}
//
//+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        return [UIFont fontWithName:@"DroidArabicKufi" size:fontSize];
//    }else{
//        return [UIFont fontWithName:@"DroidSans" size:fontSize];
//    }
//}
//
//#pragma clang diagnostic pop
//
//@end
//
//@implementation UILabel (Helper)
//- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
//    // NSLog(@"%@",name);
//    self.font = [UIFont fontWithName:name size:self.font.pointSize];
//}
//
//@end
//@implementation UITextView (Helper)
//- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
//    // NSLog(@"%@",name);
//    self.font = [UIFont fontWithName:name size:self.font.pointSize];
//
//}
//@end


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    if(![Utils getLanguage]){
//        [Utils setLanguage:KEY_LANGUAGE_AR];
//    }
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [[UILabel appearance] setSubstituteFontName:@"Cairo"];
        [[UITextView appearance] setSubstituteFontName:@"Cairo"];
        [[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
        
        [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Cairo-Regular" size:16];
        [UITextField appearance].font=[UIFont fontWithName:@"Cairo-Regular" size:16];
        
    } else {
        
        //    [[UILabel appearance] setSubstituteFontName:@"DroidSans"];
        [[UILabel appearance] setSubstituteFontName:@"Cairo"];
        [[UITextView appearance] setSubstituteFontName:@"Cairo"];
        [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Cairo-Regular" size:16];
        [UITextField appearance].font=[UIFont fontWithName:@"Cairo-Regular" size:16];
    }
    
    
    [self downloadStringsFile];
    [self downloadSettings];

    return YES;
}


- (void)downloadStringsFile {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus !=0){
        
        NSData *data2 = [NSData dataWithContentsOfURL:[Utils createURLForPage:WORDS withParameters:@{}]];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *filePath = [documentsDirectoryURL URLByAppendingPathComponent:@"strings.json"];
        NSLog(@"file: %@", filePath);
        
        [data writeToURL:filePath atomically:YES];
        
        [MCLocalization loadFromURL:filePath defaultLanguage:KEY_LANGUAGE_AR];
        if ([[Utils getLanguage] length] != 0) {
            [[MCLocalization sharedInstance] setLanguage:[Utils getLanguage]];
            [[MCLocalization sharedInstance] reloadStrings];
        }
    }
    else{
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:Localized(@"server_not_connected") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)downloadSettings {
    NSData *data2 = [NSData dataWithContentsOfURL:[Utils createURLForPage:SETTINGS withParameters:@{}]];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    [[NSUserDefaults standardUserDefaults] setValue:dictionary forKey:@"SETTINGS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if([[dictionary valueForKey:@"app_lock"] isEqual:@"1"]){
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }else
        if(![[dictionary valueForKey:@"stop_publish"] isEqual:@"1"]){
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];
        }else{
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ErrorViewController"];
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];
        }
    
    /*
     NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
     [currentDefaults setObject:data forKey:@"SETTINGS"];
     */
}
- (void)downloadSettingsWithOutLOCK {
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [currentDefaults objectForKey:@"SETTINGS"];
    
    if(![[dictionary valueForKey:@"stop_publish"] isEqual:@"1"]){
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }else{
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ErrorViewController"];
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
    
    /*
     NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
     [currentDefaults setObject:data forKey:@"SETTINGS"];
     */
}

- (void)reloadUIForLanguageChange {

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [[UILabel appearance] setSubstituteFontName:@"Cairo"];
        [[UITextView appearance] setSubstituteFontName:@"Cairo"];
        [[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
        
        [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Cairo" size:16];
        [UITextField appearance].font=[UIFont fontWithName:@"Cairo" size:16];
        [[UICollectionView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];

    } else {
        
        //    [[UILabel appearance] setSubstituteFontName:@"DroidSans"];
        [[UILabel appearance] setSubstituteFontName:@"Cairo"];
        [[UITextView appearance] setSubstituteFontName:@"Cairo"];
        [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Cairo" size:16];
        [UITextField appearance].font=[UIFont fontWithName:@"Cairo" size:16];
        [[UICollectionView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    }
}

- (void)afterLoginSucess {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
