//
//  NoteBL.m
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


#import "NoteBL.h"

@implementation NoteBL

//插入Note方法
-(void) createNote:(Note*)model {
    NoteDAO* dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao create:model];
}

//删除Note方法
-(void) removeNote:(Note*)model {
    NoteDAO* dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao remove:model];
}

//查询所有数方法
-(void) findAllNotes {
    NoteDAO* dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao findAll];
}


//修改数据方法
-(void) modifyNote:(Note*)model {
    NoteDAO* dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao modify:model];
}

#pragma --mark NoteDAODelegate 委托方法
//查询所有数据方法 成功
- (void)findAllFinished:(NSMutableArray *)list {
    [self.delegate findAllNotesFinished:list];
}

//查询所有数据方法 失败
- (void)findAllFailed:(NSError *)error {
    [self.delegate findAllNotesFailed:error];
}

//插入Note方法 成功
- (void)createFinished {
    [self.delegate createNoteFinished];
}

//插入Note方法 失败
- (void)createFailed:(NSError *)error {
    [self.delegate createNoteFailed:error];
}

//删除Note方法 成功
- (void)removeFinished {
    [self.delegate removeNoteFinished];
}
//删除Note方法 失败
- (void)removeFailed:(NSError *)error {
    [self.delegate removeNoteFailed:error];
}
//修改Note方法 成功
- (void)modifyFinished {
    [self.delegate modifyNoteFinished];
}

//修改Note方法 失败
- (void)modifyFailed:(NSError *)error {
    [self.delegate modifyNoteFailed:error];
}

@end
