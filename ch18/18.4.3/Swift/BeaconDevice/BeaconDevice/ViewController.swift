//
//  ViewController.swift
//  BeaconDevice
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
let kPower = -59

class ViewController: UIViewController, CBPeripheralManagerDelegate {

    var peripheralManager: CBPeripheralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: --实现CBPeripheralManagerDelegate协议
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        print("外设状态变化")
    }

    @IBAction func valueChanged(sender: AnyObject) {

        let swc = sender as! UISwitch
        if swc.on {
            let uuid = NSUUID(UUIDString: kUUID)
            let region = CLBeaconRegion(proximityUUID: uuid!, identifier: kID)
            let peripheralData = region.peripheralDataWithMeasuredPower(kPower)
            //NSMutableDictionary转换为NSDictionary
            let dict = NSDictionary(dictionary: peripheralData)

            //NSDictionary转换为[String : AnyObject]?
            self.peripheralManager.startAdvertising(dict as? [String:AnyObject])

        } else {
            self.peripheralManager.stopAdvertising()
        }
    }
}
