//
//  MyCustomCollectionViewFlowLayout.m
//  Alhisba
//
//  Created by Apple on 05/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MyCustomCollectionViewFlowLayout.h"

@implementation MyCustomCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributes = [NSMutableArray arrayWithCapacity:attributes.count];
    for (UICollectionViewLayoutAttributes *attribute in attributes)
    {
        if ((attribute.frame.origin.x + attribute.frame.size.width <= ceil(self.collectionViewContentSize.width)) &&
            (attribute.frame.origin.y + attribute.frame.size.height <= ceil(self.collectionViewContentSize.height)))
        {
            [newAttributes addObject:attribute];
        }
    }
    return newAttributes;
}


@end
