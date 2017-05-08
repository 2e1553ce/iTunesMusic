//
//  AVGServerManager.h
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@class AVGTrackList;

@protocol AVGServerManager <NSObject>

@required
- (void)getTracksByArtist:(NSString *)name
               withCompletionHandler:(void(^)(AVGTrackList *, NSError *))completion;

@end