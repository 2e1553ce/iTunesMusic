//
//  AVGTrack.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrack.h"

@implementation AVGTrack

-(instancetype)initWithArtistName:(NSString *)artistName
                        trackName:(NSString *)name
                     thumbURLPath:(NSString *)thumbURLPath
                            price:(NSDecimalNumber *)price
                             time:(NSString *)time {
    self = [super init];
    
    if(self) {
        self.artistName = artistName;
        self.name = name;
        self.thumbURLPath = thumbURLPath;
        self.price = price;
        self.time = time;
    }
    
    return self;
}

@end
