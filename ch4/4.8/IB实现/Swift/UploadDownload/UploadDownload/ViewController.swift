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

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startToMove(sender: AnyObject) {
        if (self.activityIndicatorView.isAnimating()) {
            self.activityIndicatorView.stopAnimating()
        }else{
            self.activityIndicatorView.startAnimating()
        }
    }
    
    @IBAction func downloadProgress(sender: AnyObject) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "download", userInfo: nil, repeats: true)
    }
    
    func download() {
        self.progressView.progress = self.progressView.progress + 0.1
        if (self.progressView.progress == 1.0) {
            self.timer.invalidate()
            
            let alertController: UIAlertController = UIAlertController(title: "download completed！", message: "", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            
            //显示
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}

