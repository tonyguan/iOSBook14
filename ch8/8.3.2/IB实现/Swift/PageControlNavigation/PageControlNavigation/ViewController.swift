//
//  ViewController.swift
//  PageControlNavigation
//
//  Created by 关东升 on 15/12/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        
        self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width*3, self.scrollView.frame.size.height)
        self.scrollView.frame = self.view.frame
        
        self.imageView1 = UIImageView(frame: CGRectMake(0.0, 0.0, 320.0, 480.0))
        self.imageView1.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        self.scrollView.addSubview(self.imageView1)
        
        self.imageView2 = UIImageView(frame: CGRectMake(320.0, 0.0, 320.0, 480.0))
        self.imageView2.image = UIImage(named: "罗丹-思想者.png")
        self.scrollView.addSubview(self.imageView2)
        
        self.imageView3 = UIImageView(frame: CGRectMake(2 * 320.0, 0.0, 320.0, 480.0))
        self.imageView3.image = UIImage(named: "保罗克利-肖像.png")
        self.scrollView.addSubview(self.imageView3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: --实现UIScrollViewDelegate委托协议
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / 320
    }
    
    // MARK: --实现UIPageControl事件处理
    @IBAction func changePage(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations : {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPointMake(320 * CGFloat(whichPage), 0)
        })
    }

}

