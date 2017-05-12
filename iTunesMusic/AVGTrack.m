//
//  AVGTrack.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrack.h"

@implementation AVGTrack

- (instancetype)initWithArtistName:(NSString *)artistName
                         trackName:(NSString *)name
                      thumbURLPath:(NSString *)thumbURLPath
                             price:(NSDecimalNumber *)price
                              time:(NSString *)time {
    self = [super init];
    if (self) {
        _artistName = artistName;
        _name = name;
        _thumbURLPath = thumbURLPath;
        _price = price;
        _time = time;
    }
    
    return self;
}

@end
