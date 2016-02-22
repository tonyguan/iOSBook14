//
//  NotesTBXMLParser.m
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

#import "NotesTBXMLParser.h"


@implementation NotesTBXMLParser

//开始解析
-(void)start {
    
    self.listData = [[NSMutableArray alloc] init];
    
    TBXML* tbxml = [[TBXML alloc] initWithXMLFile:@"NotesTestData.xml" error:nil];
    
    TBXMLElement * root = tbxml.rootXMLElement;
    
	// 如果root元素有效
	if (root) {
        
		TBXMLElement * noteElement = [TBXML childElementNamed:@"Note" parentElement:root];
        
        while ( noteElement != nil) {
            
            NSMutableDictionary *dict = [NSMutableDictionary new];
            
            TBXMLElement *dateElement = [TBXML childElementNamed:@"CDate" parentElement:noteElement];
            if ( dateElement != nil) {
                NSString *date = [TBXML textForElement:dateElement];
                dict[@"CDate"] = date;
            }
            
            TBXMLElement *contentElement = [TBXML childElementNamed:@"Content" parentElement:noteElement];
            if ( contentElement != nil) {
                NSString *content = [TBXML textForElement:contentElement];
                dict[@"Content"] = content;
            }
            
            TBXMLElement *userIDElement = [TBXML childElementNamed:@"UserID" parentElement:noteElement];
            if ( userIDElement != nil) {
                NSString *userID = [TBXML textForElement:userIDElement];
                dict[@"UserID"] = userID;
            }
            
            //获得ID属性
            NSString *identifier = [TBXML valueOfAttributeNamed:@"id" forElement:noteElement error:nil];
            dict[@"id"] = identifier;
            
            [self.listData addObject:dict];
            
            noteElement = [TBXML nextSiblingNamed:@"Note" searchFromElement:noteElement];
            
		}
    }
    
    NSLog(@"TBXML解析完成...");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.listData userInfo:nil];
    self.listData = nil;
    
}


@end
