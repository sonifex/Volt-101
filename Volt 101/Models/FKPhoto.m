//
//  FKPhoto.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "FKPhoto.h"

#import "FKUtilities.h"


@implementation FKPhoto


- (NSString*)photoURLString {
    
    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_l.jpg",self.farm,self.server,self.Id,self.secret];
    
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"Id"
                                                       }];
}

@end
