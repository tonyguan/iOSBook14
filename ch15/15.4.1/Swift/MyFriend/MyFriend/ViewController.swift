//
//  ViewController.swift
//  MyFriend
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
import ContactsUI

class ViewController: UITableViewController, CNContactPickerDelegate {
    
    var listContacts: [CNContact]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listContacts = [CNContact]()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectContacts(sender: AnyObject) {
        
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        self.presentViewController(contactPicker, animated: true, completion: nil)
        
    }
    
    //MARK: --表视图数据源
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listContacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let contact = self.listContacts[indexPath.row]
        let firstName = contact.givenName
        let lastName = contact.familyName
        
        let name = "\(firstName) \(lastName)"
        cell.textLabel!.text = name
        
        return cell
    }
    
    
    //MARK: --实现CNContactPickerDelegate委托协议
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        
        if !self.listContacts.contains(contact) {
            self.listContacts.append(contact)
            self.tableView.reloadData()
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        
        for contact in contacts  where !self.listContacts.contains(contact) {
            self.listContacts.append(contact)
            self.tableView.reloadData()
        }
        
    }
    
    
    //
    //    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
    //        let contact = contactProperty.contact
    //        let phoneNumber = contactProperty.value as! CNPhoneNumber
    //
    //        print(contact.givenName)
    //        print(phoneNumber.stringValue)
    //    }
    
}

