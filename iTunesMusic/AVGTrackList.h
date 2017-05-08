//
//  AVGTrackList.h
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVGTrack;

@interface AVGTrackList : NSObject

@property(nonatomic, readonly) NSUInteger count;

- (instancetype)initWithArray:(NSArray<AVGTrack *> *)tracks;
- (AVGTrack *)objectAtIndexedSubscript:(NSUInteger)index;

@end
