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

class AddViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var txtView: UITextView!
    //业务逻辑对象BL
    var bl = NoteBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.delegate = self
        self.txtView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onclickSave(sender: AnyObject) {
        
        let note = Note()
        note.date = NSDate()
        note.content = self.txtView.text
        let reslist = bl.createNote(note)
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadViewNotification", object: reslist, userInfo: nil)
        self.txtView.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
    
}
