//
//  ViewController.swift
//  TextFieldTextView
//
//  Created by 关东升 on 15/12/11.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - 实现UITextFieldDelegate委托协议方法
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("TextField获得焦点，点击return键")
        return true
    }
    
    // MARK: - 实现UITextViewDelegate委托协议方法
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            NSLog("TextView获得焦点，点击return键")
            return false
        }
        return true
    }
}