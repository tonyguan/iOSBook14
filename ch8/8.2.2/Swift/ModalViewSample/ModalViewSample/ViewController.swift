//
//  ViewController.swift
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
        
        self.navigationItem.title = "登录"
        
        /// 1.添加用户ID：标签
        let labelId = UILabel(frame: CGRectMake(59,115, 68, 21))
        labelId.text = "用户ID："
        self.view.addSubview(labelId)
        
        /// 2.添加用户ID TextField
        let textFieldId = UITextField(frame: CGRectMake(141, 106, 100, 30))
        textFieldId.borderStyle = .RoundedRect
        self.view.addSubview(textFieldId)
        
        /// 3.添加密码：标签
        let labelPwd = UILabel(frame: CGRectMake(76, 178, 51, 21))
        labelPwd.text = "密码："
        self.view.addSubview(labelPwd)
        
        /// 4.添加密码 TextField
        let textFieldPwd = UITextField(frame: CGRectMake(141, 169, 100, 30))
        textFieldPwd.borderStyle = .RoundedRect
        self.view.addSubview(textFieldPwd)
        
        /// 5.添加 登录按钮
        let buttonLogin = UIButton(type: .System)
        buttonLogin.frame = CGRectMake((screen.size.width - 30)/2, 231, 30, 30)
        buttonLogin.setTitle("登录", forState: .Normal)
        self.view.addSubview(buttonLogin)
        
        /// 6.添加 注册按钮
        let buttonReg = UIButton(type: .System)
        buttonReg.frame = CGRectMake((screen.size.width - 30)/2, 294, 30, 30)
        buttonReg.setTitle("注册", forState: .Normal)
        buttonReg.addTarget(self, action: "onClick:", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonReg)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "registerCompletion:", name: "RegisterCompletionNotification", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func onClick(sender: AnyObject) {
        
        let registerViewController = RegisterViewController()
        let navigationController = UINavigationController(rootViewController: registerViewController)
        
        self .presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func registerCompletion(notification: NSNotification) {
        
        let theData = notification.userInfo!
        let username = theData["username"] as! String
        
        NSLog("username = %@", username)
    }

}

