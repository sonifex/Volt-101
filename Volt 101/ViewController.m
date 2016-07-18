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
@property (nonatomic,strong) FKPhotos *searchPhotos;
@property (nonatomic,strong) NSString *searchQuery;

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
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
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
        
        self.photos = photos;
        [self updateTableView];
        
    }];
    
}


#pragma mark - SearhBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchPhotos = nil;
    [self updateTableView];
    
}



#pragma mark - SearchBarController Delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *query = searchController.searchBar.text;
    
    if ([query isEqualToString:@""]) {
        
        self.searchPhotos = nil;
        [self updateTableView];
        
    }
    
    [[FlickrManager sharedManager] getPhotosWithSearchQuery:searchController.searchBar.text page:1 count:10 completion:^(FKPhotos *photos, NSError *error) {
        
        self.searchPhotos = photos;
        
        [self updateTableView];
    }];
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



#pragma mark - Helpers

- (void)updateTableView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
    
}

- (FKPhotos *)photos {
    
    if (self.searchPhotos && self.searchPhotos.photo.count > 0) {
        return self.searchPhotos;
    }else {
        return _photos;
    }
}

@end
