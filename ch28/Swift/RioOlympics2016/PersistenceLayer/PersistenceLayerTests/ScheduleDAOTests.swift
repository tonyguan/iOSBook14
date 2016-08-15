//
//  ScheduleDAOTests.swift
//  PersistenceLayerTests
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
import XCTest

class ScheduleDAOTests: XCTestCase {
    
    var dao: ScheduleDAO!
    var theSchedule: Schedule!
    
    override func setUp() {
        super.setUp()
        //创建ScheduleDAO对象
        self.dao = ScheduleDAO.sharedInstance
        //创建Schedule对象
        self.theSchedule = Schedule()
        self.theSchedule.GameDate = "test GameDate"
        self.theSchedule.GameTime = "test GameTime"
        self.theSchedule.GameInfo = "test GameInfo"
        let event = Events()
        event.EventID = 1
        self.theSchedule.Event = event
    }
    
    override func tearDown() {
        self.dao = nil
        super.tearDown()
    }
    
    //测试 插入Schedule方法
    func test_1_Create() {
        let res = self.dao.create(self.theSchedule)
        //断言 无异常，返回值为0，
        XCTAssert(res == 0)
    }
    
    //测试 按照主键查询数据方法
    func test_2_FindById() {
        
        self.theSchedule.ScheduleID = 502
        let resSchedule = self.dao.findById(self.theSchedule)
        
        //断言 查询结果非nil
        XCTAssertNotNil(resSchedule)
        //断言
        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule!.GameDate!)
        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule!.GameTime!)
        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule!.GameInfo!)
        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule!.Event!.EventID!)
    }
    
    //测试 查询所有数据方法
    func test_3_FindAll() {
        let list =  self.dao.findAll()
        //断言 查询记录数为1
        XCTAssert(list.count == 502)
        
        let resSchedule:Schedule = list[501] as! Schedule
        
        //断言
        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule.GameDate!)
        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule.GameTime!)
        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule.GameInfo!)
        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule.Event!.EventID!)
    }
    
    
    //测试 修改Events方法
    func test_4_Modify() {
        
        self.theSchedule.ScheduleID = 502
        self.theSchedule.GameInfo = "test modify GameInfo"
        
        let res = self.dao.modify(self.theSchedule)
        //断言 无异常，返回值为0
        XCTAssert(res == 0)
        
        let resSchedule = self.dao.findById(self.theSchedule)
        //断言 查询结果非nil
        XCTAssertNotNil(resSchedule)
        //断言
        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule!.GameDate!)
        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule!.GameTime!)
        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule!.GameInfo!)
        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule!.Event!.EventID!)
        
    }
    
    
    //测试 删除数据方
    func test_5_Remove() {
        
        self.theSchedule.ScheduleID = 502
        let res = self.dao.remove(self.theSchedule)
        //断言 无异常，返回值为0
        XCTAssert(res == 0)
        
        let resSchedule = self.dao.findById(self.theSchedule)
        //断言 查询结果nil
        XCTAssertNil(resSchedule)
    }
    
}
