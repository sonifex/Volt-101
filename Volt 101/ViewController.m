//
//  ViewController.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[FlickrManager sharedManager] getRecentPhotosByPage:1 count:10 completion:^(FKPhotos *photos, NSError *error) {
        
        NSLog(@"photos: %@",photos);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
