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
#import <PersistenceLayer/NoteDAODelegate.h>
#import "NoteBLDelegate.h"

@interface NoteBL : NSObject <NoteDAODelegate>

@property (weak, nonatomic) id <NoteBLDelegate> delegate;

//插入Note方法
-(void) createNote:(Note*)model;

//删除Note方法
-(void) removeNote:(Note*)model;

//查询所有数据方法
-(void) findAllNotes;

//修改数据方法
-(void) modifyNote:(Note*)model;


@end
