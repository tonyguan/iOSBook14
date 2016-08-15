//
//  ViewController.swift
//  APPClient
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
import CoreBluetooth
import CoreLocation

let kUUID = "533F8EF4-EED2-4FEC-8566-84C242B0C636"
let kID = "com.51work6.AirLocate"

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblRanging: UILabel!
    
    var locationManager : CLLocationManager!
    var region : CLBeaconRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        let uuid = NSUUID(UUIDString: kUUID)
        self.region = CLBeaconRegion(proximityUUID: uuid!, identifier: kID)
        
        self.lblRegion.text = ""
        self.lblRanging.text = ""
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //开启区域（或围栏）监视
        self.locationManager.startMonitoringForRegion(self.region)
        //开启Beacon距离检测
        self.locationManager.startRangingBeaconsInRegion(self.region)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //停止区域（或围栏）监视
        self.locationManager.stopMonitoringForRegion(self.region)
        //停止Beacon距离检测
        self.locationManager.stopRangingBeaconsInRegion(self.region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: --实现CLLocationManagerDelegate委托协议
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        
        switch state {
        case .Inside:
            self.lblRegion.text = "围栏内"
        case .Outside:
            self.lblRegion.text = "围栏外"
        case .Unknown:
            self.lblRegion.text = "未知"
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.lblRegion.text = "进入围栏外"
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.lblRegion.text = "退出围栏"
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        let aryBeacons = beacons as NSArray
        
        var predicate = NSPredicate(format: "proximity = %d", CLProximity.Unknown.rawValue)
        let unknownBeacons = aryBeacons.filteredArrayUsingPredicate(predicate)
        if unknownBeacons.count > 0 {
            self.lblRanging.text = "未检测到"
        }
        
        predicate = NSPredicate(format: "proximity = %d", CLProximity.Immediate.rawValue)
        let immediateBeacons = aryBeacons.filteredArrayUsingPredicate(predicate)
        if immediateBeacons.count > 0 {
            self.lblRanging.text = "最接近"
        }
        
        predicate = NSPredicate(format: "proximity = %d", CLProximity.Near.rawValue)
        let nearBeacons = aryBeacons.filteredArrayUsingPredicate(predicate)
        if nearBeacons.count > 0 {
            self.lblRanging.text = "近距离"
        }
        
        predicate = NSPredicate(format: "proximity = %d", CLProximity.Far.rawValue)
        let farBeacons = aryBeacons.filteredArrayUsingPredicate(predicate)
        if farBeacons.count > 0 {
            self.lblRanging.text = "远距离"
        }
        
    }
}
