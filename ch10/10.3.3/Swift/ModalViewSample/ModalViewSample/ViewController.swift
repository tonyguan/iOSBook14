//
//  ViewController.swift
//  ModalViewSample
//
//  Created by 关东升 on 15/12/22.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "registerCompletion:",
            name: "RegisterCompletionNotification",
            object: nil)
        
        //监听系统通知UIApplicationDidEnterBackgroundNotification
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleEnterBackground:",
            name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        //监听系统通知UIApplicationWillEnterForegroundNotification
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleEnterForeground:",
            name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func registerCompletion(notification: NSNotification) {
        
        let theData = notification.userInfo!
        let username = theData["username"] as! String
        
        NSLog("username = %@", username)
    }
    
    func handleEnterBackground(notification : NSNotification) {
        NSLog("进入到后台")
    }
    
    func handleEnterForeground(notification : NSNotification) {
        NSLog("回到前台")
    }
}

