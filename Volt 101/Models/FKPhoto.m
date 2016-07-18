//
//  FKPhoto.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "FKPhoto.h"

#import "JSONValueTransformer+DateTransformer.h"


@implementation FKPhoto



+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"Id",
                                                       @"dateupload" : @"dateUpload",
                                                       @"url_l" : @"photoURL"
                                                       }];
}



- (NSURL*)ownerAvatarURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://flickr.com/buddyicons/%@.jpg",self.owner]];
}

@end
