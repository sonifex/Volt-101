//
//  PhotoCell.h
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FKPhoto;

@interface PhotoCell : UITableViewCell

- (void)setWithPhoto:(FKPhoto*)photo;

@end
