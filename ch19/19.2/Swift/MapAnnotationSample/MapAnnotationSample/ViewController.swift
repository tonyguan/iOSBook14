//
//  ViewController.swift
//  MapAnnotationSample
//
//  Created by 关东升 on 16/1/17.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
//import CoreLocation
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var txtQueryKey: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.mapType = .Standard
        self.mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func geocodeQuery(sender: AnyObject) {
        
        if (self.txtQueryKey.text == nil) {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.txtQueryKey.text!, completionHandler: { (placemarks, error) -> Void in
            
            NSLog("查询记录数：%i", placemarks!.count)
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            for placemark in placemarks! {
                
                let annotation = MyAnnotation(coordinate: placemark.location!.coordinate)
                annotation.city = placemark.locality
                annotation.state = placemark.administrativeArea
                annotation.streetAddress = placemark.thoroughfare
                annotation.zip = placemark.postalCode
                
                self.mapView.addAnnotation(annotation)
                
            }
            
            if placemarks!.count  > 0 {
                //取出最后一个地标点
                let lastPlacemark = placemarks!.last
                //调整地图位置和缩放比例
                let viewRegion = MKCoordinateRegionMakeWithDistance(lastPlacemark!.location!.coordinate, 10000, 10000)
                self.mapView.setRegion(viewRegion, animated: true)
            }
            
            //关闭键盘
            self.txtQueryKey.resignFirstResponder()
        })
    }
    
    //MARK: --实现MKMapViewDelegate协议
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier("PIN_ANNOTATION") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_ANNOTATION")
        }
        annotationView!.pinTintColor = UIColor.redColor()
        annotationView!.animatesDrop = true
        annotationView!.canShowCallout = true
        
        return annotationView!
    }
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        print("error : \(error.localizedDescription)")
    }
    
}

