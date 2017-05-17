//
//  AVGTrack.h
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@import Foundation;

@class UIImage;

@interface AVGTrack : NSObject

@property (nonatomic, copy) NSString            *artistName;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *thumbURLPath;
@property (nonatomic, copy) NSString            *time;
@property (nonatomic, strong) NSDecimalNumber   *price;
@property (nonatomic, strong) UIImage           *thumbImage;

- (instancetype)initWithArtistName:(NSString *)artistName
                         trackName:(NSString *)name
                      thumbURLPath:(NSString *)thumbURLPath
                             price:(NSDecimalNumber *)price
                              time:(NSString *)time;

@end
