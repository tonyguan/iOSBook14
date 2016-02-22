//
//  AppDelegate.swift
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

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    dynamic var appStatus: NSString!
    var observer: AppStatusObserver!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.observer = AppStatusObserver()
        self.addObserver(self.observer, forKeyPath: "appStatus",
            options: [NSKeyValueObservingOptions.New ,NSKeyValueObservingOptions.Old], context: nil)
        self.appStatus = "launch"
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        self.appStatus = "inactive"
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        self.appStatus = "background"
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        self.appStatus = "inactive"
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        self.appStatus = "active"
    }
    
    func applicationWillTerminate(application: UIApplication) {
        self.appStatus = "terminate"
    }
}


