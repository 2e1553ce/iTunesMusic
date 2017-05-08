//
//  AVGTrackService.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGTrackService.h"
#import "AVGTrackList.h"
#import "AVGTrack.h"

@implementation AVGTrackService

static const NSInteger tracksLimit = 50;

- (void)getTracksByArtist:(NSString *)name
               withCompletionHandler:(void(^)(AVGTrackList *, NSError *))completion {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *iTunesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=%ld&entity=music",
                           name,
                           (long)tracksLimit];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL: url];
    [request setHTTPMethod: @"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[iTunesSession dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
                         dict = dict[@"results"];
                         
                         NSMutableArray *tracksArray = [NSMutableArray new];
                         
                         for(id object in dict) {
                             AVGTrack *track = [AVGTrack new];
                             
                             track.artistName = object[@"artistName"];
                             track.trackName = object[@"trackName"];
                             track.trackPrice = object[@"trackPrice"];
                             track.thumbURLPath = object[@""];
                             
                             [tracksArray addObject: track];
                         }
                         
                         AVGTrackList *tracks = [[AVGTrackList alloc] initWithArray:tracksArray];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(tracks, error);
                         });
    }] resume];
}


@end
