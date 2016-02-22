//
//  NoteBLDelegate.h
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


@protocol NoteBLDelegate

@optional
//查询所有数据方法 成功
- (void)findAllNotesFinished:(NSMutableArray *)list;
//查询所有数据方法 失败
- (void)findAllNotesFailed:(NSError *)error;

//插入Note方法 成功
- (void)createNoteFinished;
//插入Note方法 失败
- (void)createNoteFailed:(NSError *)error;

//删除Note方法 成功
- (void)removeNoteFinished;
//删除Note方法 失败
- (void)removeNoteFailed:(NSError *)error;

//修改Note方法 成功
- (void)modifyNoteFinished;
//修改Note方法 失败
- (void)modifyNoteFailed:(NSError *)error;


@end
