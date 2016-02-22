//
//  DetailViewController.swift
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

class DetailViewController: UIViewController {
    //更新行号
    var selectRow = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("选择的行号： %i", selectRow)        
        
        if self.selectRow == 0 {
            //蓝色
            let blueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("blueViewController")
            self.addChildViewController(blueViewController)
            self.view.addSubview(blueViewController.view)
        } else {
            //黄色
            let yellowViewController = self.storyboard!.instantiateViewControllerWithIdentifier("yellowViewController")
            self.addChildViewController(yellowViewController)
            self.view.addSubview(yellowViewController.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

