//
//  AddViewController.swift
//  PresentationLayer
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func onclickCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onclickSave(sender: AnyObject) {
        self.txtView.resignFirstResponder()
        self.startRequest()
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    //MARK: - 开始请求Web Service
    func startRequest() {

        //准备参数
        let date = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.stringFromDate(date)

        //设置参数
        let post = NSString(format: "email=%@&type=%@&action=%@&date=%@&content=%@", "<你的51work6.com用户邮箱>", "JSON", "add", dateStr, self.txtView.text)
        let postData: NSData = post.dataUsingEncoding(NSUTF8StringEncoding)!

        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        let url = NSURL(string: strURL)!

        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData

        let defaultConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: defaultConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())

        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            NSLog("请求完成...")
            if error == nil {
                do {
                    let resDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary

                    let resultCode: NSNumber = resDict["ResultCode"] as! NSNumber
                    var message = "操作成功。"
                    if (resultCode.integerValue < 0) {
                        message = resultCode.errorMessage
                    }

                    let alertController: UIAlertController = UIAlertController(title: "提示信息", message: message, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(okAction)
                    //显示
                    self.presentViewController(alertController, animated: true, completion: nil)

                } catch {
                    NSLog("返回数据解析失败")
                }

            } else {
                NSLog("error : %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
}
