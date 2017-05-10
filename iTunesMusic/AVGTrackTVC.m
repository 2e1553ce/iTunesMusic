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
#import "AVGTrack.h"

@interface AVGTrackTVC () <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (nonatomic, strong) AVGTrackList *tracks;
@property (nonatomic, strong) id <AVGServerManager> trackManager;

@end

@implementation AVGTrackTVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Apple Music";
    [self.tableView registerClass:[AVGTrackCell class] forCellReuseIdentifier:AVGTrackCellIdentifier];
    
    CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40.f);
    self.searchBar = [[UISearchBar alloc] initWithFrame:bounds];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Поиск";
    self.tableView.tableHeaderView = self.searchBar;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVGTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:AVGTrackCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[AVGTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AVGTrackCellIdentifier];
    }
    
    AVGTrack *track = [self.tracks objectAtIndexedSubscript:indexPath.row];
    [cell addTrack: track];

    NSURL *url = [NSURL URLWithString:track.thumbURLPath];
    
    __weak AVGTrackCell *weakCell = cell;
    [self.trackManager downloadImageFrom:url
                   withCompletionHandler:^(UIImage *image, NSError *error) {
                       __strong AVGTrackCell *strongCell = weakCell;
                       [strongCell addImage:image];
                       [strongCell layoutSubviews];
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AVGTrackCell heightForCell];
}

#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    
    NSString *artistName = searchBar.text;
    self.trackManager = [AVGTrackService new];
    
    __weak typeof(self)weakSelf = self;
    [self.trackManager getTracksByArtist:artistName withCompletionHandler:^(AVGTrackList *trackList, NSError *error) {
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.tracks = trackList;
        [strongSelf.tableView reloadData];
    }];
}

@end
