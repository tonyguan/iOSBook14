//
//  PersistenceLayerTests.swift
//  PersistenceLayerTests
//
//  Created by 关东升 on 16/1/20.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import XCTest

class PersistenceLayerTests: XCTestCase {
    
    var dateFormatter: NSDateFormatter!
    var dao: NoteDAO!
    
    var theContent: String!
    var theDate: NSDate!
    
    override func setUp() {
        super.setUp()
        
        self.dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.dao = NoteDAO.sharedInstance
        self.theContent = "welcome www.51work6.com"
        self.theDate = dateFormatter.dateFromString("2015-06-03 08:20:38")
        
    }
    
    override func tearDown() {
        
        self.dateFormatter = nil
        self.dao = nil
        
        super.tearDown()
    }
    
    //测试 查询所有数据方法
    func testCreate() {
        //创建Note对象
        let note = Note(date: self.theDate, content: self.theContent)
        let res:Int = self.dao.create(note)
        
        //断言 无异常，返回值为0，
        XCTAssertEqual(res, 0)
    }
    
    //测试查询所有数据的方法
    func testFindAll() {
        let list = self.dao.findAll()
        //断言 查询记录数为1
        XCTAssertEqual(list!.count, 1)
        
        let note = list![0] as! Note
        //断言 cdate=2015-06-03 08:20:38
        XCTAssertEqual(self.theDate , note.date)
        
        //断言 content= welcome www.51work6.com
        XCTAssertEqual(self.theContent, note.content)
    }
    
    //测试 按照主键查询数据方法
    func testFindById() {
        //创建Note对象
        let note = Note(date: self.theDate, content: self.theContent)
        let resNote = self.dao.findById(note)
        //断言 查询结果非nil
        XCTAssertNotNil(resNote)
        
        //断言 cdate=2015-06-03 08:20:38
        XCTAssertEqual(note.date, resNote!.date)
        
        //断言 content= welcome www.51work6.com
        XCTAssertEqual(self.theContent, resNote!.content)
    }
    
    
    //测试 修改Note方法
    func  testModify () {
        //创建Note对象
        let note = Note(date: self.theDate, content: "modify data")
        let res:Int = self.dao.modify(note)
        //断言 无异常，返回值为0
        XCTAssertEqual(res, 0)
        let resNote = self.dao.findById(note)
        
        //断言 查询结果非nil
        XCTAssertNotNil(resNote)
        //断言 cdate=2015-06-03 08:20:38
        XCTAssertEqual(note.date , resNote!.date)
        //断言 content="modify data"
        XCTAssertEqual(note.content, resNote!.content)
    }
    
    //测试 删除数据方法
    func  testRemove() {
        //创建Note对象
        let note = Note(date: self.theDate, content: self.theContent)
        let res:Int = self.dao.remove(note)
        
        //断言 无异常，返回值为0
        XCTAssertEqual(res, 0)
        let resNote = self.dao.findById(note)
        
        //断言 查询结果nil
        XCTAssertNil(resNote)
        
    }
}