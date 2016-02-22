//
//  ViewController.swift
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

class ViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var listContacts: [CNContact]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //实例化UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        //设置self为更新搜索结果对象
        self.searchController.searchResultsUpdater = self
        //在搜索是背景设置为灰色
        self.searchController.dimsBackgroundDuringPresentation = false
        //将搜索栏放到表视图的表头中
        self.tableView.tableHeaderView = self.searchController.searchBar

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //查询通信录中所有联系人
            self.listContacts = self.findAllContacts()
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ---预处理Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.selectContact = self.listContacts[indexPath!.row]
        }
    }
    // MARK: --查询通信录中所有联系人
    func findAllContacts() -> [CNContact] {
        //返回的联系人集合
        var contacts = [CNContact]()
        
        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        let contactStore = CNContactStore()
        
        do {  
            try contactStore.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: {
                (contact, stop) -> Void in
                contacts.append(contact)
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return contacts
    }
    
    // MARK: --按照姓名查询通信录中的联系人
    func findContactsByName(searchName: String?) -> [CNContact] {
        
        //没有输入任何字符
        if (searchName == nil || searchName!.characters.count == 0) {
            //返回通信录中所有联系人
            return self.findAllContacts()
        }
        
        let contactStore = CNContactStore()
        
        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey]
        let predicate = CNContact.predicateForContactsMatchingName(searchName!)
        
        do {
            //没有错误情况下返回查询结果
            let contacts = try contactStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            return contacts
        } catch let error as NSError {
            print(error.localizedDescription)
            //如果有错误发生，返回通信录中所有联系人
            return self.findAllContacts()
        }
    }
    
    // MARK: --实现UISearchBarDelegate协议方法
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResultsForSearchController(self.searchController)
    }
    
    // MARK: --实现UISearchResultsUpdating协议方法
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        //查询
        self.listContacts = self.findContactsByName(searchString)
        self.tableView.reloadData()
    }
    
    // MARK: --Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.listContacts == nil {
            return 0
        }
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
    
}

