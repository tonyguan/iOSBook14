//
//  ViewController.swift
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

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///创建Full Screen按钮
        let buttonFullScreen = UIButton(type: .System)
        buttonFullScreen.setTitle("Full Screen", forState: .Normal)
        buttonFullScreen.titleLabel?.font = UIFont.systemFontOfSize(20)
        buttonFullScreen.addTarget(self, action: "onclick:", forControlEvents:.TouchUpInside)
        //设置tag区别其他的按钮
        buttonFullScreen.tag = 100
        self.view.addSubview(buttonFullScreen)
        
        ///创建Form Sheet按钮
        let buttonFormSheet = UIButton(type: .System)
        buttonFormSheet.setTitle("Form Sheet", forState: .Normal)
        buttonFormSheet.titleLabel?.font = UIFont.systemFontOfSize(20)
        buttonFormSheet.addTarget(self, action: "onclick:", forControlEvents:.TouchUpInside)
        //设置tag区别其他的按钮
        buttonFormSheet.tag = 200
        self.view.addSubview(buttonFormSheet)
        
        ///创建Page Sheet按钮
        let buttonPageSheet = UIButton(type: .System)
        buttonPageSheet.setTitle("Page Sheet", forState: .Normal)
        buttonPageSheet.titleLabel?.font = UIFont.systemFontOfSize(20)
        buttonPageSheet.addTarget(self, action: "onclick:", forControlEvents:.TouchUpInside)
        //设置tag区别其他的按钮
        buttonPageSheet.tag = 300
        self.view.addSubview(buttonPageSheet)
        
        ///创建Current Context按钮
        let buttonCurrentContext = UIButton(type: .System)
        buttonCurrentContext.setTitle("Current Context", forState: .Normal)
        buttonCurrentContext.titleLabel?.font = UIFont.systemFontOfSize(20)
        buttonCurrentContext.addTarget(self, action: "onclick:", forControlEvents:.TouchUpInside)
        //设置tag区别其他的按钮
        buttonCurrentContext.tag = 400
        self.view.addSubview(buttonCurrentContext)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLog("重新布局")
        
        let screen = UIScreen.mainScreen().bounds
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 20
        let buttonTopView: CGFloat = 115
        let buttonX: CGFloat = (screen.size.width - buttonWidth)/2
        
        ///创建Full Screen按钮
        let buttonFullScreen = self.view.viewWithTag(100)
        buttonFullScreen!.frame = CGRectMake(buttonX, buttonTopView, buttonWidth, buttonHeight)
        
        ///创建Form Sheet按按钮
        let buttonFormSheet = self.view.viewWithTag(200)
        buttonFormSheet!.frame = CGRectMake(buttonX, buttonFullScreen!.frame.origin.y + 100, buttonWidth, buttonHeight)
        
        ///创建Page Sheet按钮
        let buttonPageSheet = self.view.viewWithTag(300)
        buttonPageSheet!.frame = CGRectMake(buttonX, buttonFormSheet!.frame.origin.y + 100, buttonWidth, buttonHeight)
        
        ///创建Current Context按钮
        let buttonCurrentContext = self.view.viewWithTag(400)
        buttonCurrentContext!.frame = CGRectMake(buttonX, buttonPageSheet!.frame.origin.y + 100, buttonWidth, buttonHeight)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onclick(sender: AnyObject) {
        
        let modalViewController = ModalViewController()
        let navigationController = UINavigationController(rootViewController: modalViewController)
        navigationController.modalTransitionStyle = .CoverVertical
        
        let button = sender as! UIButton
        
        switch (button.tag) {
        case 100:
            navigationController.modalPresentationStyle = .FullScreen
        case 200:
            navigationController.modalPresentationStyle = .FormSheet
        case 300:
            navigationController.modalPresentationStyle = .PageSheet
        case 400:
            navigationController.modalPresentationStyle = .CurrentContext
        default :
            NSLog("默认分支")
        }
        
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
}

