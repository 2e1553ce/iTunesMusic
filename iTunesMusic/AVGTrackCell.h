//
//  AVGTrackCell.h
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@import UIKit;

@class AVGTrack;
@class AVGTrackThumbImageView;

extern NSString *const AVGTrackCellIdentifier;

@interface AVGTrackCell : UITableViewCell

@property (nonatomic, strong) UILabel *artistNameLabel;
@property (nonatomic, strong) UILabel *trackNameLabel;
@property (nonatomic, strong) UILabel *trackPriceLabel;
@property (nonatomic, strong) UILabel *trackTimeLabel;
@property (nonatomic, strong) AVGTrackThumbImageView *trackThumbImageView;

- (void)addTrack:(AVGTrack *)track;
- (void)addImage:(UIImage *)downloadedImage;

- (void)stopActivityIndicator;

+ (CGFloat)heightForCell;

@end
