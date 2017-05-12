//
//  AppDelegate.m
//  iTunesMusic
//
//  Created by aiuar on 07.05.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import "AppDelegate.h"
#import "AVGTrackTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:82.0/255.0
                                                                  green:176.0/255.0
                                                                   blue:243.0/255.0
                                                                  alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UINavigationController *navigationController = [UINavigationController new];
    
    AVGTrackTableViewController *tableViewController = [[AVGTrackTableViewController alloc] initWithStyle:UITableViewStylePlain];
    navigationController.viewControllers = @[tableViewController] ;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    window.rootViewController = navigationController;
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
