//
//  ViewController.swift
//  AlertViewActionSheet
//
//  Created by 关东升 on 15/12/13.
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
        
        let buttonAlertView = UIButton(type: UIButtonType.System)
        buttonAlertView.setTitle("Test警告框", forState: UIControlState.Normal)
        
        let buttonAlertViewWidth: CGFloat = 100
        let buttonAlertViewHeight: CGFloat = 30
        let buttonAlertViewTopView: CGFloat = 130
        
        buttonAlertView.frame = CGRectMake((screen.size.width - buttonAlertViewWidth)/2 , buttonAlertViewTopView, buttonAlertViewWidth, buttonAlertViewHeight)
        //指定事件处理方法
        buttonAlertView.addTarget(self, action: Selector("testAlertView:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonAlertView)

        let buttonActionSheet = UIButton(type: UIButtonType.System)
        buttonActionSheet.setTitle("Test操作表", forState: UIControlState.Normal)
        
        let buttonActionSheetWidth: CGFloat = 100
        let buttonActionSheetHeight: CGFloat = 30
        let buttonActionSheetTopView: CGFloat = 260
        
        buttonActionSheet.frame = CGRectMake((screen.size.width - buttonActionSheetWidth)/2 , buttonActionSheetTopView, buttonActionSheetWidth, buttonActionSheetHeight)
        //指定事件处理方法
        buttonActionSheet.addTarget(self, action: Selector("testActionSheet:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonActionSheet)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func testAlertView(sender: AnyObject) {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "Alert text goes here", preferredStyle: UIAlertControllerStyle.Alert)
        
        let noAction = UIAlertAction(title: "No", style: .Cancel) { (alertAction) -> Void in
            NSLog("Tap No Button")
        }
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (alertAction) -> Void in
            NSLog("Tap Yes Button")
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)

        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func testActionSheet(sender: AnyObject) {
        
        let actionSheetController: UIAlertController = UIAlertController()
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            NSLog("Tap 取消 Button")
        }
        
        let destructiveAction = UIAlertAction(title: "破坏性按钮", style: UIAlertActionStyle.Destructive) { (alertAction) -> Void in
            NSLog("Tap 破坏性按钮 Button")
        }
        
        let otherAction = UIAlertAction(title: "新浪微博", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            NSLog("Tap 新浪微博 Button")
        }
        
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(destructiveAction)
        actionSheetController.addAction(otherAction)
        
        //显示
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
}

