//
//  NoteBL.swift
//  BusinessLogicLayer
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
import PersistenceLayer

//定义BL查询所有数据成功通知
public let	BLFindAllFinishedNotification	    = "BLFindAllFinishedNotification"
//定义BL查询所有数据失败通知
public let	BLFindAllFailedNotification	        = "BLFindAllFailedNotification"

//定义BL插入数据成功通知
public let	BLCreateNoteFinishedNotification	= "BLCreateNoteFinishedNotification"
//定义BL插入数据失败通知
public let	BLCreateNoteFailedNotification	    = "BLCreateNoteFailedNotification"

//定义BL删除数据成功通知
public let	BLRemoveFinishedNotification	    = "BLRemoveFinishedNotification"
//定义BL删除数据失败通知
public let	BLRemoveFailedNotification	        = "BLRemoveFailedNotification"

//定义BL修改数据成功通知
public let	BLModifyFinishedNotification	    = "BLModifyFinishedNotification"
//定义BL修改数据失败通知
public let	BLModifyFailedNotification	        = "BLModifyFailedNotification"

public class NoteBL: NSObject {

    public override init() {
    }

    //插入Note方法
    public func createNote(model: Note) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "createFinished:", name: DaoCreateFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "createFailed:", name: DaoCreateFailedNotification, object: nil)
        
        let dao = NoteDAO.sharedInstance
        dao.create(model)
    }
    
    //修改Note方法
    public func modifyNote(model: Note) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "modifyFinished:", name: DaoModifyFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "modifyFailed:", name: DaoModifyFailedNotification, object: nil)
        
        let dao = NoteDAO.sharedInstance
        dao.modify(model)
    }
    
    //删除Note方法
    public func removeNote(model: Note) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeFinished:", name: DaoRemoveFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeFailed:", name: DaoRemoveFailedNotification, object: nil)
        
        let dao = NoteDAO.sharedInstance
        dao.remove(model)
    }
    
    //查询所用数据方法
    public func findAllNotes() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findAllFinished:", name: DaoFindAllFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findAllFailed:", name: DaoFindAllFailedNotification, object: nil)
        
        let dao = NoteDAO.sharedInstance
        dao.findAll()
    }

    //MARK: 通知回调方法
    //查询所有数据方法 成功
    func findAllFinished(notification: NSNotification) {
        
        let resList = notification.object as! NSMutableArray
        NSNotificationCenter.defaultCenter().postNotificationName(BLFindAllFinishedNotification, object: resList)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoFindAllFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoFindAllFailedNotification, object: nil)
        
    }
    
    //查询所有数据方法 失败
    func findAllFailed(notification: NSNotification)  {
        
        let error = notification.object
        
        NSNotificationCenter.defaultCenter().postNotificationName(BLFindAllFailedNotification, object: error)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoFindAllFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoFindAllFailedNotification, object: nil)
        
    }
    
    //插入Note方法 成功
    func createFinished(notification: NSNotification)  {
        NSNotificationCenter.defaultCenter().postNotificationName(BLCreateNoteFinishedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoCreateFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoCreateFailedNotification, object: nil)
        
    }
    
    //插入Note方法 失败
    func createFailed(notification: NSNotification)  {
        
        let error = notification.object
        
        NSNotificationCenter.defaultCenter().postNotificationName(BLCreateNoteFailedNotification, object: error)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoCreateFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoCreateFailedNotification, object: nil)
    }
    
    //删除Note方法 成功
    func removeFinished(notification: NSNotification)  {
        
        NSNotificationCenter.defaultCenter().postNotificationName(BLRemoveFinishedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFailedNotification, object: nil)
    }
    
    //删除Note方法 失败
    func removeFailed(notification: NSNotification)  {
        
        let error = notification.object
        
        NSNotificationCenter.defaultCenter().postNotificationName(BLRemoveFailedNotification, object: error)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFailedNotification, object: nil)
    }
    
    //修改Note方法 成功
    func modifyFinished(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName(BLModifyFinishedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoRemoveFailedNotification, object: nil)
    }
    //修改Note方法 失败
    func modifyFailed(notification: NSNotification)  {
        
        let error = notification.object
        
        NSNotificationCenter.defaultCenter().postNotificationName(BLModifyFailedNotification, object: error)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoModifyFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DaoModifyFailedNotification, object: nil)
    }
    
}
