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
import MapKit

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
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.txtQueryKey.text
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response, error) -> Void in
            
            if response?.mapItems.count > 0 {
                //取出最后一个地标点
                let lastMapItem = response?.mapItems.last
                lastMapItem!.openInMapsWithLaunchOptions(nil)
                //地图上设置行车路线
//                let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
//                lastMapItem!.openInMapsWithLaunchOptions(options)
                //多个点标注线
//                MKMapItem.openMapsWithItems(response!.mapItems, launchOptions: nil)
            }
        }
        //关闭键盘
        self.txtQueryKey.resignFirstResponder()
    }
}

