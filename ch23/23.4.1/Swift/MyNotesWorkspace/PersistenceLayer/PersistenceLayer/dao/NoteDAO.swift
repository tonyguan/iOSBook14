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

    //初始化属性列表文件
    func createEditableCopyOfDatabaseIfNeeded() {

        let fileManager = NSFileManager.defaultManager()
        let dbexits = fileManager.fileExistsAtPath(self.plistFilePath)
        if (!dbexits) {

            let frameworkBundle = NSBundle(forClass: NoteDAO.self)
            let frameworkBundlePath = frameworkBundle.resourcePath as NSString?
            let defaultDBPath = frameworkBundlePath!.stringByAppendingPathComponent("NotesList.plist")

            do {
                try fileManager.copyItemAtPath(defaultDBPath, toPath: self.plistFilePath)
            } catch {
                assert(false, "错误写入文件")
            }
        }
    }

    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent("NotesList.plist") as String
        return path
    }

    //插入Note方法
    public func create(model: Note) -> Int {

        let array = self.readFromArray(self.plistFilePath)!

        let strDate = self.dateFormatter.stringFromDate(model.date)
        let dict = NSDictionary(objects: [strDate, model.content], forKeys: ["date", "content"])

        array.addObject(dict)
        self.write(array, toFilePath: self.plistFilePath)

        return 0
    }

    //删除Note方法
    public func remove(model: Note) -> Int {

        let array = self.readFromArray(self.plistFilePath)!

        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.dateFromString(strDate)

            //比较日期主键是否相等
            if date == model.date {
                array.removeObject(dict)
                self.write(array, toFilePath: self.plistFilePath)
                break
            }
        }
        return 0
    }

    //修改Note方法
    public func modify(model: Note) -> Int {

        let array = self.readFromArray(self.plistFilePath)!

        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.dateFromString(strDate)

            //比较日期主键是否相等
            if date == model.date {
                dict.setValue(model.content, forKey: "content")
                self.write(array, toFilePath: self.plistFilePath)
                break
            }
        }
        return 0
    }
    //查询所有数据方法
    public func findAll() -> NSMutableArray {

        let array = self.readFromArray(self.plistFilePath)!

        let listData = NSMutableArray()

        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.dateFromString(strDate)!
            let content = dict["content"] as! String

            let note = Note(date: date, content: content)

            listData.addObject(note)
        }

        return listData
    }

    //按照主键查询数据方法
    public func findById(model: Note) -> Note? {

        let array = self.readFromArray(self.plistFilePath)!

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

    //从文件中读取数据到NSMutableArray
    func readFromArray(path: String) -> NSMutableArray? {
        //从文件读取到NSMutableData
        let data = NSMutableData(contentsOfFile: path)!
        var array: NSMutableArray!
        do {
            //反序列化到属性列表对象（NSMutableArray）
            array = try NSPropertyListSerialization.propertyListWithData(data, options: .MutableContainersAndLeaves, format: nil) as! NSMutableArray
        } catch let err as NSError {
            NSLog("读取文件失败，%@", err.description)
        }
        return array
    }

    //写入NSMutableArray数据到文件中
    func write(array: NSMutableArray, toFilePath path: String) {
        do {
            //把属性列表对象（NSMutableArray）序列化为NSData
            let data = try NSPropertyListSerialization.dataWithPropertyList(array, format: NSPropertyListFormat.BinaryFormat_v1_0, options: 0)
            //写入到沙箱目录的序列化文件
            try data.writeToFile(path, options: .DataWritingAtomic)
        } catch let err as NSError {
            NSLog("写入文件失败，%@", err.description)
        }
    }
}
