//
//  AppDelegate.m
//  NavigationComb
//
//  Created by 关东升 on 15/12/26.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    //设置黑龙江标签
    ViewController* viewController1 = [[ViewController alloc] init];
    UINavigationController* navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    navigationController1.tabBarItem.title = @"黑龙江";
    navigationController1.tabBarItem.image = [UIImage imageNamed:@"Hei"];
    
    //设置吉林标签
    ViewController* viewController2 = [[ViewController alloc] init];
    UINavigationController* navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    navigationController2.tabBarItem.title = @"吉林";
    navigationController2.tabBarItem.image = [UIImage imageNamed:@"Ji"];
    
    //设置辽宁标签
    ViewController* viewController3 = [[ViewController alloc] init];
    UINavigationController* navigationController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    navigationController3.tabBarItem.title = @"吉林";
    navigationController3.tabBarItem.image = [UIImage imageNamed:@"Ji"];
    
    tabBarController.viewControllers = @[navigationController1, navigationController2, navigationController3];
    
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
