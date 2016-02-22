//
//  ViewController.swift
//  UploadDownload
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

    var activityIndicatorView: UIActivityIndicatorView!
    var progressView: UIProgressView!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        let screen = UIScreen.mainScreen().bounds
        
        ///1.获得指示器
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        var frame = self.activityIndicatorView.frame
        frame.origin = CGPointMake((screen.size.width - frame.size.width) / 2, 84)
        //重新设置控件的位置
        self.activityIndicatorView.frame = frame
        
        self.activityIndicatorView.hidesWhenStopped = false
        self.view.addSubview(self.activityIndicatorView)
        
        ///2.Upload按钮
        let buttonUpload = UIButton(type: UIButtonType.System)
        buttonUpload.setTitle("Upload", forState: UIControlState.Normal)
        
        let buttonUploadWidth:CGFloat = 50
        let buttonUploadHeight:CGFloat = 30
        let buttonUploadTopView:CGFloat = 190
        
        buttonUpload.frame = CGRectMake((screen.size.width - buttonUploadWidth)/2 , buttonUploadTopView, buttonUploadWidth, buttonUploadHeight)
        //指定事件处理方法
        buttonUpload.addTarget(self, action: Selector("startToMove:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonUpload)
        
        ///3.进度条
        let progressViewWidth:CGFloat = 200
        let progressViewHeight:CGFloat = 2
        let progressViewTopView:CGFloat = 283
        
        self.progressView = UIProgressView(frame: CGRectMake((screen.size.width - progressViewWidth)/2 , progressViewTopView, progressViewWidth, progressViewHeight))
        
        self.view.addSubview(self.progressView)
        
        ///4.Download按钮
        let buttonDownload = UIButton(type: UIButtonType.System)
        buttonDownload.setTitle("Download", forState: UIControlState.Normal)
        
        let buttonDownloadWidth:CGFloat = 69
        let buttonDownloadHeight:CGFloat = 30
        let buttonDownloadTopView:CGFloat = 384
        
        buttonDownload.frame = CGRectMake((screen.size.width - buttonDownloadWidth)/2 , buttonDownloadTopView, buttonDownloadWidth, buttonDownloadHeight)
        //指定事件处理方法
        buttonDownload.addTarget(self, action: Selector("downloadProgress:"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(buttonDownload)
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func startToMove(sender: AnyObject) {
        if (self.activityIndicatorView.isAnimating()) {
            self.activityIndicatorView.stopAnimating()
        }else{
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func downloadProgress(sender: AnyObject) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
            selector: Selector("download"),
            userInfo: nil, repeats: true)
    }
    
    func download() {
        self.progressView.progress = self.progressView.progress + 0.1
        if (self.progressView.progress == 1.0) {
            self.timer.invalidate()
            
            let alertController: UIAlertController = UIAlertController(title: "download completed！",
                message: "", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            
            //显示
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}

