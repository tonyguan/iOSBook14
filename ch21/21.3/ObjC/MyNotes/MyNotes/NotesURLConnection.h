//
//  NotesURLConnection.h
//  MyNotes
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import <Foundation/Foundation.h>

@protocol NotesURLConnectionDelegate

//查询所有数据方法 成功
- (void)findAllFinished:(NSDictionary *)res;

//查询所有数据方法 失败
- (void)findAllFailed:(NSError *)error;

@end


@interface NotesURLConnection : NSObject

//保存数据列表
@property(nonatomic, strong) NSMutableArray *listData;

@property(nonatomic, weak) id <NotesURLConnectionDelegate> delegate;

//查询所有数据方法
- (void)findAll;


@end
