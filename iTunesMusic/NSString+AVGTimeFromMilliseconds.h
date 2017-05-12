//
//  NSString+AVGTimeFromMilliseconds.h
//  iTunesMusic
//
//  Created by aiuar on 12.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AVGTimeFromMilliseconds)

+ (NSString *)getTimeFromMilliseconds:(NSInteger)interval;

@end
