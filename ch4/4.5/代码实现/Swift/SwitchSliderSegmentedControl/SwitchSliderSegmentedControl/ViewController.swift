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
    
    var leftSwitch: UISwitch!
    
    var rightSwitch: UISwitch!
    
    var sliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
        
        /// 1.添加rightSwitch控件
        //rightSwitch与屏幕左边距
        //leftSwitch与屏幕右边距
        let switchScreenSpace:CGFloat = 39
        
        self.rightSwitch = UISwitch()
        var frame = self.rightSwitch.frame
        frame.origin = CGPointMake(switchScreenSpace, 98)
        //重新设置控件的位置
        self.rightSwitch.frame = frame
        //设置控件状态
        self.rightSwitch.on = true
        //指定事件处理方法
        self.rightSwitch.addTarget(self, action: Selector("switchValueChanged:"), forControlEvents: .ValueChanged)
        
        self.view.addSubview(self.rightSwitch)
        
        /// 2.添加rightSwitch控件
        self.leftSwitch = UISwitch()
        frame = self.leftSwitch.frame
        frame.origin = CGPointMake(screen.size.width - (frame.size.width + switchScreenSpace), 98)
        //重新设置控件的位置
        self.leftSwitch.frame = frame
        //设置控件状态
        self.leftSwitch.on = true
        //指定事件处理方法
        self.leftSwitch.addTarget(self, action: Selector("switchValueChanged:"), forControlEvents: .ValueChanged)
        
        self.view.addSubview(self.leftSwitch)
        
        /// 3.添加segmentedControl控件
        let segments = ["Right", "Left"]
        let segmentedControl = UISegmentedControl(items: segments)
        
        let scWidth:CGFloat = 220
        let scHeight:CGFloat = 29 //29默认高度
        let scTopView:CGFloat = 186
        frame = CGRectMake((screen.size.width - scWidth)/2 , scTopView, scWidth, scHeight)
        //重新设置控件的位置
        segmentedControl.frame = frame
        //指定事件处理方法
        segmentedControl.addTarget(self, action: Selector("touchDown:"), forControlEvents: .ValueChanged)
        
        self.view.addSubview(segmentedControl)
        
        /// 4.添加slider控件
        let sliderWidth:CGFloat  = 300
        let sliderHeight:CGFloat  = 31 //31默认高度
        let sliderdTopView:CGFloat  = 298
        let slider = UISlider(frame: CGRectMake((screen.size.width - sliderWidth)/2 , sliderdTopView, sliderWidth, sliderHeight))
        
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.value = 50.00
        
        //指定事件处理方法
        slider.addTarget(self, action: Selector("sliderValueChange:"), forControlEvents: .ValueChanged)
        
        self.view.addSubview(slider)
        
        /// 5.添加SliderValue：标签
        //SliderValue：标签与Slider之间的距离
        let labelSliderValueSliderSpace:CGFloat = 30
        let labelSliderValue = UILabel(frame: CGRectMake(slider.frame.origin.x, slider.frame.origin.y - labelSliderValueSliderSpace, 103, 21))
        
        labelSliderValue.text = "SliderValue："
        self.view.addSubview(labelSliderValue)
        
        /// 6.添加sliderValue标签
        self.sliderValue = UILabel(frame: CGRectMake(labelSliderValue.frame.origin.x + 120, labelSliderValue.frame.origin.y, 50, 21))
        self.sliderValue.text = "50"
        self.view.addSubview(self.sliderValue)
        
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

