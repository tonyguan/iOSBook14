//
//  NotesURLConnection.swift
//  MyNotes
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


import Foundation

protocol NotesURLConnectionDelegate {

    //查询所有数据方法 成功
    func findAllFinished(res: NSDictionary)

    //查询所有数据方法 失败
    func findAllFailed(error: NSError)

}

class NotesURLConnection: NSObject, NSURLConnectionDataDelegate {

    //保存数据列表
    var listData: NSMutableArray!

    //接收从服务器返回数据。
    var datas: NSMutableData!

    var delegate: NotesURLConnectionDelegate!

    //查询所有数据方法
    func findAll() {
        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"

        let url = NSURL(string: strURL)!

        let post = NSString(format: "email=%@&type=%@&action=%@", "<你的51work6.com用户邮箱>", "JSON", "query")
        let postData: NSData = post.dataUsingEncoding(NSUTF8StringEncoding)!

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

                    self.delegate.findAllFinished(resDict)

                } catch {
                    NSLog("返回数据解析失败")
                }
            } else {
                NSLog("error : %@", error!.localizedDescription)
                self.delegate.findAllFailed(error!)
            }
        })

        task.resume()
    }

}