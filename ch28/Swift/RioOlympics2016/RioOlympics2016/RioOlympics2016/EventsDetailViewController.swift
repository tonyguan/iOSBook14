//
//  EventsDetailViewController.swift
//  RioOlympics2016
//
//  Created by 关东升 on 16/1/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import BusinessLogicLayer
import PersistenceLayer

class EventsDetailViewController: UIViewController {

    var event: Events!
    
    @IBOutlet weak var imgEventIcon: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var txtViewKeyInfo: UITextView!
    @IBOutlet weak var txtViewBasicsInfo: UITextView!
    @IBOutlet weak var txtViewOlympicInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgEventIcon.image = UIImage(named:self.event.EventIcon as! String)        
        self.lblEventName.text = self.event.EventName as? String
        self.txtViewBasicsInfo.text = self.event.BasicsInfo as! String
        self.txtViewKeyInfo.text = self.event.KeyInfo as! String
        self.txtViewOlympicInfo.text = self.event.OlympicInfo as! String

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

