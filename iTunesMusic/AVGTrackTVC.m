//
//  AVGTrackTVC.m
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackTVC.h"
#import "AVGTrackList.h"
#import "AVGServerManager.h"
#import "AVGTrackCell.h"
#import "AVGTrackService.h"

@interface AVGTrackTVC () <UISearchBarDelegate>

@property (nonatomic, strong) AVGTrackList *tracks;
@property (nonatomic, strong) id <AVGServerManager> trackManager;

@end

@implementation AVGTrackTVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Apple Music";
    [self.tableView registerClass:[AVGTrackCell class] forCellReuseIdentifier:AVGTrackCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *artistName = searchBar.text;
    
    self.trackManager = [AVGTrackService new];
    [self.trackManager getTracksByArtist:artistName withCompletionHandler:^(AVGTrackList *trackList, NSError *error) {
        self.tracks = trackList;
        [self.tableView reloadData];
    }];
}

@end
