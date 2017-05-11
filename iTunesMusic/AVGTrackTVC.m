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
    
    // Search bar
    CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40.f);
    self.searchBar = [[UISearchBar alloc] initWithFrame:bounds];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Поиск";
    self.tableView.tableHeaderView = self.searchBar;
    
    // Done button on keyboard
    UIToolbar *ViewForDoneButtonOnKeyboard = [UIToolbar new];
    [ViewForDoneButtonOnKeyboard sizeToFit];
    UIBarButtonItem *btnDoneOnKeyboard = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                          style:UIBarButtonItemStyleDone target:self
                                                                         action:@selector(doneBtnFromKeyboardClicked:)];
    [ViewForDoneButtonOnKeyboard setItems:[NSArray arrayWithObjects:btnDoneOnKeyboard, nil]];
    self.searchBar.inputAccessoryView = ViewForDoneButtonOnKeyboard;
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
    __weak typeof(self) weakSelf = self;
    
    if([self.tracks objectAtIndexedSubscript:indexPath.row].thumbImage) {
        [cell addImage:[self.tracks objectAtIndexedSubscript:indexPath.row].thumbImage];
    } else {
        [self.trackManager downloadImageFrom:url
                       withCompletionHandler:^(UIImage *image, NSError *error) {
                           __strong AVGTrackCell *strongCell = weakCell;
                           [strongCell addImage:image];
                           [strongCell stopActivityIndicator];
                           [strongCell layoutSubviews];
                           
                           __strong typeof(self) strongSelf = weakSelf;
                           [strongSelf.tracks objectAtIndexedSubscript:indexPath.row].thumbImage = image;
                           
                       }];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AVGTrackCell heightForCell];
}

#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Cancel all tasks
    if(self.trackManager) {
        [((AVGTrackService *)self.trackManager).iTunesSession getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
            for(NSURLSessionTask *task in tasks) {
                [task cancel];
            }
        }];
    }
    
    NSString *artistName = searchBar.text;
    self.trackManager = [AVGTrackService new];
    
    __weak typeof(self) weakSelf = self;
    [self.trackManager getTracksByArtist:artistName withCompletionHandler:^(AVGTrackList *trackList, NSError *error) {
        if([trackList count] > 0) {
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.tracks = trackList;
            
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            [self.searchBar endEditing:YES];
        } else {
            // No tracks! - show uiview animationduration?
            [self.searchBar endEditing:YES];
        }
    }];
}

#pragma mark - Actions

- (void)doneBtnFromKeyboardClicked:(id)sender
{
    [self.searchBar endEditing:YES];
}

@end
