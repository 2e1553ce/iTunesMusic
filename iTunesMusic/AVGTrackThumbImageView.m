//
//  AVGTrackThumbImageView.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackThumbImageView.h"

@implementation AVGTrackThumbImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        self.layer.shouldRasterize = YES;
    }
    return self;
}

@end
