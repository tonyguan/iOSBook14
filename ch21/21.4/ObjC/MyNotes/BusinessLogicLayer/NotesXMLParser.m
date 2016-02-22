//
//  NotesXMLParser.m
//  MyNotes
//
//  Created by 关东升 on 16/1/9.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "NotesXMLParser.h"

@implementation NotesXMLParser

- (void)start {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NotesTestData" ofType:@"xml"];

    NSURL *url = [NSURL fileURLWithPath:path];
    //开始解析XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

//文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.listData = [[NSMutableArray alloc] init];
}

//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

//遇到一个开始标签时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {

    self.currentTagName = elementName;
    if ([self.currentTagName isEqualToString:@"Note"]) {
        NSString *identifier = [attributeDict objectForKey:@"id"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:identifier forKey:@"id"];
        [self.listData addObject:dict];
    }

}

//遇到字符串时候触发
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //替换回车符和空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary *dict = [self.listData lastObject];

    if ([self.currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }

    if ([self.currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }

    if ([self.currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
}

//遇到结束标签时候出发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    self.currentTagName = nil;
}

//遇到文档结束时候触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {

    NSLog(@"NSXML解析完成...");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.listData userInfo:nil];

}

@end
