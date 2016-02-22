//
//  ViewController.swift
//  GeocodeQuery
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

class ViewController: UIViewController {
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var txtQueryKey: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func geocodeQuery(sender: AnyObject) {
        
        if self.txtQueryKey.text == nil {
            return
        }

        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(self.txtQueryKey.text!, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                print("\(error?.localizedDescription)")
            } else if placemarks!.count > 0 {
                
                let placemark = placemarks![0] as CLPlacemark
                
                let name = placemark.name!
                
                let location = placemark.location!
                
                let lng = location.coordinate.longitude
                let lat = location.coordinate.latitude
                
                self.txtView.text = String(format: "经度：%3.5f \n纬度：%3.5f \n%@", lng, lat, name)
                
            }
        })
//        let location = CLLocation(latitude: 40.002240, longitude: 116.323328)
//        let region = CLCircularRegion(center:location.coordinate, radius: 5000, identifier:"GeocodeRegion")
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(self.txtQueryKey.text!, inRegion:region, completionHandler: { (placemarks, error) -> Void in
//          //TODO
//        })

        //关闭键盘
        self.txtQueryKey.resignFirstResponder()
        
    }
}

