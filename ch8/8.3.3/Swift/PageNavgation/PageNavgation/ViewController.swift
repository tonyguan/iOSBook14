//
//  ViewController.swift
//  PageNavgation
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

enum DirectionForward : Int {
    case Before = 1 //向前
    case After = 2  //向后
}

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //当前Page的索引
    var pageIndex = 0
    //翻页的方向 BeforeForward 向前 AfterForward 向后
    var directionForward  =  DirectionForward.After
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1ViewController = UIViewController()
        let page2ViewController = UIViewController()
        let page3ViewController = UIViewController()
        
        self.viewControllers = [page1ViewController, page2ViewController, page3ViewController]
        
        let imageView1 = UIImageView(frame: self.view.frame)
        imageView1.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        page1ViewController.view.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: self.view.frame)
        imageView2.image = UIImage(named: "罗丹-思想者.png")
        page2ViewController.view.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: self.view.frame)
        imageView3.image = UIImage(named: "保罗克利-肖像.png")
        page3ViewController.view.addSubview(imageView3)
        
        //设置UIPageViewController控制器
        self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        //设置首页
        self.pageViewController.setViewControllers([page1ViewController], direction: .Forward, animated: true, completion: nil)
        
        self.view.addSubview(self.pageViewController.view)
        
        pageIndex = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: --实现UIPageViewControllerDataSource协议
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        pageIndex--
        
        if (pageIndex < 0){
            pageIndex = 0
            return nil
        }
        
        directionForward = .Before
        return self.viewControllers[pageIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        pageIndex++
        
        if (pageIndex > 2){
            pageIndex = 2
            return nil
        }
        
        directionForward = .After
        return self.viewControllers[pageIndex]
    }
    
    // MARK: --实现UIPageViewControllerDelegate协议
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        self.pageViewController.doubleSided = false
        return .Min
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed == false) {
            if (directionForward == .After) {
                pageIndex--
            }
            if (directionForward == .Before) {
                pageIndex++
            }
        }
    }
    
}

