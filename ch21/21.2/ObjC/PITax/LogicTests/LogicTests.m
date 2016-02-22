//
//  LogicTests.m
//  LogicTests
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

#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface LogicTests : XCTestCase

@property (nonatomic,strong) ViewController *viewController;

@end

@implementation LogicTests

- (void)setUp {
    [super setUp];
    self.viewController = [[ViewController alloc] init];
}

- (void)tearDown {
    self.viewController = nil;
    [super tearDown];
}

//测试月应纳税额不超过1500元 用例1
- (void)testCalculateLevel1 {
    double dbRevenue = 5000;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 45.0, @"用例1测试失败");
}

//测试月应纳税额超过1500元至4500元 用例2
- (void)testCalculateLevel2 {
    double dbRevenue = 8000;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 345.0, @"用例2测试失败");
}

//测试月应纳税额超过4500元至9000元 用例3
- (void)testCalculateLevel3 {
    double dbRevenue = 12500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 1245.0, @"用例3测试失败");
}


//测试月应纳税额超过9000元至35000元 用例4
- (void)testCalculateLevel4 {
    double dbRevenue = 38500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 7745.0, @"用例4测试失败");
}

//测试月应纳税额超过35000元至55000元 用例5
- (void)testCalculateLevel5 {
    double dbRevenue = 58500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 13745.0, @"用例5测试失败");
}


//测试月应纳税额超过55000元至80000元 用例6
- (void)testCalculateLevel6 {
    double dbRevenue = 83500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 22495.0, @"用例6测试失败");
}

//测试月应纳税额超过80000元 用例7
- (void)testCalculateLevel7 {
    double dbRevenue = 103500;
    NSString *strRevenue = [NSString stringWithFormat:@"%f",dbRevenue];
    NSString* strTax =[self.viewController calculate:strRevenue];
    
    XCTAssertEqual(strTax.doubleValue, 31495.0, @"用例7测试失败");
}


@end
