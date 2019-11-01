//
//  AppDelegate.m
//  KJSupportObjc
//
//  Created by uback on 2018/5/3.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "AppDelegate.h"
#import "KJSupportObjcListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置UIWindow的背景颜色
    self.window.backgroundColor = [UIColor redColor];
    
    // 让UIWindow显示出来(让窗口成为主窗口 并且显示出来)
    // 一个应用程序只能有一个主窗口
    [self.window makeKeyAndVisible];
    UINavigationController *rootvc = [[UINavigationController alloc] initWithRootViewController:[[KJSupportObjcListVC alloc] init]];
    
    self.window.rootViewController = rootvc;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
