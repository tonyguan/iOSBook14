//
//  MyNotesTests.m
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

#import <XCTest/XCTest.h>
#import "NotesURLConnection.h"

@interface MyNotesTests : XCTestCase <NotesURLConnectionDelegate>

@property(strong, nonatomic) XCTestExpectation *expectation;

@end

@implementation MyNotesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFindAll {

    self.expectation = [self expectationWithDescription:@"Request NotesURL"];
    NotesURLConnection *conn = [[NotesURLConnection alloc] init];
    conn.delegate = self;

    //开始查询
    [conn findAll];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}


#pragma mark - NotesURLConnection委托协议

//查询所有数据方法 成功
- (void)findAllFinished:(NSDictionary *)res {

    [self.expectation fulfill];
    XCTAssert(true, @"查询所有数据方法 成功");

    NSNumber *resultCode = (NSNumber *) [res objectForKey:@"ResultCode"];
    XCTAssertEqual([resultCode integerValue], 0);

    NSMutableArray *objects = [res objectForKey:@"Record"];
    XCTAssertEqual(objects.count, 7);
}

//查询所有数据方法 失败
- (void)findAllFailed:(NSError *)error {
    [self.expectation fulfill];
    XCTAssertNotNil(error);
    XCTFail(@"查询所有数据方法失败");
}

@end
