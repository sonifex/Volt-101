//
//  PhotoCell.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "PhotoCell.h"

#import "PureLayout.h"
#import "FKPhoto.h"
#import "UIImageView+WebCache.h"
#import "NSDate+TimeAgo.h"

@interface PhotoCell()

@property (nonatomic,strong) UIImageView *imageViewUserAvatar;
@property (nonatomic,strong) UILabel *labelUserName;
@property (nonatomic,strong) UILabel *labelDate;
@property (nonatomic,strong) UIImageView *imageViewPhoto;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic,strong) FKPhoto *photo;

@end

@implementation PhotoCell

- (void)setWithPhoto:(FKPhoto *)photo {
    
    _photo = photo;
    
    [self.imageViewPhoto sd_setImageWithURL:self.photo.photoURL];
    [self.imageViewUserAvatar sd_setImageWithURL:[self.photo ownerAvatarURL]];
    
    [self.labelUserName setText:self.photo.ownername];
    [self.labelDate setText:[self.photo.dateUpload dateTimeAgo]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupViews];
        
    }
    return self;
}


- (void)setupViews {
    
    
    [self.contentView addSubview:self.imageViewUserAvatar];
    [self.contentView addSubview:self.labelUserName];
    [self.contentView addSubview:self.labelDate];
    [self.contentView addSubview:self.imageViewPhoto];
    
    
    [self.contentView setNeedsUpdateConstraints];
    
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        
        // User Avatar
        [self.imageViewUserAvatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.imageViewUserAvatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [self.imageViewUserAvatar autoSetDimensionsToSize:CGSizeMake(40, 40)];
        
        
        // Username Label
        [self.labelUserName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imageViewUserAvatar withOffset:10];
        [self.labelUserName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:0];
        [self.labelUserName autoSetDimension:ALDimensionHeight toSize:50];
        
        
        // Label Date
        [self.labelDate autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10];
        [self.labelDate autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:0];
        [self.labelDate autoSetDimension:ALDimensionHeight toSize:50];
        [self.labelDate autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.labelUserName withMultiplier:0.8];
        
        
        // Photo
        [self.imageViewPhoto autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 50, 0) excludingEdge:ALEdgeTop];
        [self.imageViewPhoto autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageViewUserAvatar withOffset:10];
        [self.imageViewPhoto autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageViewPhoto withMultiplier:1];
        
        
        
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


#pragma mark - Sub-Views

- (UIImageView *)imageViewPhoto {
    
    if (!_imageViewPhoto) {
        self.imageViewPhoto = [UIImageView newAutoLayoutView];
        self.imageViewPhoto.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPhoto.clipsToBounds = YES;
    }
    return _imageViewPhoto;
}

- (UILabel *)labelUserName {
    
    if (!_labelUserName) {
        self.labelUserName = [UILabel newAutoLayoutView];
        [self.labelUserName setTextColor:[UIColor colorWithWhite:0.200 alpha:1.000]];
        [self.labelUserName setFont:[UIFont boldSystemFontOfSize:15]];
        [self.labelUserName setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return _labelUserName;
}

- (UIImageView *)imageViewUserAvatar {
    
    if (!_imageViewUserAvatar) {
        self.imageViewUserAvatar = [UIImageView newAutoLayoutView];
        self.imageViewUserAvatar.layer.cornerRadius = 20;
    }
    return _imageViewUserAvatar;
}

- (UILabel *)labelDate {
    
    if (!_labelDate) {
        self.labelDate = [UILabel newAutoLayoutView];
        self.labelDate.textAlignment = NSTextAlignmentRight;
        [self.labelDate setTextColor:[UIColor colorWithWhite:0.600 alpha:1.000]];
        [self.labelDate setFont:[UIFont systemFontOfSize:13]];
    }
    return _labelDate;
}


@end
