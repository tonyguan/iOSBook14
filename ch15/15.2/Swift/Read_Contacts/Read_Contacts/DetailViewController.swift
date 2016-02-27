//
//  DetailViewController.swift
//  Read_Contacts
//
//  Created by 关东升 on 16/1/5.
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
    @IBOutlet weak var lblMobile: UILabel!

    @IBOutlet weak var lblIPhone: UILabel!
    @IBOutlet weak var lblWorkEmail: UILabel!
    @IBOutlet weak var lblHomeEmail: UILabel!

    var selectContact: CNContact!

    override func viewDidLoad() {
        super.viewDidLoad()

        let contactStore = CNContactStore()

        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey]

        do {
            let contact = try contactStore.unifiedContactWithIdentifier(self.selectContact.identifier, keysToFetch: keysToFetch)
            //取得姓名属性
            let firstName = contact.givenName
            let lastName = contact.familyName

            let name = "\(firstName) \(lastName)"
            self.lblName.text = name

            //取得Email属性
            let emailAddresses = contact.emailAddresses

            for emailProperty in emailAddresses {
                if emailProperty.label == CNLabelWork {
                    self.lblWorkEmail.text = emailProperty.value as? String
                } else if emailProperty.label == CNLabelHome {
                    self.lblHomeEmail.text = emailProperty.value as? String
                } else {
                    print("其他Email : \(emailProperty.value)")
                }
            }

            //取得电话号码属性
            let phoneNumbers = contact.phoneNumbers
            for phoneNumberProperty in phoneNumbers {

                let phoneNumber = phoneNumberProperty.value as! CNPhoneNumber

                if phoneNumberProperty.label == CNLabelPhoneNumberMobile {
                    self.lblMobile.text = phoneNumber.stringValue
                } else if phoneNumberProperty.label == CNLabelPhoneNumberiPhone {
                    self.lblIPhone.text = phoneNumber.stringValue
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

}
