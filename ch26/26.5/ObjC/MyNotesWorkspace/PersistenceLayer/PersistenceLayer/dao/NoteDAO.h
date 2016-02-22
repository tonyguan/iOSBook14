//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by 关东升 on 16/1/1.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import <Foundation/Foundation.h>
#import "Note.h"

//定义DAO查询所有数据成功通知
#define	DaoFindAllFinishedNotification 	    @"DaoFindAllFinishedNotification"
//定义DAO查询所有数据失败通知
#define	DaoFindAllFailedNotification	    @"DaoFindAllFailedNotification"

//定义DAO通过ID查询数据成功通知
#define	DaoFindIdFinishedNotification	    @"DaoFindIdFinishedNotification"
//定义DAO通过ID查询数据失败通知
#define	DaoFindIdFailedNotification	        @"DaoFindIdFailedNotification"

//定义DAO插入数据成功通知
#define	DaoCreateFinishedNotification	    @"DaoCreateFinishedNotification"
//定义DAO插入数据失败通知
#define	DaoCreateFailedNotification	        @"DaoCreateFailedNotification"

//定义DAO删除数据成功通知
#define	DaoRemoveFinishedNotification	    @"DaoRemoveFinishedNotification"
//定义DAO删除数据失败通知
#define	DaoRemoveFailedNotification	        @"DaoRemoveFailedNotification"

//定义DAO修改数据成功通知
#define	DaoModifyFinishedNotification	    @"DaoModifyFinishedNotification"
//定义DAO修改数据失败通知
#define	DaoModifyFailedNotification	        @"DaoModifyFailedNotification"


@interface NoteDAO : NSObject

+ (NoteDAO*)sharedInstance;

//插入Note方法
-(void) create:(Note*)model;

//删除Note方法
-(void) remove:(Note*)model;

//修改Note方法
-(void) modify:(Note*)model;

//查询所有数据方法
-(void) findAll;

//按照主键查询数据方法
-(void) findById:(Note*)model;

@end
