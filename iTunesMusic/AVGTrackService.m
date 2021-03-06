//
//  AVGTrackService.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

@import UIKit;

#import "AVGTrackService.h"
#import "AVGCacheService.h"
#import "AVGTrack.h"
#import "NSString+AVGTimeFromMilliseconds.h"

static const NSInteger tracksLimit = 50;

@interface AVGTrackService ()

@property (nonatomic, strong) NSURLSession *iTunesSession;
@property (nonatomic, strong) NSURLSessionDataTask *iTunesSessionDataTask;
@property (nonatomic, strong) AVGCacheService *cacheService;

@end

@implementation AVGTrackService

#pragma mark - initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.iTunesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
        self.cacheService = [AVGCacheService new];
    }
    
    return self;
}

#pragma mark - AVGServerManager protocol

- (void)getTracksByArtist:(NSString *)name
               withCompletionHandler:(void(^)(NSArray *trackList, NSError *error))completion {
    if (self.iTunesSessionDataTask) {
        [self.iTunesSessionDataTask cancel];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=%ld&entity=song", name, (long)tracksLimit];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:
                                       [NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Formatter for track price
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    self.iTunesSessionDataTask = [self.iTunesSession dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         
                         if (data) {
                             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                             dict = dict[@"results"];
                             
                             NSMutableArray *tracks = [NSMutableArray arrayWithCapacity:[dict count]];
                             for (id object in dict) {
                                 // Track price
                                 NSString *priceStr = [formatter stringFromNumber:object[@"trackPrice"]];
                                 
                                 AVGTrack *track = [[AVGTrack alloc] initWithArtistName:object[@"artistName"]
                                                                              trackName:object[@"trackName"]
                                                                           thumbURLPath:object[@"artworkUrl100"]
                                                                                  price:[NSDecimalNumber decimalNumberWithString:priceStr]
                                                                                   time:[NSString getTimeFromMilliseconds:[object[@"trackTimeMillis"] integerValue]]];
                                 
                                 [tracks addObject:track];
                             }
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 completion(tracks, error);
                             });
                         } else {
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 completion(nil, error);
                             });
                         }
    }];
    [self.iTunesSessionDataTask resume];
}

- (void)downloadImageFrom:(NSURL *)url withCompletionHandler:(void(^)(UIImage *image, NSError *error))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    UIImage *cachedImage = [self.cacheService objectForKey:url];
    if (cachedImage) {
        completion(cachedImage, nil);
    } else {
        [[self.iTunesSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            UIImage *downloadedImage = [UIImage imageWithData:
                                        [NSData dataWithContentsOfURL:location]];
            // Caching image
            [self.cacheService setObject:downloadedImage forKey:url];
            
            if (downloadedImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(downloadedImage, error);
                });
            }
        }] resume];
    }
}

@end
