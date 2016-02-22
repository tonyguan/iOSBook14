//
//  PresentationLayerUITests.swift
//  PresentationLayerUITests
//
//  Created by 关东升 on 16/1/23.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import XCTest

class PresentationLayerUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = true

        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK： --查询操作
    func testMasterViewControllerTableViewCellFindAll() {
        
        let app = XCUIApplication()
        //获得当前界面中的表视图
        let tableView = app.tables.elementBoundByIndex(0)
        //断言表视图存在
        XCTAssert(tableView.exists)
        //断言表视图单元格数为0
        XCTAssertEqual(tableView.cells.count, 2)
        
        let cell1 = tableView.cells.elementBoundByIndex(0)
        XCTAssert(cell1.staticTexts["Welcome"].exists)
        
        let cell2 = tableView.cells.elementBoundByIndex(1)
        XCTAssert(cell2.staticTexts["欢迎"].exists)
    }

    //MARK： --增加备忘录操作
    func testAddViewControllerSave() {
        
        let app = XCUIApplication()
        //获得当前界面中的表视图
        let tableView = app.tables.elementBoundByIndex(0)
        let cellsCount = tableView.cells.count
        
        //点击添加“增加”按钮，跳转到增加界面
        app.navigationBars["备忘录"].buttons["Add"].tap()
        
        //获得增加界面中TextView对象
        let textView = app.textViews["Text View"]
        textView.tap()
        textView.typeText("HelloWorld")
        
        //在增加界面添加Save按钮，跳转到备忘录界面
        app.navigationBars["增加"].buttons["Save"].tap()
        //断言备忘录界面中表视图单元格数为+1
        XCTAssertEqual(tableView.cells.count, cellsCount + 1)
        
        
        
    }
    
    //MARK: --增加备忘录时取消操作
    func testAddViewControllerCancel() {
        
        let app = XCUIApplication()
        //获得当前界面中的表视图
        let tableView = app.tables.elementBoundByIndex(0)
        let cellsCount = tableView.cells.count
        
        //点击添加“增加”按钮，跳转到增加界面
        app.navigationBars["备忘录"].buttons["Add"].tap()
        
        //在增加界面添加Save按钮，跳转到备忘录界面
        app.navigationBars["增加"].buttons["Cancel"].tap()
        //断言备忘录界面中表视图单元格数没有+1
        XCTAssertEqual(tableView.cells.count, cellsCount)
        
    }
    
    //MARK: --删除最后一个单元格操作
    func testMasterViewControllerTableViewCellRemove() {
        
        let app = XCUIApplication()
        let navigationBar = app.navigationBars["备忘录"]
        navigationBar.buttons["Edit"].tap()
        
        let tableView = app.tables.elementBoundByIndex(0)
        let cellsCount = tableView.cells.count
        
        tableView.buttons.elementBoundByIndex(1).tap()
        tableView.buttons["Delete"].tap()
        navigationBar.buttons["Done"].tap()
        
        XCTAssertEqual(tableView.cells.count, cellsCount - 1)
        
        let staticTexts = tableView.cells.staticTexts["Welcome"]
        //tableView.staticTexts["Welcome"]
        XCTAssert(!staticTexts.exists)
        
    }
    
    //MARK: --详细界面中显示操作
    func testDetailViewControllerShowDetail() {

        let app = XCUIApplication()
        //获得当前界面中的表视图
        let tableView = app.tables.elementBoundByIndex(0)
        
        let cell1 = tableView.cells.elementBoundByIndex(0)
        cell1.tap()
        
        let welcomeStaticText = app.staticTexts["Welcome"]
        //断言
        XCTAssert(welcomeStaticText.exists)

        app.navigationBars["详细"].buttons["备忘录"].tap()
  
    }
    

}
