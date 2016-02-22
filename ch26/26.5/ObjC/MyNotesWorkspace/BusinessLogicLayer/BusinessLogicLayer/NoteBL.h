//
//  NoteBL.h
//  BusinessLogicLayer
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

#import <PersistenceLayer/Note.h>
#import <PersistenceLayer/NoteDAO.h>

//定义BL查询所有数据成功通知
#define	BLFindAllFinishedNotification	    @"BLFindAllFinishedNotification"
//定义BL查询所有数据失败通知
#define	BLFindAllFailedNotification	        @"BLFindAllFailedNotification"

//定义BL插入数据成功通知
#define	BLCreateNoteFinishedNotification	@"BLCreateNoteFinishedNotification"
//定义BL插入数据失败通知
#define	BLCreateNoteFailedNotification	    @"BLCreateNoteFailedNotification"

//定义BL删除数据成功通知
#define	BLRemoveFinishedNotification	    @"BLRemoveFinishedNotification"
//定义BL删除数据失败通知
#define	BLRemoveFailedNotification	        @"BLRemoveFailedNotification"

//定义BL修改数据成功通知
#define	BLModifyFinishedNotification	    @"BLModifyFinishedNotification"
//定义BL修改数据失败通知
#define	BLModifyFailedNotification	        @"BLModifyFailedNotification"


@interface NoteBL : NSObject

//插入Note方法
-(void) createNote:(Note*)model;

//删除Note方法
-(void) removeNote:(Note*)model;

//查询所有数据方法
-(void) findAllNotes;

//修改数据方法
-(void) modifyNote:(Note*)model;


@end
