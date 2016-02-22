//
//  ViewController.swift
//  Create_Contacts
//
//  Created by 关东升 on 16/1/7.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import ContactsUI

class ViewController: UITableViewController, CNContactViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //点击New Contact按钮
    @IBAction func newContactClick(sender: AnyObject) {
        
        let contact = CNMutableContact()
        contact.givenName = "Tony"
        contact.familyName = "Guan"
        
        let controller = CNContactViewController(forNewContact: contact)
        
        let contactStore = CNContactStore()
        controller.contactStore = contactStore
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    //点击Unknown Contact
    @IBAction func unknownContactClick(sender: AnyObject) {
        
        let contact = CNMutableContact()
        contact.givenName = "Tony"
        contact.familyName = "Guan"
        
        //设置Email属性
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "tony@sina.com")
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "tony@sina.com")
        // 添加Email到数据库
        contact.emailAddresses = [homeEmail, workEmail]
        
        let controller = CNContactViewController(forUnknownContact: contact)
        
        let contactStore = CNContactStore()
        controller.contactStore = contactStore
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

