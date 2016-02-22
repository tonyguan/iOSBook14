//
//  ViewController.swift
//  PageControlNavigation
//
//  Created by 关东升 on 2016-2-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


import UIKit

let S_WIDTH: CGFloat = 320.0 //屏幕的宽度
let S_HEIGHT: CGFloat = 480.0 //屏幕的高度

class ViewController: UIViewController, UIScrollViewDelegate {

    var page1: UIImageView!
    var page2: UIImageView!
    var page3: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.delegate = self

        self.scrollView.frame = self.view.frame
        self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT)

        self.page1 = UIImageView(frame: CGRectMake(0.0, 0.0, S_WIDTH, S_HEIGHT))
        self.page1.image = UIImage(named: "达芬奇-蒙娜丽莎.png")

        self.scrollView.addSubview(page1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //属性UIScrollViewDelegate协议
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / Int(S_WIDTH)

        self.loadImage(self.pageControl.currentPage + 1)

    }

    @IBAction func changePage(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPointMake(S_WIDTH * CGFloat(whichPage), 0)
            self.loadImage(self.pageControl.currentPage + 1)
        })
    }

    func loadImage(nextPage: Int) {

        if nextPage == 1 && self.page2 == nil {
            self.page2 = UIImageView(frame: CGRectMake(S_WIDTH, 0.0, S_WIDTH, S_HEIGHT))
            self.page2.image = UIImage(named: "罗丹-思想者.png")
            self.scrollView.addSubview(page2)
        }


        if nextPage == 2 && self.page3 == nil {
            self.page3 = UIImageView(frame: CGRectMake(2 * S_WIDTH, 0.0, S_WIDTH, S_HEIGHT))
            self.page3.image = UIImage(named: "保罗克利-肖像.png")
            self.scrollView.addSubview(page3)
        }
    }
}

