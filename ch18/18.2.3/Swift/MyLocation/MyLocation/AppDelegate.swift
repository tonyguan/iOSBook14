//
//  AppDelegate.swift
//  MyLocation
//
//  Created by 关东升 on 16/1/14.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

let UpdateLocationNotification = "kUpdateLocationNotification"

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    var locationManager: CLLocationManager!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {

        //定位服务管理对象初始化
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1000.0

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        //开始定位
        self.locationManager.startUpdatingLocation()
        print("定位开始")
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        //停止定位
        self.locationManager.stopUpdatingLocation()
        print("定位停止")
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }


    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: --Core Location委托方法用于实现位置的更新
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let currLocation = locations.last! as CLLocation

        NSNotificationCenter.defaultCenter().postNotificationName(UpdateLocationNotification, object: currLocation)

    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: \(error.localizedDescription)")
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        switch status {
        case .AuthorizedAlways:
            print("已经授权")
        case .AuthorizedWhenInUse:
            NSLog("当使用时候授权")
        case .Denied:
            print("拒绝")
        case .Restricted:
            print("受限")
        case .NotDetermined:
            print("用户还没有确定")
        }

    }

}

