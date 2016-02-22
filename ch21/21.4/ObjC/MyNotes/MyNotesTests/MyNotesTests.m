//
//  MyNotesTests.m
//  √
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

#import "NotesTBXMLParser.h"
#import "NotesXMLParser.h"

@interface MyNotesTests : XCTestCase

@end

@implementation MyNotesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNotesTBXMLParser {
    [self measureBlock:^{
        NotesTBXMLParser* parser = [[NotesTBXMLParser alloc] init];
        [parser start];
    }];
}

- (void)testNotesXMLParser {
    [self measureBlock:^{
        NotesXMLParser* parser = [[NotesXMLParser alloc] init];
        [parser start];
    }];
}

@end
