//
//  BaseDAO.swift
//  PersistenceLayer
//
//  Created by 关东升 on 16/1/31.
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

public class BaseDAO: NSObject {

    //sqlite3 *db
    var db:COpaquePointer = nil

    override init() {
        //初始化数据库
        DBHelper.initDB()
    }
    
    //打开SQLite数据库，返回值为true打开成功，false打开失败
    func openDB()->Bool {
        
        //数据文件全路径
        let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)!
        
        print("DbFilePath = \(String.fromCString(dbFilePath))")
        
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            sqlite3_close(db)
            print("数据库打开失败。")
            return false
        }
        return true
    }
    
}
