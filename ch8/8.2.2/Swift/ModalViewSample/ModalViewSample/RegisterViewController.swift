//
//  RegisterViewController.swift
//  ModalViewSample
//
//  Created by 关东升 on 15/12/22.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class RegisterViewController: UIViewController {
    
    var txtUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "注册"
        
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save:")
        
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel:")
        
        self.navigationItem.rightBarButtonItem = saveButtonItem
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        
        /// 1.添加用户ID：标签
        let labelId = UILabel(frame: CGRectMake(35, 187, 85, 21))
        labelId.text = "用户ID："
        self.view.addSubview(labelId)
        
        /// 2.添加Username TextField
        self.txtUsername = UITextField(frame: CGRectMake(145, 178, 131, 30))
        self.txtUsername.borderStyle = .RoundedRect
        self.view.addSubview(self.txtUsername)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func save(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("点击Save按钮，关闭模态视图")
            
            let dataDict = ["username" : self.txtUsername.text!]
            
            NSNotificationCenter.defaultCenter().postNotificationName("RegisterCompletionNotification", object: nil, userInfo: dataDict)
            
        }
    }
    
    func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            NSLog("点击Cancel按钮，关闭模态视图")
        })
    }

}
