//
//  ViewController.swift
//  DownloadSample
//
//  Created by 关东升 on 16/1/11.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClick(sender: AnyObject) {

        let strURL = String(format: "http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", "<你的51work6.com用户邮箱>")
        let url = NSURL(string: strURL)!

        let defaultConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: defaultConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())

        let downloadTask = session.downloadTaskWithURL(url)

        downloadTask.resume()
    }

    //MARK: -- 实现NSURLSessionDownloadDelegate委托协议
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        self.progressView .setProgress(progress, animated: true)
        NSLog("进度= %f", progress)
        NSLog("接收: %lld 字节 (已下载: %lld 字节)  期待: %lld 字节.", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite)
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {

        NSLog("临时文件: %@\n", location)

        let downloadsDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

        let downloadStrPath = downloadsDir.stringByAppendingString("/test1.jpg")
        let downloadURLPath = NSURL.fileURLWithPath(downloadStrPath)
        
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(downloadStrPath) == true {
            do {
                try fileManager.removeItemAtPath(downloadStrPath)
            } catch let error as NSError {
                NSLog("删除文件失败: %@", error.localizedDescription)
            }
        }

        do {
            try fileManager.moveItemAtURL(location, toURL: downloadURLPath)
            NSLog("文件保存: %@", downloadStrPath)            
            let img = UIImage(contentsOfFile: downloadStrPath)
            self.imageView1.image = img
            
        } catch let error as NSError {
            NSLog("保存文件失败: %@", error.localizedDescription)
        }
    }
}

