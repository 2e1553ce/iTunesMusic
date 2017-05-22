//
//  NSString+AVGTimeFromMilliseconds.m
//  iTunesMusic
//
//  Created by aiuar on 12.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "NSString+AVGTimeFromMilliseconds.h"

@implementation NSString (AVGTimeFromMilliseconds)

+ (NSString *)getTimeFromMilliseconds:(NSInteger)interval {
    
    unsigned long milliseconds = interval;
    unsigned long seconds = milliseconds / 1000;
    milliseconds %= 1000;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    
    NSMutableString *result = [NSMutableString new];
    if (hours) {
        [result appendFormat:@"%lu:", hours];
    }
    
    [result appendFormat:@"%2lu:", minutes];
    if (seconds < 10) {
        [result appendFormat:@"0%1lu", seconds];
    } else {
        [result appendFormat:@"%2lu", seconds];
    }
    
    //[result appendFormat: @"%2lu", milliseconds];
    
    return result;
}

@end
