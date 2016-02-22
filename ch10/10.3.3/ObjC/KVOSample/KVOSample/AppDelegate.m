//
//  AppDelegate.m
//  KVOSample
//
//  Created by 关东升 on 15/12/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.observer = [AppStatusObserver new];
    
    [self addObserver:self.observer forKeyPath:@"appStatus"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"Pass Context"];
    
    self.appStatus = @"launch";
    
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    self.appStatus = @"inactive";
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.appStatus = @"background";
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    self.appStatus = @"inactive";
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    self.appStatus = @"active";
}

- (void)applicationWillTerminate:(UIApplication *)application {
    self.appStatus = @"terminate";
}

@end
