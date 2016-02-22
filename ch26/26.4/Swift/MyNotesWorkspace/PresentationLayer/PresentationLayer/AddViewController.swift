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
import BusinessLogicLayer
import PersistenceLayer

class AddViewController: UIViewController, UITextViewDelegate, NoteBLDelegate {

    @IBOutlet weak var txtView: UITextView!
    //业务逻辑对象BL
    var bl: NoteBL!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.becomeFirstResponder()
        self.bl = NoteBL()
        self.bl.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onclickSave(sender: AnyObject) {

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate  =  dateFormatter.stringFromDate(NSDate())
        
        let note = Note()
        note.date = strDate
        note.content = self.txtView.text
        
        self.bl.createNote(note)
        
        self.txtView.resignFirstResponder()

    }

    @IBAction func onclickCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    // MARK:- 处理通知
    //插入Note方法 成功
    func createNoteFinished() {

        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: "插入成功。", preferredStyle: UIAlertControllerStyle.Alert)

        let noAction = UIAlertAction(title: "返回", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let yesAction = UIAlertAction(title: "继续", style: .Default) {
            (alertAction) -> Void in
            self.txtView.text = ""
            self.txtView.becomeFirstResponder()
        }

        alertController.addAction(noAction)
        alertController.addAction(yesAction)

        //显示
        self.presentViewController(alertController, animated: true, completion: nil)

    }

    //插入Note方法 失败
    func createNoteFailed(error: NSError) {

        let errorStr = error.localizedDescription
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: errorStr, preferredStyle: UIAlertControllerStyle.Alert)

        let noAction = UIAlertAction(title: "返回", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let yesAction = UIAlertAction(title: "继续", style: .Default) {
            (alertAction) -> Void in
            self.txtView.text = ""
            self.txtView.becomeFirstResponder()
        }

        alertController.addAction(noAction)
        alertController.addAction(yesAction)

        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
