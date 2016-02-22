//
//  ViewController.swift
//  AppSetting
//
//  Created by 关东升 on 16/1/3.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UITableViewController {
    
    //用户名
    @IBOutlet weak var username: UILabel!
    //密码
    @IBOutlet weak var password: UILabel!
    //每月是否清除缓存
    @IBOutlet weak var clearCache: UILabel!
    //每月流量限制
    @IBOutlet weak var flowmeter: UILabel!
    //服务器
    @IBOutlet weak var serverName: UILabel!
    //通知-声音
    @IBOutlet weak var notiSound: UILabel!
    //通知-震动
    @IBOutlet weak var notiVibrate: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getData() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        self.username.text = defaults.stringForKey("name_preference")
        self.password.text = defaults.stringForKey("password_preference")
        
        
        if defaults.boolForKey("enabled_preference") {
            self.clearCache.text = "YES"
        } else  {
            self.clearCache.text = "NO"
        }
        
        let sliderStr = String(format:"%.2fGB", defaults.doubleForKey("slider_preference"))
        self.flowmeter.text = sliderStr
        
        self.serverName.text = defaults.stringForKey("multivaule_preference")
        
        if defaults.boolForKey("sound_enabled_preference") {
            self.notiSound.text = "YES"
        } else {
            self.notiSound.text = "NO"
        }
        
        if defaults.boolForKey("vibrate_enabled_preference") {
            self.notiVibrate.text = "YES"
        } else {
            self.notiVibrate.text = "NO"
        }
    }
}
