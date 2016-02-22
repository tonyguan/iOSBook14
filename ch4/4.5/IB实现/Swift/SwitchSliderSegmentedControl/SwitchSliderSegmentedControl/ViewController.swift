//
//  ViewController.swift
//  SwitchSliderSegmentedControl
//
//  Created by 关东升 on 15/12/12.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftSwitch: UISwitch!
    
    @IBOutlet weak var rightSwitch: UISwitch!
    
    @IBOutlet weak var sliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //使两个开关的值保持一致
    @IBAction func switchValueChanged(sender: AnyObject) {
        let witchSwitch = sender as! UISwitch
        let setting = witchSwitch.on
        self.leftSwitch.setOn(setting, animated: true)
        self.rightSwitch.setOn(setting, animated: true)
    }

    //点击分段控件控制开关控件的隐藏或显示
    @IBAction func touchDown(sender: AnyObject) {
        
        let segmentedControl = sender as! UISegmentedControl
        NSLog("选择的段 : %li", segmentedControl.selectedSegmentIndex)
                
        if (self.leftSwitch.hidden == true) {
            self.rightSwitch.hidden = false
            self.leftSwitch.hidden  = false
        }else {
            self.rightSwitch.hidden = true
            self.leftSwitch.hidden  = true
        }
    }
    
    //用标签显示滑块的值
    @IBAction func sliderValueChange(sender: AnyObject) {
        let slider = sender as! UISlider
        let progressAsInt = Int(slider.value)
        let newText = String(format: "%d", progressAsInt)
        NSLog("滑块的值 : %@", newText)
        self.sliderValue.text = newText
    }
    

}

