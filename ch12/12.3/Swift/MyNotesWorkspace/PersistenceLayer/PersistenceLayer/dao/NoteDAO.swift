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

let FILE_NAME = "NotesList.archive"
let ARCHIVE_KEY = "NotesList"

public class NoteDAO {
    
    //私有的DateFormatter属性
    private var dateFormatter = NSDateFormatter()
    //私有的沙箱目录中属性列表文件路径
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

        let fileManager = NSFileManager.defaultManager()
        let dbexits = fileManager.fileExistsAtPath(self.plistFilePath)
        if (!dbexits) {

            //添加一些测试数据
            let date1: NSDate = self.dateFormatter.dateFromString("2016-01-01 16:01:03")!
            let note1: Note = Note(date: date1, content: "Welcome to MyNote.")

            let date2: NSDate = self.dateFormatter.dateFromString("2016-01-02 8:01:0")!
            let note2: Note = Note(date: date2, content: "欢迎使用MyNote。")

            let array = NSMutableArray()
            array.addObject(note1)
            array.addObject(note2)

            let theData = NSMutableData()
            let archiver = NSKeyedArchiver(forWritingWithMutableData: theData)
            archiver.encodeObject(array, forKey: ARCHIVE_KEY)
            archiver.finishEncoding()

            theData.writeToFile(self.plistFilePath, atomically: true)
        }

    }

    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(FILE_NAME) as String
        return path
    }

    //插入Note方法
    public func create(model: Note) -> Int {

        let array = self.findAll()!
        array.addObject(model)

        let theData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: theData)
        archiver.encodeObject(array, forKey: ARCHIVE_KEY)
        archiver.finishEncoding()

        theData.writeToFile(self.plistFilePath, atomically: true)

        return 0
    }

    //删除Note方法
    public func remove(model: Note) -> Int {

        let array = self.findAll()!

        for item in array {

            let note = item as! Note

            //比较日期主键是否相等
            if note.date == model.date {

                array.removeObject(note)

                let theData = NSMutableData()
                let archiver = NSKeyedArchiver(forWritingWithMutableData: theData)
                archiver.encodeObject(array, forKey: ARCHIVE_KEY)
                archiver.finishEncoding()
                theData.writeToFile(self.plistFilePath, atomically: true)

                break
            }
        }
        return 0
    }

    //修改Note方法
    public func modify(model: Note) -> Int {

        let array = self.findAll()!

        for item in array {

            let note = item as! Note

            //比较日期主键是否相等
            if note.date == model.date {

                note.content = model.content

                let theData = NSMutableData()
                let archiver = NSKeyedArchiver(forWritingWithMutableData: theData)
                archiver.encodeObject(array, forKey: ARCHIVE_KEY)
                archiver.finishEncoding()
                theData.writeToFile(self.plistFilePath, atomically: true)

                break
            }
        }
        return 0
    }
    //查询所有数据方法
    public func findAll() -> NSMutableArray? {

        let theData = NSData(contentsOfFile: self.plistFilePath)!

        if theData.length > 0 {
            let archiver = NSKeyedUnarchiver(forReadingWithData: theData)
            let listData = archiver.decodeObjectForKey(ARCHIVE_KEY) as! NSMutableArray
            archiver.finishDecoding()

            return listData
        }

        return nil
    }

    //按照主键查询数据方法
    public func findById(model: Note) -> Note? {

        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!

        for item in array {

            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.dateFromString(strDate)!
            let content = dict["content"] as! String

            //比较日期主键是否相等
            if date == model.date {
                let note = Note(date: date, content: content)
                return note
            }
        }
        return nil
    }


}
