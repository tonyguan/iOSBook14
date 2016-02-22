//
//  NoteDAODelegate.h
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

@class Note;

@protocol NoteDAODelegate 

@optional
//查询所有数据方法 成功
- (void)findAllFinished:(NSMutableArray *)list;
//查询所有数据方法 失败
- (void)findAllFailed:(NSError *)error;

//按照主键查询数据方法 成功
- (void)findByIdFinished:(Note *)model;
//按照主键查询数据方法 失败
- (void)findByIdFailed:(NSError *)error;

//插入Note方法 成功
- (void)createFinished;
//插入Note方法 失败
- (void)createFailed:(NSError *)error;

//删除Note方法 成功
- (void)removeFinished;
//删除Note方法 失败
- (void)removeFailed:(NSError *)error;

//修改Note方法 成功
- (void)modifyFinished;
//修改Note方法 失败
- (void)modifyFailed:(NSError *)error;

@end
