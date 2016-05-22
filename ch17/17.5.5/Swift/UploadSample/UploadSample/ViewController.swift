//
//  ViewController.swift
//  UploadSample
//
//  Created by 关东升 on 16/1/13.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var imageView1: UIImageView!

    @IBOutlet weak var label: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClick(sender: AnyObject) {

        self.label.text = "上传进度"
        self.progressView.progress = 0.0

        let uploadStrURL = String(format: "http://www.51work6.com/service/upload.php?email=%@", "<你的51work6.com用户邮箱>")

        let fileURL = NSBundle.mainBundle().URLForResource("test2", withExtension: "jpg")

        Alamofire.upload(.POST, uploadStrURL,
                multipartFormData: {
                    multipartFormData in
                    multipartFormData.appendBodyPart(fileURL: fileURL!, name: "file", fileName: "1.jpg", mimeType: "image/jpeg")
                },
                encodingCompletion: {
                    encodingResult in
                    switch encodingResult {
                    case .Success(let upload, _, _ ):
                        upload.progress {
                            bytesRead, totalBytesRead, totalBytesExpectedToRead in
                            let progress = Float(totalBytesRead) / Float(totalBytesExpectedToRead)
                            print("上传进度 = \(progress)")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.progressView.setProgress(progress, animated: true)
                            }
                        }
                        upload.response {
                            _, _, _, error in
                            if error != nil {
                                print("上传失败: \(error!.localizedDescription)")
                            } else {
                                print("上传成功")
                                self.download()
                            }
                        }
                    case .Failure(let encodingError):
                        print("上传失败: \(encodingError)")
                    }
                }
        )

    }

    func download() {

        self.label.text = "下载进度"
        self.progressView.progress = 0.0

        let downloadsDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let downloadStrPath = downloadsDir.stringByAppendingString("/test1.jpg")
        let downloadURLPath = NSURL.fileURLWithPath(downloadStrPath)

        let strURL = String(format: "http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", "<你的51work6.com用户邮箱>")

        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
            (temporaryUrl, response) in
            if response.statusCode == 200 {
                if NSFileManager.defaultManager().fileExistsAtPath(downloadStrPath) {
                    try! NSFileManager.defaultManager().removeItemAtURL(downloadURLPath)
                }
                return downloadURLPath
            } else {
                return temporaryUrl
            }
        }

        Alamofire.download(.POST, strURL, destination: destination)
        .progress {
            bytesRead, totalBytesRead, totalBytesExpectedToRead in
            let progress = Float(totalBytesRead) * 1.0 / Float(totalBytesExpectedToRead)
            print("下载进度 = \(progress)")
            dispatch_async(dispatch_get_main_queue(), {
                self.progressView.setProgress(progress, animated: true)
            })
        }
        .response {
            _, _, _, error in
            if error != nil {
                print("下载失败: \(error!.localizedDescription)")
            } else {
                print("下载成功，保存文件: \(downloadStrPath)")
                let img = UIImage(contentsOfFile: downloadStrPath)
                self.imageView1.image = img
            }
        }
    }
}

