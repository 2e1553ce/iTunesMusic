//
//  AVGTrack.h
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@import Foundation;

@interface AVGTrack : NSObject

@property (nonatomic, copy) NSString            *artistName;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *thumbURLPath;
@property (nonatomic, strong) NSDecimalNumber   *price;
@property (nonatomic, copy) NSString            *time;

- (instancetype)initWithArtistName:(NSString *)artistName
                        trackName:(NSString *)name
                     thumbURLPath:(NSString *)thumbURLPath
                            price:(NSDecimalNumber *)price
                             time:(NSString *)time;

@end
