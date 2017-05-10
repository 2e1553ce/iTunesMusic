//
//  AVGTrackService.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@import UIKit;
#import "AVGTrackService.h"
#import "AVGTrackList.h"
#import "AVGTrack.h"
#import "NSString+Additions.h"

@implementation AVGTrackService

static const NSInteger tracksLimit = 50;

- (void)getTracksByArtist:(NSString *)name
               withCompletionHandler:(void(^)(AVGTrackList *, NSError *))completion {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *iTunesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=%ld&entity=song",
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
                             track.name = object[@"trackName"];
                             
                             NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                             [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                             [formatter setMaximumFractionDigits:2];
                             NSString *priceStr = [formatter stringFromNumber:object[@"trackPrice"]];
                             track.price = [NSDecimalNumber decimalNumberWithString:priceStr];
                             
                             track.time = [NSString getTimeFromMilliseconds:[object[@"trackTimeMillis"] integerValue]];
                             track.thumbURLPath = object[@"artworkUrl100"];
                             
                             [tracksArray addObject: track];
                         }
                         
                         AVGTrackList *tracks = [[AVGTrackList alloc] initWithArray:tracksArray];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(tracks, error);
                         });
    }] resume];
}

- (void)downloadImageFrom:(NSURL *)url withCompletionHandler:(void(^)(UIImage *, NSError *))completion {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[downloadSession downloadTaskWithURL:url
                       completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                           UIImage *downloadedImage = [UIImage imageWithData:
                                                       [NSData dataWithContentsOfURL:location]];
                           if(downloadedImage) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   completion(downloadedImage, error);
                               });
                           }
    }] resume];
}

@end
