//
//  AVGTrack.h
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVGTrack : NSObject

@property (nonatomic, copy) NSString            *artistName;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *thumbURLPath;
@property (nonatomic, strong) NSDecimalNumber   *price;
@property (nonatomic, copy) NSString            *time;

@end
