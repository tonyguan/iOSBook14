//
//  ViewController.swift
//  WebViewSample
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
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let screen = UIScreen.mainScreen().bounds

        ///按钮栏
        //按钮栏宽
        let buttonBarWidth: CGFloat = 316
        let buttonBar = UIView(frame: CGRectMake((screen.size.width - buttonBarWidth) / 2, 20, buttonBarWidth, 30))
        self.view.addSubview(buttonBar)

        /// 1.添加LoadHTMLString按钮
        let buttonLoadHTMLString = UIButton(type: UIButtonType.System)
        buttonLoadHTMLString.setTitle("LoadHTMLString", forState: UIControlState.Normal)
        buttonLoadHTMLString.frame = CGRectMake(0, 0, 117, 30)
        //指定事件处理方法
        buttonLoadHTMLString.addTarget(self, action: Selector("testLoadHTMLString:"), forControlEvents: .TouchUpInside)
        buttonBar.addSubview(buttonLoadHTMLString)

        /// 2.添加LoadData按钮
        let buttonLoadData = UIButton(type: UIButtonType.System)
        buttonLoadData.setTitle("LoadData", forState: UIControlState.Normal)
        buttonLoadData.frame = CGRectMake(137, 0, 67, 30)
        //指定事件处理方法
        buttonLoadData.addTarget(self, action: Selector("testLoadData:"), forControlEvents: .TouchUpInside)
        buttonBar.addSubview(buttonLoadData)

        /// 3.添加LoadRequest按钮
        let buttonLoadRequest = UIButton(type: UIButtonType.System)
        buttonLoadRequest.setTitle("LoadRequest", forState: UIControlState.Normal)
        buttonLoadRequest.frame = CGRectMake(224, 0, 92, 30)
        //指定事件处理方法
        buttonLoadRequest.addTarget(self, action: Selector("testLoadRequest:"), forControlEvents: .TouchUpInside)
        buttonBar.addSubview(buttonLoadRequest)

        /// 4.添加WKWebView
        self.webView = WKWebView(frame: CGRectMake(0, 60, screen.size.width, screen.size.height - 80))
        self.view.addSubview(self.webView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func testLoadHTMLString(sender: AnyObject) {

        let htmlPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let bundleUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)

        do {
            let html = try NSString(contentsOfFile: htmlPath!, encoding: NSUTF8StringEncoding)
            self.webView.loadHTMLString(html as String, baseURL: bundleUrl)

        } catch let err as NSError {
            err.description
        }
    }

    func testLoadData(sender: AnyObject) {

        let htmlPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let bundleUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
        let htmlData = NSData(contentsOfFile: htmlPath!)

        self.webView.loadData(htmlData!, MIMEType: "text/html", characterEncodingName: "UTF-8", baseURL: bundleUrl)

    }

    func testLoadRequest(sender: AnyObject) {
        let url = NSURL(string: "http://51work6.com")
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
        self.webView.navigationDelegate = self
    }

    // MARK: --实现WKNavigationDelegate委托协议
    //开始加载时调用
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("开始加载")
    }

    //当内容开始返回时调用
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        NSLog("内容开始返回")
    }

    //加载完成之后调用
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        NSLog("加载完成")
    }

    //加载失败时调用
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog("加载失败 error :  %@", error.description)
    }

}

