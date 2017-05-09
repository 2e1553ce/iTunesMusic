//
//  AVGNavigationController.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGNavigationController.h"
#import "AVGTrackTVC.h"

@interface AVGNavigationController ()

@end

@implementation AVGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVGTrackTVC *tableViewController = [[AVGTrackTVC alloc] initWithStyle:UITableViewStylePlain];
    self.viewControllers = @[tableViewController] ;
}
@end
