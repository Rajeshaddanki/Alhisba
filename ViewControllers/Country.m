#import "Country.h"
#import "MCLocalization.h"
#import "BaseViewController.h"

#import "CountryArea.h"

@implementation Country

@synthesize areas, countryId, title, titleAr;

+ (Country *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Country *instance = [[Country alloc] init];
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

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedAreas = [aDictionary objectForKey:@"areas"];
    if ([receivedAreas isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedAreas = [NSMutableArray arrayWithCapacity:[receivedAreas count]];
        for (NSDictionary *item in receivedAreas) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedAreas addObject:[CountryArea instanceFromDictionary:item]];
            }
        }

        self.areas = populatedAreas;

    }
    self.countryId = [aDictionary objectForKey:@"id"];
    self.title = [aDictionary objectForKey:@"title"];
    self.titleAr = [aDictionary objectForKey:@"title_ar"];
    self.address_id = [aDictionary objectForKey:@"address_id"];
}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.areas) {
        [dictionary setObject:self.areas forKey:@"services"];
    }

    if (self.countryId) {
        [dictionary setObject:self.countryId forKey:@"id"];
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
