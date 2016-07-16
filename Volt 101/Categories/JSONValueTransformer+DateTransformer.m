//
//  JSONValueTransformer+DateTransformer.m
//  Volt 101
//
//  Created by Soner Güler on 17/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "JSONValueTransformer+DateTransformer.h"

@implementation JSONValueTransformer (DateTransformer)


- (NSDate *)NSDateFromNSString:(NSString*)string {
    
    return [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date {
    
    return [NSString stringWithFormat:@"%i",(uint)[date timeIntervalSince1970]];
}


@end
