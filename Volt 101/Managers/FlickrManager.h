//
//  FlickrManager.h
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FlickrKit.h"
#import "FKPhotos.h"

typedef void (^FMRequestCompletion)(FKPhotos *photos, NSError *error);

@interface FlickrManager : NSObject

+ (FlickrManager*) sharedManager;

/*!
 * @discussion  Recent Public Photos on Flickr
 * @param page Number of current page
 * @param count Number of photos fetching
 */
- (void)getRecentPhotosByPage:(NSInteger)page count:(NSInteger)numberOfPhotos completion:(FMRequestCompletion)completion;

/*!
 * @discussion Getting the photos related with search query
 * @param query Search Text
 * @param page Number of current page
 * @param count Number of photos fetching
 */
- (void)getPhotosWithSearchQuery:(NSString*)query page:(NSInteger)page count:(NSInteger)numberOfPhotos completion:(FMRequestCompletion)completion;
@end
