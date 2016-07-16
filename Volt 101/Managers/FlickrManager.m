//
//  FlickrManager.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "FlickrManager.h"



@implementation FlickrManager

+ (FlickrManager *) sharedManager {
    static dispatch_once_t onceToken;
    static FlickrManager *manager = nil;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

#pragma mark - Recent Public Photos

- (void)getRecentPhotosByPage:(NSInteger)page count:(NSInteger)numberOfPhoto completion:(FMRequestCompletion)completion {
    
    NSDictionary *args = @{
                           @"per_page" : [NSString stringWithFormat:@"%i",(int)numberOfPhoto],
                           @"page" : [NSString stringWithFormat:@"%i",(int)page]
                           };
    
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.getRecent" args:args maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
        
        FKPhotos *photos = [[FKPhotos alloc] initWithDictionary:[response objectForKey:@"photos"] error:nil];
        
        completion(photos,error);
        
    }];
    
    
    
}



@end
