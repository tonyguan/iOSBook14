//
//  ViewController.swift
//  MapSample
//
//  Created by 关东升 on 16/1/16.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.mapType = .Standard
    
        let location = CLLocation(latitude: 40.002240, longitude: 116.323328)
        //调整地图位置和缩放比例
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000)
        self.mapView.region = viewRegion
        
        //授权
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        self.mapView.showsUserLocation = true
        self.mapView.userLocation.title = "我在这里！"
        self.mapView.delegate = self
    }

    @IBAction func selectMapViewType(sender: AnyObject) {
        
        let sc = sender as! UISegmentedControl
        
        switch (sc.selectedSegmentIndex) {
        case 1:
            self.mapView.mapType = .Satellite
        case 2:
            self.mapView.mapType = .Hybrid
        default:
            self.mapView.mapType = .Standard
        }        
    }
    
    //MARK: --实现MKMapViewDelegate协议
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        mapView.userTrackingMode = .FollowWithHeading
    }
}

