//
//  AppDelegate.swift
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

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSLog("%@", "application:didFinishLaunchingWithOptions:")
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        NSLog("%@", "applicationWillResignActive:")
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        NSLog("%@", "applicationDidEnterBackground:")
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        NSLog("%@", "applicationWillEnterForeground:")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        NSLog("%@", "applicationDidBecomeActive:")
    }
    
    func applicationWillTerminate(application: UIApplication) {
        NSLog("%@", "applicationWillTerminate:")
    }
}

