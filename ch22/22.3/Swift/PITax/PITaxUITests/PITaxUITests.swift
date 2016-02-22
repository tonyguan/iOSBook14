//
//  PITaxUITests.swift
//  PITaxUITests
//
//  Created by 关东升 on 16/1/21.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import XCTest

class PITaxUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // 测试用例出错后是否继续执行，设置为ture是继续执行，设置为false是终止。
        continueAfterFailure = false
        // UI测试必须启动应用，该语句可以启动应用程序
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testExample() {
        
        /////////////录制生成脚本 开始///////////////////
        let app = XCUIApplication()
        let textfieldRevenueTextField = app.textFields["TextField Revenue"]
        textfieldRevenueTextField.tap()
        textfieldRevenueTextField.typeText("5000")
        app.buttons["Calculate Button"].tap()
        /////////////录制生成脚本 结束//////////////////
        
        //自己添加的代码
        let lbl = app.staticTexts["45.00"]
        XCTAssert(lbl.exists)
        
    }
    
}
