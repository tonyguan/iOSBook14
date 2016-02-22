//
//  NoteDAO.swift
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
import CoreData

public class NoteDAO : CoreDataDAO {
    
    //私有的DateFormatter属性
    private var dateFormatter = NSDateFormatter()
    
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return instance
    }()
    
    //插入Note方法
    public func create(model: Note) -> Int {
        
        let cxt = self.managedObjectContext
        
        let note = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext:cxt) as! NoteManagedObject
        
        note.date = model.date
        note.content = model.content
        
        //保存数据
        self.saveContext()
        
        return 0
    }
    
    //删除Note方法
    public func remove(model: Note) -> Int {
        
        let cxt = self.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try cxt.executeFetchRequest(fetchRequest)
            if listData.count > 0 {
                let note = listData[0] as! NSManagedObject
                cxt.deleteObject(note)
                //保存数据
                self.saveContext()
            }
        } catch {
            NSLog("删除数据失败")
        }
        return 0
    }
    
    //修改Note方法
    public func modify(model: Note) -> Int {
        
        let cxt = self.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try cxt.executeFetchRequest(fetchRequest)
            if listData.count > 0 {
                let note = listData[0] as! NoteManagedObject
                //note.setValue(model.content, forKey: "content")
                note.content = model.content
                
                //保存数据
                self.saveContext()
            }
        } catch {
            NSLog("修改数据失败")
        }
        return 0
    }
    
    //查询所有数据方法
    public func findAll() -> NSMutableArray? {
        
        let cxt = self.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let listData = try cxt.executeFetchRequest(fetchRequest)
            let resListData = NSMutableArray()
            
            if listData.count > 0 {
                
                for item in listData {
                    let mo = item as! NoteManagedObject
                    let note = Note(date: mo.date!, content: mo.content!)
                    resListData.addObject(note)
                }
            }
            return resListData
        } catch {
            NSLog("查询数据失败")
            return nil
        }
    }
    
    //按照主键查询数据方法
    public func findById(model: Note) -> Note? {
        
        let cxt = self.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try cxt.executeFetchRequest(fetchRequest)
            
            if listData.count > 0 {
                let mo = listData[0] as! NoteManagedObject
                let note = Note(date: mo.date!, content: mo.content!)
                return note
            }
        } catch {
            NSLog("查询数据失败")
        }
        return nil
    }
    
}
