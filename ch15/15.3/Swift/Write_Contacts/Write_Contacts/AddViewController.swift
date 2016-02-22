//
//  AddViewController.swift
//  Write_Contacts
//
//  Created by 关东升 on 16/1/6.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import Contacts


class AddViewController: UITableViewController {
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtIPhone: UITextField!
    
    @IBOutlet weak var txtWorkEmail: UITextField!
    @IBOutlet weak var txtHomeEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveClick(sender: AnyObject) {
        
        let contact = CNMutableContact()
        
        //设置姓名属性
        contact.familyName =  self.txtFirstName.text!
        contact.givenName =  self.txtLastName.text!
        
        // 设置电话号码
        let mobilePhoneValue = CNPhoneNumber(stringValue: self.txtMobile.text!)
        let mobilePhone = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: mobilePhoneValue)
        
        let iPhoneValue = CNPhoneNumber(stringValue: self.txtIPhone.text!)
        let iPhone = CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: iPhoneValue)
        
        // 添加电话号码到数据库
        contact.phoneNumbers = [mobilePhone, iPhone]
        
        //设置Email属性
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: self.txtHomeEmail.text!)
        let workEmail = CNLabeledValue(label: CNLabelWork, value: self.txtWorkEmail.text!)
        // 添加Email到数据库
        contact.emailAddresses = [homeEmail, workEmail]
        
        //最后保存
        let request = CNSaveRequest()
        request.addContact(contact, toContainerWithIdentifier: nil)
        
        let contactStore = CNContactStore()
        
        do {
            try contactStore.executeSaveRequest(request)
            //关闭模态视图
            self.dismissViewControllerAnimated(true, completion:nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func cancelClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

