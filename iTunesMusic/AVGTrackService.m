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

static const NSInteger tracksLimit = 50;

@interface AVGTrackService ()

@end

@implementation AVGTrackService

#pragma mark - initialization

- (instancetype)init {
    self = [super init];
    
    if(self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.iTunesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
        
        [self setSharedCacheForImages];
    }
    
    return self;
}

#pragma mark - AVGServerManager protocol methods

- (void)getTracksByArtist:(NSString *)name
               withCompletionHandler:(void(^)(AVGTrackList *, NSError *))completion {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=%ld&entity=song", name, (long)tracksLimit];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL: url];
    [request setHTTPMethod: @"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[self.iTunesSession dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
                         dict = dict[@"results"];
                         
                         NSMutableArray *tracksArray = [NSMutableArray new];
                         
                         for(id object in dict) {
                             // Track price
                             NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                             [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                             [formatter setMaximumFractionDigits:2];
                             NSString *priceStr = [formatter stringFromNumber:object[@"trackPrice"]];
                             
                             AVGTrack *track = [[AVGTrack alloc] initWithArtistName:object[@"artistName"]
                                                                          trackName:object[@"trackName"]
                                                                       thumbURLPath:object[@"artworkUrl100"]
                                                                              price:[NSDecimalNumber decimalNumberWithString:priceStr]
                                                                               time:[NSString getTimeFromMilliseconds:[object[@"trackTimeMillis"] integerValue]]];
                             
                             [tracksArray addObject: track];
                         }
                         
                         AVGTrackList *tracks = [[AVGTrackList alloc] initWithArray:tracksArray];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(tracks, error);
                         });
    }] resume];
}

- (void)downloadImageFrom:(NSURL *)url withCompletionHandler:(void(^)(UIImage *, NSError *))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
#warning NOT WORKING! - ASK!
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    
    if (cachedResponse.data) {
        UIImage *downloadedImage = [UIImage imageWithData:cachedResponse.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(downloadedImage, nil);
        });
    } else {
        [[self.iTunesSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *downloadedImage = [UIImage imageWithData:
                                        [NSData dataWithContentsOfURL:location]];
            if(downloadedImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(downloadedImage, error);
                });
            }
        }] resume];
    }
}

#pragma mark - Cache size

- (void)setSharedCacheForImages
{
    NSUInteger cashSize = 250 * 1024 * 1024;
    NSUInteger cashDiskSize = 250 * 1024 * 1024;
    NSURLCache *imageCache = [[NSURLCache alloc] initWithMemoryCapacity:cashSize diskCapacity:cashDiskSize diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:imageCache];
    //sleep(1);
}

@end
