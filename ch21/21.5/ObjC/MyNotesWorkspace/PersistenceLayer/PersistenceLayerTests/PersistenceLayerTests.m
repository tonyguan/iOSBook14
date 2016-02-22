//
//  PersistenceLayerTests.m
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

#import <XCTest/XCTest.h>

#import "NoteDAO.h"
#import "Note.h"

@interface PersistenceLayerTests : XCTestCase

@property (nonatomic,strong) NSDateFormatter * dateFormatter;
@property (nonatomic,strong) NoteDAO * dao;

@property (nonatomic,strong) NSString* theContent;
@property (nonatomic,strong) NSDate* theDate;


@end

@implementation PersistenceLayerTests


- (void)setUp {
    [super setUp];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.dao = [NoteDAO sharedInstance];
    self.theContent = @"welcome www.51work6.com";
    self.theDate = [self.dateFormatter dateFromString:@"2015-06-03 08:20:38"];
    
}

- (void)tearDown {
    self.dateFormatter = nil;
    self.dao = nil;
    [super tearDown];
}

//测试 插入Note方法
-(void) testCreate {
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    note.content = self.theContent;
    
    int res = [self.dao create:note];
    //断言 无异常，返回值为0，
    XCTAssertEqual(res, 0);
    
}

//测试 查询所有数据方法
-(void) testFindAll {
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    XCTAssertEqual(list.count, 1);
    
    Note* note  = list[0];
    //断言 cdate=2015-06-03 08:20:38
    XCTAssertEqualObjects(self.theDate, note.date);
    //XCTAssertTrue([self.theDate isEqualToDate: note.date]);
    //断言 content= welcome www.51work6.com
    XCTAssertEqualObjects(self.theContent, note.content);
    
}

//测试 按照主键查询数据方法
-(void) testFindById {
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果非nil
    XCTAssertNotNil(resNote, @"查询记录为nil");
    //断言 cdate=2015-06-03 08:20:38
    XCTAssertEqualObjects(note.date, resNote.date);
    //断言 content= welcome www.51work6.com
    XCTAssertEqualObjects(self.theContent, resNote.content);
}

//测试 修改Note方法
-(void) testModify {
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    note.content = @"www.51work6.com";
    
    int res = [self.dao modify:note];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果非nil
    XCTAssertNotNil(resNote, @"查询记录为nil");
    //断言 cdate=2015-06-03 08:20:38
    XCTAssertEqualObjects(note.date, resNote.date);
    //断言 content=www.51work6.com
    XCTAssertEqualObjects(note.content, resNote.content);
}


//测试 删除数据方法
-(void) testRemove {
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    
    int res =   [self.dao remove:note];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果nil
    XCTAssertNil(resNote, @"记录删除失败");
    
}

@end
