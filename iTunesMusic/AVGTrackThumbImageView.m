//
//  AVGTrackThumbImageView.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackThumbImageView.h"
#import <Masonry.h>

@implementation AVGTrackThumbImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        self.layer.shouldRasterize = YES;
        
        // Constraints for indicator
        self.activityIndicatorView = [UIActivityIndicatorView new];
        [self addSubview:self.activityIndicatorView];
        
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(@(self.center.y));
            make.centerX.equalTo(@(self.center.x));
        }];
        
        [self.activityIndicatorView startAnimating];
    }
    return self;
}

@end
