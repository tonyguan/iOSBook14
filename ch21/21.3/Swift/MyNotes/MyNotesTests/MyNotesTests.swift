//
//  MyNotesTests.swift
//  MyNotesTests
//
//  Created by 关东升 on 16/1/19.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import XCTest

class MyNotesTests: XCTestCase, NotesURLConnectionDelegate {

    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFindAll() {

        self.expectation = self.expectationWithDescription("Request NotesURL")

        let conn = NotesURLConnection()
        conn.delegate = self
        //开始查询
        conn.findAll()
        self.waitForExpectationsWithTimeout(5.0, handler: nil)

    }

    // MARK: --查询所有数据方法 成功
    func findAllFinished(res: NSDictionary) {

        self.expectation.fulfill()
        XCTAssert(true, "查询所有数据方法 成功")

        let resultCode: NSNumber = res.objectForKey("ResultCode") as! NSNumber
        XCTAssertEqual(resultCode.integerValue, 0)

        let objects = res.objectForKey("Record") as! NSMutableArray
        XCTAssertEqual(objects.count, 7)

    }

    //MARK: --查询所有数据方法 失败
    func findAllFailed(error: NSError) {
        self.expectation.fulfill()
        XCTAssertNotNil(error)
        XCTFail("查询所有数据方法失败")
    }


}
