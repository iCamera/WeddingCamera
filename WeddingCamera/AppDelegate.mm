//
//  AppDelegate.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/03.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageFilterBase.h"
#import "BrightnessFilter.h"
#import "GrayScaleFilter.h"
#import "SepiaFilter.h"
#import "MosaicFilter.h"
#import "FishEyeFilter.h"
#import "GaussianFilter.h"
#import "EdgeFindFilter.h"
#import "FaceFindFilter.h"
#import "MultiMonitorFilter.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSArray *)filters {
    if (filters == nil) {
        NSMutableArray *newFilters = [[NSMutableArray alloc]init];
        // ここにフィルタを追加
        [newFilters addObject:[[ImageFilterBase alloc]init]]; // (1)
        [newFilters addObject:[[BrightnessFilter alloc]init]];
        [newFilters addObject:[[GrayScaleFilter alloc]init]];
        [newFilters addObject:[[SepiaFilter alloc]init]];
        [newFilters addObject:[[MosaicFilter alloc]init]];
        [newFilters addObject:[[FishEyeFilter alloc]init]];
        [newFilters addObject:[[GaussianFilter alloc]init]];
        [newFilters addObject:[[EdgeFindFilter alloc]init]];
        [newFilters addObject:[[FaceFindFilter alloc]init]];
        [newFilters addObject:[[MultiMonitorFilter alloc]init]];
    
        filters = newFilters;
    }
    return filters;
}


@end
