//
//  AVGTrackCell.m
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackCell.h"
#import "AVGTrackThumbImageView.h"
#import "AVGTrack.h"
#import "NSString+Additions.h"
#import <Masonry.h>

NSString *const AVGTrackCellIdentifier = @"AVGTrackCellIdentifier";

@interface AVGTrackCell ()

@end

@implementation AVGTrackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self createSubviewsWithContact];
    }
    return self;
}

- (void)createSubviewsWithContact {
    _artistNameLabel = [UILabel new];
    _artistNameLabel.textAlignment = NSTextAlignmentLeft;
    _artistNameLabel.font = [UIFont systemFontOfSize:12];
    _artistNameLabel.textColor = UIColor.grayColor;
    
    _trackNameLabel = [UILabel new];
    _trackNameLabel.textAlignment = NSTextAlignmentLeft;
    _trackNameLabel.font = [UIFont systemFontOfSize:14];
    
    _trackPriceLabel = [UILabel new];
    _trackPriceLabel.textAlignment = NSTextAlignmentLeft;
    _trackPriceLabel.font = [UIFont systemFontOfSize:12];
    _trackPriceLabel.textColor = UIColor.grayColor;
    
    _trackTimeLabel = [UILabel new];
    _trackTimeLabel.textAlignment = NSTextAlignmentLeft;
    _trackTimeLabel.font = [UIFont systemFontOfSize:12];
    _trackTimeLabel.textColor = UIColor.grayColor;
    
    _trackThumbImageView = [AVGTrackThumbImageView new];
    
    [self addSubview:_artistNameLabel];
    [self addSubview:_trackNameLabel];
    [self addSubview:_trackPriceLabel];
    [self addSubview:_trackTimeLabel];
    [self addSubview:_trackThumbImageView];
    
    // Masonry
    UIView *superview = self.contentView;
    
    // Left track thumbnail
    [self.trackThumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.left.equalTo(superview).with.offset(5);
        make.top.equalTo(superview).with.offset(5);
        make.bottom.equalTo(superview).with.offset(-5);
    }];
    
    // Top artist name label
    [self.trackNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.equalTo(self.trackThumbImageView.mas_right).with.offset(10);
        make.right.equalTo(superview).with.offset(-70);
        make.centerY.equalTo(@(superview.center.y)).with.offset(-12);
    }];
    
    // Bot track name label
    [self.artistNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.equalTo(self.trackThumbImageView.mas_right).with.offset(10);
        make.right.equalTo(superview).with.offset(-70);
        make.centerY.equalTo(@(superview.center.y)).with.offset(12);
    }];
    
    // Right-top track price label
    [self.trackTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.equalTo(self.trackNameLabel.mas_right).with.offset(5);
        make.right.equalTo(superview).with.offset(-10);
        make.centerY.equalTo(@(superview.center.y)).with.offset(-12);
    }];
    
    // Right-bot track time label
    [self.trackPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.left.equalTo(self.artistNameLabel.mas_right).with.offset(5);
        make.right.equalTo(superview).with.offset(-10);
        make.centerY.equalTo(@(superview.center.y)).with.offset(12);
    }];
}

- (void)addTrack:(AVGTrack *)track {
    self.artistNameLabel.text   = track.artistName;
    self.trackNameLabel.text    = track.name;
    
    if([track.price integerValue] < 0) {
        self.trackPriceLabel.text   = @"нет цены";
    } else {
        self.trackPriceLabel.text   = [NSString stringWithFormat:@"%@$", track.price];
    }
    
    self.trackTimeLabel.text    = track.time;
}

- (void)addImage:(UIImage *)downloadedImage {
    self.trackThumbImageView.image = downloadedImage;
}

- (void)stopActivityIndicator {
    [self.trackThumbImageView.activityIndicatorView stopAnimating];
}

+ (CGFloat)heightForCell {
    return 70;
}

@end
// TODO:
// add indicator on view
// didnt find track - alert
