//
//  BlueViewController.swift
//  SplitViewSample
//
//  Created by 关东升 on 16/2/4.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailFrame = self.navigationController!.view.frame
        
        self.view.backgroundColor = UIColor.blueColor()
        
        let buttonWidth:CGFloat = 60
        let buttonHeight:CGFloat = 20
        let buttonX: CGFloat = (detailFrame.size.width - buttonWidth)/2
        let buttonY: CGFloat = (detailFrame.size.height - buttonHeight)/2
        
        let button = UIButton(type: UIButtonType.System)
        button.setTitle("Tap", forState: UIControlState.Normal)
        
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)
        button.titleLabel!.font = UIFont.systemFontOfSize(28)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.addTarget(self, action: Selector("onClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClick(sender: AnyObject) {
        
        let alertController: UIAlertController = UIAlertController(title: "系统消息", message: "蓝色视图", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
