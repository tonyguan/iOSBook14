//
//  AppDelegate.m
//  HelloWorld
//
//  Created by 关东升 on 2015-3-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//  
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", @"application:didFinishLaunchingWithOptions:");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@", @"applicationWillResignActive:");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@", @"applicationDidEnterBackground:");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@", @"applicationWillEnterForeground:");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@", @"applicationDidBecomeActive:");}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@", @"applicationWillTerminate:");
}

@end
