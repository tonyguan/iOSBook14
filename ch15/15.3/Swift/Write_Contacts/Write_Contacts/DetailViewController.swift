//
//  DetailViewController.swift
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

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtIPhone: UITextField!
    
    @IBOutlet weak var txtWorkEmail: UITextField!
    @IBOutlet weak var txtHomeEmail: UITextField!
    
    var selectContact: CNContact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contactStore = CNContactStore()
        
        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
        
        do {
            let contact = try contactStore.unifiedContactWithIdentifier(self.selectContact.identifier, keysToFetch: keysToFetch)
            
            //保存查询出的联系人
            self.selectContact = contact
            
            //取得姓名属性
            let firstName = contact.givenName
            let lastName = contact.familyName
            
            let name = "\(firstName) \(lastName)"
            self.lblName.text = name
            
            //取得Email属性
            let emailAddresses = contact.emailAddresses
            
            for emailProperty in emailAddresses {
                if emailProperty.label == CNLabelWork {
                    self.txtWorkEmail.text = emailProperty.value as? String
                } else if emailProperty.label == CNLabelHome {
                    self.txtHomeEmail.text = emailProperty.value as? String
                } else {
                    print("其他Email : \(emailProperty.value)")
                }
            }
            
            //取得电话号码属性
            let phoneNumbers = contact.phoneNumbers
            for phoneNumberProperty in phoneNumbers {
                
                let phoneNumber = phoneNumberProperty.value as! CNPhoneNumber
                
                if phoneNumberProperty.label == CNLabelPhoneNumberMobile {
                    self.txtMobile.text = phoneNumber.stringValue
                } else if phoneNumberProperty.label == CNLabelPhoneNumberiPhone {
                    self.txtIPhone.text = phoneNumber.stringValue
                } else {
                    print("其他电话 : \(phoneNumber.stringValue)")
                }
            }
            //取得个人图片
            if let photoData = contact.imageData {
                self.imageView.image = UIImage(data: photoData)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClick(sender: AnyObject) {
        
        let contact = self.selectContact.mutableCopy() as! CNMutableContact
        
        // 设置电话号码
        let mobilePhoneValue = CNPhoneNumber(stringValue: self.txtMobile.text!)
        let mobilePhone = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: mobilePhoneValue)
        
        let iPhoneValue = CNPhoneNumber(stringValue: self.txtIPhone.text!)
        let iPhone = CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: iPhoneValue)
        
        // 添加电话号码到数据库
        contact.phoneNumbers = [mobilePhone, iPhone]
        
        // 设置Email属性
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: self.txtHomeEmail.text!)
        let workEmail = CNLabeledValue(label: CNLabelWork, value: self.txtWorkEmail.text!)
        
        // 添加Email到数据库
        contact.emailAddresses = [homeEmail, workEmail]
        
        //最后保存
        let request = CNSaveRequest()
        request.updateContact(contact)
        
        let contactStore = CNContactStore()
        
        do {
            try contactStore.executeSaveRequest(request)
            //导航回根视图控制器ViewController
            self.navigationController?.popToRootViewControllerAnimated(true)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func deleteClick(sender: AnyObject) {
        
        let contact = self.selectContact.mutableCopy() as! CNMutableContact
        
        let request = CNSaveRequest()
        request.deleteContact(contact)
        
        let contactStore = CNContactStore()
        
        do {
            try contactStore.executeSaveRequest(request)
            //导航回根视图控制器ViewController
            self.navigationController?.popToRootViewControllerAnimated(true)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
