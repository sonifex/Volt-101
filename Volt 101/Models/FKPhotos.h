//
//  FKPhotos.h
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FKPhoto.h"

@protocol FKPhoto
@end

@interface FKPhotos : JSONModel

@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *pages;
@property (nonatomic,strong)NSString *perpage;
@property (nonatomic,strong)NSArray<FKPhoto> *photo;


@end
