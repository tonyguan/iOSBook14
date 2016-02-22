//
//  BusinessLogicLayerTests.swift
//  BusinessLogicLayerTests
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
import PersistenceLayer

class BusinessLogicLayerTests: XCTestCase {
    
    var dateFormatter: NSDateFormatter!
    var bl: NoteBL!
    
    var theContent: String!
    var theDate: NSDate!
    
    override func setUp() {
        super.setUp()
        
        self.dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.bl = NoteBL()
        self.theContent = "welcome www.51work6.com"
        self.theDate = dateFormatter.dateFromString("2015-06-03 08:20:38")
        
    }
    
    override func tearDown() {
        
        self.dateFormatter = nil
        self.bl = nil
        
        super.tearDown()
    }
    
    //测试 插入Note方法
    func testCreate() {
        //创建Note对象
        let note = Note(date: self.theDate, content: self.theContent)
        
        let list = self.bl.createNote(note)
        //断言 查询记录数为1
        XCTAssertEqual(list.count, 1)
    }
    
    
    //测试 查询所有数据方法
    func testFindAll() {
        let list = self.bl.findAll()
        //断言 查询记录数为1
        XCTAssertTrue(list.count == 1)
        
        let note = list.objectAtIndex(0) as! Note
        //断言 cdate=2015-06-03 08:20:38
        XCTAssertEqual(self.theDate, note.date)
        //断言 content= welcome www.51work6.com
        XCTAssertEqual(self.theContent, note.content)
    }
    
    //测试 删除数据方法
    func  testRemove() {
        //创建Note对象
        let note = Note(date: self.theDate, content: self.theContent)
        let list = self.bl.remove(note)
        
        //断言 查询记录数为0
        XCTAssertEqual(list.count, 0)
    }
    
}
