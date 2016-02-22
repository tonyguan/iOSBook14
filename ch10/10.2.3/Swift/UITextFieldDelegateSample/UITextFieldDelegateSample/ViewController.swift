//
//  ViewController.swift
//  UITextFieldDelegateSample
//
//  Created by 关东升 on 15/12/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: --实现UITextFieldDelegate 委托协议方法
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSLog("call textFieldShouldBeginEditing:")
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        NSLog("call textFieldDidBeginEditing:")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSLog("call textFieldShouldEndEditing:")
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        NSLog("call textFieldDidEndEditing:")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("call textFieldShouldReturn:")
        textField.resignFirstResponder()
        return true
    }
}