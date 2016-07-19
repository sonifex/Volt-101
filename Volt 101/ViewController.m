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

@property (nonatomic) BOOL isBottomReached;

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
        
        NSLog(@"First Photo Set loaded");
        
        self.photos = photos;
        
        [self updateTableView];
        
    }];
    
}

- (void)getNextRecentPhotos {
    
    NSInteger currentPage = [self.photos.page integerValue];
    NSInteger perPage = [self.photos.perpage integerValue];
    
    [[FlickrManager sharedManager] getRecentPhotosByPage:currentPage+1 count:perPage completion:^(FKPhotos *photos, NSError *error) {
        
        NSLog(@"Next photo set loaded");
        
        self.isBottomReached = NO;
        
        self.photos.page = photos.page;
        self.photos.perpage = photos.perpage;
        [self.photos.photo addObjectsFromArray:photos.photo];
        
        [self updateTableView];
        
    }];
}

- (void)getNextSearchPhotos {
    
    NSInteger currentPage = [self.searchPhotos.page integerValue];
    NSInteger perPage = [self.searchPhotos.perpage integerValue];
    
    [[FlickrManager sharedManager] getPhotosWithSearchQuery:self.searchController.searchBar.text page:currentPage+1 count:perPage completion:^(FKPhotos *photos, NSError *error) {
        
        NSLog(@"Next photo set loaded");
        
        self.isBottomReached = NO;
        
        self.searchPhotos.page = photos.page;
        self.searchPhotos.perpage = photos.perpage;
        [self.searchPhotos.photo addObjectsFromArray:photos.photo];
        
        [self updateTableView];
        
    }];
}



#pragma mark - SearhBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [[FlickrManager sharedManager] getPhotosWithSearchQuery:searchBar.text page:1 count:10 completion:^(FKPhotos *photos, NSError *error) {
        
        self.isBottomReached = NO;
        
        self.searchPhotos = photos;
        
        [self updateTableView];
    }];
    
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchPhotos.photo removeAllObjects];
    [self updateTableView];
    
}



#pragma mark - SearchBarController Delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *query = searchController.searchBar.text;
    
    if ([query isEqualToString:@""]) {
        
        [self.searchPhotos.photo removeAllObjects];
        [self updateTableView];
        
    }
    
}



#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.photo.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PhotoCell";
    
    
    PhotoCell *cell = (PhotoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    FKPhoto *photo = [self.photos.photo objectAtIndex:indexPath.row];
    
    [cell setWithPhoto:photo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isBottomReached) {
        return;
    }
    
    if (self.searchPhotos.photo.count > 0) {
        
        if (self.searchPhotos.photo.count - 1 == indexPath.row) {
            
            self.isBottomReached = YES;
            [self getNextSearchPhotos];
            
        }
    } else if (self.photos.photo.count - 1 == indexPath.row) {
        
        self.isBottomReached = YES;
        [self getNextRecentPhotos];
        
    }
}

#pragma mark - Helpers

- (void)updateTableView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
    
}

- (FKPhotos *)photos {
    
    if (self.searchPhotos.photo.count > 0) {
        return self.searchPhotos;
    }else {
        return _photos;
    }
}

@end
