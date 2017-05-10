//
//  AVGServerManager.h
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@class AVGTrackList;
@class UIImage;

@protocol AVGServerManager <NSObject>

@required
- (void)getTracksByArtist:(NSString *)name
    withCompletionHandler:(void(^)(AVGTrackList *, NSError *))completion;

- (void)downloadImageFrom:(NSURL *)url
    withCompletionHandler:(void(^)(UIImage *, NSError *))completion;

@end
