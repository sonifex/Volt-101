//
//  JSONValueTransformer+DateTransformer.h
//  Volt 101
//
//  Created by Soner Güler on 17/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONValueTransformer (DateTransformer)

- (NSDate *)NSDateFromNSString:(NSString*)string;

- (NSString *)JSONObjectFromNSDate:(NSDate *)date;

@end
