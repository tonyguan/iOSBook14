//
//  EventsDAO.swift
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

public class EventsDAO: BaseDAO {

    public static let sharedInstance: EventsDAO = {
        let instance = EventsDAO()
        return instance
    }()

    //插入方法
    public func create(model: Events) -> Int {

        if self.openDB() {
            let sql = "INSERT INTO Events (EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo) VALUES (?,?,?,?,?)"

            var statement: COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {

                //绑定参数开始
                sqlite3_bind_text(statement, 1, model.EventName!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 2, model.EventIcon!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 3, model.KeyInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 4, model.BasicsInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 5, model.OlympicInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)

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
    public func remove(model: Events) -> Int {

        if self.openDB() {

            //先删除子表（比赛日程表）相关数据
            let sqlScheduleStr = NSString(format: "DELETE  from Schedule where EventID=%i", model.EventID!)
            //开启事务，立刻提交之前事务
            sqlite3_exec(db, "BEGIN IMMEDIATE TRANSACTION", nil, nil, nil)

            if sqlite3_exec(db, sqlScheduleStr.cStringUsingEncoding(NSUTF8StringEncoding), nil, nil, nil) != SQLITE_OK {
                //回滚事务
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败。")
            }

            //先删除主表（比赛项目）数据
            let sqlEventsStr = NSString(format: "DELETE  from Events where EventID =%i", model.EventID!)

            if sqlite3_exec(db, sqlEventsStr.cStringUsingEncoding(NSUTF8StringEncoding), nil, nil, nil) != SQLITE_OK {
                //回滚事务
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败。")
            }
            //提交事务
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil)

            sqlite3_close(db)
        }
        return 0
    }

    //修改方法
    public func modify(model: Events) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID =?"
  
            var statement: COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                //绑定参数开始
                sqlite3_bind_text(statement, 1, model.EventName!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 2, model.EventIcon!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 3, model.KeyInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 4, model.BasicsInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 5, model.OlympicInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_int(statement, 6, Int32(model.EventID!))

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

            let qsql = "SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events"

            var statement: COpaquePointer = nil

            //预处理过程
            if sqlite3_prepare_v2(db, qsql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {

                //执行
                while sqlite3_step(statement) == SQLITE_ROW {

                    let events = Events()

                    let cEventName = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    events.EventName = String.fromCString(cEventName)

                    let cEventIcon = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    events.EventIcon = String.fromCString(cEventIcon)

                    let cKeyInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 2))
                    events.KeyInfo = String.fromCString(cKeyInfo)

                    let cBasicsInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 3))
                    events.BasicsInfo = String.fromCString(cBasicsInfo)

                    let cOlympicInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 4))
                    events.OlympicInfo = String.fromCString(cOlympicInfo)

                    events.EventID = Int(sqlite3_column_int(statement, 5))

                    listData.addObject(events)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }

    //修改Note方法
   public func findById(model: Events) -> Events? {

        if self.openDB() {

            let qsql = "SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events where EventID =?"
            var statement: COpaquePointer = nil

            //预处理过程
            if sqlite3_prepare_v2(db, qsql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                //绑定参数开始
                sqlite3_bind_int(statement, 1, Int32(model.EventID!))
                //执行
                while sqlite3_step(statement) == SQLITE_ROW {

                    let events = Events()

                    let cEventName = UnsafePointer<Int8>(sqlite3_column_text(statement, 0))
                    events.EventName = String.fromCString(cEventName)

                    let cEventIcon = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    events.EventIcon = String.fromCString(cEventIcon)

                    let cKeyInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 2))
                    events.KeyInfo = String.fromCString(cKeyInfo)

                    let cBasicsInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 3))
                    events.BasicsInfo = String.fromCString(cBasicsInfo)

                    let cOlympicInfo = UnsafePointer<Int8>(sqlite3_column_text(statement, 4))
                    events.OlympicInfo = String.fromCString(cOlympicInfo)

                    events.EventID = Int(sqlite3_column_int(statement, 5))

                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    return events
                }
                sqlite3_finalize(statement)
                sqlite3_close(db)
            }
        }

        return nil
    }

}
