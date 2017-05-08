//
//  AVGTrack.h
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVGTrack : NSObject

@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *trackPrice;
@property (nonatomic, copy) NSString *thumbURLPath;

@end
