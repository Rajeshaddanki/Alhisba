#import <Foundation/Foundation.h>

@interface CountryArea : NSObject {

}

@property (nonatomic, copy) NSString *countryAreaId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;
@property (nonatomic, copy) NSString *lattitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *address_id;


@property (nonatomic, copy) NSMutableArray *servicesArray;
@property (nonatomic, copy) NSMutableDictionary *detailsDictionary;


+ (CountryArea *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
- (NSString *)titleArTitle;
- (NSString *)titleEnTitle;
- (NSDictionary *)dictionaryRepresentation;

@end
