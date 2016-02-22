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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFinished:)
                                                 name:DaoCreateFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFailed:)
                                                 name:DaoCreateFailedNotification
                                               object:nil];
    NoteDAO* dao = [NoteDAO sharedInstance];
    [dao create:model];
}


//修改Note方法
-(void) modifyNote:(Note*)model {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFinished:)
                                                 name:DaoModifyFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFailed:)
                                                 name:DaoModifyFailedNotification
                                               object:nil];
    
    NoteDAO* dao = [NoteDAO sharedInstance];
    [dao modify:model];
}


//删除Note方法
-(void) removeNote:(Note*)model {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFinished:)
                                                 name:DaoRemoveFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFailed:)
                                                 name:DaoRemoveFailedNotification
                                               object:nil];
    NoteDAO* dao = [NoteDAO sharedInstance];
    [dao remove:model];
}

//查询所有数方法
-(void) findAllNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFinished:)
                                                 name:DaoFindAllFinishedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFailed:)
                                                 name:DaoFindAllFailedNotification
                                               object:nil];
    NoteDAO* dao = [NoteDAO sharedInstance];
    [dao findAll];
}

#pragma --mark 接收数据持久层回调方法
//查询所有数据方法 成功
- (void)findAllFinished:(NSNotification*)notification {
    
    NSMutableArray *resList = [notification object];
    [[NSNotificationCenter defaultCenter]
            postNotificationName:BLFindAllFinishedNotification
            object:resList];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:DaoFindAllFinishedNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:DaoFindAllFailedNotification
                                                  object:nil];
}

//查询所有数据方法 失败
- (void)findAllFailed:(NSNotification*)notification {
    
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter]
            postNotificationName:BLFindAllFailedNotification
            object:error];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:DaoFindAllFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:DaoFindAllFailedNotification object:nil];
}

//插入Note方法 成功
- (void)createFinished:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFinishedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoCreateFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoCreateFailedNotification object:nil];
}

//插入Note方法 失败
- (void)createFailed:(NSNotification*)notification {
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFailedNotification object:error];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoCreateFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoCreateFailedNotification object:nil];
}

//删除Note方法 成功
- (void)removeFinished:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveFinishedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoRemoveFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoRemoveFailedNotification object:nil];
}
//删除Note方法 失败
- (void)removeFailed:(NSNotification*)notification {
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveFailedNotification object:error];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoRemoveFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoRemoveFailedNotification object:nil];
}

//修改Note方法 成功
- (void)modifyFinished:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyFinishedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoModifyFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoModifyFailedNotification object:nil];
}

//修改Note方法 失败
- (void)modifyFailed:(NSNotification*)notification {
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyFailedNotification object:error];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoModifyFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoModifyFailedNotification object:nil];
}

@end
