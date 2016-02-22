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

import sqlite3

let DBFILE_NAME = "NotesList.sqlite3"

public class NoteDAO {
    
    private var db:COpaquePointer = nil
    
    //私有DateFormatter属性
    private var dateFormatter = NSDateFormatter()
    //私有沙箱目录中属性列表文件路径
    private var plistFilePath: String!
    
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        
        return instance
    }()
    
    //初始化文件
    func createEditableCopyOfDatabaseIfNeeded() {
        
        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            NSLog("数据库打开失败。")
        } else {
            let sql = "CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT)"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            if (sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK) {
                NSLog("建表失败。")
            }
        }
        sqlite3_close(db)
    }
    
    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(DBFILE_NAME) as String
        return path
    }
    
    //插入Note方法
    public func create(model: Note) -> Int {
        
        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            NSLog("数据库打开失败。")
        } else {
            let sql = "INSERT OR REPLACE INTO note (cdate, content) VALUES (?,?)"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)

            //语句对象        
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let strDate = self.dateFormatter.stringFromDate(model.date)
                let cDate = strDate.cStringUsingEncoding(NSUTF8StringEncoding)
                
                let cContent = model.content.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cDate!, -1, nil)
                sqlite3_bind_text(statement, 2, cContent!, -1, nil)
                
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    NSLog("插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    //删除Note方法
    public func remove(model: Note) -> Int {
        
        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            NSLog("数据库打开失败。")
        } else {
            let sql = "DELETE from note where cdate =?"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            //语句对象       
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
 
                let strDate = self.dateFormatter.stringFromDate(model.date)
                let cDate = strDate.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cDate!, -1, nil)
                //执行删除数据
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    NSLog("删除数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    //修改Note方法
    public func modify(model: Note) -> Int {

        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            NSLog("数据库打开失败。")
        } else {
            let sql = "UPDATE note set content=? where cdate =?"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)

            //语句对象           
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let strDate = self.dateFormatter.stringFromDate(model.date)
                let cDate = strDate.cStringUsingEncoding(NSUTF8StringEncoding)
                
                let cContent = model.content.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cContent!, -1, nil)
                sqlite3_bind_text(statement, 2, cDate!, -1, nil)
                
                //执行修改数据
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    NSLog("修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return 0
    }
    
    //查询所有数据方法
    public func findAll() -> NSMutableArray? {

        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)

        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            NSLog("数据库打开失败。")
        } else {
            let sql = "SELECT cdate,content FROM Note"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            //语句对象
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                let listData = NSMutableArray()
                //执行查询
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let bufDate = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    let strDate = String.fromCString(bufDate)!
                    let date : NSDate = self.dateFormatter.dateFromString(strDate)!
                    
                    let bufContent = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    let strContent = String.fromCString(bufContent)!
                    
                    let note = Note(date: date, content:strContent)
                    
                    listData.addObject(note)
                }
                
                sqlite3_finalize(statement)
                sqlite3_close(db)
                
                return listData
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return nil
    }
    
    //按照主键查询数据方法
    public func findById(model: Note) -> Note? {
        
        let cpath = self.plistFilePath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            NSLog("数据库打开失败。")
        } else {
            let sql = "SELECT cdate,content FROM Note where cdate =?"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                //准备参数
                let strDate = self.dateFormatter.stringFromDate(model.date)
                let cDate = strDate.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cDate!, -1, nil)
                
                //执行查询
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let bufDate = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    let strDate = String.fromCString(bufDate)!
                    let date : NSDate = self.dateFormatter.dateFromString(strDate)!
                    
                    let bufContent = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    let strContent = String.fromCString(bufContent)!
                    
                    let note = Note(date: date, content:strContent)
                    
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return note
                }
                
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return nil
    }
    
}
