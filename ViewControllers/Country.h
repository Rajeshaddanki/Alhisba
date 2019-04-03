#import <Foundation/Foundation.h>

@interface Country : NSObject {

}

@property (nonatomic, copy) NSArray *areas;
@property (nonatomic, copy) NSString *countryId;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;
@property (nonatomic, copy) NSMutableArray *servicesArray;

+ (Country *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
