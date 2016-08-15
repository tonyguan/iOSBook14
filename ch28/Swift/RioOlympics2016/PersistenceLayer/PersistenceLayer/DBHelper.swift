//
//  DBHelper.swift
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

let DB_FILE_NAME = "app.db"

public class DBHelper {

    //sqlite3 *db
    static var db: COpaquePointer = nil

    //获得沙箱Document目录下全路径
    static func applicationDocumentsDirectoryFile(fileName: NSString) -> [CChar]? {

        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(DB_FILE_NAME)

        let cpath = path.cStringUsingEncoding(NSUTF8StringEncoding)

        return cpath
    }

    //初始化并加载数据
    public static func initDB() {

        let frameworkBundle = NSBundle(forClass: DBHelper.self)

        let configTablePath = frameworkBundle.pathForResource("DBConfig", ofType: "plist")

        let configTable = NSDictionary(contentsOfFile: configTablePath!)

        //从配置文件获得数据库版本号
        var dbConfigVersion = configTable?["DB_VERSION"] as? NSNumber
        if (dbConfigVersion == nil) {
            dbConfigVersion = 0
        }
        //从数据库DBVersionInfo表记录返回的数据库版本号
        let versionNubmer = DBHelper.dbVersionNubmer()

        //版本号不一致
        if dbConfigVersion?.intValue != versionNubmer {
            let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
            if sqlite3_open(dbFilePath!, &db) == SQLITE_OK {
                //加载数据到业务表中
                print("数据库升级...")
                let createtablePath = frameworkBundle.pathForResource("create_load", ofType: "sql")
                let sql = try? NSString(contentsOfFile: createtablePath!, encoding: NSUTF8StringEncoding)
                let cSql = sql?.cStringUsingEncoding(NSUTF8StringEncoding)
                sqlite3_exec(db, cSql!, nil, nil, nil)

                //把当前版本号写回到文件中
                let usql = NSString(format: "update  DBVersionInfo set version_number = %i", dbConfigVersion!.integerValue)
                let cusql = usql.cStringUsingEncoding(NSUTF8StringEncoding)

                sqlite3_exec(db, cusql, nil, nil, nil)

            } else {
                print("数据库打开失败。")
            }
            sqlite3_close(db)
        }

    }

    static func dbVersionNubmer() -> Int32 {

        var versionNubmer: Int32 = -1

        let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)

        if sqlite3_open(dbFilePath!, &db) == SQLITE_OK {
            let sql = "create table if not exists DBVersionInfo ( version_number int )"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)

            sqlite3_exec(db, cSql!, nil, nil, nil)

            let qsql = "select version_number from DBVersionInfo"
            let cqsql = qsql.cStringUsingEncoding(NSUTF8StringEncoding)

            var statement: COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cqsql!, -1, &statement, nil) == SQLITE_OK {
                //执行查询
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    //有数据情况
                    print("有数据情况")
                    versionNubmer = Int32(sqlite3_column_int(statement, 0))
                } else {
                    print("无数据情况")
                    let insertSql = "insert into DBVersionInfo (version_number) values(-1)"
                    let cInsertSql = insertSql.cStringUsingEncoding(NSUTF8StringEncoding)
                    sqlite3_exec(db, cInsertSql!, nil, nil, nil)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        } else {
            sqlite3_close(db)
        }
        return versionNubmer
    }

}
