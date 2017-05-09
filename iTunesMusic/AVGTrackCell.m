//
//  AVGTrackCell.m
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackCell.h"
#import "AVGTrackThumbView.h"
#import "AVGTrack.h"
#import "NSString+Additions.h"
#import <Masonry.h>

NSString *const AVGTrackCellIdentifier = @"AVGTrackCellIdentifier";

@interface AVGTrackCell ()

@property (nonatomic, strong) UILabel *artistNameLabel;
@property (nonatomic, strong) UILabel *trackNameLabel;
@property (nonatomic, strong) UILabel *trackPriceLabel;
@property (nonatomic, strong) UILabel *trackTime;
@property (nonatomic, strong) AVGTrackThumbView *trackThumbView;

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
    _artistNameLabel    = [UILabel new];
    _trackNameLabel     = [UILabel new];
    _trackPriceLabel    = [UILabel new];
    _trackTime          = [UILabel new];
    _trackThumbView     = [AVGTrackThumbView new];
    
    _artistNameLabel.frame  = CGRectMake(20.0, 10.0, 100.0, 20.0);
    _trackNameLabel.frame   = CGRectMake(20.0, 35.0, 100.0, 20.0);
    
    [self addSubview:_artistNameLabel];
    [self addSubview:_trackNameLabel];
    [self addSubview:_trackThumbView];
    
    // Masonry
    
}

- (void)addTrack:(AVGTrack *)track {
    self.artistNameLabel.text = track.artistName;
    self.trackNameLabel.text  = track.name;
    self.trackPriceLabel.text = [NSString stringWithFormat:@"%@", track.price];
    self.trackTime.text = [NSString getTimeFromMilliseconds:track.time];
}

+ (CGFloat)heightForCell {
    return 120;
}

@end
// TODO:
// Cellku nastroit s masonry
// Cveta na TVC krasivo
// convert track time
// tableview begin updates etc
// na Cellkinu View postavit gruzyashisya krug
// Keshiravanie
