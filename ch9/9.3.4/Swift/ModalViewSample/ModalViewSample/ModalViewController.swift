//
//  ModalViewController.swift
//  ModalViewSample
//
//  Created by 关东升 on 16/2/6.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save:")
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel:")
        
        self.navigationItem.rightBarButtonItem = saveButtonItem
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        
        /// UITextView
        let textView = UITextView(frame: self.view.frame)
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        self.view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    

    func save(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
             NSLog("点击Save按钮，关闭模态视图")
        }
    }

    func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("点击Cancel按钮，关闭模态视图")
        }
    }
}
