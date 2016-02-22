//
//  ViewController.swift
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

import UIKit
import CoreLocation

class ViewController: UIViewController {

    //经度
    @IBOutlet weak var txtLng: UITextField!
    //纬度
    @IBOutlet weak var txtLat: UITextField!
    //高度
    @IBOutlet weak var txtAlt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLocation:", name: UpdateLocationNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    //接收位置变化通知
    func updateLocation(notification: NSNotification) {

        let currLocation = notification.object as! CLLocation
        self.txtLat.text = String(format: "%3.5f", currLocation.coordinate.latitude)
        self.txtLng.text = String(format: "%3.5f", currLocation.coordinate.longitude)
        self.txtAlt.text = String(format: "%3.5f", currLocation.altitude)

    }
}