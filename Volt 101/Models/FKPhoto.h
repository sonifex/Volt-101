//
//  FKPhoto.h
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FKPhoto : JSONModel

@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *owner;
@property(nonatomic,strong) NSString *secret;
@property(nonatomic,strong) NSString *server;
@property(nonatomic,strong) NSString *farm;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *ownername;
@property(nonatomic,strong) NSDate *dateUpload;
@property(nonatomic,strong) NSURL *photoURL;




@end
