//
//  PITaxUITests.m
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

#import <XCTest/XCTest.h>

@interface PITaxUITests : XCTestCase

@end

@implementation PITaxUITests

- (void)setUp {
    [super setUp];
    
    // 测试用例出错后是否继续执行，设置为ture是继续执行，设置为false是终止。
    self.continueAfterFailure = NO;
    // UI测试必须启动应用，该语句可以启动应用程序
    [[[XCUIApplication alloc] init] launch];

}

- (void)tearDown {

    [super tearDown];
}

- (void)testExample {

}

@end
