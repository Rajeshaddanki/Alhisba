#import "CountryArea.h"
#import "MCLocalization.h"
#import "BaseViewController.h"

@implementation CountryArea

@synthesize countryAreaId, title, titleAr;

+ (CountryArea *)instanceFromDictionary:(NSDictionary *)aDictionary {

    CountryArea *instance = [[CountryArea alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}

- (NSString *)title {
    
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return title;
    } else {
        return [titleAr length] > 0 ? titleAr : title;
    }
}

- (NSString *)titleArTitle {
    
        return [titleAr length] > 0 ? titleAr : title;
}

- (NSString *)titleEnTitle {
    
        return title;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.countryAreaId = [aDictionary objectForKey:@"id"];
    self.title = [aDictionary objectForKey:@"title"];
    self.titleAr = [aDictionary objectForKey:@"title_ar"];
    self.lattitude = [aDictionary objectForKey:@"latitude"];
    self.longitude = [aDictionary objectForKey:@"longitude"];
    self.servicesArray = [aDictionary objectForKey:@"services"];
    self.address_id = [aDictionary objectForKey:@"address_id"];
    
    _detailsDictionary = [[NSMutableDictionary alloc]initWithDictionary:aDictionary];
}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.countryAreaId) {
        [dictionary setObject:self.countryAreaId forKey:@"countryAreaId"];
    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"title"];
    }

    if (self.titleAr) {
        [dictionary setObject:self.titleAr forKey:@"titleAr"];
    }

    return dictionary;

}


@end
