//
//  NotesXMLParser.h
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

#import <Foundation/Foundation.h>

@interface NotesXMLParser : NSObject <NSXMLParserDelegate>

//解析出的数据内部是字典类型
@property(strong, nonatomic) NSMutableArray *listData;
//当前标签的名字
@property(strong, nonatomic) NSString *currentTagName;

//开始解析
- (void)start;

@end
