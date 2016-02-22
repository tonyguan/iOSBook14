//
//  NotesTBXMLParser.swift
//  MyNotes
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

import Foundation

class NotesTBXMLParser: NSObject {
    
    //解析出的数据内部是字典类型
    private var listData: NSMutableArray!
    
    //开始解析
    func start() {
        
        self.listData = NSMutableArray()
        
        let tbxml = TBXML(XMLFile: "Notes.xml")
        
        let root = tbxml.rootXMLElement
        
        if root != nil {
            
            var noteElement = TBXML.childElementNamed("Note", parentElement: root)
            
            while noteElement != nil {
                
                let dict = NSMutableDictionary()
                
                let dateElement = TBXML.childElementNamed("CDate", parentElement: noteElement)
                if dateElement != nil {
                    let date = TBXML.textForElement(dateElement)
                    dict["CDate"] = date
                }
                
                let contentElement = TBXML.childElementNamed("Content", parentElement: noteElement)
                if contentElement != nil {
                    let content = TBXML.textForElement(contentElement)
                    dict["Content"] = content
                }
                
                let userIDElement = TBXML.childElementNamed("UserID", parentElement: noteElement)
                if userIDElement != nil {
                    let userID = TBXML.textForElement(userIDElement)
                    dict["UserID"] = userID
                }
                
                let identifier = TBXML.valueOfAttributeNamed("id", forElement: noteElement)
                dict["id"] = identifier
                
                self.listData.addObject(dict)
                
                noteElement = TBXML.nextSiblingNamed("Note", searchFromElement: noteElement)
                
            }
        }
        
        NSLog("TBXML解析完成...")
        NSNotificationCenter.defaultCenter().postNotificationName("reloadViewNotification", object: self.listData)
        
        self.listData = nil
    }
    
}
