//
//  ViewController.m
//  Volt 101
//
//  Created by Soner Güler on 16/07/16.
//  Copyright © 2016 Soner Güler. All rights reserved.
//

#import "ViewController.h"

#import "PhotoCell.h"

@interface ViewController ()

@property (nonatomic,strong) FKPhotos *photos;

@property (nonatomic,strong) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Flickr"];
    
    [self configureTableView];
    [self configureSearchController];
    
    
    
    [self getRecentPhotos];
}

#pragma mark - Configuration

- (void)configureSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)configureTableView {
    
    [self.tableView registerClass:[PhotoCell class] forCellReuseIdentifier:@"PhotoCell"];
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}


#pragma mark - SERVICES

- (void)getRecentPhotos {
    
    [[FlickrManager sharedManager] getRecentPhotosByPage:1 count:10 completion:^(FKPhotos *photos, NSError *error) {
        
        NSLog(@"Download successed!");
        self.photos = photos;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
    }];
    
}



#pragma mark - SearchBar Delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"search Text: %@",searchController.searchBar.text);
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.photo ? 10 : 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PhotoCell";
    
    
    PhotoCell *cell = (PhotoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    FKPhoto *photo = [self.photos.photo objectAtIndex:indexPath.row];
    
    [cell setWithPhoto:photo];
    
    return cell;
}


@end
