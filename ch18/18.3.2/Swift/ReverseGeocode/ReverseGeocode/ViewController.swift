//
//  ViewController.swift
//  ReverseGeocode
//
//  Created by 关东升 on 16/1/15.
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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //经度
    @IBOutlet weak var txtLng: UITextField!
    //纬度
    @IBOutlet weak var txtLat: UITextField!
    //高度
    @IBOutlet weak var txtAlt: UITextField!
    
    @IBOutlet weak var txtView: UITextView!
    
    var locationManager: CLLocationManager!
    
    var currLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtView.text = ""
        
        //定位服务管理对象初始化
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1000.0
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //开始定位
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //停止定位
        self.locationManager.stopUpdatingLocation()
    }
    
    @IBAction func reverseGeocode(sender: AnyObject) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(self.currLocation, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else if placemarks != nil &&  placemarks!.count  > 0 {
                
                let placemark = placemarks![0] 
                let name = placemark.name
                self.txtView.text = name
            }
        })
       
    }
    
    //MARK: --Core Location委托方法用于实现位置的更新
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currLocation = locations.last! as CLLocation
        
        self.txtLat.text = String(format:"%3.5f", self.currLocation.coordinate.latitude)
        self.txtLng.text = String(format:"%3.5f", self.currLocation.coordinate.longitude)
        self.txtAlt.text = String(format:"%3.5f", self.currLocation.altitude)
        
        print("位置更新")
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: \(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways :
            print("已经授权")
        case .AuthorizedWhenInUse :
            NSLog("当使用时候授权")
        case .Denied :
            print("拒绝")
        case .Restricted :
            print("受限")
        case .NotDetermined:
            print("用户还没有确定")
        }
    }
}

