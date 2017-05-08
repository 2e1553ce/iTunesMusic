//
//  AVGTrackCell.h
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const AVGTrackCellIdentifier;

@class AVGTrack;

@interface AVGTrackCell : UITableViewCell

- (void)addTrack:(AVGTrack *)track;
+ (CGFloat)heightForCell;

@end
