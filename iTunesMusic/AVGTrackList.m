//
//  AVGTrackList.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackList.h"
#import "AVGTrack.h"

@interface AVGTrackList ()

@property(nonatomic, copy, readwrite) NSArray *tracks;

@end

@implementation AVGTrackList

- (instancetype)initWithArray:(NSArray<AVGTrack *> *)tracks {
    self = [super init];
    if (self) {
        _tracks = tracks;
    }
    
    return self;
}

- (NSUInteger)count {
    return self.tracks.count;
}

- (AVGTrack *)objectAtIndexedSubscript:(NSUInteger)index {
    return self.tracks[index];
}


@end
