//
//  DetailViewController.swift
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
import BusinessLogicLayer
import PersistenceLayer

class DetailViewController: UIViewController, UITextViewDelegate {

    //业务逻辑对象BL
    var bl: NoteBL!

    @IBOutlet weak var txtView: UITextView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let note: Note = self.detailItem as? Note {
            let content = note.content as String?
            if self.txtView != nil {
                self.txtView.text = content
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()

        self.bl = NoteBL()
        self.txtView.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "modifyNoteFinished:", name: BLModifyFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "modifyNoteFailed:", name: BLModifyFailedNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @IBAction func onclickSave(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate  =  dateFormatter.stringFromDate(NSDate())
        
        let note = self.detailItem as! Note
        note.date = strDate
        note.content = self.txtView.text
        
        self.bl.modifyNote(note)

        self.txtView.resignFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK:- 处理通知
    //修改Note方法 成功
    func modifyNoteFinished(notification: NSNotification) {
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: "修改成功。", preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction(title: "OK", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)

        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    //修改Note方法 失败
    func modifyNoteFailed(notification: NSNotification) {
        
        let error = notification.object as! NSError
        let errorStr = error.localizedDescription
        
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: errorStr, preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction(title: "OK", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)

        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

