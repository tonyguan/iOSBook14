//
//  ViewController.swift
//  TextFieldTextView
//
//  Created by 关东升 on 15/12/11.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
        
        let textFieldWidth:CGFloat = 223
        let textFieldHeight:CGFloat = 30
        let textFieldTopView:CGFloat = 150
        let textField = UITextField(frame: CGRectMake((screen.size.width - textFieldWidth)/2 , textFieldTopView, textFieldWidth, textFieldHeight))

        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.delegate = self
        
        textField.returnKeyType = UIReturnKeyType.Next
        textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        
        self.view.addSubview(textField)
        
        //labelName标签与textField之间的距离
        let labelNameTextFieldSpace: CGFloat = 30
        let labelName = UILabel(frame: CGRectMake(textField.frame.origin.x, textField.frame.origin.y - labelNameTextFieldSpace, 51, 21))
        labelName.text = "Name:"
        self.view.addSubview(labelName)
        
        let textViewWidth:CGFloat = 236
        let textViewHeight: CGFloat = 198
        let textViewTopView: CGFloat = 240
        let textView = UITextView(frame: CGRectMake((screen.size.width - textViewWidth)/2 , textViewTopView, textViewWidth, textViewHeight))
        
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        textView.delegate = self
        textView.returnKeyType = UIReturnKeyType.Go
        textView.keyboardType = UIKeyboardType.Default
        
        self.view.addSubview(textView)
        
        //labelAbstract标签与textView之间的距离
        let labelAbstractTextViewSpace: CGFloat = 30
        let labelAbstract = UILabel(frame: CGRectMake(textView.frame.origin.x, textView.frame.origin.y - labelAbstractTextViewSpace, 103, 21))
        
        labelAbstract.text = "Abstract:"
        self.view.addSubview(labelAbstract)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 实现UITextFieldDelegate委托协议方法
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - 实现UITextViewDelegate委托协议方法
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //注册键盘出现通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        //注册键盘隐藏通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //解除键盘出现通知
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        //解除键盘隐藏通知
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        NSLog("键盘打开")
    }
    
    func keyboardDidHide(notification: NSNotification) {
        NSLog("键盘关闭")
    }
    
}

