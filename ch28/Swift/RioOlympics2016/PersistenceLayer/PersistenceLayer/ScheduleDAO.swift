//
//  ScheduleDAO.swift
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

public class ScheduleDAO: BaseDAO {
    
    public static let sharedInstance: ScheduleDAO = {
        let instance = ScheduleDAO()
        return instance
    }()
    
    //插入方法
    public func create(model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Schedule (GameDate, GameTime,GameInfo,EventID) VALUES (?,?,?,?)"

            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                //绑定参数开始
                sqlite3_bind_text(statement, 1, model.GameDate!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 2, model.GameTime!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 3, model.GameInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_int(statement, 4, Int32(model.Event!.EventID!))
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    assert(false, "插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //删除方法
    public func remove(model: Schedule) -> Int {
        
            if self.openDB() {
                let sql = "DELETE  from Schedule where ScheduleID =?"

                var statement:COpaquePointer = nil
                //预处理过程
                if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                    
                    //绑定参数开始
                    sqlite3_bind_int(statement, 1, Int32(model.ScheduleID!))
                    
                    //执行插入
                    if (sqlite3_step(statement) != SQLITE_DONE) {
                        sqlite3_finalize(statement)
                        sqlite3_close(db)
                        assert(false, "删除数据失败。")
                    }
                }
                sqlite3_finalize(statement)
                sqlite3_close(db)
            }
            
        return 0
    }
    
    //修改方法
    public func modify(model: Schedule) -> Int {
        
        if self.openDB() {
            
            let sql = "UPDATE Schedule set GameInfo=?,EventID=?,GameDate =?, GameTime=? where ScheduleID=?"

            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {

                //绑定参数开始
                sqlite3_bind_text(statement, 1, model.GameInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_int(statement, 2, Int32(model.Event!.EventID!))
                sqlite3_bind_text(statement, 3, model.GameDate!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 4, model.GameTime!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_int(statement, 5, Int32(model.ScheduleID!))

                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    assert(false, "修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //查询所有数据方法
    public func findAll() -> NSMutableArray {
        
        let listData = NSMutableArray()
        
        if self.openDB() {
            
            let qsql = "SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule"
            
            var statement:COpaquePointer = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, qsql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                
                //执行
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let schedule = Schedule()
                    let event  = Events()
                    schedule.Event = event
                    
                    let cGameDate = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    schedule.GameDate = String.fromCString(cGameDate)
                    
                    let cGameTime = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    schedule.GameTime = String.fromCString(cGameTime)
                    
                    let cGameInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 2))
                    schedule.GameInfo = String.fromCString(cGameInfo)
                    
                    schedule.Event!.EventID = Int(sqlite3_column_int(statement, 3))
                    schedule.ScheduleID = Int(sqlite3_column_int(statement, 4))
                    
                    listData.addObject(schedule)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }
    
    //修改Note方法
    public func findById(model: Schedule) -> Schedule? {
        
        if self.openDB() {
            
            let qsql = "SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule where ScheduleID=?"
            
            var statement:COpaquePointer = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, qsql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数开始
                sqlite3_bind_int(statement, 1, Int32(model.ScheduleID!))
                
                //执行
                if sqlite3_step(statement) == SQLITE_ROW {
                    
                    let schedule = Schedule()
                    let event  = Events()
                    schedule.Event = event
                    
                    let cGameDate = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    schedule.GameDate = String.fromCString(cGameDate)
                    
                    let cGameTime = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    schedule.GameTime = String.fromCString(cGameTime)
                    
                    let cGameInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 2))
                    schedule.GameInfo = String.fromCString(cGameInfo)
                    
                    schedule.Event!.EventID = Int(sqlite3_column_int(statement, 3))
                    schedule.ScheduleID = Int(sqlite3_column_int(statement, 4))
                    
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return schedule
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        return nil
    }
}
