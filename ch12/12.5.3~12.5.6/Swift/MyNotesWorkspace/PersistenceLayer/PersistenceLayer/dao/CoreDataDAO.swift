//
//  CoreDataDAO.swift
//  PersistenceLayer
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

public class CoreDataDAO: NSObject {
    
    /// MARK: - Core Data stack
    //获得应用程序沙箱Document目录
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    //返回被管理对象模型
    lazy var managedObjectModel: NSManagedObjectModel = {
        let frameworkBundle = NSBundle(forClass: CoreDataDAO.self)
        let modelURL = frameworkBundle.URLForResource("CoreDataNotes", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    //返回持久化存储协调器
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("CoreDataNotes.sqlite")
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            NSLog("加载数据失败")
            abort()
        }
        
        return coordinator
    }()
    
    //返回被管理对象上下文
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    /// MARK: - 保存数据
    //保存数据
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("数据保存错误：%@", nserror.localizedDescription)
                abort()
            }
        }
    }

}
