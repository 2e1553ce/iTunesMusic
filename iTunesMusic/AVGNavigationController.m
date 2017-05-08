//
//  AVGNavigationController.m
//  iTunesMusic
//
//  Created by aiuar on 08.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AVGNavigationController.h"

@interface AVGNavigationController ()

@end

@implementation AVGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVGMus *tableViewController = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.viewControllers = @[tableViewController] ;
}
@end
